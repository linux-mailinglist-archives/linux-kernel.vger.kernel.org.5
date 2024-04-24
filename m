Return-Path: <linux-kernel+bounces-156780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CED8B080B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041FB1C21982
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34ED15AAAF;
	Wed, 24 Apr 2024 11:10:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A215A482
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957030; cv=none; b=vAVbIxuBXtBqDQ/1YTUM4iC8+lUe3BMXCX29xO9Pd4Efge2MWkTYkaWadRjTAGWEaZmcNLX1lkM9jr9wOHYARFgWT5mjK6xPvKu30uhJj7x+EUXoctasgLEFpF9FBzjuTu3C7uhshf5SwSZznoAV4jkqmap+Qj3DKKhAhSuPidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957030; c=relaxed/simple;
	bh=Hp6HU1H9XKj1goSR/zmVzhMG9A3n6qgITSLB6TFTkRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h7kqDwisMXyQM3N1QhSSVc2c4J1qlvnNVIyQJCnh8qGdePZRxnGgkx9PirVYuU5WqZEIDVRsgIzB4ri39DAkew/kRNDnhimM3CyYh/Pv3RqlyipAYF04y05aePOTeY0dhYFw58t15txFKwsUpRdD9sA7Tyaddrm6KDtxiBSsq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5ADB2F;
	Wed, 24 Apr 2024 04:10:54 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ADC13F73F;
	Wed, 24 Apr 2024 04:10:25 -0700 (PDT)
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
Subject: [PATCH v1 0/2] arm64/mm: Enable userfaultfd write-protect
Date: Wed, 24 Apr 2024 12:10:15 +0100
Message-Id: <20240424111017.3160195-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series adds uffd write-protect support for arm64. The patches are
extracted, without change, from a wider RFC I posted at [1].

Previous attempts to add uffd-wp (and soft-dirty) have failed because of a
perceived lack of available PTE SW bits. However it actually turns out that
there are 2 available but they are hidden. PTE_PROT_NONE was previously
occupying a SW bit, but it only applies when PTE_VALID is clear, so this is
moved to overlay PTE_UXN in patch 1, freeing up the SW bit. Bit 63 is marked as
"IGNORED" in the Arm ARM, but it does not currently indicate "reserved for SW
use" like it does for the other SW bits. I've confirmed with the spec owner that
this is an oversight; the bit is intended to be reserved for SW use and the spec
will clarify this in a future update.

So now we have two spare bits; patch 2 enables uffd-wp on arm64, using the SW
bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
(e.g. soft-dirty - see RFC at [1] - or some other usage).

This applies on top of v6.9-rc3. The all mm selftests involving uffd-wp now run
and pass and no other selftest regressions are observed.

[1] https://lore.kernel.org/all/20240419074344.2643212-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (2):
  arm64/mm: Move PTE_PROT_NONE and PMD_PRESENT_INVALID
  arm64/mm: Add uffd write-protect support

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h | 12 ++++-
 arch/arm64/include/asm/pgtable.h      | 71 ++++++++++++++++++++++++---
 3 files changed, 75 insertions(+), 9 deletions(-)

--
2.25.1


