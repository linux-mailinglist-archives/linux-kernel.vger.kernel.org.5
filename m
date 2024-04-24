Return-Path: <linux-kernel+bounces-157490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337588B121D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B241C2376C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392719DF5E;
	Wed, 24 Apr 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJOH3V5m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85977184103
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982528; cv=none; b=DHyvKWUR/MbnUlvlI6iptcw7oXI9/ZXMP+6Eshgq0OT1ZCPF31kcXA4ireD36ZRWr/mmSE0TUxy/VzkJFYJ/vorolRs3WwZNjDYmCzokt0FNtfknPmUFV4SfADVm8zLOEEGNOh1YzpFFlI5e8tDJ9k8hVE/0QN9ehgq2Yk0YX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982528; c=relaxed/simple;
	bh=KWWRdUU5f5jfluH+XjQDN6u50z+YdtCCFs2TFHrBnZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENVwJqLvp0SIMD/nWofmM4LA1XI+2iV3j1nI37DrmJb60aFeDdVj5F5So6mBSEQE09dR0JdGuaB+imYp2UMPR1qxl2zHvOLA2tYdWyldc0cB0sFvM3komlPAnPHtYAxrO26Oo8XEBI7YHqc7wmS5fX1567A3pA9Em2/JWnU2EbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJOH3V5m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982526; x=1745518526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWWRdUU5f5jfluH+XjQDN6u50z+YdtCCFs2TFHrBnZg=;
  b=PJOH3V5mGXNnefMXY0iP9ch3e499ofgsDOtlDL3WUjsvao/obfTjYawC
   9cSwRg2l8ONMNYLeSsKzuanvjSlPnHbxELN7RvNWXPQJDS59pdQlfKLqw
   m7ENmtJaKcw5vy8BmXERn14VKix0yxuD3KdJJ8L2mrUSWKLswoBbXSCub
   35wFjo5eg2olcWuwRDGzYbbPqZKuXyuycno38h4zAqywS3mCscCw4NW4Y
   2UjulORWWL+s8enhVF29n5Y7p6dRSx7DjlvJ0hDAo6atVL0H5G1NrfWAv
   pwUUywjt5vEjEGjBUAlvgGPFKEb7BfvBGIEXSH5VVHiJdrrgeFsEPg7TY
   w==;
X-CSE-ConnectionGUID: 9BMmsSpCTjyhL2qxtBZI9g==
X-CSE-MsgGUID: rhPgeYUKQiKTb9uhifXLWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503581"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503581"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:25 -0700
X-CSE-ConnectionGUID: frX1FmZ/Q8+j9izbmvqBfw==
X-CSE-MsgGUID: AfU7iprISOqMf9sUP5P87g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750156"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:25 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johannes Stezenbach <js@sig21.net>,
	Takashi Iwai <tiwai@suse.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 46/71] x86/platform/atom: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:25 -0700
Message-ID: <20240424181525.42043-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
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
 arch/x86/platform/atom/punit_atom_debug.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index 6b9c6deca8ba..44c30ce6360a 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -165,14 +165,13 @@ static void punit_s2idle_check_register(struct punit_device *punit_device) {}
 static void punit_s2idle_check_unregister(void) {}
 #endif
 
-#define X86_MATCH(model, data)						 \
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_MWAIT, data)
+#define X86_MATCH(vfm, data)					 \
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_MWAIT, data)
 
 static const struct x86_cpu_id intel_punit_cpu_ids[] = {
-	X86_MATCH(ATOM_SILVERMONT,		&punit_device_byt),
-	X86_MATCH(ATOM_SILVERMONT_MID,		&punit_device_tng),
-	X86_MATCH(ATOM_AIRMONT,			&punit_device_cht),
+	X86_MATCH(INTEL_ATOM_SILVERMONT,	&punit_device_byt),
+	X86_MATCH(INTEL_ATOM_SILVERMONT_MID,	&punit_device_tng),
+	X86_MATCH(INTEL_ATOM_AIRMONT,		&punit_device_cht),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_punit_cpu_ids);
-- 
2.44.0


