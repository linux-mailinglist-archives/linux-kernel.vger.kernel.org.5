Return-Path: <linux-kernel+bounces-51502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD7848BF9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01D51C20AC7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4F11709;
	Sun,  4 Feb 2024 07:49:41 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802DE570
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032980; cv=none; b=d/050lzLU+Zzmc9Mk5lwfXVjbXbcfYI2sCUf9LjNayf10fZ+0m7KLnEm2Vjb7nvKgbTOJeJvGXJWEQEvm86UFdQ//WtrgIFaAMWckrRq3c2os3Lh4QIpJ6ysrR0sOhauXDkJRByCVrQXOOMbztj0pZcZyODcLOBsgF/spFd2eAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032980; c=relaxed/simple;
	bh=V2dplIcXwgwtYYeVnBhwj0TNKdw7NOt1svmTLt/jfe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjNgSkxRn8BOWhCGLxxY5qGBiv3eqKGOR4AtVBk3FvZ+En067rUJG9lCLy1VDh6K9bDMumHSNUyNMqM2FA2OD/rlrG//oXyZuilGseGX0n5Yw8xX353YBnT3hVYDm0ZOG6xDAVOa8ZuPAGjFBPyMNP2P83tz9pC5LEckUqHdiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TSM3y2rk3z1FJpd;
	Sun,  4 Feb 2024 15:45:02 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id A60A71A016B;
	Sun,  4 Feb 2024 15:49:35 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 15:49:35 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH 4/7] drivers/perf: hisi_pcie: Check the target filter properly
Date: Sun, 4 Feb 2024 15:45:24 +0800
Message-ID: <20240204074527.47110-5-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240204074527.47110-1-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/

after the patch:
     <not supported>      hisi_pcie0_core1/rx_mrd_flux/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,port=0/
              24,153      hisi_pcie0_core1/rx_mrd_flux,port=1/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=0/
     <not supported>      hisi_pcie0_core1/rx_mrd_flux,bdf=1/

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 83be3390686c..b91f03c02c57 100644
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


