Return-Path: <linux-kernel+bounces-131621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE291898A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69896281DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0102179AA;
	Thu,  4 Apr 2024 14:33:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09B10A19
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241201; cv=none; b=OQ0tNw0rO+J/nJJxRCNmxtTAXZKWgM+Wt1b9K1ThI5EW1ymXP1bGpbzeFal2jywyVsel3Xlcvz0zpGWPbSctrRJuQzIs8xOiWJ4tTi814p1dwajMpV4I60pGFBuavxoillgNMFCUMHsSol6HX56bdCEXibIPxo94vY/t5TOmZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241201; c=relaxed/simple;
	bh=jlmku7RatfworrazUzsfj/1dtMg3H6tYvOlS0mINCKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YiTllvRLUsMfnSkG87n7BOdqm6uYzt843lbNNOkN9/Rp7SEcuU6RgjqXCzQQKRE2t0ZngV3KR2YakuUIdoSl41ExDMnns/v/0CR/mhJWkI9F9TViLfhQDLR0lHoPSY13k1eAUCdl0ZEUvYHPuY/Ggr8PdgHdT8uNXuwvwQOkBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F02DFEC;
	Thu,  4 Apr 2024 07:33:49 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6499A3F64C;
	Thu,  4 Apr 2024 07:33:17 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Speed up boot with faster linear map creation
Date: Thu,  4 Apr 2024 15:33:04 +0100
Message-Id: <20240404143308.2224141-1-ryan.roberts@arm.com>
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
the total boot time, especially when rodata=full. And most of the time is spent
waiting on superfluous tlb invalidation and memory barriers. This series reworks
the kernel pgtable generation code to significantly reduce the number of those
TLBIs, ISBs and DSBs. See each patch for details.

The below shows the execution time of map_mem() across a couple of different
systems with different RAM configurations. We measure after applying each patch
and show the improvement relative to base (v6.9-rc2):

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
base           |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   (0%)
no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 (-78%)
batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) |  1656 (-91%)
no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) |  1257 (-93%)
lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) |   838 (-95%)

This series applies on top of v6.9-rc2. All mm selftests pass. I've compile and
boot tested various PAGE_SIZE and VA size configs.

---

Changes since v1 [1]
====================

  - Added Tested-by tags (thanks to Eric and Itaru)
  - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
  - Reordered patches (biggest impact & least controversial first)
  - Reordered alloc/map/unmap functions in mmu.c to aid reader
  - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
  - Reverted generic p4d_index() which caused x86 build error. Replaced with
    unconditional p4d_index() define under arm64.


[1] https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/

Thanks,
Ryan


Ryan Roberts (4):
  arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
  arm64: mm: Batch dsb and isb when populating pgtables
  arm64: mm: Don't remap pgtables for allocate vs populate
  arm64: mm: Lazily clear pte table mappings from fixmap

 arch/arm64/include/asm/fixmap.h  |   5 +-
 arch/arm64/include/asm/mmu.h     |   8 +
 arch/arm64/include/asm/pgtable.h |  13 +-
 arch/arm64/kernel/cpufeature.c   |  10 +-
 arch/arm64/mm/fixmap.c           |  11 +
 arch/arm64/mm/mmu.c              | 377 +++++++++++++++++++++++--------
 6 files changed, 319 insertions(+), 105 deletions(-)

--
2.25.1


