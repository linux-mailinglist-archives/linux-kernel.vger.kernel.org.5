Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D08675DF9F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 04:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGWCBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 22:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWCBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 22:01:15 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1F39DE4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 19:01:10 -0700 (PDT)
Received: (qmail 1802266 invoked by uid 1000); 22 Jul 2023 22:01:09 -0400
Date:   Sat, 22 Jul 2023 22:01:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
Message-ID: <e5a6c3be-6dd3-4c85-9c5b-f9fb7aca0b36@rowland.harvard.edu>
References: <000000000000c0ffe505fe86c9ca@google.com>
 <CACGdZYJVYXA1gYTx+fvLa6H443+4SXLgG-iJcE7wQYSh+0aOzg@mail.gmail.com>
 <CACGdZYK8FupYqA2CoqoDjS4i=FvG1+ie7fG2MENHtuxspC0-Dg@mail.gmail.com>
 <69cddb70-771c-4ded-a14e-b46ce6413eb4@rowland.harvard.edu>
 <CACGdZYJexQYh8T_5vpanWvjADuGQYW82gdV-51N=nk5HTtcDwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGdZYJexQYh8T_5vpanWvjADuGQYW82gdV-51N=nk5HTtcDwg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:40:01PM -0700, Khazhy Kumykov wrote:
> On Fri, Jul 21, 2023 at 11:56 AM Alan Stern <stern@rowland.harvard.edu> wrote:

> > On the other hand, it would almost certainly be simpler if
> > hub_port_connect_change() and the other places calling
> > usb_get_device_descriptor() would read into a temporary buffer instead
> > of directly into udev->descriptor.  Do you think the problem could be
> > solved this way?  It would be cleaner in the end.
> 
> Simpler... It'll probably be cleaner in the end, but we're
> snapshotting and resetting udev->descriptor several call frames above
> where we're calling usb_get_device_descriptor in the case of
> usb_reset_and_verify_device().. For hub_port_connect_change() it
> should be straightforward - use the on-stack descriptor as the buf for
> usb_get_descriptor(), and bail out like we do already.
> 
> For usb_reset_and_verify_device... we're calling hub_port_init, which
> is directly modifying a bunch of the usb struct, fetches the
> descriptor, validates it, and we rely on the return here to decide
> whether or not to simulate a disconnect...
> 
> I'd personally lean to reverting 45bf39f8df7f, but I'm not that
> familiar with the code here. :)

Let's see what syzbot has to say about this patch...

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.5-rc2

 drivers/usb/core/hcd.c     |    3 
 drivers/usb/core/hub.c     |  167 +++++++++++++++++++++++++--------------------
 drivers/usb/core/message.c |   37 ---------
 drivers/usb/core/usb.h     |    8 +-
 4 files changed, 104 insertions(+), 111 deletions(-)

