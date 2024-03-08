Return-Path: <linux-kernel+bounces-96403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D486B875BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126C61C209B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99873225CC;
	Fri,  8 Mar 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NSVOmUVP"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704821101;
	Fri,  8 Mar 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859471; cv=none; b=kSPNWbL/ZKkdiusfStXum0TFlmyt9wOI3cqmQkMGRaLI/MmwhF5TJX5hzu4jWr/mGCg42NMLXQrlE2WuRFokS6vjJYuxrL3cVxthCUfgkRLF/T09YV3ZxIHmED022ReUyIJoiMTdbB1y7gZ0CEMQJP0Fb7SWJkGR5Y157CD9ftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859471; c=relaxed/simple;
	bh=sSjaIfkTAktGf+9AAsIO4JHeEHwJYfIzr2hNCCAV+58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbG4Jq9+wFs3ppDQ51nO0OxFqes6W3vLpEsgID0eQ3n3MDGOczK4ywrkY43nqC0z7ADtYFZeA0ZY+ipHt6MuAYrYAOfrNOBvCKGQoADfACtYIbp7/olXyamwBUGwfwW59sfkEqR8rfPSndcN61B1FH5sFlvK8n2MkLbsoDezBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NSVOmUVP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkbh019071;
	Thu, 7 Mar 2024 18:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709859466;
	bh=GnxP41eg+wpGi3UmhF1GxM8e7PFXcDhJmixYLiFciD0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NSVOmUVPQN24/utAx0zSYbC/+leUwC/MSnwQb7y6D7m6p6bEyMezVzYmDIMei6gak
	 EhrK64kv2p2rv+pen51lTxGpmR0m7q3oyo+RXTatzujNxnkDd5lsQ2GuzdV6FVSGR2
	 +wkFk1ydNiPNZSdAmcWtMKRKC/NPwMBIPIg1e3Zo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4280vkvZ007737
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Mar 2024 18:57:46 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Mar 2024 18:57:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Mar 2024 18:57:46 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkjW055151;
	Thu, 7 Mar 2024 18:57:46 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] mmc: sdhci_am654: Update comments in sdhci_am654_set_clock
Date: Thu, 7 Mar 2024 18:57:44 -0600
Message-ID: <20240308005746.1059813-6-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308005746.1059813-1-jm@ti.com>
References: <20240308005746.1059813-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The sdhci_am654_set_clock function is also used to enable
delay chain, therefore fix comments to be more generic in
case we are not enabling DLL.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changelog:
v2->v3:
- Remove fixes tags when not needed
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 75f55b07bae9..d207751a63f0 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -279,7 +279,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_set_clock(host, clock);
 
-	/* Setup DLL Output TAP delay */
+	/* Setup Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
@@ -321,7 +321,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	u32 itap_del_ena;
 	u32 mask, val;
 
-	/* Setup DLL Output TAP delay */
+	/* Setup Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-- 
2.43.2


