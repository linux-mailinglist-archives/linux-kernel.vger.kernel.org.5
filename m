Return-Path: <linux-kernel+bounces-42230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004983FE43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925C51C226D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B154CB2E;
	Mon, 29 Jan 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyVrbS20"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092745BE3;
	Mon, 29 Jan 2024 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509320; cv=none; b=s47lf0EeiZJJrRXEAdPAgEN/lUICJd1J0YjxurHO7FhOgMXw4z/9rtnTUxl4NGFmBr3z4MDIDfyUxnGWCG0w4EpGVoNNygEEotAwHI3PlSQEFrrXwVaSwc/sDcOtcuRKPqbVsV/Kae529aKHPDRwfPNZ5mRNm6Rm05FwkKOx/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509320; c=relaxed/simple;
	bh=NyFm/qK97sk3YCbcjtu2VHQloWxPYZyoAekB4PP4bnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KR2Lu1kTiu0vaXopF9c6k82RbplgEhtUF9XTNob2ZsfWDYwe9NIsgQS8kBoIlwUbTGoa44ch2zciyF1sq0DoRqlb1AnnK1S6gYJXDQm8IMU223XNQi7HDfAXnYYLmZAozd0UHfLRBBX8Y/InPwx2bPIPYGMd8aiL7X1qShH/heI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyVrbS20; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706509319; x=1738045319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NyFm/qK97sk3YCbcjtu2VHQloWxPYZyoAekB4PP4bnI=;
  b=IyVrbS20F5rv4pdlrFyIBczGSxQfYrYZqBMchMo1Lwv7VaArS0E4qkzl
   LwWySDMTdqyJ+TvyooOCaW8ezQfYcm22RIj+9hpQGY1udHqiWx5kmMmOR
   AyC5M94PZIkss8foW8xhRvPmiGsBmzVjwFbMWUNKENI6AatobkUgaJm30
   OOXQKjH7HZfTfWlWyxOhwg+Lvunu1SFis3ZDq/dMRuPvZBCQEwAq+j3aj
   lY8dUm7seE98WDjJuWsclTfLfEB7RXu3PoMMCOFRBWvmyZb/k3v4mYlf7
   74GtgG++uUDXN1hrViGjEBCwNhdFVEQKKAjUpMAOw00ClOqMyAa3Nm/hh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16219206"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="16219206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3270608"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:21:55 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Lili Li <lili.li@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com
Subject: [PATCH 1/2] EDAC/igen6: Add one more Intel Alder Lake-N SoC support
Date: Mon, 29 Jan 2024 14:20:39 +0800
Message-Id: <20240129062040.60809-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
References: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Lili Li <lili.li@intel.com>

Add a new Intel Alder Lake-N SoC compute die ID for EDAC support.

Signed-off-by: Lili Li <lili.li@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 2b0ecdeba5cd..cdd8480e7368 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -238,6 +238,7 @@ static struct work_struct ecclog_work;
 #define DID_ADL_N_SKU9	0x4678
 #define DID_ADL_N_SKU10	0x4679
 #define DID_ADL_N_SKU11	0x467c
+#define DID_ADL_N_SKU12	0x4632
 
 /* Compute die IDs for Raptor Lake-P with IBECC */
 #define DID_RPL_P_SKU1	0xa706
@@ -583,6 +584,7 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU9), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU10), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU11), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU12), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU1), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU2), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU3), (kernel_ulong_t)&rpl_p_cfg },
-- 
2.17.1


