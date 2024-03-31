Return-Path: <linux-kernel+bounces-126328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC8289353C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A055C2873EC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF840146011;
	Sun, 31 Mar 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCNMIkfG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31A1F5F5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906017; cv=none; b=TGwCkHmfRt9ZD6QKeW4V1qYj3o1zDUItnIrVoAqKE9xIqI9r6icbsO1QETX4KzPffXkPAKrGNC6oI77Pj9eeDHPybb/RvREMzeT3zIb9KIKgj3v/OFoMLQ5eMNY3Efl4fIblbVnhqivrywgeAdntsU8sgS+6UkgFM/a0MYDqZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906017; c=relaxed/simple;
	bh=HBfXrxJi/V+dCkH6GT+y26NqwpH06Fj5pM+zu7PdZzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go8EdoRFL/EMAAY5txDCov1OJoGi57+YIcpnMgjn5BdqLJim5nl1Lz7qL0x68HX7v/qQqr1fkVGjlv7EIYvfD5SZ++B1Z3RXwE+g+74lGgSRFS5N6NY5Jtnepn6saRMlzok7zwfp7iCKk89vS3kkLXfM1GhhoYFZckwGqcWc/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gCNMIkfG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XdWBA2pTXq0OobA5sGejKwVafJreHXMQk3h9hm0Oz5k=; b=gCNMIkfGiYYKQ7hBBuTEOdnx0U
	fdYiZoTke1+np2OBl4txb23v6MBqOAoo3mbn18ryOBMKklwNliVfI2nkz95cX1ysstyHUT+MaR17o
	pdapLdwFFyvSC/N/m49KIHQPrtM2ZFPO/GUsGHyPLdAeI949cwPiZwW9Z0AHenVZMno0gkqaKKz82
	jGcvfoH6DXmiEFGhGJf6cI1XmbN2woDa7MTMnR7xsQGBHy8hS4r7nJQelgc3LQzEenDGkBLwgFdXt
	xK1TbLF1ZSKIn6gkkuZkcUnPbyKZxt5jQ8NCuwoRqlhhMhkX04LwsR8EmwELgvxt83FhxCG3CpPLs
	D8US2aWg==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqyxL-00000005z30-1XAn;
	Sun, 31 Mar 2024 17:26:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4/6] tick/sched: fix various kernel-doc warnings
Date: Sun, 31 Mar 2024 10:26:50 -0700
Message-ID: <20240331172652.14086-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331172652.14086-1-rdunlap@infradead.org>
References: <20240331172652.14086-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a slew of kernel-doc warnings in tick-sched.c:

tick-sched.c:650: warning: Function parameter or struct member 'now' not described in 'tick_nohz_update_jiffies'
tick-sched.c:741: warning: No description found for return value of 'get_cpu_idle_time_us'
tick-sched.c:767: warning: No description found for return value of 'get_cpu_iowait_time_us'
tick-sched.c:1210: warning: No description found for return value of 'tick_nohz_idle_got_tick'
tick-sched.c:1228: warning: No description found for return value of 'tick_nohz_get_next_hrtimer'
tick-sched.c:1243: warning: No description found for return value of 'tick_nohz_get_sleep_length'
tick-sched.c:1282: warning: Function parameter or struct member 'cpu' not described in 'tick_nohz_get_idle_calls_cpu'
tick-sched.c:1282: warning: No description found for return value of 'tick_nohz_get_idle_calls_cpu'
tick-sched.c:1294: warning: No description found for return value of 'tick_nohz_get_idle_calls'
tick-sched.c:1577: warning: Function parameter or struct member 'hrtimer' not described in 'tick_setup_sched_timer'
tick-sched.c:1577: warning: Excess function parameter 'mode' description in 'tick_setup_sched_timer'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

 kernel/time/tick-sched.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff -- a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -697,6 +697,7 @@ bool tick_nohz_tick_stopped_cpu(int cpu)
 
 /**
  * tick_nohz_update_jiffies - update jiffies when idle was interrupted
+ * @now: current ktime_t
  *
  * Called from interrupt entry when the CPU was idle
  *
@@ -794,7 +795,7 @@ static u64 get_cpu_sleep_time_us(struct
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * This function returns -1 if NOHZ is not enabled.
+ * Return: -1 if NOHZ is not enabled, else total idle time of the @cpu
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
@@ -820,7 +821,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * This function returns -1 if NOHZ is not enabled.
+ * Return: -1 if NOHZ is not enabled, else total iowait time of @cpu
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
@@ -1287,6 +1288,8 @@ void tick_nohz_irq_exit(void)
 
 /**
  * tick_nohz_idle_got_tick - Check whether or not the tick handler has run
+ *
+ * Return: %true if the tick handler has run, otherwise %false
  */
 bool tick_nohz_idle_got_tick(void)
 {
@@ -1305,6 +1308,8 @@ bool tick_nohz_idle_got_tick(void)
  * stopped, it returns the next hrtimer.
  *
  * Called from power state control code with interrupts disabled
+ *
+ * Return: the next expiration time
  */
 ktime_t tick_nohz_get_next_hrtimer(void)
 {
@@ -1320,6 +1325,8 @@ ktime_t tick_nohz_get_next_hrtimer(void)
  * The return value of this function and/or the value returned by it through the
  * @delta_next pointer can be negative which must be taken into account by its
  * callers.
+ *
+ * Return: the expected length of the current sleep
  */
 ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
@@ -1357,8 +1364,11 @@ ktime_t tick_nohz_get_sleep_length(ktime
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
+ * @cpu: target CPU number
  *
  * Called from the schedutil frequency scaling governor in scheduler context.
+ *
+ * Return: the current idle calls counter value for @cpu
  */
 unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 {
@@ -1371,6 +1381,8 @@ unsigned long tick_nohz_get_idle_calls_c
  * tick_nohz_get_idle_calls - return the current idle calls counter value
  *
  * Called from the schedutil frequency scaling governor in scheduler context.
+ *
+ * Return: the current idle calls counter value for the current CPU
  */
 unsigned long tick_nohz_get_idle_calls(void)
 {
@@ -1559,7 +1571,7 @@ early_param("skew_tick", skew_tick);
 
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
- * @mode: tick_nohz_mode to setup for
+ * @hrtimer: whether to use the hrtimer or not
  */
 void tick_setup_sched_timer(bool hrtimer)
 {

