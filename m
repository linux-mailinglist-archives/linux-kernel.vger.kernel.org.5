Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E28762231
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGYT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGYT0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:26:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 60E671FFC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:26:18 -0700 (PDT)
Received: (qmail 1896362 invoked by uid 1000); 25 Jul 2023 15:26:17 -0400
Date:   Tue, 25 Jul 2023 15:26:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, khazhy@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
Message-ID: <c9bb72e0-8e02-4568-bd43-6897f9c94d12@rowland.harvard.edu>
References: <e5a6c3be-6dd3-4c85-9c5b-f9fb7aca0b36@rowland.harvard.edu>
 <0000000000007fc04d06011e274f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007fc04d06011e274f@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 07:21:23PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com

Here's a revised version of the patch, with some mistakes fixed.  If 
this works, I'll split it into three parts and submit them.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.5-rc3

Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -2671,12 +2671,17 @@ int usb_authorize_device(struct usb_devi
 	}
 
 	if (usb_dev->wusb) {
-		result = usb_get_device_descriptor(usb_dev, sizeof(usb_dev->descriptor));
-		if (result < 0) {
+		struct usb_device_descriptor *descr;
+
+		descr = usb_get_device_descriptor(usb_dev);
+		if (IS_ERR(descr)) {
+			result = PTR_ERR(descr);
 			dev_err(&usb_dev->dev, "can't re-read device descriptor for "
 				"authorization: %d\n", result);
 			goto error_device_descriptor;
 		}
+		usb_dev->descriptor = *descr;
+		kfree(descr);
 	}
 
 	usb_dev->authorized = 1;
@@ -4718,6 +4723,67 @@ static int hub_enable_device(struct usb_
 	return hcd->driver->enable_device(hcd, udev);
 }
 
+/*
+ * Get the bMaxPacketSize0 value during initialization by reading the
+ * device's device descriptor.  Since we don't already know this value,
+ * the transfer is unsafe and it ignores I/O errors, only testing for
+ * reasonable received values.
+ *
+ * For "old scheme" initialization size will be 8, so we read just the
+ * start of the device descriptor, which should work okay regardless of
+ * the actual bMaxPacketSize0 value.  For "new scheme" initialization,
+ * size will be 64 (and buf will point to a sufficiently large buffer),
+ * which might not be kosher according to the USB spec but it's what
+ * Windows does and what many devices expect.
+ *
+ * Returns bMaxPacketSize0 or a negative error code.
+ */
+static int get_bMaxPacketSize0(struct usb_device *udev,
+		struct usb_device_descriptor *buf, int size, bool first_time)
+{
+	int i, rc;
+
+	/*
+	 * Retry on all errors; some devices are flakey.
+	 * 255 is for WUSB devices, we actually need to use
+	 * 512 (WUSB1.0[4.8.1]).
+	 */
+	for (i = 0; i < GET_MAXPACKET0_TRIES; ++i) {
+		/* Start with invalid values in case the transfer fails */
+		buf->bDescriptorType = buf->bMaxPacketSize0 = 0;
+		rc = usb_control_msg(udev, usb_rcvaddr0pipe(),
+				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
+				USB_DT_DEVICE << 8, 0,
+				buf, size,
+				initial_descriptor_timeout);
+		switch (buf->bMaxPacketSize0) {
+		case 8: case 16: case 32: case 64: case 255:
+			if (buf->bDescriptorType == USB_DT_DEVICE) {
+				rc = buf->bMaxPacketSize0;
+				break;
+			}
+			fallthrough;
+		default:
+			if (rc >= 0)
+				rc = -EPROTO;
+			break;
+		}
+
+		/*
+		 * Some devices time out if they are powered on
+		 * when already connected. They need a second
+		 * reset, so return early. But only on the first
+		 * attempt, lest we get into a time-out/reset loop.
+		 */
+		if (rc > 0 || (rc == -ETIMEDOUT && first_time &&
+				udev->speed > USB_SPEED_FULL))
+			break;
+	}
+	return rc;
+}
+
+#define GET_DESCRIPTOR_BUFSIZE	64
+
 /* Reset device, (re)assign address, get device descriptor.
  * Device connection must be stable, no more debouncing needed.
  * Returns device in USB_STATE_ADDRESS, except on error.
@@ -4727,10 +4793,17 @@ static int hub_enable_device(struct usb_
  * the port lock.  For a newly detected device that is not accessible
  * through any global pointers, it's not necessary to lock the device,
  * but it is still necessary to lock the port.
+ *
+ * For a newly detected device, @dev_descr must be NULL.  The device
+ * descriptor retrieved from the device will then be stored in
+ * @udev->descriptor.  For an already existing device, @dev_descr
+ * must be non-NULL.  The device descriptor will be stored there,
+ * not in @udev->descriptor, because descriptors for registered
+ * devices are meant to be immutable.
  */
 static int
 hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
-		int retry_counter)
+		int retry_counter, struct usb_device_descriptor *dev_descr)
 {
 	struct usb_device	*hdev = hub->hdev;
 	struct usb_hcd		*hcd = bus_to_hcd(hdev->bus);
@@ -4742,6 +4815,13 @@ hub_port_init(struct usb_hub *hub, struc
 	int			devnum = udev->devnum;
 	const char		*driver_name;
 	bool			do_new_scheme;
+	const bool		initial = !dev_descr;
+	int			maxp0;
+	struct usb_device_descriptor	*buf, *descr;
+
+	buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
+	if (!buf)
+		return -ENOMEM;
 
 	/* root hub ports have a slightly longer reset period
 	 * (from USB 2.0 spec, section 7.1.7.5)
@@ -4774,32 +4854,34 @@ hub_port_init(struct usb_hub *hub, struc
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
+	if (initial) {
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
@@ -4822,22 +4904,24 @@ hub_port_init(struct usb_hub *hub, struc
 	if (udev->speed < USB_SPEED_SUPER)
 		dev_info(&udev->dev,
 				"%s %s USB device number %d using %s\n",
-				(udev->config) ? "reset" : "new", speed,
+				(initial ? "new" : "reset"), speed,
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
+	if (initial) {
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
@@ -4861,9 +4945,6 @@ hub_port_init(struct usb_hub *hub, struc
 		}
 
 		if (do_new_scheme) {
-			struct usb_device_descriptor *buf;
-			int r = 0;
-
 			retval = hub_enable_device(udev);
 			if (retval < 0) {
 				dev_err(&udev->dev,
@@ -4872,52 +4953,14 @@ hub_port_init(struct usb_hub *hub, struc
 				goto fail;
 			}
 
-#define GET_DESCRIPTOR_BUFSIZE	64
-			buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
-			if (!buf) {
-				retval = -ENOMEM;
-				continue;
-			}
-
-			/* Retry on all errors; some devices are flakey.
-			 * 255 is for WUSB devices, we actually need to use
-			 * 512 (WUSB1.0[4.8.1]).
-			 */
-			for (operations = 0; operations < GET_MAXPACKET0_TRIES;
-					++operations) {
-				buf->bMaxPacketSize0 = 0;
-				r = usb_control_msg(udev, usb_rcvaddr0pipe(),
-					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-					USB_DT_DEVICE << 8, 0,
-					buf, GET_DESCRIPTOR_BUFSIZE,
-					initial_descriptor_timeout);
-				switch (buf->bMaxPacketSize0) {
-				case 8: case 16: case 32: case 64: case 255:
-					if (buf->bDescriptorType ==
-							USB_DT_DEVICE) {
-						r = 0;
-						break;
-					}
-					fallthrough;
-				default:
-					if (r == 0)
-						r = -EPROTO;
-					break;
-				}
-				/*
-				 * Some devices time out if they are powered on
-				 * when already connected. They need a second
-				 * reset. But only on the first attempt,
-				 * lest we get into a time out/reset loop
-				 */
-				if (r == 0 || (r == -ETIMEDOUT &&
-						retries == 0 &&
-						udev->speed > USB_SPEED_FULL))
-					break;
+			maxp0 = get_bMaxPacketSize0(udev, buf,
+					GET_DESCRIPTOR_BUFSIZE, retries == 0);
+			if (maxp0 > 0 && !initial &&
+					maxp0 != udev->descriptor.bMaxPacketSize0) {
+				dev_err(&udev->dev, "device reset changed ep0 maxpacket size!\n");
+				retval = -ENODEV;
+				goto fail;
 			}
-			udev->descriptor.bMaxPacketSize0 =
-					buf->bMaxPacketSize0;
-			kfree(buf);
 
 			retval = hub_port_reset(hub, port1, udev, delay, false);
 			if (retval < 0)		/* error or disconnect */
@@ -4928,14 +4971,13 @@ hub_port_init(struct usb_hub *hub, struc
 				retval = -ENODEV;
 				goto fail;
 			}
-			if (r) {
-				if (r != -ENODEV)
+			if (maxp0 < 0) {
+				if (maxp0 != -ENODEV)
 					dev_err(&udev->dev, "device descriptor read/64, error %d\n",
-							r);
-				retval = -EMSGSIZE;
+							maxp0);
+				retval = maxp0;
 				continue;
 			}
-#undef GET_DESCRIPTOR_BUFSIZE
 		}
 
 		/*
@@ -4981,18 +5023,22 @@ hub_port_init(struct usb_hub *hub, struc
 				break;
 		}
 
-		retval = usb_get_device_descriptor(udev, 8);
-		if (retval < 8) {
+		/* !do_new_scheme || wusb */
+		maxp0 = get_bMaxPacketSize0(udev, buf, 8, retries == 0);
+		if (maxp0 < 0) {
+			retval = maxp0;
 			if (retval != -ENODEV)
 				dev_err(&udev->dev,
 					"device descriptor read/8, error %d\n",
 					retval);
-			if (retval >= 0)
-				retval = -EMSGSIZE;
 		} else {
 			u32 delay;
 
-			retval = 0;
+			if (!initial && maxp0 != udev->descriptor.bMaxPacketSize0) {
+				dev_err(&udev->dev, "device reset changed ep0 maxpacket size!\n");
+				retval = -ENODEV;
+				goto fail;
+			}
 
 			delay = udev->parent->hub_delay;
 			udev->hub_delay = min_t(u32, delay,
@@ -5010,27 +5056,10 @@ hub_port_init(struct usb_hub *hub, struc
 	if (retval)
 		goto fail;
 
-	/*
-	 * Some superspeed devices have finished the link training process
-	 * and attached to a superspeed hub port, but the device descriptor
-	 * got from those devices show they aren't superspeed devices. Warm
-	 * reset the port attached by the devices can fix them.
-	 */
-	if ((udev->speed >= USB_SPEED_SUPER) &&
-			(le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) {
-		dev_err(&udev->dev, "got a wrong device descriptor, "
-				"warm reset device\n");
-		hub_port_reset(hub, port1, udev,
-				HUB_BH_RESET_TIME, true);
-		retval = -EINVAL;
-		goto fail;
-	}
-
-	if (udev->descriptor.bMaxPacketSize0 == 0xff ||
-			udev->speed >= USB_SPEED_SUPER)
+	if (maxp0 == 0xff || udev->speed >= USB_SPEED_SUPER)
 		i = 512;
 	else
-		i = udev->descriptor.bMaxPacketSize0;
+		i = maxp0;
 	if (usb_endpoint_maxp(&udev->ep0.desc) != i) {
 		if (udev->speed == USB_SPEED_LOW ||
 				!(i == 8 || i == 16 || i == 32 || i == 64)) {
@@ -5046,13 +5075,33 @@ hub_port_init(struct usb_hub *hub, struc
 		usb_ep0_reinit(udev);
 	}
 
-	retval = usb_get_device_descriptor(udev, USB_DT_DEVICE_SIZE);
-	if (retval < (signed)sizeof(udev->descriptor)) {
+	descr = usb_get_device_descriptor(udev);
+	if (IS_ERR(descr)) {
+		retval = PTR_ERR(descr);
 		if (retval != -ENODEV)
 			dev_err(&udev->dev, "device descriptor read/all, error %d\n",
 					retval);
-		if (retval >= 0)
-			retval = -ENOMSG;
+		goto fail;
+	}
+	if (initial)
+		udev->descriptor = *descr;
+	else
+		*dev_descr = *descr;
+	kfree(descr);
+
+	/*
+	 * Some superspeed devices have finished the link training process
+	 * and attached to a superspeed hub port, but the device descriptor
+	 * got from those devices show they aren't superspeed devices. Warm
+	 * reset the port attached by the devices can fix them.
+	 */
+	if ((udev->speed >= USB_SPEED_SUPER) &&
+			(le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) {
+		dev_err(&udev->dev, "got a wrong device descriptor, "
+				"warm reset device\n");
+		hub_port_reset(hub, port1, udev,
+				HUB_BH_RESET_TIME, true);
+		retval = -EINVAL;
 		goto fail;
 	}
 
@@ -5078,6 +5127,7 @@ fail:
 		hub_port_disable(hub, port1, 0);
 		update_devnum(udev, devnum);	/* for disconnect processing */
 	}
+	kfree(buf);
 	return retval;
 }
 
@@ -5158,7 +5208,7 @@ hub_power_remaining(struct usb_hub *hub)
 
 
 static int descriptors_changed(struct usb_device *udev,
-		struct usb_device_descriptor *old_device_descriptor,
+		struct usb_device_descriptor *new_device_descriptor,
 		struct usb_host_bos *old_bos)
 {
 	int		changed = 0;
@@ -5169,8 +5219,8 @@ static int descriptors_changed(struct us
 	int		length;
 	char		*buf;
 
-	if (memcmp(&udev->descriptor, old_device_descriptor,
-			sizeof(*old_device_descriptor)) != 0)
+	if (memcmp(&udev->descriptor, new_device_descriptor,
+			sizeof(*new_device_descriptor)) != 0)
 		return 1;
 
 	if ((old_bos && !udev->bos) || (!old_bos && udev->bos))
@@ -5348,7 +5398,7 @@ static void hub_port_connect(struct usb_
 		}
 
 		/* reset (non-USB 3.0 devices) and get descriptor */
-		status = hub_port_init(hub, udev, port1, i);
+		status = hub_port_init(hub, udev, port1, i, NULL);
 		if (status < 0)
 			goto loop;
 
@@ -5495,9 +5545,8 @@ static void hub_port_connect_change(stru
 {
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_device *udev = port_dev->child;
-	struct usb_device_descriptor descriptor;
+	struct usb_device_descriptor *descr;
 	int status = -ENODEV;
-	int retval;
 
 	dev_dbg(&port_dev->dev, "status %04x, change %04x, %s\n", portstatus,
 			portchange, portspeed(hub, portstatus));
@@ -5524,23 +5573,20 @@ static void hub_port_connect_change(stru
 			 * changed device descriptors before resuscitating the
 			 * device.
 			 */
-			descriptor = udev->descriptor;
-			retval = usb_get_device_descriptor(udev,
-					sizeof(udev->descriptor));
-			if (retval < 0) {
+			descr = usb_get_device_descriptor(udev);
+			if (IS_ERR(descr)) {
 				dev_dbg(&udev->dev,
-						"can't read device descriptor %d\n",
-						retval);
+						"can't read device descriptor %ld\n",
+						PTR_ERR(descr));
 			} else {
-				if (descriptors_changed(udev, &descriptor,
+				if (descriptors_changed(udev, descr,
 						udev->bos)) {
 					dev_dbg(&udev->dev,
 							"device descriptor has changed\n");
-					/* for disconnect() calls */
-					udev->descriptor = descriptor;
 				} else {
 					status = 0; /* Nothing to do */
 				}
+				kfree(descr);
 			}
 #ifdef CONFIG_PM
 		} else if (udev->state == USB_STATE_SUSPENDED &&
@@ -5982,7 +6028,7 @@ static int usb_reset_and_verify_device(s
 	struct usb_device		*parent_hdev = udev->parent;
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
-	struct usb_device_descriptor	descriptor = udev->descriptor;
+	struct usb_device_descriptor	descriptor;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -6018,7 +6064,7 @@ static int usb_reset_and_verify_device(s
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
 		usb_ep0_reinit(udev);
-		ret = hub_port_init(parent_hub, udev, port1, i);
+		ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
 	}
@@ -6030,7 +6076,6 @@ static int usb_reset_and_verify_device(s
 	/* Device might have changed firmware (DFU or similar) */
 	if (descriptors_changed(udev, &descriptor, bos)) {
 		dev_info(&udev->dev, "device firmware changed\n");
-		udev->descriptor = descriptor;	/* for disconnect() calls */
 		goto re_enumerate;
 	}
 
Index: usb-devel/drivers/usb/core/hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hcd.c
+++ usb-devel/drivers/usb/core/hcd.c
@@ -983,6 +983,7 @@ static int register_root_hub(struct usb_
 {
 	struct device *parent_dev = hcd->self.controller;
 	struct usb_device *usb_dev = hcd->self.root_hub;
+	struct usb_device_descriptor *descr;
 	const int devnum = 1;
 	int retval;
 
@@ -994,13 +995,16 @@ static int register_root_hub(struct usb_
 	mutex_lock(&usb_bus_idr_lock);
 
 	usb_dev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-	retval = usb_get_device_descriptor(usb_dev, USB_DT_DEVICE_SIZE);
-	if (retval != sizeof usb_dev->descriptor) {
+	descr = usb_get_device_descriptor(usb_dev);
+	if (IS_ERR(descr)) {
+		retval = PTR_ERR(descr);
 		mutex_unlock(&usb_bus_idr_lock);
 		dev_dbg (parent_dev, "can't read %s device descriptor %d\n",
 				dev_name(&usb_dev->dev), retval);
-		return (retval < 0) ? retval : -EMSGSIZE;
+		return retval;
 	}
+	usb_dev->descriptor = *descr;
+	kfree(descr);
 
 	if (le16_to_cpu(usb_dev->descriptor.bcdUSB) >= 0x0201) {
 		retval = usb_get_bos_descriptor(usb_dev);
Index: usb-devel/drivers/usb/core/message.c
===================================================================
--- usb-devel.orig/drivers/usb/core/message.c
+++ usb-devel/drivers/usb/core/message.c
@@ -1040,40 +1040,35 @@ char *usb_cache_string(struct usb_device
 EXPORT_SYMBOL_GPL(usb_cache_string);
 
 /*
- * usb_get_device_descriptor - (re)reads the device descriptor (usbcore)
- * @dev: the device whose device descriptor is being updated
- * @size: how much of the descriptor to read
+ * usb_get_device_descriptor - read the device descriptor
+ * @udev: the device whose device descriptor should be read
  *
  * Context: task context, might sleep.
  *
- * Updates the copy of the device descriptor stored in the device structure,
- * which dedicates space for this purpose.
- *
  * Not exported, only for use by the core.  If drivers really want to read
  * the device descriptor directly, they can call usb_get_descriptor() with
  * type = USB_DT_DEVICE and index = 0.
  *
- * This call is synchronous, and may not be used in an interrupt context.
- *
- * Return: The number of bytes received on success, or else the status code
- * returned by the underlying usb_control_msg() call.
+ * Returns: a pointer to a dynamically allocated usb_device_descriptor
+ * structure (which the caller must deallocate), or an ERR_PTR value.
  */
-int usb_get_device_descriptor(struct usb_device *dev, unsigned int size)
+struct usb_device_descriptor *usb_get_device_descriptor(struct usb_device *udev)
 {
 	struct usb_device_descriptor *desc;
 	int ret;
 
-	if (size > sizeof(*desc))
-		return -EINVAL;
 	desc = kmalloc(sizeof(*desc), GFP_NOIO);
 	if (!desc)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+
+	ret = usb_get_descriptor(udev, USB_DT_DEVICE, 0, desc, sizeof(*desc));
+	if (ret == sizeof(*desc))
+		return desc;
 
-	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, size);
 	if (ret >= 0)
-		memcpy(&dev->descriptor, desc, size);
+		ret = -EMSGSIZE;
 	kfree(desc);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
Index: usb-devel/drivers/usb/core/usb.h
===================================================================
--- usb-devel.orig/drivers/usb/core/usb.h
+++ usb-devel/drivers/usb/core/usb.h
@@ -43,8 +43,8 @@ extern bool usb_endpoint_is_ignored(stru
 		struct usb_endpoint_descriptor *epd);
 extern int usb_remove_device(struct usb_device *udev);
 
-extern int usb_get_device_descriptor(struct usb_device *dev,
-		unsigned int size);
+extern struct usb_device_descriptor *usb_get_device_descriptor(
+		struct usb_device *udev);
 extern int usb_set_isoch_delay(struct usb_device *dev);
 extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);
