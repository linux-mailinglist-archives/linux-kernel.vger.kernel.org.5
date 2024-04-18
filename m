Return-Path: <linux-kernel+bounces-149557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA18A92DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A82EB2176C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572C6A343;
	Thu, 18 Apr 2024 06:15:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB558129
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420953; cv=none; b=Ry33oZuxaSZncYhPe6fCqEI8LLiFRD+AbgLSostxttvnNlmpyHLFanpRjzAuVufUH3NEmG3Hd80vqvQTSGNJz3o/RqYlc+7JP1GTNfU3xErIisJtALMHB24K6GbT6GT841HQWc0K6lQfIgeix349mHoOpTcpJdogdGCCyLv9I6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420953; c=relaxed/simple;
	bh=DwZ21YpU6DS7qxbUmMpNArY0GTu0rE1pYDwE/6PUoUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n4SeiXn7MUSrbJ7Hs6M16HhxHosYy9K9QlO+Ukbb6qzUUAMiF4gKyN4DtMzO3GJVHjOUCG6uWWwQFaNL3y2RrY89bhQ2uZtinBLpJKY/XHZ+JSDBSpizd1Ma8+fKItqU4Ik/vPbqnHjX+SdN6sJi/9sLFbLLz+kGochF07iVtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-02-6620ba92c48d
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v9 rebase on mm-unstable 2/8] arm64: tlbflush: add APIs manipulating tlb batch's arch data
Date: Thu, 18 Apr 2024 15:15:30 +0900
Message-Id: <20240418061536.11645-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXC9ZZnke6kXQppBlsPWVrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	hR2bWQv2cFXs/3mIsYHxJkcXIweHhICJxKxnfl2MnGDmzT13WUFsNgF1iRs3fjKD2CICZhIH
	W/+wg9jMAneZJA70s4HYwgJZEid/LGMCsVkEVCX+XzzKDDKSV8BUon2mAMRIeYnVGw6AjeEE
	GtP//hAjSIkQUMmFvyFdjFxAJZ/ZJJpvH2SHqJeUOLjiBssERt4FjAyrGIUy88pyEzNzTPQy
	KvMyK/SS83M3MQKDflntn+gdjJ8uBB9iFOBgVOLhPXlAPk2INbGsuDL3EKMEB7OSCG+LsGya
	EG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsYerauXVWbG
	rOuXm1rZrhQt9s87p3JXpNbefJbbF38USa8KWFTu/nHCQYt18/n+uryrqQqfGbVr64XlXR9S
	DTzUbty4npJZ63G3426t558jYtczji1u5Lx79NqU2DPORpf/H9a5FKVWoMjtlLBLc7PEXpe2
	5C11dhfYnDe/8Ll188nVkK0fZTqVWIozEg21mIuKEwHdYkdfdgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrDtpl0Kawb7zehZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyljYsZm1YA9Xxf6fhxgbGG9ydDFyckgImEjc3HOXFcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/G4gtLJAlcfLHMiYQm0VAVeL/xaNA9RwcvAKmEu0zBSBGykus3nAA
	bAwn0Jj+94cYQUqEgEou/A2ZwMi1gJFhFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmAQL6v9
	M3EH45fL7ocYBTgYlXh4TxyQTxNiTSwrrsw9xCjBwawkwtsiLJsmxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwPhoA4/oknqJpz/2zlzXIlBSt3HOsod7
	50Y69O18X3Lx2Y1bB7td31Xochfc/Lvfv+joROvsF+mXF32rKFDweTXr6/4j7p27vni6eTgG
	2yf9Mj/y3rr/wq7mN4km1+2tmv8bmH+4OGvFsRrve+/O3/iQkHbG99t5htNq55W/h7IH6Qoy
	stWmatgrsRRnJBpqMRcVJwIASJLWsl4CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to manipulate
tlb batch's arch data.  Even though arm64 does nothing for it, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a75de2665d84..b8c7fbc1c68e 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -347,6 +347,24 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	/* nothing to do */
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* Kernel can consider tlb batch always has been done. */
+	return true;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


