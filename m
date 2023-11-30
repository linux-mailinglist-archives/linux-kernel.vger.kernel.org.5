Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF06C7FFF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377223AbjK3XRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377216AbjK3XRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:17:12 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157CD5C;
        Thu, 30 Nov 2023 15:17:16 -0800 (PST)
Received: from localhost ([80.209.221.177]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKsWr-1qpwLs0uE9-00LHtd; Fri, 01 Dec 2023 00:17:05 +0100
From:   Simon Holesch <simon@holesch.de>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simon Holesch <simon@holesch.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] usbip: Don't submit special requests twice
Date:   Fri,  1 Dec 2023 00:10:13 +0100
Message-ID: <20231130231650.22410-1-simon@holesch.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JSWYadvl06BY/GP/X48YbWWR8oe7ky/mMR7iCfES6xabSW7p4uX
 Ysu1/4quPMTyT/Hf2vaXRoHv2tJLXwqSpaSo7wnkaVbpefNa3YO0YmCz4RWndmR35+0egRS
 xYI/RmhbBul3gu8EP4tT5tJ9l30UgkyImITjfYH+2+3dDTAmJbz+96QGMb8c7mDuH//5WhJ
 CIzGRumnU98q/9p2eH3XA==
UI-OutboundReport: notjunk:1;M01:P0:uQqYBdCFXmg=;jOFLonkHGXSl33/h14ZjSomW1mh
 9UWwnIQBCrppk7rruyVzSwR6N+/v2t71hnbJ5XmbgsIOyFO77rg/TTjcv8KM0jR6ND2CEUfev
 Fe7qb7UMX/CLfTd0xIkCQ9RDIDMs69npmggec9x9Goo0reYuHSpZQCO1y4WOfuKLug+FASBOt
 l7z7CCXQDbU1tKWBoUcOhANTp6x6dH653KVVWfmLkGGIcKgq6LRg9D7wobMDjnDT4BTD0z97J
 aZt/k5BjMdNqILzKzrkab+dJ3Dwym+6q6b0MM+pxnWoRi2xyDGRxqfeU3pUvYK4cXEQJ+gCM+
 u6d4LI/mXalQuYptxKRKP0aqKFOna3lzpAnXr30Wvowotcr1H8+/qV8RabzJZclLxBvmTwlHP
 jSyMvHjxSJac+vzwTDOPs3ehragt8RqA2uVbxKXWn9NMIjuPSG6gZxGWwteRb+WivXxiphATM
 WiA5uATTNaz0iuLlJprQu5WwM3R3T8pDGIWpQ/za8QcUe7S/QRieH3tJXa8sWgTbkQm9gIHCD
 APY4yogeZVCAyCyi5kEE3Oi+w4OOUfEEZ2tTl1jIwSqP7AyHhTphk3BaQhIuwqBCXIc0yvFYH
 O/84wHOfu2kPmClUTk223GzuuPjvSMupRO9RFSCzVn6KIF4SAFVvw5f624FTUOD7E6Pd2Jx1R
 wDHqH0+r22ogBJYCYEyPxtESCbpFB9iS5M2B4L6xyNrDMwetY56yIqL/EHsxD97BDxazioYvz
 KYI+lw+G9r7eKB5F4UCxKfThe5GkWqvvGymAz5vmN+Bx4vSUP9RIoY9cdfVXavaTa4dxC33pt
 3JuaE+g/ZiUcPh3Y0WpbMwBAFYMsREWn/PpqVpiWfDcFQ8VjBpHwmiAwHl2K6iQTor+CmU/b6
 rwn0O80H5N9SZ9w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Changes in v3:
- handle errors in tweak_* routines: send URB if tweaking fails

Changes in v2:
- explain change in commit message

Thanks again for the feedback!

 drivers/usb/usbip/stub_rx.c | 73 +++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index fc01b31bbb87..76a6f46b8676 100644
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
+	err = usb_lock_device_for_reset(sdev->udev, NULL)
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

