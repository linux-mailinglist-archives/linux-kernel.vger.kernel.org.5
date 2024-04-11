Return-Path: <linux-kernel+bounces-140708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C08A1805
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F61286996
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF61DF51;
	Thu, 11 Apr 2024 15:01:18 +0000 (UTC)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DA134BE;
	Thu, 11 Apr 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.59.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847677; cv=none; b=gZwz9o8UvnfvQYfu04jDRV0mIrSUfwwRwK+pd45vzbZtPQMPetq2jOpXYJB6iiyBD++pBJwX6KKBEzV4d6uAr7M2o5bbBv+nZbFW5whJvquazkZ6r4kR1OfWPKnQUFE3tRpoNsqG9T2qg+cRGUkSOG6r+PLPg8Cuw1mMh2Q2AUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847677; c=relaxed/simple;
	bh=4Ukjqm4Uw1XkLoSWFdID5VT/BDuOQuEsIMIYWMR4nv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfe7+5HXi0F1HQoKrjuu7hvR/YXEcAeaH6SwfMX6RFRTcyzRzpHZ0Comenrxz4AcFNoSfiAvfKjO32XqCsM+DgUZgO4tWjRjKtPxEEeF++oJofXgnyJcyfg/3h2+bSRImksUOVnroJ+aYLTAAhGnqdQwRhZEsEQBnZ3b9R4WvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=permerror (bad message/signature format); arc=none smtp.client-ip=80.241.59.207
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VFjMf6XX8z9svy;
	Thu, 11 Apr 2024 16:51:58 +0200 (CEST)
From: Marcello Sylvester Bauer <email@web.codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcello Sylvester Bauer <sylv@sylv.io>,
	Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
	=?UTF-8?q?Matthias=20St=C3=B6ckl?= <matthias.stoeckl@secunet.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
Date: Thu, 11 Apr 2024 16:51:28 +0200
Message-ID: <57a1c2180ff74661600e010c234d1dbaba1d0d46.1712843963.git.sylv@sylv.io>
In-Reply-To: <cover.1712843963.git.sylv@sylv.io>
References: <cover.1712843963.git.sylv@sylv.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VFjMf6XX8z9svy

From: Marcello Sylvester Bauer <sylv@sylv.io>

The dummy_hcd transfer scheduler assumes that the internal kernel timer
frequency is set to 1000Hz to give a polling interval of 1ms. Reducing
the timer frequency will result in an anti-proportional reduction in
transfer performance. Switch to a hrtimer to decouple this association.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0953e1b5c030..dab559d8ee8c 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -240,7 +240,7 @@ enum dummy_rh_state {
 struct dummy_hcd {
 	struct dummy			*dum;
 	enum dummy_rh_state		rh_state;
-	struct timer_list		timer;
+	struct hrtimer			timer;
 	u32				port_status;
 	u32				old_status;
 	unsigned long			re_timeout;
@@ -1301,8 +1301,8 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!timer_pending(&dum_hcd->timer))
-		mod_timer(&dum_hcd->timer, jiffies + 1);
+	if (!hrtimer_active(&dum_hcd->timer))
+		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1323,7 +1323,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		mod_timer(&dum_hcd->timer, jiffies);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1777,7 +1777,7 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
  * drivers except that the callbacks are invoked from soft interrupt
  * context.
  */
-static void dummy_timer(struct timer_list *t)
+static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 {
 	struct dummy_hcd	*dum_hcd = from_timer(dum_hcd, t, timer);
 	struct dummy		*dum = dum_hcd->dum;
@@ -1808,8 +1808,6 @@ static void dummy_timer(struct timer_list *t)
 		break;
 	}
 
-	/* FIXME if HZ != 1000 this will probably misbehave ... */
-
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
 
@@ -1817,7 +1815,7 @@ static void dummy_timer(struct timer_list *t)
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
 		spin_unlock_irqrestore(&dum->lock, flags);
-		return;
+		return HRTIMER_NORESTART;
 	}
 	dum_hcd->next_frame_urbp = NULL;
 
@@ -1995,10 +1993,12 @@ static void dummy_timer(struct timer_list *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		mod_timer(&dum_hcd->timer, jiffies + msecs_to_jiffies(1));
+		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2387,7 +2387,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			mod_timer(&dum_hcd->timer, jiffies);
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2465,7 +2465,8 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2494,7 +2495,8 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2513,8 +2515,11 @@ static int dummy_start(struct usb_hcd *hcd)
 
 static void dummy_stop(struct usb_hcd *hcd)
 {
-	device_remove_file(dummy_dev(hcd_to_dummy_hcd(hcd)), &dev_attr_urbs);
-	dev_info(dummy_dev(hcd_to_dummy_hcd(hcd)), "stopped\n");
+	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
+
+	hrtimer_cancel(&dum_hcd->timer);
+	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
+	dev_info(dummy_dev(dum_hcd), "stopped\n");
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.44.0


