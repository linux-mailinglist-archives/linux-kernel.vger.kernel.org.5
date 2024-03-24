Return-Path: <linux-kernel+bounces-115551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE2889B68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073BBB3F5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1AD24C326;
	Mon, 25 Mar 2024 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2L0B6my"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC31EFE46;
	Sun, 24 Mar 2024 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321053; cv=none; b=ZxbwbhL6iV3CdogLg5OAsRj9aIuyyVpEWnngQ2wKXKs4XnBoOMlB+0W5TLSKJW4jFHM85znwCNcmj9r7ccCkytXazZvHilDNXCftC1uR0QJieZeTJ7S4JSsSxW75c4PqUBJhZyUE421szpMcSLdws2rcGJUXnqz+Q8djYRtG9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321053; c=relaxed/simple;
	bh=ugff2LHVRFathEQ6wJJFeYiUK/FNblnUf9BbyLAEWyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfwGmdLdtpkkAn8QS+Jb5LoWZyHJI1sHJTqACMyTtJ3ql/n7FztPUN6UPN6pYe1Az+2zt3IxHymsP5OgLkhOv4BiBBsFs974xgo5It6ij9kumjE3tkrg9Fqe+G7YF5kwseMfpSlCBKtAdNZ7evhw3dPK2i/yAbBwRysgONcbt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2L0B6my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0679BC433F1;
	Sun, 24 Mar 2024 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321053;
	bh=ugff2LHVRFathEQ6wJJFeYiUK/FNblnUf9BbyLAEWyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2L0B6myTZHrtsChdTgOLvLw7ElsChSMDH47Nt19ju7q4BMar+ZGb47xH6J4kCU//
	 OYXayx2/L26hqeE75w2LT8byO2CimmdXdqnhCFYTlZ+9yBYCHYrUMKnu/Oz8bSolj7
	 f8zA/br1ELymAF3OfeBssrl7/QKIjRMP0lvDqVnfkqY5qK3FJ36oGU5QTIg+Jcu7sa
	 tuQQDVwaeMkIPox47TXhTUWWScOOW+B6Y6lXMRGmGib1ymiyCbqvnCRwI+aJOHUlNd
	 LuQdYyCYPH8EFEus5sDLn9lAm4HLhUYmmvfKtFEGxDWkuZ/qP5uYAmj2rKIhIfgU32
	 sYLhryKRsEWWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 617/713] comedi: comedi_test: Prevent timers rescheduling during deletion
Date: Sun, 24 Mar 2024 18:45:43 -0400
Message-ID: <20240324224720.1345309-618-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ian Abbott <abbotti@mev.co.uk>

commit f53641a6e849034a44bf80f50245a75d7a376025 upstream.

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
Cc: stable@vger.kernel.org # 4.4+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20240214100747.16203-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/comedi_test.c | 30 ++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 30ea8b53ebf81..05ae9122823f8 100644
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


