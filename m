Return-Path: <linux-kernel+bounces-113440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C188845A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8951F1F23CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA21AC787;
	Sun, 24 Mar 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYiEhByS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E71AC76B;
	Sun, 24 Mar 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320242; cv=none; b=fO25aP/UNKCyWDNTh/vXSek2M+HG+xebpxYtzqlTBKtBZyeygi6esVx3BSEp7HpX/vP4tKgtbDx8iOoaH2yHDeT3Ed9gDy/KvxoThh9RZkBVNiqXtys/GU4bJqX3XIFSCMaIRzWyG/8FyDXpd4dOejlADLpwZoojZKQ8V0zaKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320242; c=relaxed/simple;
	bh=LcEVKaWomblcy47ceepZ7ALs9Ii+KiTYzE4AAMNMs6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBYiycbHrKm2wMrfqwvBOXAer5NY6yccI7wTxdn8voksfiMlqFwHD2OWlY3aDqbRTlXvufDICrxxMPBYUDWCVxu7/kiRX9TQYER+uOMvqxndrT4dGcMpjiYNKezpEJNzUnXr6LvL80HN8ZFMPywS1b1VZLEsdLlmCiXrnm9QyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYiEhByS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43561C433F1;
	Sun, 24 Mar 2024 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320242;
	bh=LcEVKaWomblcy47ceepZ7ALs9Ii+KiTYzE4AAMNMs6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYiEhByS/7fV0cW+btwRjLHqt2s1Ne2M6XiJwi2vjFauq0CaTPHTDHK5tIsg0+2Uh
	 Wknt5gJFCBBnMnew0FKj1mQPVLD4syAvvi41p87T+41CoANzlzr6TB5JhRauf8XTTB
	 QHKlXnFgGXHffn6lEphIMGDeKJuQJt71ktk1vyXqxAiOefz+P9vOjPjdYqFsUFh6wD
	 GkK/gz+Yt4YL5iiNx2v0I4/gfui0U+9ydb/+bjXdPqblUd0QsbgdWZP4Vm22wwHz5Q
	 NQ7oWNDPTduD1CHravg1ukhIN5tbbAIF/4d9Y7aG9GD6UkfKUZT5Qq+d+TUPBUvCOQ
	 skiN96WuJxYwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 549/715] platform/x86/intel/pmc/lnl: Remove SSRAM support
Date: Sun, 24 Mar 2024 18:32:08 -0400
Message-ID: <20240324223455.1342824-550-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "David E. Box" <david.e.box@linux.intel.com>

[ Upstream commit e6ba4acde44957dc9bdc3222b5739217a102752d ]

A recent PMC firmware change in Lunar Lake caused the pmc_core driver to
fail to probe. This is due to a change in the GUID for PMC telemetry coming
from the SSRAM device. Until a final release is ready this value may
change again. In the meantime, disable the SSRAM support for Lunar Lake so
the driver can load and provide some basic functionality.

Fixes: 3748dfdae2a6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240227190134.1592072-2-david.e.box@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/pmc/lnl.c | 40 ++++------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index abad17cdd3d78..068d72504683f 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,21 +13,6 @@
 
 #include "core.h"
 
-#define SOCM_LPM_REQ_GUID	0x11594920
-
-#define PMC_DEVID_SOCM	0xa87f
-
-static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
-
-static struct pmc_info lnl_pmc_info_list[] = {
-	{
-		.guid	= SOCM_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_SOCM,
-		.map	= &lnl_socm_reg_map,
-	},
-	{}
-};
-
 const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
@@ -490,7 +475,6 @@ const struct pmc_reg_map lnl_socm_reg_map = {
 	.lpm_sts = lnl_lpm_maps,
 	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
-	.lpm_reg_index = LNL_LPM_REG_INDEX,
 };
 
 #define LNL_NPU_PCI_DEV		0x643e
@@ -517,33 +501,19 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
 	int ret;
-	int func = 2;
-	bool ssram_init = true;
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 
 	lnl_d3_fixup();
 
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = lnl_resume;
-	pmcdev->regmap_list = lnl_pmc_info_list;
-	ret = pmc_core_ssram_init(pmcdev, func);
-
-	/* If regbase not assigned, set map and discover using legacy method */
-	if (ret) {
-		ssram_init = false;
-		pmc->map = &lnl_socm_reg_map;
-		ret = get_primary_reg_base(pmc);
-		if (ret)
-			return ret;
-	}
 
-	pmc_core_get_low_power_modes(pmcdev);
+	pmc->map = &lnl_socm_reg_map;
+	ret = get_primary_reg_base(pmc);
+	if (ret)
+		return ret;
 
-	if (ssram_init) {
-		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
-		if (ret)
-			return ret;
-	}
+	pmc_core_get_low_power_modes(pmcdev);
 
 	return 0;
 }
-- 
2.43.0


