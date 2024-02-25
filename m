Return-Path: <linux-kernel+bounces-80327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B835862D74
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800E21F21BA6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0C1BC27;
	Sun, 25 Feb 2024 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0Ko0lot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC01B947
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901714; cv=none; b=KgER/X/sqhGnysh1Lga0mNHrRwmMMWgKhtCWe98IVwmoX0CJKQzkMonoEsQYw7h1fTqT4SSMq/rc+hApJv1Eu0A/CljRsUoOLKzxSaxkwTqP/3Pc4uPySzdmtBhTMRAbd+1lR4wCQDrlFK4zLxg2p/HPTY7Utl6axFsWXtvOi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901714; c=relaxed/simple;
	bh=xN5KqWF8+jxp1fVahcYZnWcHbDF58rr/ulFRlSkcI94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kMEcobsdD8zJoLirACKGmp1HP26Gd6Y1MlDalvbICd3psjrfKE35aK20euk0O2qhGVjm1c2m8F/OuOmRkw8MwaPvAiP7/nrSFdHIG497iCQ4IaeHy5vH1EcwlyvbcfxTQVi37cDWThO9fyelrbnYUOUvr2Y/dRPlbzbI3oO0TrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0Ko0lot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB25C433F1;
	Sun, 25 Feb 2024 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901713;
	bh=xN5KqWF8+jxp1fVahcYZnWcHbDF58rr/ulFRlSkcI94=;
	h=From:To:Cc:Subject:Date:From;
	b=D0Ko0lotlxlU6WvQvSIeVlDm9SZdRG2grGjk9HXI239//mxgzIU/su6dlH3BuNiFN
	 FE/SV4/QGTMqW0X0Euj9foNU4e3LuS0V8BmETDsVH4hpJmqVecaUF45Bx2hhXUNu9w
	 22oPcaH8bQG1+6UHof8fhW1mFNDhXC+gF5OLR2PUxNtqORosv5BhmcKzd3PjpZvcN8
	 KwhJPpae2tWxbajFXenM+KDGtEaTOW9Fnw6iqh93psANqWfVM87TC+OVDqrdh7Ytiu
	 BO5x/R8mcP9FGgk10F8ueuoY00FoW0g6W5Wb5Eefq+I87XX5bPCt3oEClX4OowMMAv
	 h4sD/gu30w1Kg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/16 v3] timers/nohz cleanups and hotplug reorganization
Date: Sun, 25 Feb 2024 23:54:52 +0100
Message-ID: <20240225225508.11587-1-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Here are some cleanups here and there and also some more rational tick
related CPU hotplug code reorganization.

Changes since v3:

* Rebase against latest tip:timers/core (after tmigr introduction)
* New patch "timers: Assert no next dyntick timer look-up while CPU"

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        timers/hotplug-v3

HEAD: a0d432ebab0b7f75e03049d5d2baabff7f39ee1d

Frederic Weisbecker (14):
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
  tick: Assume timekeeping is correctly handed over upon last offline
    idle call
  timers: Assert no next dyntick timer look-up while CPU is offline

Peng Liu (2):
  tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and
    tick_setup_sched_timer()
  tick/nohz: Remove duplicate between lowres and highres handlers

 include/linux/cpuhotplug.h  |   1 +
 include/linux/tick.h        |  16 +-
 kernel/cpu.c                |  11 +-
 kernel/sched/idle.c         |   1 -
 kernel/time/hrtimer.c       |   4 +-
 kernel/time/tick-common.c   |  31 ++--
 kernel/time/tick-internal.h |   2 +
 kernel/time/tick-sched.c    | 297 +++++++++++++++++-------------------
 kernel/time/tick-sched.h    |  40 ++---
 kernel/time/timer.c         |   6 +-
 kernel/time/timer_list.c    |  10 +-
 11 files changed, 215 insertions(+), 204 deletions(-)

-- 
2.43.0


