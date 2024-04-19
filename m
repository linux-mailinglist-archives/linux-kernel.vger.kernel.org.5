Return-Path: <linux-kernel+bounces-151835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5874A8AB48A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ADF1C21705
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A913AD1E;
	Fri, 19 Apr 2024 17:51:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87E4D110
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549066; cv=none; b=YWztBlJnkCR4Hsupl0P/D4HvcQijlR/Z5o++/9SSF8o3fJVdBfg4y2t9TRibjjF11bMa4Duo2H6SNt2cR3lgA37BOSmA/0f4XLcXxakDSkqmHV/r//qUvsYplEwe5vN4R/sLBkSUUnBK58BfrWkU5MTqrNJcMG1Qv9FcZ3Woc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549066; c=relaxed/simple;
	bh=xm/cEdvDwJOM1RuJcs5xQuCfb8lKFQSKWCg69BNzd/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fEPARPm+6fD4ega8ApdLSIEI5XQmdB9AA7faScl2tP5F4QjmU2SCUWdFg5Pn7jzEzDx/4kIWq4N3Niq1aPhQVpFvLOHZ0++iL3IByCguSLqW2ywcSh92ynwiZyaigkzoEsiXaRJwxYQ9L/tURnSHIh38OpabQnff1vY/7OIaYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22067C116B1;
	Fri, 19 Apr 2024 17:51:04 +0000 (UTC)
Date: Fri, 19 Apr 2024 18:51:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.9-rc5
Message-ID: <ZiKvB7Pp62tFAoBP@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit e3ba51ab24fddef79fc212f9840de54db8fd1685:

  arm64: tlb: Fix TLBI RANGE operand (2024-04-10 18:22:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 50449ca66cc5a8cbc64749cf4b9f3d3fc5f4b457:

  arm64: hibernate: Fix level3 translation fault in swsusp_save() (2024-04-19 16:33:00 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix a kernel fault during page table walking in huge_pte_alloc() with
  PTABLE_LEVELS=5 due to using p4d_offset() instead of p4d_alloc()

- head.S fix and cleanup to disable the MMU before toggling the
  HCR_EL2.E2H bit when entering the kernel with the MMU on from the EFI
  stub. Changing this bit (currently from VHE to nVHE) causes some
  system registers as well as page table descriptors to be interpreted
  differently, potentially resulting in spurious MMU faults

- Fix translation fault in swsusp_save() accessing MEMBLOCK_NOMAP memory
  ranges due to kernel_page_present() returning true in most
  configurations other than rodata_full == true,
  CONFIG_DEBUG_PAGEALLOC=y or CONFIG_KFENCE=y

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64/hugetlb: Fix page table walk in huge_pte_alloc()

Ard Biesheuvel (2):
      arm64/head: Drop unnecessary pre-disable-MMU workaround
      arm64/head: Disable MMU at EL2 before clearing HCR_EL2.E2H

Yaxiong Tian (1):
      arm64: hibernate: Fix level3 translation fault in swsusp_save()

 arch/arm64/kernel/head.S    | 7 +++++--
 arch/arm64/mm/hugetlbpage.c | 5 ++++-
 arch/arm64/mm/pageattr.c    | 3 ---
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
Catalin

