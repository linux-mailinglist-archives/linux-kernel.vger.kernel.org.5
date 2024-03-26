Return-Path: <linux-kernel+bounces-118765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2488BF09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6908A305515
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BA75D49E;
	Tue, 26 Mar 2024 10:15:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACACD5CDD9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448102; cv=none; b=ZSG1YO29fKvsp0tTDf60pG38v53uEKtjI8SX570eUnaNFynW7VFcRoPUG4wcfG54t2Brg1IzNdvALL0y2wrey0pXlNMyjfao5WRleOPYvvDZ3VGpaNHnlcdw4mAQju2n7r2CEZFLgPhVHeCHQ5Zxh5Gh6TQvF3XxCAhH2lfstjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448102; c=relaxed/simple;
	bh=U6mVMLb3MGIT4h2uFZ/xO6sg4pcukjRFqfCkJlPEMdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AwvP3ReP/gUCVpV7R0izPsne2znbS+WGXqe85XHgsn+LWXH//QbeEwp4kDcJmLgt2R5ilERcVO+Et1+2JQB/S8/o2ao87rmQ4yvs/YXxsemBWgx9uCeyFa4GbweQT2ssdSSsuLT4soQvV2hIQDIPzWZBKQ+/ko9jqVZkZE+Jt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 598CD2F4;
	Tue, 26 Mar 2024 03:15:33 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 867653F64C;
	Tue, 26 Mar 2024 03:14:58 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Speed up boot with faster linear map creation
Date: Tue, 26 Mar 2024 10:14:45 +0000
Message-Id: <20240326101448.3453626-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

It turns out that creating the linear map can take a significant proportion of
the total boot time, especially when rodata=full. And a large portion of the
time it takes to create the linear map is issuing TLBIs. This series reworks the
kernel pgtable generation code to significantly reduce the number of TLBIs. See
each patch for details.

The below shows the execution time of map_mem() across a couple of different
systems with different RAM configurations. We measure after applying each patch
and show the improvement relative to base (v6.9-rc1):

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)

This series applies on top of v6.9-rc1. All mm selftests pass. I haven't yet
tested all VA size configs (although I don't anticipate any issues); I'll do
this as part of followup.

Thanks,
Ryan


Ryan Roberts (3):
  arm64: mm: Don't remap pgtables per- cont(pte|pmd) block
  arm64: mm: Don't remap pgtables for allocate vs populate
  arm64: mm: Lazily clear pte table mappings from fixmap

 arch/arm64/include/asm/fixmap.h  |   5 +-
 arch/arm64/include/asm/mmu.h     |   8 +
 arch/arm64/include/asm/pgtable.h |   4 -
 arch/arm64/kernel/cpufeature.c   |  10 +-
 arch/arm64/mm/fixmap.c           |  11 +
 arch/arm64/mm/mmu.c              | 364 +++++++++++++++++++++++--------
 include/linux/pgtable.h          |   8 +
 7 files changed, 307 insertions(+), 103 deletions(-)

--
2.25.1


