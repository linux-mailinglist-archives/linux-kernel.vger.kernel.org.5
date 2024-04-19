Return-Path: <linux-kernel+bounces-151087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586228AA8E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4891F220A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21303EA68;
	Fri, 19 Apr 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRiOizix"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736104E1AD;
	Fri, 19 Apr 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510645; cv=none; b=IncwLY2AnvQw9EI4zaHXig5x773yjDxRPPEy/YuHxFuW+RaINxQtWxZCl8eAvVxHKjqKNgcLogIi1+j+sTGfB8SL9q0pXFGcKqgWWVVoP4lAuSCuJrHBZfV+2xcLxSsL34iFRmknuSmFBWShGqi59ME3rx1Df7EkUzSjcK/uAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510645; c=relaxed/simple;
	bh=/Q6Sp/a/VCj1FwCXRbrJ9YkgBf+bahR7pz6KrJ/M7yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxuppBTt4YQI5vzqE74suwNU1eDg3cCH9ZFcsoCU2X6L2biTwjOrH/ReKiBDV/3FjGYefKjCI3jOeRAfr1AOheWOFSBfX/unLEgGYLre5srVIhKaMdcvBEFQQS6HKdpfK1qqtDMZCVJQB74pntj/FUfbqTHxAhFojj334Fvm/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRiOizix; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713510644; x=1745046644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Q6Sp/a/VCj1FwCXRbrJ9YkgBf+bahR7pz6KrJ/M7yc=;
  b=LRiOizix4dTfTdU3rY8+optSs3lI5F3TpgxkPUohMo5jcOVsj0w3d04V
   7uFcu6t81L7BjXjDzOuWt7qP70KslMSxaNGZyV4n0p9MLP7Mp9XVc4C1o
   DNmxvi0YV7PMgSCySHUvECn87RUxqK/GoPhKmLQ5ooqp3bY421AthGJeG
   5uDGskWTR1qZAczWSXJKYH8HEQdisiTK11tWiTCrzlSiBoztedbsO/SgR
   Z8NnGHEbkE84pu4uZOTqTXzsl5sz8NSc2UA/UkNgOitLwgkvqFflqjYrM
   gvLpAyXhVxZZTgHphTJR5T/glm63oBknbI1Y0L4rYUwcV/OhJ86qAAnny
   w==;
X-CSE-ConnectionGUID: IiB4jHzyREGb015SkDtC3g==
X-CSE-MsgGUID: mwg2a2z5RBe9LmjT/F1QEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26611872"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="26611872"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:10:39 -0700
X-CSE-ConnectionGUID: R+/zK1yUSz+oVcr+4R0z9A==
X-CSE-MsgGUID: +xwrOkUhTbS/eh2N2Lr18g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54451894"
Received: from lxia1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:10:35 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH 3/3] perf/x86/intel/cstate: Add Lunarlake support
Date: Fri, 19 Apr 2024 15:10:19 +0800
Message-Id: <20240419071019.1103953-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419071019.1103953-1-rui.zhang@intel.com>
References: <20240419071019.1103953-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared with previous client platforms, PC8 is removed from Lunarlake.
It supports CC1/CC6/CC7 and PC2/PC3/PC6/PC10 residency counters.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/intel/cstate.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 22e8f2687349..2500a89fcb7c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF,GRR,ARL
+ *					  MTL,SRF,GRR,ARL,LNL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -53,31 +53,31 @@
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						GRR,ARL
+ *						GRR,ARL,LNL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL,MTL,ARL
+ *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL
+ *						RPL,SPR,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL
+ *						ADL,RPL,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
  *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
- *						ARL
+ *						ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -96,7 +96,7 @@
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL,MTL,ARL
+ *						TNT,RKL,ADL,RPL,MTL,ARL,LNL
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
@@ -646,6 +646,17 @@ static const struct cstate_model adl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model lnl_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C3_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -768,6 +779,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&lnl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.34.1


