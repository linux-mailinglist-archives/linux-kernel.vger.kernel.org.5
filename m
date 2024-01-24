Return-Path: <linux-kernel+bounces-37385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1583AF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293F61F2013A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B2F86AC7;
	Wed, 24 Jan 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVw4YTMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B286152
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115924; cv=none; b=GfuuP+5qxrfS+wwQy5xfeApEt5Z7WxmHtkp3ZaWQ0BSxIoyUeL8jdXZeBxxSY3biS/HtdjCz/8nDpHhbopeMWBO0DYjiBG7Al45dNPLLEUNyvewt58MABXmndmmen5Ff6gvKLTRF3gt5XKZromV/EPOJhCnBEibEJjiID07csFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115924; c=relaxed/simple;
	bh=GdB05R0GsBmz9FGndTlKhr/I91b5e4z4ItUWDOBSGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTlUINVpxTsGxpCi2DOAgeCj8CIvxIPWWFsjyEHz0ZC947X6rgA2mpNeuV2GMIUPhu+DfIdgeiP8hx0d3Rt+e1PkMa8rosvV5ijJ1C5roRjgcIOc7p9VecVy5qAsd1gVGokLeXC/uIWWR500J2pJbAmBmUv1b0l9CgP7/ALlwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVw4YTMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46808C43394;
	Wed, 24 Jan 2024 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115924;
	bh=GdB05R0GsBmz9FGndTlKhr/I91b5e4z4ItUWDOBSGsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVw4YTMJqW3je/Ce8E99eZlXXP+h6cjZcztkpnVmQmdffy4SHzim8AdAxwB2FRNia
	 k9q1sFndfren1L9iuNRuj8j/8TUNDqj41uJgOkC+pwFPluy37N6iHxSH3X6wx9I1yx
	 c15hgzyWIIJePPSV/89Lc5HvugTL1klwPWZ26ayhuVcSQ3RpeVCZYmbW4KZy0Qdxx0
	 uPA+0qH07tpRav03TSVifwofBjqCTglIKqNkj7mzo1iM/1slrXXcNqCx2S5jgU8MQ1
	 hrpe+hWJAMeAbH1Q+1rtCHIdZh3p9WB4BLRw9ikRxSaIKe7BkVCNzdAQ3+WgA2+Qdv
	 Sw2NlLFaGXdRw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 06/15] tick: No need to clear ts->next_tick again
Date: Wed, 24 Jan 2024 18:04:50 +0100
Message-ID: <20240124170459.24850-7-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170459.24850-1-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tick sched structure is already cleared from
tick_cancel_sched_timer(), so there is no need to clear that field
again.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4089bd274d8e..e8e3b5d447e9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1101,11 +1101,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(!cpu_online(cpu))) {
 		if (cpu == tick_do_timer_cpu)
 			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		/*
-		 * Make sure the CPU doesn't get fooled by obsolete tick
-		 * deadline if it comes back online later.
-		 */
-		ts->next_tick = 0;
 		return false;
 	}
 
-- 
2.43.0


