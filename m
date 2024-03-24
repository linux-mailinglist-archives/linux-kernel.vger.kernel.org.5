Return-Path: <linux-kernel+bounces-114637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAAF888B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B403E1C23FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A9234D68;
	Sun, 24 Mar 2024 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQi6QtkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF02365A4;
	Sun, 24 Mar 2024 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322303; cv=none; b=ieRKWqGWzxGTJdK176QHXqUjvJBCdrBNc6lqv1DA5qMyZcbUtWB6Hcg/zY1MRnAI2PDxrxIL483VQTkfL9svEZqdfWsMF61C4JhUF0QLwbcpqveAufgC3vzZtCfCtxt12L4Da4ljVK2FbV/uEXeq5/WsZu+UKCBtf0nAmxcKT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322303; c=relaxed/simple;
	bh=K6X5WjRVRF0L1mfohnD+dgPFYx3wAX97Iy/2G9o1zdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTPqFu1J076cUSCnMx0H3KFg+O3101lldMP8fB6hpalE5dkhrKJ+i5iOttw+lHFVlalYjKulPvUWl41yMtaIOYEvTNMYmNN5ZxtHkDaUvkWxFJgVp1uZhqypVvBHVN3jj2abuH6BwWR5ifLLkpsK3YeDXuVILUE0PWogoJIKX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQi6QtkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CC6C433C7;
	Sun, 24 Mar 2024 23:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322302;
	bh=K6X5WjRVRF0L1mfohnD+dgPFYx3wAX97Iy/2G9o1zdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQi6QtkKGxNmucIaDa4ECdcbnt9EGCjOnsiMYosiBQGF0SGof/SZ0ECeiRejk37jQ
	 PRsmCaGvhbjrjVpOx05rPsmgn10rR0Ynn+0wym35M1hsVDh4A3tO56ftQz/v6ZxGlj
	 J44WVgkdbgx/+qiTO1/p1Rlcx8xc8w/7tJ3GnCQoyDc9IFpcROGFTVai63rqlhzsLP
	 sHhTedOQ6peSLSRuVIMciRByuKbb46XdLwkEuSTLWylPtkAaq5+1WcEARCgYarCvXU
	 ImtF4gZ5pewZ53NVFLaJhxgJ97nySvmQewfapthrRc52jFxCsvAv7Amr+2oFH0iEZn
	 kH96ZPi3WNzDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1 385/451] comedi: comedi_test: Prevent timers rescheduling during deletion
Date: Sun, 24 Mar 2024 19:11:01 -0400
Message-ID: <20240324231207.1351418-386-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 0b5c0af1cebf0..626d53bf9146a 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -85,6 +85,8 @@ struct waveform_private {
 	struct comedi_device *dev;	/* parent comedi device */
 	u64 ao_last_scan_time;		/* time of previous AO scan in usec */
 	unsigned int ao_scan_period;	/* AO scan period in usec */
+	bool ai_timer_enable:1;		/* should AI timer be running? */
+	bool ao_timer_enable:1;		/* should AO timer be running? */
 	unsigned short ao_loopbacks[N_CHANS];
 };
 
@@ -234,8 +236,12 @@ static void waveform_ai_timer(struct timer_list *t)
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
@@ -391,9 +397,12 @@ static int waveform_ai_cmd(struct comedi_device *dev,
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
 
@@ -402,6 +411,9 @@ static int waveform_ai_cancel(struct comedi_device *dev,
 {
 	struct waveform_private *devpriv = dev->private;
 
+	spin_lock_bh(&dev->spinlock);
+	devpriv->ai_timer_enable = false;
+	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ai_timer);
@@ -493,8 +505,12 @@ static void waveform_ao_timer(struct timer_list *t)
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
@@ -515,9 +531,12 @@ static int waveform_ao_inttrig_start(struct comedi_device *dev,
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
@@ -602,6 +621,9 @@ static int waveform_ao_cancel(struct comedi_device *dev,
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


