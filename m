Return-Path: <linux-kernel+bounces-2786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5228161D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192131F219F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA6481B1;
	Sun, 17 Dec 2023 19:47:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E947F78;
	Sun, 17 Dec 2023 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holesch.de
Received: from localhost ([80.209.221.177]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MY6TD-1qgXf31mFZ-00YUJQ; Sun, 17 Dec 2023 20:47:04 +0100
From: Simon Holesch <simon@holesch.de>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Holesch <simon@holesch.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] usbip: Don't submit special requests twice
Date: Sun, 17 Dec 2023 20:30:40 +0100
Message-ID: <20231217194624.102385-1-simon@holesch.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sdSLCVYJz3wAVyQEcKQU1Fn3uIrSbCxQxLLDYQO91tYEv2LrvUQ
 mtBKqjPOG8Fuie+LXHpYBg7jfGElTSJj3waaOkmSRwddUKasf/5puQKqa/Sx5c1+ONK0JfT
 liPg7Sd57HpeQBbnPz2PVuqV1yxJNUmr3f3H80X+IuyMD1t666qtgATxlOVfz1h3TvH0fa5
 1U0HxwIZiq5qIcawtgWGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V0dWg/4d4a0=;1RAwIOFrZx8FgQoG3xLjMCn6gZt
 gjqaruZqGRKr03XJ4z2XTRnUoCh/k9chWOUQQtUmt6ThiS7Kv1Y4eJp+r7Aze+VsXm/9sZgA9
 ukNpdPZFCnJFRI+JOgPO+Dr057wqwAjp5Rv4z3aBDxXfQV8qS8un1RMa4FoB1HSwBfCky+SkO
 06+L8Sh2rNnVu3KoeihKuYjokHP0Ukey+tQWpjOWVbonvMsNnZ0Lyg8WuEZnXAkLTrBlySxkk
 27ZUTM4HRjrdTLRyZ7ys7PFAD7FRO3c4aqzsZJgRFSdJogK1wcw2LF3D/T3oSdVvjL1E915dC
 MLB+au+f4W8Fy4suv/tE0TAbXH8mgFfqD5vNM/9ts0GA50SK5vGoOAVNrWSfIMXtK4WYkDch7
 KJ3eKbilh6/2YRStQrRjqnPkvpYTxdQsR3an72NsTvv3iVWe8Gji3jgP5dDDYR4Oq6T/cIQyE
 s+n49iP+0s7XM3zZ2jbA5/38smEuJ0PO5nzUkih1TpIymUu7D0DfyMMSvGbmFGcLXDVfQjsTi
 fBpuL2aRLfMG9CreWTFshCvcpdnoq0Mrc5tc6F0+ujY4aeIRnfz/pHqvlnddmOvlQ9xhpFtw2
 TraZEY5Xz9SZTSW3eXDM79E60ebyIZO3j7g7EAMzHFhh6V3EhhRD3XQA/YpDWbyA4YONYgDbo
 eywA7ateH88Ve1xtgGtaim8ZkvXG9zRbgGD/shhCvAXddvox3SjTCHVtwXAVpxUC3HoOUiA6N
 oJAEpR8nEA2jNYvaP5tlyOp0tQWXRu84p3oGScvdzawKNqodYL9W6Wgrsl41zFmF7dscznzFu
 zCP1pACihAEH8OvtiL4WgMoB9ki7P0TAcHW/M1lXQ465Dm0jRqMXNHI1RGp5++2VorZmWCZ/V
 kB/2P4DV3kENEqg==

Skip submitting URBs, when identical requests were already sent in
tweak_special_requests(). Instead call the completion handler directly
to return the result of the URB.

Even though submitting those requests twice should be harmless, there
are USB devices that react poorly to some duplicated requests.

