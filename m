Return-Path: <linux-kernel+bounces-98040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518AC8773FB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591A8B21136
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2051C50;
	Sat,  9 Mar 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/CYXRBT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6B4F200
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710018170; cv=none; b=d0Er4zXf2EECZoTtst/nujoG8p7es3Dh0lvQ9cnav+AsQ9bye7uQXMt5xTpBby7aC1Nw792bVJTvzE2lZrNVPdHFb/0qbLbykJB6EYqgdMnsHJlOYcYRO2qlEUDNY3Wnu9ydEMP/zslLBUaTeji6GLY8wIU/PDouc25ycpC/rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710018170; c=relaxed/simple;
	bh=Jk5tt+gSzYYhQIlktRhIlr+6QKg9CrR+h9qHi82xD1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peCJ4klOpCwqtiUCpQ+pTaKH39kUA4ujM1ofYYkCz3UghGIZxHkAUVeY273GPact8sdSTHf+UA5TP38zifrpGW3ZryQItlm/CIOHddsNQDqbgvtxpPD8bzYm5noNNSH6Y+VpLdVBjlkyX4EOXRuUZGMH5o9B9xvI+v/tHRc/hXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/CYXRBT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710018169; x=1741554169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jk5tt+gSzYYhQIlktRhIlr+6QKg9CrR+h9qHi82xD1w=;
  b=B/CYXRBTq1CO3EIP5Bf+ynumSwyEWPIJGWLeCiNd2m74alrDz1BcWVux
   H0k1oI8ph34TXas9b/dJoKMcSALlFjEU4YipIeGxGlg3U+GpYp19T10SR
   mQFQoqyLsxk6q4pjBSlKHvCC0oXUJ7OxO84z/lPZkicHmxJ6ozXVtOycm
   xaocAc9bDOI4qXsLzKcgaL5VDq5snXVX9/EQJVMA8diAm+l5SRLYMu9qj
   /Bk+toN/eQ1VaBe4scpCzbk7hYd/EjP539wYaw1X0E02/X9KCImuu8fWe
   IOiFx+K9hVooD/rXrQxmzi8RabhEiI0BEexq4lUE8o2xX7jB+jK6iEvwk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4861561"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4861561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 13:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="937048389"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="937048389"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2024 13:02:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6402B385; Sat,  9 Mar 2024 23:02:42 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	ele.reshetova@intel.com,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Date: Sat,  9 Mar 2024 23:02:30 +0200
Message-ID: <20240309210230.239045-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
References: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX 1.0 generates a #VE when accessing topology-related CPUID leafs
(0xB and 0x1F) and the X2APIC_APICID MSR. The kernel returns all
zeros on CPUID #VEs. In practice, this means that the kernel can only
boot with a plain topology. Any complications will cause problems.

The ENUM_TOPOLOGY feature allows the VMM to provide topology
information to the guest in a safe manner. Enabling the feature
eliminates topology-related #VEs: the TDX module virtualizes
accesses to the CPUID leafs and the MSR.

Enable ENUM_TOPOLOGY if it is available.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 20 ++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index d9ea82f8772d..291e45db8d54 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -280,6 +280,26 @@ static void tdx_setup(u64 *cc_mask)
 		else
 			tdx_panic(msg);
 	}
+
+	/*
+	 * TDX 1.0 generates a #VE when accessing topology-related CPUID leafs
+	 * (0xB and 0x1F) and the X2APIC_APICID MSR. The kernel returns all
+	 * zeros on CPUID #VEs. In practice, this means that the kernel can only
+	 * boot with a plain topology. Any complications will cause problems.
+	 *
+	 * The ENUM_TOPOLOGY feature allows the VMM to provide topology
+	 * information to the guest in a safe manner. Enabling the feature
+	 * eliminates topology-related #VEs: the TDX module virtualizes
+	 * accesses to the CPUID leafs and the MSR.
+	 *
+	 * Enable ENUM_TOPOLOGY if it is available.
+	 */
+	if ((features & TDX_FEATURES0_ENUM_TOPOLOGY) &&
+	    tdg_vm_rd(TDCS_TOPOLOGY_ENUM_CONFIGURED)) {
+		tdg_vm_wr(TDCS_TD_CTLS,
+			  TD_CTLS_ENUM_TOPOLOGY,
+			  TD_CTLS_ENUM_TOPOLOGY);
+	}
 }
 
 /*
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 29a61c72e4dd..2964c506b241 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -27,15 +27,18 @@
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
+#define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
 
 /* TDCS_TDX_FEATURES0 bits */
 #define TDX_FEATURES0_PENDING_EPT_VIOLATION_V2	BIT_ULL(16)
+#define TDX_FEATURES0_ENUM_TOPOLOGY		BIT_ULL(20)
 
 /* TDCS_CONFIG_FLAGS bits */
 #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
 
 /* TDCS_TD_CTLS bits */
 #define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
+#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
-- 
2.43.0


