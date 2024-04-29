Return-Path: <linux-kernel+bounces-162410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF78B5AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8881F23A48
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D79757ED;
	Mon, 29 Apr 2024 14:02:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D7762D7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399343; cv=none; b=Gf9AZPxOw6Xcts6dfMUaqC9JSZenT1BXfjjFsks2GE57kWoJZ+PJv+Ee94Fn48RVNppKni91ULd1s7NLDFB64fLExKoLw6C7NwfhkCZpEkxeSdw1JgRv03JJeRB/TSOntU7b6kHGjOW5W3uf2JrodhGKRF9GqL2uIKR+vDpjcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399343; c=relaxed/simple;
	bh=rMnHZjdQN+Aqo4+QWB8UaGoJOi4w06hu8T/CVzfU8nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQ+IPvpDXUm3nUOfBHE9TPCi2gbLG+XyMH/BurqkJwr35sp6mheh59Aq2Nx72fNHtACNSmLzQgrl2z9tFxWt+m/yBa2asB8/Bxp2vNxKbJrf+KmWRWGresIDcF4E5/zBbsjhWxKpiO0LyVbN4xsJkpFHy62mgnEHYQH2/BBvYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C7282F4;
	Mon, 29 Apr 2024 07:02:45 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3E153F793;
	Mon, 29 Apr 2024 07:02:16 -0700 (PDT)
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
Subject: [PATCH v2 0/3] arm64/mm: Enable userfaultfd write-protect
Date: Mon, 29 Apr 2024 15:02:04 +0100
Message-Id: <20240429140208.238056-1-ryan.roberts@arm.com>
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
(e.g. soft-dirty - see RFC at [2] - or some other usage).

---

This applies on top of v6.9-rc5.

All mm selftests involving uffd-wp now run. However, this work exposed a bug in
core-mm that was leading to some test uffd-wp failures in the pagemap_ioctl
test. The fix for that is posted at [3]. With the fix applied, all the uffd-wp
tests pass and no other selftest regressions are observed.


Changes since v1 [1]
====================

patch 1 & 2 (was patch 1):
  - generalized PMD_PRESENT_INVALID into PTE_INVALID
  - removed explicit PTE_PROT_NONE bit

patch 3 (was patch 2):
  - collected R-b/A-b from Peter and Catalin - thanks!


[1] https://lore.kernel.org/linux-arm-kernel/20240424111017.3160195-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/all/20240419074344.2643212-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/all/20240429114104.182890-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (3):
  arm64/mm: Refactor PMD_PRESENT_INVALID and PTE_PROT_NONE bits
  arm64/mm: Move PTE_INVALID to overlay PTE_NS
  arm64/mm: Add uffd write-protect support

 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/include/asm/pgtable-prot.h  | 17 ++---
 arch/arm64/include/asm/pgtable.h       | 88 +++++++++++++++++++-------
 4 files changed, 75 insertions(+), 32 deletions(-)

--
2.25.1


