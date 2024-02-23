Return-Path: <linux-kernel+bounces-78143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADDC860F87
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373B61F23B12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4E651BE;
	Fri, 23 Feb 2024 10:38:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC756280B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684703; cv=none; b=YOAIGsnyIFSXTW2ahQytwuvoAKZRMzFTnPuDrYzF3R/qPn5X3QGbBkIx7eLp0v0dF1yADaN6qLVPOGh1JBGjeb7SgVxdOUEsTs7TyVbFxIVsZFBlv63aAa/fRLHuAg8UBQJfJlI6fJ9lspiPvDaUvc2TJ+YUIBPEh7B5qLomDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684703; c=relaxed/simple;
	bh=qHWLYtRlKhwqIEOeaqNuTNGZAOEJatl8IxH61J5yzBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3jvk212G7QkvvBTBM/kh5tynszebPthaQ+/jfdNYOLnlDs1L1YCvMO0gh6pcEoX67ndWrbsTwNpB5CcP505Qakfs2p7HBNvZaGXrL30pD3EECWJZJEAjwki8YFZA48NiL4LgIOU9XmDAm8DDutf8cjcqABul3uIRjCh7FGwqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Th5yd0F71z2BdSB;
	Fri, 23 Feb 2024 18:36:09 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id A6D9C18002F;
	Fri, 23 Feb 2024 18:38:19 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:38:19 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH v2 5/8] drivers/perf: hisi_pcie: Check the target filter properly
Date: Fri, 23 Feb 2024 18:33:56 +0800
Message-ID: <20240223103359.18669-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240223103359.18669-1-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Junhao He <hejunhao3@huawei.com>

The PMU can monitor traffic of certain target Root Port or downstream
target Endpoint. User can specify the target filter by the "port" or
"bdf" option respectively. The PMU can only monitor the Root Port or
Endpoint on the same PCIe core so the value of "port" or "bdf" should
be valid and will be checked by the driver.

Currently at least and only one of "port" and "bdf" option must be set.
If "port" filter is not set or is set explicitly to zero (default),
driver will regard the user specifies a "bdf" option since "port" option
is a bitmask of the target Root Ports and zero is not a valid
value.

If user not explicitly set "port" or "bdf" filter, the driver uses "bdf"
default value (zero) to set target filter, but driver will skip the
check of bdf=0, although it's a valid value (meaning 0000:000:00.0).
Then the user just gets zero.

Therefore, we need to check if both "port" and "bdf" are invalid, then
return failure and report warning.

Testing:
before the patch:
                   0      hisi_pcie0_core1/rx_mrd_flux/
                   0      hisi_pcie0_core1/rx_mrd_flux,port=0/
              24,124      hisi_pcie0_core1/rx_mrd_flux,port=1/
                   0      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
                   0      hisi_pcie0_core1/rx_mrd_flux,port=0x800/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/
              24,132      hisi_pcie0_core1/rx_mrd_flux,bdf=0x1700/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x0/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1/
              24,138      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1700/
              24,126      hisi_pcie0_core1/rx_mrd_flux,port=0x1,bdf=0x0/

after the patch:
     <not supported>      hisi_pcie0_core1/rx_mrd_flux/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0/
              24,153      hisi_pcie0_core1/rx_mrd_flux,port=1/
                   0      hisi_pcie0_core1/rx_mrd_flux,port=0x800/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/
              24,117      hisi_pcie0_core1/rx_mrd_flux,bdf=0x1700/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x0/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1/
              24,120      hisi_pcie0_core1/rx_mrd_flux,port=0x0,bdf=0x1700/
              24,123      hisi_pcie0_core1/rx_mrd_flux,port=0x1,bdf=0x0/

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 6f39cb82661e..b2dde7559639 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -306,10 +306,10 @@ static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
 	if (hisi_pcie_get_trig_len(event) > HISI_PCIE_TRIG_MAX_VAL)
 		return false;
 
-	if (requester_id) {
-		if (!hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id))
-			return false;
-	}
+	/* Need to explicitly set filter of "port" or "bdf" */
+	if (!hisi_pcie_get_port(event) &&
+	    !hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id))
+		return false;
 
 	return true;
 }
-- 
2.24.0


