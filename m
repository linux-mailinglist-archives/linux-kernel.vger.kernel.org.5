Return-Path: <linux-kernel+bounces-37379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55783AF24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915C01C243B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E97E789;
	Wed, 24 Jan 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGhzjmEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B697E77D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115909; cv=none; b=kgQvlJ5qJyHZ+kfyzo9fx5/89A/0d5koeAJnUBaCgFcibPod0wK/T83XZOrStu9v1jkPowlim9fdDRqSqrucGkoU5NakUC1m3Tq95pniRTlqvLv6PIwzCGnz3YWksf1hNxbRTjiWpCpn6V+0HgfTjlAAbS0nfpeb3j64ZUjqa6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115909; c=relaxed/simple;
	bh=3QVdSsNIVHd+XBav0xMnzNX9FzcXdVijbP2sd6UI4JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfM3KP52f5Ut+uQJWcMMFsSJsBxWJFE6Q2//W8yVWjrukxi6X3PtAWRxZmH1Cz8D61Ddkt7/TTlNELeIGRAkqow44uFAvMntyTWhGgGOH8sF+TIlQZ21jl58Sdjfifs7DM+aKTpLJ1W/0FctXmZwLzWgq6/L3mSVF9+0UGxpJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGhzjmEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B41C433F1;
	Wed, 24 Jan 2024 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115909;
	bh=3QVdSsNIVHd+XBav0xMnzNX9FzcXdVijbP2sd6UI4JU=;
	h=From:To:Cc:Subject:Date:From;
	b=QGhzjmEwWVrlhGuHSAZC8ODXiRdA+FVI22xCDwKGT8RbetWLOU3fTVpibzJtTHEbu
	 13+mp0sRzQi9JJicOw6Y1mHYwMvI8/Dmy6RCCYGi2lYlb/AMJoTvinwhvKq0U1lev5
	 wZz9+8OxnGAWDloSirQhRprvoJk126oPM8cqm1bD7V0M1NBHNF6b1evuI0YcVLusMY
	 59Xhg0ysDQN9XdGMWJBhl5HVdl5e6fQfDG3FFDGKSl/roCAaYn/CUnyxxFCQpOiTZT
	 rk7DOBdoNfDwDI4/bqgy3FeE37LjTPikujAcAn1KnWXYJhfGr3Dxtbs3uBsvqixqJz
	 wMKnV+SG6FWrA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/15] timers/nohz cleanups and hotplug reorganization
Date: Wed, 24 Jan 2024 18:04:44 +0100
Message-ID: <20240124170459.24850-1-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are some cleanups here and there and also some more rational tick
related CPU hotplug code reorganization.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/hotplug

HEAD: 378e195ce2fd96d90ed7c1cde9033cb7079a7274

Thanks,
	Frederic
---

Frederic Weisbecker (13):
      tick: Remove useless oneshot ifdeffery
      tick: Use IS_ENABLED() whenever possible
      tick: s/tick_nohz_stop_sched_tick/tick_nohz_full_stop_tick
      tick: No need to clear ts->next_tick again
      tick: Start centralizing tick related CPU hotplug operations
      tick: Move tick cancellation up to CPUHP_AP_TICK_DYING
      tick: Move broadcast cancellation up to CPUHP_AP_TICK_DYING
      tick: Assume the tick can't be stopped in NOHZ_MODE_INACTIVE mode
      tick: Move got_idle_tick away from common flags
      tick: Move individual bit features to debuggable mask accesses
      tick: Split nohz and highres features from nohz_mode
      tick: Shut down low-res tick from dying CPU
      tick: Assume timekeeping is correctly handed over upon last offline idle call

Peng Liu (2):
      tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
      tick/nohz: Remove duplicate between lowres and highres handlers


 include/linux/cpuhotplug.h  |   1 +
 include/linux/tick.h        |  16 +--
 kernel/cpu.c                |  11 +-
 kernel/sched/idle.c         |   1 -
 kernel/time/hrtimer.c       |   4 +-
 kernel/time/tick-common.c   |  31 +++--
 kernel/time/tick-internal.h |   2 +
 kernel/time/tick-sched.c    | 296 ++++++++++++++++++++++----------------------
 kernel/time/tick-sched.h    |  40 +++---
 kernel/time/timer_list.c    |  10 +-
 10 files changed, 213 insertions(+), 199 deletions(-)