One example is the ChipIdea controller implementation in U-Boot: The
second SET_CONFIURATION request makes U-Boot disable and re-enable all
endpoints. Re-enabling an endpoint in the ChipIdea controller, however,
was broken until U-Boot commit b272c8792502 ("usb: ci: Fix gadget
reinit").

Signed-off-by: Simon Holesch <simon@holesch.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

I tested this patch by building only the usbip-host module and loading it with
the running Kernel. To build I had to revert 6309727ef271 ("kthread: add
kthread_stop_put"), which moves the kthread_stop_put() away from usbip.

    $ uname -r
    6.6.5-arch1-1
    $ make -C "/lib/modules/$(uname -r)/build" M="$PWD/drivers/usb/usbip" usbip-host.ko
    $ sudo rmmod usbip-host
    $ sudo insmod drivers/usb/usbip/usbip-host.ko

The first test was with my laptop camera. I attached the device while using
usbmon to capture the packages.

    sudo usbip bind -b 3-7
    sudo usbip attach -r localhost -b 3-7

Without the patch you can see the duplicated requests while attaching:

    $ tshark -i usbmon3 -Y "usb.device_address == $(cat /sys/bus/usb/devices/3-7/devnum) && usb.setup.bRequest in {9,11}"
    Capturing on 'usbmon3'
    77   3.903685         host → 3.11.0       USB 64 SET CONFIGURATION Request
    79   3.904687         host → 3.11.0       USB 64 SET CONFIGURATION Request
    113   4.068943         host → 3.11.0       USB 64 SET INTERFACE Request
    115   4.069126         host → 3.11.0       USB 64 SET INTERFACE Request
    4 packets captured

With the patch the duplicate requests are no longer sent:

    $ tshark -i usbmon3 -Y "usb.device_address == $(cat /sys/bus/usb/devices/3-7/devnum) && usb.setup.bRequest in {9,11}"
    Capturing on 'usbmon3'
    79   4.368262         host → 3.12.0       USB 64 SET CONFIGURATION Request
    113   4.529754         host → 3.12.0       USB 64 SET INTERFACE Request
    2 packets captured

To double check, that I didn't break something, I opened the video stream of
the camera and it still works.

The second test was with the embedded development board, with which I
originally saw the problem (a board with the i.MX 6ULZ SoC). It's
connected to a host with Ubuntu 20.04. To test the patch there (and also
to use it later), I created a usbip-backports project[1], that can build
the USB/IP modules on older Kernels. Once the backported usbip-host
module was loaded, I could successfully flash the board over USB/IP.

[1]: https://github.com/holesch/usbip-backports

Changes in v4:
- fix compile error

Changes in v3:
- handle errors in tweak_* routines: send URB if tweaking fails

Changes in v2:
- explain change in commit message

 drivers/usb/usbip/stub_rx.c | 73 +++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index fc01b31bbb87..c1522a916181 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -144,53 +144,62 @@ static int tweak_set_configuration_cmd(struct urb *urb)
 	if (err && err != -ENODEV)
 		dev_err(&sdev->udev->dev, "can't set config #%d, error %d\n",
 			config, err);
-	return 0;
+	return err;
 }
 
 static int tweak_reset_device_cmd(struct urb *urb)
 {
 	struct stub_priv *priv = (struct stub_priv *) urb->context;
 	struct stub_device *sdev = priv->sdev;
+	int err;
 
 	dev_info(&urb->dev->dev, "usb_queue_reset_device\n");
 
-	if (usb_lock_device_for_reset(sdev->udev, NULL) < 0) {
+	err = usb_lock_device_for_reset(sdev->udev, NULL);
+	if (err < 0) {
 		dev_err(&urb->dev->dev, "could not obtain lock to reset device\n");
-		return 0;
+		return err;
 	}
-	usb_reset_device(sdev->udev);
+	err = usb_reset_device(sdev->udev);
 	usb_unlock_device(sdev->udev);
 
-	return 0;
+	return err;
 }
 
 /*
  * clear_halt, set_interface, and set_configuration require special tricks.
+ * Returns 1 if request was tweaked, 0 otherwise.
  */
-static void tweak_special_requests(struct urb *urb)
+static int tweak_special_requests(struct urb *urb)
 {
+	int err;
+
 	if (!urb || !urb->setup_packet)
-		return;
+		return 0;
 
 	if (usb_pipetype(urb->pipe) != PIPE_CONTROL)
-		return;
+		return 0;
 
 	if (is_clear_halt_cmd(urb))
 		/* tweak clear_halt */
-		 tweak_clear_halt_cmd(urb);
+		err = tweak_clear_halt_cmd(urb);
 
 	else if (is_set_interface_cmd(urb))
 		/* tweak set_interface */
-		tweak_set_interface_cmd(urb);
+		err = tweak_set_interface_cmd(urb);
 
 	else if (is_set_configuration_cmd(urb))
 		/* tweak set_configuration */
-		tweak_set_configuration_cmd(urb);
+		err = tweak_set_configuration_cmd(urb);
 
 	else if (is_reset_device_cmd(urb))
-		tweak_reset_device_cmd(urb);
-	else
+		err = tweak_reset_device_cmd(urb);
+	else {
 		usbip_dbg_stub_rx("no need to tweak\n");
+		return 0;
+	}
+
+	return !err;
 }
 
 /*
@@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	int support_sg = 1;
 	int np = 0;
 	int ret, i;
+	int is_tweaked;
 
 	if (pipe == -1)
 		return;
@@ -580,8 +590,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 		priv->urbs[i]->pipe = pipe;
 		priv->urbs[i]->complete = stub_complete;
 
-		/* no need to submit an intercepted request, but harmless? */
-		tweak_special_requests(priv->urbs[i]);
+		is_tweaked = tweak_special_requests(priv->urbs[i]);
 
 		masking_bogus_flags(priv->urbs[i]);
 	}
@@ -594,22 +603,32 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 
 	/* urb is now ready to submit */
 	for (i = 0; i < priv->num_urbs; i++) {
-		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
+		if (!is_tweaked) {
+			ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
 
-		if (ret == 0)
-			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
-					pdu->base.seqnum);
-		else {
-			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
-			usbip_dump_header(pdu);
-			usbip_dump_urb(priv->urbs[i]);
+			if (ret == 0)
+				usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
+						pdu->base.seqnum);
+			else {
+				dev_err(&udev->dev, "submit_urb error, %d\n", ret);
+				usbip_dump_header(pdu);
+				usbip_dump_urb(priv->urbs[i]);
 
+				/*
+				 * Pessimistic.
+				 * This connection will be discarded.
+				 */
+				usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
+				break;
+			}
+		} else {
 			/*
-			 * Pessimistic.
-			 * This connection will be discarded.
+			 * An identical URB was already submitted in
+			 * tweak_special_requests(). Skip submitting this URB to not
+			 * duplicate the request.
 			 */
-			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
-			break;
+			priv->urbs[i]->status = 0;
+			stub_complete(priv->urbs[i]);
 		}
 	}
 
-- 
2.43.0


