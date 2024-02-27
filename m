Return-Path: <linux-kernel+bounces-83883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAB869FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6B71F2D0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEBC148319;
	Tue, 27 Feb 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evB+libN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3749B50277;
	Tue, 27 Feb 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060501; cv=none; b=rnzamQj+mCFr0iJfS0x50kvkmJidIhLtH7BnMXwQ36OlY88jUK1D7TUSQXRjUUXByfUr+XUyZweW+4GRzG2DL5avtKRihz6mncM/TLjrQi5IXfefzyUNpfpP4NNiLlJwrGpgF9/ywgQTirA8HfP0FaH8hcE3CxhnWUHDfp3xZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060501; c=relaxed/simple;
	bh=mPV8+XATiMCdPLjzfUpMB+cAZDzcYLpuh1vBO6V5R0A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EG308cjb7KI79TI0tTS3xoQ1Pv8/FxSZIRalFtm6TBR9xMSUcuS39zW/wO+/t5jP8RECKyXHIar8uCTbfAbPu9EnydwMcWuq56HR92fiTiHLg2tTtucNAZdzikiycQ99lxuVSgM6h5oX5SbsvIQLZeWsPUWEnFTbHJAJtuK3L2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evB+libN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709060500; x=1740596500;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mPV8+XATiMCdPLjzfUpMB+cAZDzcYLpuh1vBO6V5R0A=;
  b=evB+libNKX/c8RULx+IUS/8nGb88Mfk+e9PNyUfICTkkHR2DxFX6fiE9
   ezHAVAnW88xhpJB20t3UgHSG3K2TjIQ35Rl9rzfwR3s7Spw2KsbdnVuT7
   tVIKdPJuXx4zVkLU5nLYY3MtrnyiGP4ISz9Yph3hovbFZqMhq4Wg+Wa5b
   LHwmMD04g7Fwf2KzqgAIZ8/g8MdJEwAZXT1mJiTlTc3s2fE//k7aUcKUR
   RjdWVw7ubBZolUeNGetCLaAYw2c/jhap1LXYrKaptdlaFCOsfCUACx84z
   P8xdqMo7WQg7O8mRzGQ2bQLmaS4HmhhTC0yuCPj6V84Xb4rnFMahRflhZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14063664"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14063664"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:01:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7120055"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:01:37 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 52C2B580B9A;
	Tue, 27 Feb 2024 11:01:37 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 3/3] platform/x86/intel/pmc/arl: Put GNA device in D3
Date: Tue, 27 Feb 2024 11:01:34 -0800
Message-Id: <20240227190134.1592072-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227190134.1592072-1-david.e.box@linux.intel.com>
References: <20240227190134.1592072-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As is the case on Meteor Lake, the Gaussian & Neural Accelerator (GNA)
device is powered by BIOS to D0 by default. If no driver is loaded, this
will cause the Package C state to be limited to PC2, leading to
significant power consumption and decrease in batter life.  Put the GNA
device in D3 by default if no driver is loaded for it.

Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V2 - Better explain the issue in the changelog and spell out GNA.

 drivers/platform/x86/intel/pmc/arl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 683ae828276b..34b4cd23bfe5 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -673,6 +673,7 @@ static struct pmc_info arl_pmc_info_list[] = {
 };
 
 #define ARL_NPU_PCI_DEV			0xad1d
+#define ARL_GNA_PCI_DEV			0xae4c
 /*
  * Set power state of select devices that do not have drivers to D3
  * so that they do not block Package C entry.
@@ -680,6 +681,7 @@ static struct pmc_info arl_pmc_info_list[] = {
 static void arl_d3_fixup(void)
 {
 	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
+	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
 }
 
 static int arl_resume(struct pmc_dev *pmcdev)
-- 
2.34.1


