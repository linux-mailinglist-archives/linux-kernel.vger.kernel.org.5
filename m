Return-Path: <linux-kernel+bounces-167787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A168BAF33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5491C215CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D64AEEF;
	Fri,  3 May 2024 14:46:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A14643A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747582; cv=none; b=sIbHephJlcPmWanBZxoVupukCz8sv0KSf6wlPaQG4m+U7R2+1/07HzWEC5ja9P2VS2lvrshGlPjkKKRMHfr0WyGnemtXWQxPT7n0mvOk6Ua0pGYXToOGN5Z5+teZ+iSZ4tpXkfP2e/bGOkXBN2s1xIlnFgRs5kiC6vgFzznZ3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747582; c=relaxed/simple;
	bh=dNT48mwrRLOK5MSIcUNVw6Bch5bQp2NytgNpxypW/Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvaCAw7+UKUbmrcu+wZRR41nDmWVRTyEpyMfCBf7mc9yHMBmAloZX/c9IlIHlpGzEWbumWz4a31HtyVv3CN8vrPjej5wniDN5/J02UkQ37RMABnJym1z8S0kiP35FqP4aPzXPVrLT6aW4pKC4SpekEiLitMkC1OEa2xenwEJnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 580D813D5;
	Fri,  3 May 2024 07:46:45 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E60B3F73F;
	Fri,  3 May 2024 07:46:18 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] arm64/mm: Enable userfaultfd write-protect
Date: Fri,  3 May 2024 15:45:58 +0100
Message-ID: <20240503144604.151095-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series adds uffd write-protect support for arm64.

Previous attempts to add uffd-wp (and soft-dirty) have failed because of a
perceived lack of available PTE SW bits. However it actually turns out that
there are 2 available but they are hidden. PTE_PROT_NONE was previously
occupying a SW bit, but can be moved, freeing up the SW bit. Bit 63 is marked as
"IGNORED" in the Arm ARM, but it does not currently indicate "reserved for SW
use" like it does for the other SW bits. I've confirmed with the spec owner that
this is an oversight; the bit is intended to be reserved for SW use and the spec
will clarify this in a future update.

So now we have two spare bits; patch 4 enables uffd-wp on arm64, using the SW
bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
(e.g. soft-dirty - see RFC at [4] - or some other usage).

---

This applies on top of v6.9-rc5.

All mm selftests involving uffd-wp now run. However, this work exposed a bug in
core-mm that was leading to some test uffd-wp failures in the pagemap_ioctl
test. The fix for that is posted at [5], and is in mm-hotfixes-unstable. With
the fix applied, all the uffd-wp tests pass and no other selftest regressions
are observed.


Changes since v3 [3]
====================

patch 1 & 2 (was patch 1):
  - Split into 2 patches (per Anshuman):
     - patch 1: generalizes PMD_PRESENT_INVALID
     - patch 2: removes PTE_PROT_NONE
  - Re-aded comment for PTE_PRESENT_INVALID (per Anshuman)


Changes since v2 [2]
====================

patch 1:
  - Renamed PTE_INVALID -> PTE_PRESENT_INVALID, pte_invalid() ->
    pte_present_invalid() (per Catalin)
  - Added comment explaining test in pte_protnone() (per Will)
  - Added R-b (thanks to Catalin)
patch 2:
  - Move PTE_PRESENT_INVALID to PTE_NG instead of PTE_NS (per Will)
  - Added R-b (thanks to Catalin)
patch 3:
  - Added R-b (thanks to Catalin, David)


Changes since v1 [1]
====================

patch 1 & 2 (was patch 1):
  - generalized PMD_PRESENT_INVALID into PTE_INVALID
  - removed explicit PTE_PROT_NONE bit
patch 3 (was patch 2):
  - collected R-b/A-b from Peter and Catalin - thanks!


[1] https://lore.kernel.org/linux-arm-kernel/20240424111017.3160195-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20240429140208.238056-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20240501145419.1390363-1-ryan.roberts@arm.com/
[4] https://lore.kernel.org/all/20240419074344.2643212-1-ryan.roberts@arm.com/
[5] https://lore.kernel.org/all/20240429114104.182890-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (4):
  arm64/mm: generalize PMD_PRESENT_INVALID for all levels
  arm64/mm: Remove PTE_PROT_NONE bit
  arm64/mm: Move PTE_PRESENT_INVALID to overlay PTE_NG
  arm64/mm: Add uffd write-protect support

 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/pgtable-prot.h |  19 +++--
 arch/arm64/include/asm/pgtable.h      | 104 +++++++++++++++++++-------
 3 files changed, 91 insertions(+), 33 deletions(-)

--
2.43.0


