Return-Path: <linux-kernel+bounces-116882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D388A8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F44B33DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B61C5226;
	Mon, 25 Mar 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxRv//7i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55214D2AC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363588; cv=none; b=Q1RBZ0olFbiF470CyrFJ5xjhPwRGboUO3aqzEEvHwc6zR1rkf2vJUKz1suMtCOgjN360ddNXlW8b6W0nkqB5VTTqnLnrKK9vBKFNrtBCUrXs5JhLSzvggm8/Szdc43JUAc29gym9zlD0/jk5i69iGCh1goWWHuUOLOUJ0+2UAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363588; c=relaxed/simple;
	bh=JRxUQLSehBM2TNxu0nNZermgpC+ysXDiyFSy6vNNmbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkHTh5ObTyCOl0xxzd1Z5mI/faRugT40CcCGC/HLAD+eI1L2gHrEgGowJtLfyI8VezV53ADRgNkprlbLqn6U2Rf1srL8I60RT9Y4Y3uT9hIUto4V1mumRYyGd8IcFmlj1Sr4Jxp5ntQv4lSZ2V6sz3tYiwtedDZidE8IbNFE5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxRv//7i; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363587; x=1742899587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRxUQLSehBM2TNxu0nNZermgpC+ysXDiyFSy6vNNmbY=;
  b=lxRv//7iIgl/n6U+5MOHF0QpcHc63EM29VybthQLLPiDy6U2bkUvISYA
   VIGEn39MBorYgxrOdJt+8xeijnD4ct174SCTqq9O4D/mPH59XSyeZng0t
   PIKirmDiQTUAfOLy9lHlQPBwK8SFF5q4evExR3Q5cknWjJD/DOPifrVNF
   M7CV+coJzRPm0MvZTAVR4t6dLqlwlQGl6gAJ+n6+YTjZAEkKuK00m4kIy
   VPhMubgVtU4nkqpfU/6HFowRCwpaC/Dc5Mw7JKNVAQWr7uuV7sPMfdFvk
   QR8Y1MwwFQjkG8X6mDSpGJPFc6xrD0Z6wAn94H11RVwtZqeaSWhypd0RL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6562007"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6562007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070185"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070185"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:46:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 028C8524; Mon, 25 Mar 2024 12:46:10 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	elena.reshetova@intel.com,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Date: Mon, 25 Mar 2024 12:46:07 +0200
Message-ID: <20240325104607.2653307-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX 1.0 defines baseline behaviour of TDX guest platform. In TDX 1.0
generates a #VE when accessing topology-related CPUID leafs (0xB and
0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID
topology. Any complications will cause problems.

The ENUM_TOPOLOGY feature allows the VMM to provide topology
information to the guest. Enabling the feature eliminates
topology-related #VEs: the TDX module virtualizes accesses to
the CPUID leafs and the MSR.

Enable ENUM_TOPOLOGY if it is available.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 19 +++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 860bfdd5a11d..b2d969432a22 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -289,6 +289,25 @@ static void tdx_setup(u64 *cc_mask)
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
+		if (!tdcs_ctls_set(TD_CTLS_ENUM_TOPOLOGY))
+			pr_warn("Failed to enable ENUM_TOPOLOGY\n");
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


