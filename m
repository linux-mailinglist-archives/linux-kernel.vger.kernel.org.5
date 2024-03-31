Return-Path: <linux-kernel+bounces-125952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D507892E95
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B51F217DB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA53C38;
	Sun, 31 Mar 2024 04:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOznWRXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035D15BB;
	Sun, 31 Mar 2024 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711858718; cv=none; b=kSn00aGVH7NTCgqt6LZJaxZ08tzLPdpGvhNhWu3StnIbwy/t4DGXkATgCBBrmYo69EPeRPvguCwg22VGCfrR7Z7IQhwQmZmW7VtfDbPfusZGH2qlxT0FvVvstr4xIvnAOOW70yOGy3b3dpuOSZbaxqcc5mtpm9Br0nj3CWcN7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711858718; c=relaxed/simple;
	bh=FjGGn7fcnwjC20CwjxDH4IySQbzGVEHimjsTW4PQZ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWW2C4SulO/wbraMRaRTjNHVXjVq3sBDvRVu84uzkwfqFOpRKo/QhIeHJUnMpfRE594JZZiVn6Crw1+t7l9aKu4oIPltHNWyGDRphRP1MLNg95PtKv/PoOLIomfxBAkacFEUOMW0QOOBapGQ9KRwTPPga74d1ppvNR++YBwBuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOznWRXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C57C433F1;
	Sun, 31 Mar 2024 04:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711858717;
	bh=FjGGn7fcnwjC20CwjxDH4IySQbzGVEHimjsTW4PQZ7o=;
	h=From:To:Cc:Subject:Date:From;
	b=bOznWRXfn341RiBXpzDvVeyHj/MbBKzH1RQzy/xT4GnGnWTkPuFuvi/Nune6/QAUP
	 dTa36Rlg8SsFeGpq439+BN1iD/qvlL8HH7QEEbMog+w2oiB/Tr3JE+9vYv+xck0vvk
	 SBsdzQUN6/ahScm9YLzz6qzc7AC7pgezlHfFozDoihsC/YmIMyUpxZSpKOmLPwGMxz
	 K+uB/lKwIBYNRh0MCuByvqBgyBVgOJrz3vITKN6fnonieXSKMYFIEl5DwwK+vgmy5i
	 V6RpfM/m1tEdCno+B3wlH/1kbMAsc+DyJqe1ybqLnbGoODTK1Uy4wBmgNcpfIVwHwl
	 2ltDQW4g8TB7A==
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
Subject: [PATCH v4 0/4] perf/x86/amd: add LBR capture support outside of hardware events
Date: Sat, 30 Mar 2024 21:18:26 -0700
Message-ID: <20240331041830.2806741-1-andrii@kernel.org>
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

Andrii Nakryiko (4):
  perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
  perf/x86/amd: avoid taking branches before disabling LBR
  perf/x86/amd: support capturing LBR from software events
  perf/x86/amd: don't reject non-sampling events with configured LBR

 arch/x86/events/amd/core.c   | 37 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/amd/lbr.c    | 11 +----------
 arch/x86/events/perf_event.h | 11 +++++++++++
 3 files changed, 48 insertions(+), 11 deletions(-)

-- 
2.43.0


