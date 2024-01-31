Return-Path: <linux-kernel+bounces-47344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A8D844CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D004284087
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C47C3BB37;
	Wed, 31 Jan 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ0El5pK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D633BB22
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742686; cv=none; b=dPZXSRMzLOg+1zIbAuYsgUaIpMvDX6+8pkNmc3LxOWCyaGVwozv/rxQOLV1MdOILHCBt/rf7/XfGiWhN7nGEXz7B9NNExlVO5/2nmeGHUSbE+NAxbwpyKvryk/WqFJWbIgV+eDkgv/R8HihqSvSmmf0VdqaMGfFoz5Ue6ieUYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742686; c=relaxed/simple;
	bh=8/cHDQ2a2ff4CLNkIPVLEkwBFQAl5xC0U6epddcvZBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKVnl3GXB3MMUR/Oc7Iq3byG0BI8FWZg9dzR2AChdzIOYMZMhBn4uie425S1bvjxhaYTdQdKUWq5nN1tJa+juV6Ei0Ae8Ne3M31/IXaEOY5ni8YnBPGPzvsG32cjrcHuFZniEFBGBzGGR517L1iHaVisOPG8qSu3/emhvdOYpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ0El5pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A80EC433F1;
	Wed, 31 Jan 2024 23:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742685;
	bh=8/cHDQ2a2ff4CLNkIPVLEkwBFQAl5xC0U6epddcvZBo=;
	h=From:To:Cc:Subject:Date:From;
	b=HJ0El5pKw470bTOmY0OecVaWlkNLoZ6MOX5saXGsH6DkJ0thfBpV8TFncM9+Rcv89
	 SkSyfez0QoCa6kcR0LjXzEP3yMA+dnLavDdXZw0bIvJOJ53wRBS4Nz5rC+F7vunAOd
	 3Cc2aBTdSJQgTckpjhIykBBi49l28oPVTKQxl6iro9vOnizhayzza55YScWlzoWmBY
	 n8nmX1KXOdiaamM/5JZ3wKuFLsyevS7DX0G8qf/CbnncTnVDvnkCp2LgTsNzlMZH3d
	 wnZl9W/9DBfuKs8SGOW4HrMgiTynv4DNlGfszPSPx4tu1npoo320zdV2nKIIyp4n2u
	 t7ug9p++fMyaw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/15 v2] timers/nohz cleanups and hotplug reorganization
Date: Thu,  1 Feb 2024 00:11:05 +0100
Message-ID: <20240131231120.12006-1-frederic@kernel.org>
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

Changes since v2:

* Add some IS_ENABLED(CONFIG_HIGH_RES_TIMERS) to optimize code
* Rename tick_nohz_highres_handler() to tick_nohz_handler()
* Add Reviewed-by tags

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/hotplug-v2

HEAD: 6921da4d7425bd33618bfec67fb2e564ea37b756

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
 kernel/time/tick-sched.c    | 295 +++++++++++++++++++++-----------------------
 kernel/time/tick-sched.h    |  40 +++---
 kernel/time/timer_list.c    |  10 +-
 10 files changed, 211 insertions(+), 200 deletions(-)

