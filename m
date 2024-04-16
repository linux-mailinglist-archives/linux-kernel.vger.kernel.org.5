Return-Path: <linux-kernel+bounces-147576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7A8A764E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0229F282A85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464E13BC38;
	Tue, 16 Apr 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuRTx1Bd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA513A403
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302406; cv=none; b=SZcLTDHKUxeaIqB7DRtWOgI9IH2hhypts7MB/a9TMEgySH71YwhDYeIullYpliL2Usy1x0FP7iY+V7WK11Q4H6lzop5oD0fkp4oEfvliCYhfBJx9BlLTsAkNas8Lare+yu3slIRnq0KCDWrPRQHKNKOH9o5M1jU9lz3t6/ukG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302406; c=relaxed/simple;
	bh=eG+ObRK9OWYeF0qpPClL+eIH5Z0ykTXrKTfDIbFpAOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYkQJBeepb/jbKWPQLnQ+xRAiKPGhYL99MuhgQ1sgrlsHW1uWa4Rp/6jd/haMlTHwW64I0JBMmx7ZRtabdE43ax/k+8/V9HEWUf6542kb/eESjp0Vi9IBfzOlUk5xXQd/vysytPYTrvLd03iTGH72qfuc2pqL2oWEv8MlQnKP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuRTx1Bd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302405; x=1744838405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eG+ObRK9OWYeF0qpPClL+eIH5Z0ykTXrKTfDIbFpAOw=;
  b=IuRTx1BdZwgiUHcyd5YTuY/X42T0uMPalJtmDFzVj+doY+X7TuGMbzBC
   NHZ0AwBEnG/Mf8u2byOwjkZYQ0i58jXuj4UTxKyW4BQCo7sKytPcVmTHp
   Rafe3Mswu3BJQisN++26mku0dd4r/DFhNMJsARTRemT6Rw+Nh9Z8CNrKM
   QENfK7t0LeM3b8UHcZYZZvkFK1iASki+tdYkHZf/E1BtDWu+A1JWiqNQI
   uzMW/BCqTC/y/5iuLamt4pnwYHLC1VArgzSTuEF0C6fR+7USnP7mmKtDR
   3ck39Vq1Muity9Bl/xd02uBD8XJzmTVDHKFOLm4J/7TqrWT+gyPkcnsu1
   g==;
X-CSE-ConnectionGUID: NMdubsSvT2+j01JG+oBfcA==
X-CSE-MsgGUID: FxVNC/0hR76D9XhHCTfKxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914735"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914735"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:59 -0700
X-CSE-ConnectionGUID: ddUWVdmxTVWRD4LrJ3Svxw==
X-CSE-MsgGUID: aveIVrY4ThuRDVMOroWgAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871930"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 16/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/bugs.c
Date: Tue, 16 Apr 2024 14:19:18 -0700
Message-ID: <20240416211941.9369-17-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ab18185894df..896d4e2150fe 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,6 +26,7 @@
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
@@ -2391,20 +2392,20 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	if (c->x86 != 6)
 		return;
 
-	switch (c->x86_model) {
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_SANDYBRIDGE:
-	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_G:
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_SKYLAKE_L:
-	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
+	switch (c->x86_vfm) {
+	case INTEL_NEHALEM:
+	case INTEL_WESTMERE:
+	case INTEL_SANDYBRIDGE:
+	case INTEL_IVYBRIDGE:
+	case INTEL_HASWELL:
+	case INTEL_HASWELL_L:
+	case INTEL_HASWELL_G:
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_G:
+	case INTEL_SKYLAKE_L:
+	case INTEL_SKYLAKE:
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
 		break;
-- 
2.44.0


