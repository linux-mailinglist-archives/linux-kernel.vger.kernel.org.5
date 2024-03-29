Return-Path: <linux-kernel+bounces-124038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92791891174
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC582902DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E33BBE2;
	Fri, 29 Mar 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kv2EoZqV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B033A1B5;
	Fri, 29 Mar 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678186; cv=none; b=UH25RMncErGKqDcHmsDLMA41uA849zDbCW9TOPjWESWBqxV7P4FzMwabWNwnIlq6G1dbKTIWvNzO7wgWRi23rd6/UUQYvHQ49qn7rJXlY7aNrSmFYTj5E0CkoRfOTAmS2tP+2wbDRLY8GStykwjrnHeCLACz+9md6PT3P+yhBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678186; c=relaxed/simple;
	bh=aLdZ4Gq66eiPhVW+fge8rLHBtRcUDjGDQQLqA+I8V7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9O2vWyaEPGTB5cID1+gHecE5GSVWdoLULE+a1AEE2SzkPBWAXznqSbBjegbFjHGHdZkYLIATnVfR1o7qEyS+vfzppRGgQgGrnG4Er3UkGwAFkDaK4j99AeWj1eCcmiF8VlaCNGFJT8i7YwP/gLrJBCAgsdEcQUMm8ZMgpJKu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kv2EoZqV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678184; x=1743214184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aLdZ4Gq66eiPhVW+fge8rLHBtRcUDjGDQQLqA+I8V7E=;
  b=kv2EoZqVdSaIFMmG2g2nJqV+xd7cyJwuR+M6BzsaCWMAqMPxAaDOz3xr
   /7aVQS5aYBmb8BEq5Y08/xkgAdaNi808cxHA8VD94oD0/S2Yu0ZFLYbpF
   LKGIKbDIynAsLNHc3/46li8TXgsFhA5vxZ/1h9iiirJFnsWfmyKGhk+Wv
   ZYZTWYTtZYv7leJJYgs9mxMK07BsUHX18/dLoDsUq2wKCXrCKcdgoXwM6
   mocTpfDhzlTnn/dbNcjExe7kO83e95q79zp9+7XfMw4H+jL3XSviOK8bc
   vvS+nTXbdFexeYghrI3ygrBlQECWC/Wtb1Jp5mhpwEme82I3c9zV2uBun
   Q==;
X-CSE-ConnectionGUID: dK6owm9xR4GpFSOurCf1yg==
X-CSE-MsgGUID: mShV2ocBTD2mmtQpcQH2xA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700064"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700064"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301402"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:43 -0700
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
Subject: [PATCH v9 06/14] x86/keylocker: Define Key Locker CPUID leaf
Date: Thu, 28 Mar 2024 18:53:38 -0700
Message-Id: <20240329015346.635933-7-chang.seok.bae@intel.com>
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

Both Key Locker enabling code in the x86 core and AES Key Locker code
in the crypto library will need to reference feature-specific CPUID bits.
Define this CPUID leaf and bits.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
Changes from v6:
* Tweak the changelog -- comment the reason first and then brief the
  change.

Changes from RFC v2:
* Separate out the code as a new patch.
---
 arch/x86/include/asm/keylocker.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 4e731f577c50..1213d273c369 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -5,6 +5,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bits.h>
 #include <asm/fpu/types.h>
 
 /**
@@ -21,5 +22,11 @@ struct iwkey {
 	struct reg_128_bit encryption_key[2];
 };
 
+#define KEYLOCKER_CPUID			0x019
+#define KEYLOCKER_CPUID_EAX_SUPERVISOR	BIT(0)
+#define KEYLOCKER_CPUID_EBX_AESKLE	BIT(0)
+#define KEYLOCKER_CPUID_EBX_WIDE	BIT(2)
+#define KEYLOCKER_CPUID_EBX_BACKUP	BIT(4)
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
-- 
2.34.1


