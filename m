Return-Path: <linux-kernel+bounces-165392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B337B8B8C2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B081F22132
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DF12DD93;
	Wed,  1 May 2024 14:54:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56112E1D5
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575270; cv=none; b=QdVeuqn0sjBSvmdVt5xRO7Xz8SwrEVTCwcmKNoM3fQ0enuGYzJLkt1UbXh4TFZ65fhY4+wOo/KWnfJdMJbUnND0My+lquMw2+67yo+MeeBAjuoM+nGHTGBT9BJayXmKomA7vXDiAuNPB2Ockt0yKtT780JajmfyK0zNZygy594w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575270; c=relaxed/simple;
	bh=9tzfYpbERcVLhMqCrpr76tHqrDFxfHUDd9FjAQbsQUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hRyJn/lD+WtezwcLOB3SVQNECm3/AstE2wXWa9oL7TcugyJ/1gAXLZkMS4gUrRe/Ilfkx1vzowTts54bPnQlM7MfE2Vu7xOa91sApsDwJiLegIsem82qxSDlj5AmzIhO2YwwtGQcTxhS9s4KdFeJhfSSRNmHs0+lso/2at0oL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03AC42F4;
	Wed,  1 May 2024 07:54:54 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4603F793;
	Wed,  1 May 2024 07:54:26 -0700 (PDT)
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
Subject: [PATCH v3 0/3] arm64/mm: Enable userfaultfd write-protect
Date: Wed,  1 May 2024 15:54:16 +0100
Message-Id: <20240501145419.1390363-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
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

So now we have two spare bits; patch 3 enables uffd-wp on arm64, using the SW
bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
(e.g. soft-dirty - see RFC at [3] - or some other usage).

---

This applies on top of v6.9-rc5.

All mm selftests involving uffd-wp now run. However, this work exposed a bug in
core-mm that was leading to some test uffd-wp failures in the pagemap_ioctl
test. The fix for that is posted at [4], and is in mm-hotfixes-unstable. With
the fix applied, all the uffd-wp tests pass and no other selftest regressions
are observed.


Changes since v1 [1]
====================

patch 1 & 2 (was patch 1):
  - generalized PMD_PRESENT_INVALID into PTE_INVALID
  - removed explicit PTE_PROT_NONE bit
patch 3 (was patch 2):
  - collected R-b/A-b from Peter and Catalin - thanks!


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


[1] https://lore.kernel.org/linux-arm-kernel/20240424111017.3160195-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20240429140208.238056-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/all/20240419074344.2643212-1-ryan.roberts@arm.com/
[4] https://lore.kernel.org/all/20240429114104.182890-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (3):
  arm64/mm: Refactor PMD_PRESENT_INVALID and PTE_PROT_NONE bits
  arm64/mm: Move PTE_PRESENT_INVALID to overlay PTE_NG
  arm64/mm: Add uffd write-protect support

 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/pgtable-prot.h |  17 +++--
 arch/arm64/include/asm/pgtable.h      | 104 +++++++++++++++++++-------
 3 files changed, 87 insertions(+), 35 deletions(-)

--
2.25.1


