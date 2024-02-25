Return-Path: <linux-kernel+bounces-80337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BD7862D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B1A1C21397
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8F3D970;
	Sun, 25 Feb 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCeDELy1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862D39FFA
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901736; cv=none; b=CIbQPkNTGSN6TWbMzkQ97KaibnvOFWYPsTfV6fYa4W8RLz8otuP5cHqPIC252jRMfebBPYVj/pLt4UVqJNDC1nnvB7ZIpYDz57W3AZ6qi6ccbDUoSS+ZqVlPSWF0u7X1duj9tn7hZElXL9Mrgp0q84geVpQVExamU0HfyOvlh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901736; c=relaxed/simple;
	bh=PZKcGOqePrNpkgM5JGTpq6/R9MYj7zTGFX6r8zvTk9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ7a8yDIXtyXTE7FByWJUNYQiLL/wSHUlaX/zu4oEJROE1neCo2cNpvm/y9ODxIocBd80ORXG+Ub0fgx88uiC9WBkzSYmeSG6WwKVHYCjCTcTj/Dybx1z8xd+KYe2fjsHl7nzrgVy2S/mcRCg8kuXGvDWcgvI76WMT0yahkadew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCeDELy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E7AC43399;
	Sun, 25 Feb 2024 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901735;
	bh=PZKcGOqePrNpkgM5JGTpq6/R9MYj7zTGFX6r8zvTk9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCeDELy1YQOown/uvX4TDYiQfujwPApQ0Wh3b2vs/w9bDEbnAwmF8CV0su5cRWPNW
	 xHpVULLwGP5eS72gUd7meM32Szn6p7y0YLXYrSihMmTkSRQ2pY7u8BOy+Nwp2LQQAK
	 JKzc1ZEfKhlWh0s58SjncruAT2eWHpJSwxPKRbyY8PI+yvfn4zY0lWu78QXMeeYKPL
	 pRJS43rBVzBNkR0CJ2sKY3Eec/OrRqjz0GlP2AA9viAVqRaPGDEiQu5HOn8R21p38y
	 HXUoiHarxDYXzOFqXRssm2dy+L33O+4Q6PQbO6PfGhkuCtU9MlFNCRpLqUJUcEBjYi
	 DIXih21NlPdTQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 10/16] tick: Assume the tick can't be stopped in NOHZ_MODE_INACTIVE mode
Date: Sun, 25 Feb 2024 23:55:02 +0100
Message-ID: <20240225225508.11587-11-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
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
index b17895de26b9..b79f5403433b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1086,7 +1086,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
-	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
+	if (ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
 	__tick_nohz_full_update_tick(ts, ktime_get());
-- 
2.43.0


