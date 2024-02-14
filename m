Return-Path: <linux-kernel+bounces-65075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E985477E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EFA1F2491F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3268D182A0;
	Wed, 14 Feb 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="vzUQ30EA"
Received: from smtp75.ord1d.emailsrvr.com (smtp75.ord1d.emailsrvr.com [184.106.54.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A114297
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907608; cv=none; b=av+tb4k0otLR+9igMQI1ULhme44KWF7zVdOwKGLBa6UEPR/xnPaQBjhIWYG5HpTFtf0qhLoE+dM7qxdVYI4O4Ya4qydJhslU0akBLImXD/dQ9sz5jhZU2l/8q4IQJf10X+odP1tghcKpaCXCwEmrK5yJtdE/YVFOEHbSaz4lYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907608; c=relaxed/simple;
	bh=A/Wp/xcNVQglirA7W8fEyBnFOSJzJ+nmZV5D9Jsfm64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDoh6beEFCleM10M/1p2ysPxRR4U4G2mN6hvHXnQSa0tbnjD1a2HCjxp8TM6RP2/LcJzRFKw8uZOn7aLgaq2+FbH5sSNriMqzmh8RMXmfXO5Yd99Pre+D/10mrIfSWrreJjrZBHtQjgMoSesYHwUo6qsDABIBGX++ZaF5HWjumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=vzUQ30EA; arc=none smtp.client-ip=184.106.54.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1707905287;
	bh=A/Wp/xcNVQglirA7W8fEyBnFOSJzJ+nmZV5D9Jsfm64=;
	h=From:To:Subject:Date:From;
	b=vzUQ30EANgsjwShEqLhVDKDeb51yvsremF6e5v+bxaGEesKzqnD5VhohB+QnNMPvF
	 kW3XKYWAZCJtTJlaKQhz0d0z6Uktw0I0mflHPuQOGShcQs5VTh+1xYnLXb3/50XAQ2
	 FoBBTRWjo7O4pzHMK8cGfDmYv3MEdFHeycQGqDiw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp2.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 07102200B5;
	Wed, 14 Feb 2024 05:08:06 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] comedi: comedi_test: Prevent timers rescheduling during deletion
Date: Wed, 14 Feb 2024 10:07:25 +0000
Message-ID: <20240214100747.16203-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213181004.105072-1-abbotti@mev.co.uk>
References: <20240213181004.105072-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 985f1548-0da3-4956-9f19-7cf2aaea3395-1-1

The comedi_test devices have a couple of timers (ai_timer and ao_timer)
that can be started to simulate hardware interrupts.  Their expiry
functions normally reschedule the timer.  The driver code calls either
del_timer_sync() or del_timer() to delete the timers from the queue, but
does not currently prevent the timers from rescheduling themselves so
synchronized deletion may be ineffective.

Add a couple of boolean members (one for each timer: ai_timer_enable and
ao_timer_enable) to the device private data structure to indicate
whether the timers are allowed to reschedule themselves.  Set the member
to true when adding the timer to the queue, and to false when deleting
the timer from the queue in the waveform_ai_cancel() and
waveform_ao_cancel() functions.

The del_timer_sync() function is also called from the waveform_detach()
function, but the timer enable members will already be set to false when
that function is called, so no change is needed there.

Fixes: 403fe7f34e33 ("staging: comedi: comedi_test: fix timer race conditions")
Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Use spin_lock_bh() instead of spin_lock_irqsave().
---
 drivers/comedi/drivers/comedi_test.c | 30 ++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 30ea8b53ebf8..05ae9122823f 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -87,6 +87,8 @@ struct waveform_private {
 	struct comedi_device *dev;	/* parent comedi device */
 	u64 ao_last_scan_time;		/* time of previous AO scan in usec */
 	unsigned int ao_scan_period;	/* AO scan period in usec */
+	bool ai_timer_enable:1;		/* should AI timer be running? */
+	bool ao_timer_enable:1;		/* should AO timer be running? */
 	unsigned short ao_loopbacks[N_CHANS];
 };
 
@@ -236,8 +238,12 @@ static void waveform_ai_timer(struct timer_list *t)
 			time_increment = devpriv->ai_convert_time - now;
 		else
 			time_increment = 1;
-		mod_timer(&devpriv->ai_timer,
-			  jiffies + usecs_to_jiffies(time_increment));
+		spin_lock(&dev->spinlock);
+		if (devpriv->ai_timer_enable) {
+			mod_timer(&devpriv->ai_timer,
+				  jiffies + usecs_to_jiffies(time_increment));
+		}
+		spin_unlock(&dev->spinlock);
 	}
 
 overrun:
@@ -393,9 +399,12 @@ static int waveform_ai_cmd(struct comedi_device *dev,
 	 * Seem to need an extra jiffy here, otherwise timer expires slightly
 	 * early!
 	 */
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ai_timer_enable = true;
 	devpriv->ai_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ai_convert_period) + 1;
 	add_timer(&devpriv->ai_timer);
+	spin_unlock_bh(&dev->spinlock);
 	return 0;
 }
 
@@ -404,6 +413,9 @@ static int waveform_ai_cancel(struct comedi_device *dev,
 {
 	struct waveform_private *devpriv = dev->private;
 
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ai_timer_enable = false;
+	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ai_timer);
@@ -495,8 +507,12 @@ static void waveform_ao_timer(struct timer_list *t)
 		unsigned int time_inc = devpriv->ao_last_scan_time +
 					devpriv->ao_scan_period - now;
 
-		mod_timer(&devpriv->ao_timer,
-			  jiffies + usecs_to_jiffies(time_inc));
+		spin_lock(&dev->spinlock);
+		if (devpriv->ao_timer_enable) {
+			mod_timer(&devpriv->ao_timer,
+				  jiffies + usecs_to_jiffies(time_inc));
+		}
+		spin_unlock(&dev->spinlock);
 	}
 
 underrun:
@@ -517,9 +533,12 @@ static int waveform_ao_inttrig_start(struct comedi_device *dev,
 	async->inttrig = NULL;
 
 	devpriv->ao_last_scan_time = ktime_to_us(ktime_get());
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ao_timer_enable = true;
 	devpriv->ao_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ao_scan_period);
 	add_timer(&devpriv->ao_timer);
+	spin_unlock_bh(&dev->spinlock);
 
 	return 1;
 }
@@ -604,6 +623,9 @@ static int waveform_ao_cancel(struct comedi_device *dev,
 	struct waveform_private *devpriv = dev->private;
 
 	s->async->inttrig = NULL;
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ao_timer_enable = false;
+	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ao_timer);
-- 
2.43.0


