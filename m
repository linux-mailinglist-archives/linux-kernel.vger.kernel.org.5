Return-Path: <linux-kernel+bounces-124037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9111891172
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D9128F2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66F3A8C0;
	Fri, 29 Mar 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcbSpSil"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D62C68C;
	Fri, 29 Mar 2024 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678184; cv=none; b=PW5jF8WSbTrTibDqltiqnlk0jsS/1+SNm0X3CJh6Msy0fo67dubDJg2Ivs+apOfoBV/OfdZ4CcQcYNUYubxpsfwdjGyHE1tkPD6FmZC2KYZOfIzoByVf6PtAaypMSw2YsjWtzFXDpq+FrViMEUc+pywiK9eoe2xoBQF4rUPUtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678184; c=relaxed/simple;
	bh=L98bHTa7C7ExooOa5n0J0qSnhQrzRsiRFuKgyofpwGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCbw1Dn/04izTJgSN4KALb2geLmUgZg/yf2yBv8TQfcMS0Q4sYUZRJwR9OBz5qOhHnluphxy9vOZwNLkk//prmohYaYbglNFBkQzDNioMZjBy4LOdYhRexDvUNZmFhZZhsVJT6NR8L1gJXfiCnTeGXuF/eROclw4CRWCvYkFau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcbSpSil; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678182; x=1743214182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L98bHTa7C7ExooOa5n0J0qSnhQrzRsiRFuKgyofpwGo=;
  b=EcbSpSilF1q10cQmZnWPGSdmIaBO2woJ4Krl3aBh5ZHXlV8yRzaemOj7
   VCho/C70AvkF5NJ1rS/y0LN09ax03sKHDEy+eaem4mjoPFZdyIjAGBKRP
   XpGHs9v0AdRmw5EUoc1ogxwZoc1VeQiR30B6pwB8rEQfenYj0R4l3+d2Z
   HnklJusI0H3TU/PdeZ06jdkFD4PRfJiM5WgqSkBuqEqAxtVWXoPc2ubEH
   ls5udX1g7Ag50DcOtRcVnlYt1JrGB2U5wCG0n+43J8DYTwGlSP9aPUhdF
   kbJAmhFdswQ9sf6jm+RUbrkpLpUjQ+yPnWV2e2fWVrLJ7jMZTywpGwy32
   Q==;
X-CSE-ConnectionGUID: pu3J4a77RRy5cSoCaDtS0A==
X-CSE-MsgGUID: yZu85nj+S9+SWi4rbXapkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700056"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700056"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301395"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:42 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 05/14] x86/msr-index: Add MSRs for Key Locker wrapping key
Date: Thu, 28 Mar 2024 18:53:37 -0700
Message-Id: <20240329015346.635933-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wrapping key resides in the same power domain as the CPU cache.
Consequently, any sleep state that invalidates the cache, such as S3,
also affects the wrapping key's state.

However, as the wrapping key's state is inaccessible to software, a
specialized mechanism is necessary to save and restore the key during
deep sleep.

A set of new MSRs is provided as an abstract interface for saving,
restoring, and checking the wrapping key's status. The wrapping key
is securely saved in a platform-scoped state using non-volatile media.
Both the backup storage and its path from the CPU are encrypted and
integrity-protected to ensure security.

Define those MSRs for saving and restoring the key during S3/4 sleep
states.

Note that the non-volatility of the backup storage is not architecturally
guaranteed across off-states such as S5 and G3. In such cases, the kernel
may generate a new key during the next boot.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
Changes from v8:
* Tweak the changelog.

Changes from v6:
* Tweak the changelog -- put the last for those about other sleep states

Changes from RFC v2:
* Update the changelog. (Dan Williams)
* Rename the MSRs. (Dan Williams)
---
 arch/x86/include/asm/msr-index.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 05956bd8bacf..a451fa1e2cd9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1192,4 +1192,10 @@
 						* a #GP
 						*/
 
+/* MSRs for managing a CPU-internal wrapping key for Key Locker. */
+#define MSR_IA32_IWKEY_COPY_STATUS		0x00000990
+#define MSR_IA32_IWKEY_BACKUP_STATUS		0x00000991
+#define MSR_IA32_BACKUP_IWKEY_TO_PLATFORM	0x00000d91
+#define MSR_IA32_COPY_IWKEY_TO_LOCAL		0x00000d92
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.34.1


