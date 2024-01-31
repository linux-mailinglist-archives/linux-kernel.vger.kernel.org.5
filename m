Return-Path: <linux-kernel+bounces-47354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845B844CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DB61F2261D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367A212C54B;
	Wed, 31 Jan 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXxcfO8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03B12BEBE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742709; cv=none; b=M1KHCVTvN3VOtpUWV2hUHHG9Uy/InO00JQxGd/0QSx6BWsDQYNvfA5o11DcMSek8zynFe6LLmswsChmXsdRFEbLbDBdoVGf7t+GH8GVkKoEPnSPxWhQmg0LQza291iXZgJOsZO6d9TZbV5cZKrlWoXUZcFaTRRze9s+vkwbw23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742709; c=relaxed/simple;
	bh=yj/CebTCEK8vWtZdTKGdNz/nxnJEqwYwgzARrGP9DTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHun7Ee/QzOCmO49/XcfWnnlORdaVNL4qGXc1H9nb/E4PivXjeGgNQ0NscUzEBEKOuy1b+HqqsMNzcTZmyVZmhqshc9Yd5hIxFtHr5dpKEYpCDM3fPVYFGk0O+VL84L9KfVqBWg0kz/xhxr1UAhi3bieYWc6sfCaxh2dIQfNOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXxcfO8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD82C433F1;
	Wed, 31 Jan 2024 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742708;
	bh=yj/CebTCEK8vWtZdTKGdNz/nxnJEqwYwgzARrGP9DTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXxcfO8+OSxfeXXn/jfn6uK+epAT2LG5oixSOXkrlhT8llyCXH2uiHdGNQc/C6bTt
	 d2c7eeqMOtd6yLGhjHg79Ysw5W2yMFWGtDSxcJLKyG+oJ/MsOIay0+LKCtjml31oG5
	 +t217wHeMRRDJmwR6Y1BTZT1QH5WPUuku8L2o8gVKPyW4QRJxjvaHJjBMOob0C2bee
	 yZraAGTpac9N4aVl7Bf5n4fRHw7w8gijebTxxO+Bcdi9qSfOrbMjLx4wvqaur5OpCR
	 CE1TNVugxbyoq+mozFcOFeMIOSqjwh3/mB2Vjf3HVrPTvOfvCA+7slVFeO1B/I3AH5
	 TlQpFnp7qRO4w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 10/15] tick: Assume the tick can't be stopped in NOHZ_MODE_INACTIVE mode
Date: Thu,  1 Feb 2024 00:11:15 +0100
Message-ID: <20240131231120.12006-11-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131231120.12006-1-frederic@kernel.org>
References: <20240131231120.12006-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The full-nohz update function checks if the nohz mode is active before
proceeding. It considers one exception though: if the tick is already
stopped even though the nohz mode is inactive, it still moves on in
order to update/restart the tick if needed.

However in order for the tick to be stopped, the nohz_mode has to be
either NOHZ_MODE_LOWRES or NOHZ_MODE_HIGHRES. Therefore it doesn't make
sense to test if the tick is stopped before verifying NOHZ_MODE_INACTIVE
mode.

Remove the needless related condition.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a07a04bb9d27..0d0370d8111e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1043,7 +1043,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
-	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
+	if (ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
 	__tick_nohz_full_update_tick(ts, ktime_get());
-- 
2.43.0