Index: usb-devel/drivers/usb/core/hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hcd.c
+++ usb-devel/drivers/usb/core/hcd.c
@@ -994,7 +994,8 @@ static int register_root_hub(struct usb_
 	mutex_lock(&usb_bus_idr_lock);
 
 	usb_dev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-	retval = usb_get_device_descriptor(usb_dev, USB_DT_DEVICE_SIZE);
+	retval = usb_get_device_descriptor(usb_dev,
+			&usb_dev->descriptor, USB_DT_DEVICE_SIZE);
 	if (retval != sizeof usb_dev->descriptor) {
 		mutex_unlock(&usb_bus_idr_lock);
 		dev_dbg (parent_dev, "can't read %s device descriptor %d\n",
Index: usb-devel/drivers/usb/core/message.c
===================================================================
--- usb-devel.orig/drivers/usb/core/message.c
+++ usb-devel/drivers/usb/core/message.c
@@ -1040,43 +1040,6 @@ char *usb_cache_string(struct usb_device
 EXPORT_SYMBOL_GPL(usb_cache_string);
 
 /*
- * usb_get_device_descriptor - (re)reads the device descriptor (usbcore)
- * @dev: the device whose device descriptor is being updated
- * @size: how much of the descriptor to read
- *
- * Context: task context, might sleep.
- *
- * Updates the copy of the device descriptor stored in the device structure,
- * which dedicates space for this purpose.
- *
- * Not exported, only for use by the core.  If drivers really want to read
- * the device descriptor directly, they can call usb_get_descriptor() with
- * type = USB_DT_DEVICE and index = 0.
- *
- * This call is synchronous, and may not be used in an interrupt context.
- *
- * Return: The number of bytes received on success, or else the status code
- * returned by the underlying usb_control_msg() call.
- */
-int usb_get_device_descriptor(struct usb_device *dev, unsigned int size)
-{
-	struct usb_device_descriptor *desc;
-	int ret;
-
-	if (size > sizeof(*desc))
-		return -EINVAL;
-	desc = kmalloc(sizeof(*desc), GFP_NOIO);
-	if (!desc)
-		return -ENOMEM;
-
-	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, size);
-	if (ret >= 0)
-		memcpy(&dev->descriptor, desc, size);
-	kfree(desc);
-	return ret;
-}
-
-/*
  * usb_set_isoch_delay - informs the device of the packet transmit delay
  * @dev: the device whose delay is to be informed
  * Context: task context, might sleep
Index: usb-devel/drivers/usb/core/usb.h
===================================================================
--- usb-devel.orig/drivers/usb/core/usb.h
+++ usb-devel/drivers/usb/core/usb.h
@@ -43,8 +43,6 @@ extern bool usb_endpoint_is_ignored(stru
 		struct usb_endpoint_descriptor *epd);
 extern int usb_remove_device(struct usb_device *udev);
 
-extern int usb_get_device_descriptor(struct usb_device *dev,
-		unsigned int size);
 extern int usb_set_isoch_delay(struct usb_device *dev);
 extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);
@@ -57,6 +55,12 @@ extern int usb_generic_driver_suspend(st
 extern int usb_generic_driver_resume(struct usb_device *udev,
 		pm_message_t msg);
 
+static inline int usb_get_device_descriptor(struct usb_device *dev,
+		struct usb_device_descriptor *desc, unsigned int size)
+{
+	return usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, size);
+}
+
 static inline unsigned usb_get_max_power(struct usb_device *udev,
 		struct usb_host_config *c)
 {
Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -2671,12 +2671,19 @@ int usb_authorize_device(struct usb_devi
 	}
 
 	if (usb_dev->wusb) {
-		result = usb_get_device_descriptor(usb_dev, sizeof(usb_dev->descriptor));
+		struct usb_device_descriptor desc;
+
+		result = usb_get_device_descriptor(usb_dev, &desc, sizeof(desc));
 		if (result < 0) {
 			dev_err(&usb_dev->dev, "can't re-read device descriptor for "
 				"authorization: %d\n", result);
 			goto error_device_descriptor;
 		}
+		if (memcmp(&usb_dev->descriptor, &desc, sizeof(desc)) != 0) {
+			dev_err(&usb_dev->dev, "device descriptor changed before authorization: %d\n",
+					result);
+			goto error_device_descriptor;
+		}
 	}
 
 	usb_dev->authorized = 1;
@@ -4730,7 +4737,7 @@ static int hub_enable_device(struct usb_
  */
 static int
 hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
-		int retry_counter)
+		int retry_counter, struct usb_device_descriptor *dev_descr)
 {
 	struct usb_device	*hdev = hub->hdev;
 	struct usb_hcd		*hcd = bus_to_hcd(hdev->bus);
@@ -4742,6 +4749,12 @@ hub_port_init(struct usb_hub *hub, struc
 	int			devnum = udev->devnum;
 	const char		*driver_name;
 	bool			do_new_scheme;
+	const bool		reinit = !!dev_descr;
+	union {
+		struct usb_device_descriptor	d;
+#define GET_DESCRIPTOR_BUFSIZE	64
+		u8				raw[GET_DESCRIPTOR_BUFSIZE];
+	}			buf;
 
 	/* root hub ports have a slightly longer reset period
 	 * (from USB 2.0 spec, section 7.1.7.5)
@@ -4774,32 +4787,34 @@ hub_port_init(struct usb_hub *hub, struc
 	}
 	oldspeed = udev->speed;
 
-	/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
-	 * it's fixed size except for full speed devices.
-	 * For Wireless USB devices, ep0 max packet is always 512 (tho
-	 * reported as 0xff in the device descriptor). WUSB1.0[4.8.1].
-	 */
-	switch (udev->speed) {
-	case USB_SPEED_SUPER_PLUS:
-	case USB_SPEED_SUPER:
-	case USB_SPEED_WIRELESS:	/* fixed at 512 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
-		break;
-	case USB_SPEED_HIGH:		/* fixed at 64 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-		break;
-	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
-		/* to determine the ep0 maxpacket size, try to read
-		 * the device descriptor to get bMaxPacketSize0 and
-		 * then correct our initial guess.
-		 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-		break;
-	case USB_SPEED_LOW:		/* fixed at 8 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
-		break;
-	default:
-		goto fail;
+	if (!reinit) {
+		/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
+		 * it's fixed size except for full speed devices.
+		 * For Wireless USB devices, ep0 max packet is always 512 (tho
+		 * reported as 0xff in the device descriptor). WUSB1.0[4.8.1].
+		 */
+		switch (udev->speed) {
+		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER:
+		case USB_SPEED_WIRELESS:	/* fixed at 512 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
+			break;
+		case USB_SPEED_HIGH:		/* fixed at 64 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
+			break;
+		case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
+			/* to determine the ep0 maxpacket size, try to read
+			 * the device descriptor to get bMaxPacketSize0 and
+			 * then correct our initial guess.
+			 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
+			break;
+		case USB_SPEED_LOW:		/* fixed at 8 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
+			break;
+		default:
+			goto fail;
+		}
 	}
 
 	if (udev->speed == USB_SPEED_WIRELESS)
@@ -4822,22 +4837,24 @@ hub_port_init(struct usb_hub *hub, struc
 	if (udev->speed < USB_SPEED_SUPER)
 		dev_info(&udev->dev,
 				"%s %s USB device number %d using %s\n",
-				(udev->config) ? "reset" : "new", speed,
+				(reinit ? "reset" : "new"), speed,
 				devnum, driver_name);
 
-	/* Set up TT records, if needed  */
-	if (hdev->tt) {
-		udev->tt = hdev->tt;
-		udev->ttport = hdev->ttport;
-	} else if (udev->speed != USB_SPEED_HIGH
-			&& hdev->speed == USB_SPEED_HIGH) {
-		if (!hub->tt.hub) {
-			dev_err(&udev->dev, "parent hub has no TT\n");
-			retval = -EINVAL;
-			goto fail;
+	if (!reinit) {
+		/* Set up TT records, if needed  */
+		if (hdev->tt) {
+			udev->tt = hdev->tt;
+			udev->ttport = hdev->ttport;
+		} else if (udev->speed != USB_SPEED_HIGH
+				&& hdev->speed == USB_SPEED_HIGH) {
+			if (!hub->tt.hub) {
+				dev_err(&udev->dev, "parent hub has no TT\n");
+				retval = -EINVAL;
+				goto fail;
+			}
+			udev->tt = &hub->tt;
+			udev->ttport = port1;
 		}
-		udev->tt = &hub->tt;
-		udev->ttport = port1;
 	}
 
 	/* Why interleave GET_DESCRIPTOR and SET_ADDRESS this way?
@@ -4861,7 +4878,6 @@ hub_port_init(struct usb_hub *hub, struc
 		}
 
 		if (do_new_scheme) {
-			struct usb_device_descriptor *buf;
 			int r = 0;
 
 			retval = hub_enable_device(udev);
@@ -4872,28 +4888,21 @@ hub_port_init(struct usb_hub *hub, struc
 				goto fail;
 			}
 
-#define GET_DESCRIPTOR_BUFSIZE	64
-			buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
-			if (!buf) {
-				retval = -ENOMEM;
-				continue;
-			}
-
 			/* Retry on all errors; some devices are flakey.
 			 * 255 is for WUSB devices, we actually need to use
 			 * 512 (WUSB1.0[4.8.1]).
 			 */
 			for (operations = 0; operations < GET_MAXPACKET0_TRIES;
 					++operations) {
-				buf->bMaxPacketSize0 = 0;
+				buf.d.bMaxPacketSize0 = 0;
 				r = usb_control_msg(udev, usb_rcvaddr0pipe(),
 					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
 					USB_DT_DEVICE << 8, 0,
-					buf, GET_DESCRIPTOR_BUFSIZE,
+					buf.raw, GET_DESCRIPTOR_BUFSIZE,
 					initial_descriptor_timeout);
-				switch (buf->bMaxPacketSize0) {
+				switch (buf.d.bMaxPacketSize0) {
 				case 8: case 16: case 32: case 64: case 255:
-					if (buf->bDescriptorType ==
+					if (buf.d.bDescriptorType ==
 							USB_DT_DEVICE) {
 						r = 0;
 						break;
@@ -4915,9 +4924,15 @@ hub_port_init(struct usb_hub *hub, struc
 						udev->speed > USB_SPEED_FULL))
 					break;
 			}
-			udev->descriptor.bMaxPacketSize0 =
-					buf->bMaxPacketSize0;
-			kfree(buf);
+			if (!reinit) {
+				udev->descriptor.bMaxPacketSize0 =
+						buf.d.bMaxPacketSize0;
+			} else if (udev->descriptor.bMaxPacketSize0 !=
+					buf.d.bMaxPacketSize0) {
+				dev_err(&udev->dev, "device reset changed ep0 maxpacket size!\n");
+				retval = -ENODEV;
+				goto fail;
+			}
 
 			retval = hub_port_reset(hub, port1, udev, delay, false);
 			if (retval < 0)		/* error or disconnect */
@@ -4981,7 +4996,8 @@ hub_port_init(struct usb_hub *hub, struc
 				break;
 		}
 
-		retval = usb_get_device_descriptor(udev, 8);
+		/* !do_new_scheme || wusb */
+		retval = usb_get_device_descriptor(udev, &buf.d, 8);
 		if (retval < 8) {
 			if (retval != -ENODEV)
 				dev_err(&udev->dev,
@@ -4992,6 +5008,15 @@ hub_port_init(struct usb_hub *hub, struc
 		} else {
 			u32 delay;
 
+			if (!reinit) {
+				udev->descriptor.bMaxPacketSize0 =
+						buf.d.bMaxPacketSize0;
+			} else if (udev->descriptor.bMaxPacketSize0 !=
+					buf.d.bMaxPacketSize0) {
+				dev_err(&udev->dev, "device reset changed ep0 maxpacket size!\n");
+				retval = -ENODEV;
+				goto fail;
+			}
 			retval = 0;
 
 			delay = udev->parent->hub_delay;
@@ -5046,8 +5071,8 @@ hub_port_init(struct usb_hub *hub, struc
 		usb_ep0_reinit(udev);
 	}
 
-	retval = usb_get_device_descriptor(udev, USB_DT_DEVICE_SIZE);
-	if (retval < (signed)sizeof(udev->descriptor)) {
+	retval = usb_get_device_descriptor(udev, &buf.d, sizeof(buf.d));
+	if (retval < (signed)sizeof(buf.d)) {
 		if (retval != -ENODEV)
 			dev_err(&udev->dev, "device descriptor read/all, error %d\n",
 					retval);
@@ -5055,6 +5080,10 @@ hub_port_init(struct usb_hub *hub, struc
 			retval = -ENOMSG;
 		goto fail;
 	}
+	if (!reinit)
+		udev->descriptor = buf.d;
+	else
+		*dev_descr = buf.d;
 
 	usb_detect_quirks(udev);
 
@@ -5158,7 +5187,7 @@ hub_power_remaining(struct usb_hub *hub)
 
 
 static int descriptors_changed(struct usb_device *udev,
-		struct usb_device_descriptor *old_device_descriptor,
+		struct usb_device_descriptor *new_device_descriptor,
 		struct usb_host_bos *old_bos)
 {
 	int		changed = 0;
@@ -5169,8 +5198,8 @@ static int descriptors_changed(struct us
 	int		length;
 	char		*buf;
 
-	if (memcmp(&udev->descriptor, old_device_descriptor,
-			sizeof(*old_device_descriptor)) != 0)
+	if (memcmp(&udev->descriptor, new_device_descriptor,
+			sizeof(*new_device_descriptor)) != 0)
 		return 1;
 
 	if ((old_bos && !udev->bos) || (!old_bos && udev->bos))
@@ -5348,7 +5377,7 @@ static void hub_port_connect(struct usb_
 		}
 
 		/* reset (non-USB 3.0 devices) and get descriptor */
-		status = hub_port_init(hub, udev, port1, i);
+		status = hub_port_init(hub, udev, port1, i, NULL);
 		if (status < 0)
 			goto loop;
 
@@ -5524,9 +5553,8 @@ static void hub_port_connect_change(stru
 			 * changed device descriptors before resuscitating the
 			 * device.
 			 */
-			descriptor = udev->descriptor;
-			retval = usb_get_device_descriptor(udev,
-					sizeof(udev->descriptor));
+			retval = usb_get_device_descriptor(udev, &descriptor,
+					sizeof(descriptor));
 			if (retval < 0) {
 				dev_dbg(&udev->dev,
 						"can't read device descriptor %d\n",
@@ -5536,8 +5564,6 @@ static void hub_port_connect_change(stru
 						udev->bos)) {
 					dev_dbg(&udev->dev,
 							"device descriptor has changed\n");
-					/* for disconnect() calls */
-					udev->descriptor = descriptor;
 				} else {
 					status = 0; /* Nothing to do */
 				}
@@ -5982,7 +6008,7 @@ static int usb_reset_and_verify_device(s
 	struct usb_device		*parent_hdev = udev->parent;
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
-	struct usb_device_descriptor	descriptor = udev->descriptor;
+	struct usb_device_descriptor	descriptor;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -6018,7 +6044,7 @@ static int usb_reset_and_verify_device(s
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
 		usb_ep0_reinit(udev);
-		ret = hub_port_init(parent_hub, udev, port1, i);
+		ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
 	}
@@ -6030,7 +6056,6 @@ static int usb_reset_and_verify_device(s
 	/* Device might have changed firmware (DFU or similar) */
 	if (descriptors_changed(udev, &descriptor, bos)) {
 		dev_info(&udev->dev, "device firmware changed\n");
-		udev->descriptor = descriptor;	/* for disconnect() calls */
 		goto re_enumerate;
 	}
 
