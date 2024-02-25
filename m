Return-Path: <linux-kernel+bounces-80343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB04862D85
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4807C28209F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE814D9EA;
	Sun, 25 Feb 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw9SWUL6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734774D5A0
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901748; cv=none; b=iDkVeZ9+7wOXfn5htAQJ0FyqVPpDI3cxVWre7TTFp6OSBJxTaG859K5dLFIoG5NK3aiFT+p10n+2icgd0rif4pk5MyNovtQzCpy6PcjrQ3HnGNpZ92b6deyNBghrgU59hW+gdNhBED4vDpAAMfWH/S4vky6UNcUlhlOGBQb1Ry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901748; c=relaxed/simple;
	bh=0ATute8e6VvAt1imtugny66nHYVAoAroOYlbqbrp6NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxScetmMguGjvpK9X/qYoyZAKdnf1tGgqfWz18luJRpTLcmr9BC87ehPtH4JaQii4KOwcSO65XhyHwhI6jNW9sw0+DU69RQXhx+lCsD9zVSBaEiF3qV5JE81RXB1O1BjWlYlpOLld+iWrv3MkmjwgQHu8Rq5c4iz8wc6QRux9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw9SWUL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3464C433C7;
	Sun, 25 Feb 2024 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901748;
	bh=0ATute8e6VvAt1imtugny66nHYVAoAroOYlbqbrp6NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cw9SWUL6v04yVpISlBEFC9hi2sYD4jXHK2xhyoCpkpTQRnH6PeLXCklz1EHkjIWnF
	 A4ponYwyRyvgHO6QC6mNhM8Q9dYaG7Y5IIy8S/ONqx1ZRfMTgZ/lsY20XuwtxwmEJ2
	 APKhijkKfHuKi9v5wdx2UEJJ0pcQPVrM6wI7vAWpWUodHhEhqd7hwJeZhX43lS8Nvw
	 kjAUkPsPo6pv1gu/4oX+YEBudLrQXxjAJAg5SIpVJErUW7Cgq3kVHSsqi0wmgmlw8c
	 f3HAbhIhyxsN2KhsHhPQvv+BTGqn7GOaNK38kLt8IUJG9k6O8HLU5Ko9GGMctZBSwE
	 XJw7x/bECQ5tQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 16/16] timers: Assert no next dyntick timer look-up while CPU is offline
Date: Sun, 25 Feb 2024 23:55:08 +0100
Message-ID: <20240225225508.11587-17-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The next timer (re-)evaluation, with the purpose of entering/updating
the dyntick mode, can happen from 3 sites and none of them are relevant
while the CPU is offline:

1) The idle loop:
	a) From the quick check helping the cpuidle governor to heuristically
	   predict the best C-state.
	b) While stopping the tick.

   But if the CPU is offline, the tick has been cancelled and there is
   consequently no need to further stop the tick.

2) Remote expiry: when a CPU remotely expires global timers on behalf of
   another CPU, the latter target's next timer is re-evaluated
   afterwards. However remote expîry doesn't happen on offline CPUs.

3) IRQ exit: on nohz_full mode, the tick is (re-)evaluated on IRQ exit.
   But full dynticks is disabled on offline CPUs.

Therefore it is safe to assume that no next dyntick timer lookup can
be performed on offline CPUs.

Assert this expectation to report any surprise.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4f4930da6448..e69e75d3858c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2233,10 +2233,10 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	bool idle_is_possible;
 
 	/*
-	 * Pretend that there is no timer pending if the cpu is offline.
-	 * Possible pending timers will be migrated later to an active cpu.
+	 * When the CPU is offline, the tick is cancelled and nothing is supposed
+	 * to try to stop it.
 	 */
-	if (cpu_is_offline(smp_processor_id())) {
+	if (WARN_ON_ONCE(cpu_is_offline(smp_processor_id()))) {
 		if (idle)
 			*idle = true;
 		return tevt.local;
-- 
2.43.0


