Return-Path: <linux-kernel+bounces-127287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70894894942
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA201C23527
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA44E567;
	Tue,  2 Apr 2024 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUCRASCY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E983201;
	Tue,  2 Apr 2024 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024483; cv=none; b=Ve4dmN5wEO71pDwtSdrXm9knkj08hXCAgoguZaigGMiiZMslJF00G/61A2UK00Ew/Yi8B5OJatKWn6NNOcXasbR42a+1B28EynOLAo3VxOQODX/Gn2GLpXk52jshFacSbch9zpU4XEk993YgEES+vR2/qnX2/VcS9e8oSjNLDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024483; c=relaxed/simple;
	bh=Og/+JDitgrRM0fH/rw9CSzIBupnsDehGZbLbP4VdvLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3Pk88jk0eZbJUAqOevbVVFv9W4c1JKijjjxfAk8apt7Wly1Qmgzpr7jiL52ZK8iYdeWgIjaEWiYgTighK+V45qUZ1HeA34Xq3mBGZZLOcWWHOzpfoTCcmsyS+FgNawFp8hvu6K+hsEgeBfWiDDFBzpcXEzVk9zPvk10abB4fNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUCRASCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E28DC433C7;
	Tue,  2 Apr 2024 02:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712024483;
	bh=Og/+JDitgrRM0fH/rw9CSzIBupnsDehGZbLbP4VdvLE=;
	h=From:To:Cc:Subject:Date:From;
	b=QUCRASCYLY87O5ee0YFs1PTo/XRNpEB7qvuHXvtchmFROQSCUXAadT3/oaaKbiLp6
	 Yp0jfym/1qh7tTOQ0m/mBHTmW4Rk6sN94/RrWSJfchA+dbLGMOgmIoOTFrJ1oR04FI
	 jlrW9e0IgmUQce6JpU/SuBDTDJ/EWi2OQFFyouCbhARDmdHM8Vs/MgqEdyarurQwMU
	 vWBHDGU8IaCfuCF2IsT63bKZtzNJNpYOkmxz7qEgtBK8y4p8SRkz8IpWBrGjJE+OvD
	 49pDy+yShsuyhwconPBp9Uu6/z5uzFjhlGg6eOi+E6WpaLGODmTFlqwmRRz+WUkch3
	 jstNB/lVuQYvA==
From: Andrii Nakryiko <andrii@kernel.org>
To: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	song@kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 0/4] perf/x86/amd: add LBR capture support outside of hardware events
Date: Mon,  1 Apr 2024 19:21:14 -0700
Message-ID: <20240402022118.1046049-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add AMD-specific implementation of perf_snapshot_branch_stack static call that
allows LBR capture from arbitrary points in the kernel. This is utilized by
BPF programs. See patch #3 for all the details.

Patches #1 and #2 are preparatory steps to ensure LBR freezing is completely
inlined and have no branches, to minimize LBR snapshot contamination.

Patch #4 removes an artificial restriction on perf events with LBR enabled.

v4->v5:
  - rebased on top of perf/urgent branch to resolve conflicts with
    598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability").

Andrii Nakryiko (4):
  perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
  perf/x86/amd: avoid taking branches before disabling LBR
  perf/x86/amd: support capturing LBR from software events
  perf/x86/amd: don't reject non-sampling events with configured LBR

 arch/x86/events/amd/core.c   | 37 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/amd/lbr.c    | 13 +------------
 arch/x86/events/perf_event.h | 13 +++++++++++++
 3 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.43.0


