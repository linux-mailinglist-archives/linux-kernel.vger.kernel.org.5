Return-Path: <linux-kernel+bounces-45523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877478431FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263D21F26578
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03DB1370;
	Wed, 31 Jan 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W6UwvpBD"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF35367;
	Wed, 31 Jan 2024 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661442; cv=none; b=EICZcNDLhe8u4QoFT+IUskIVLpJYGGrEl7O3d9TDVi991OHPYMILgzEXvvMiPz2RhUsyDKcl6fvkXixFOcCo2DT/Pv9YFJEIiYBB+IO1mm5ITCekclk+7uTzqBnVskRaivM7e8N+plv2M0Y93d1azg1SKedYaVa048wnpcwRyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661442; c=relaxed/simple;
	bh=Yde+/v/+AnUplfQUwrwsE7yIYWSZYjR61zlCFeX+dks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5tyKGujdtc1/7wCRyRkIqz7O+43bYxHlPgV4etTp17O+IQjsG1wtrn/6AM+GeB3ZU939H2Ayv45y38NDaxeXXeubS4LX5emf6BZZ5wz9giKyY4ZKYEIbdv8+Ctvk3URamnpnnSiDnd/Ht/TqILrjy81EKT/V/cdZPOGSURGbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W6UwvpBD; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bFhi038158;
	Tue, 30 Jan 2024 18:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706661435;
	bh=RHyTtzIAoeUMLOJFOBHlD1R5jRaYgsYXm6fuzcPyioU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=W6UwvpBDROaTTwQ3dE2R9wx30n4qWHX/EUnYgs4ftSdmTgC/60KaI6veo3Q9UV/5I
	 pkRQO+Pw2w4LCp0KPvwGw37NoQr2mdV/+Pg1whUh4etDdvZlADIzEOsFRhzS3rxi12
	 a0l27FeozYKkxMsTkiG+Pu0VyNl8Mrjp/+oFf4WA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V0bFHI007806
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 18:37:15 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 18:37:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 18:37:15 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bEwC026520;
	Tue, 30 Jan 2024 18:37:15 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, Randolph Sapp <rs@ti.com>
Subject: [RFC PATCH 05/13] drivers: mmc: host: sdhci_am654: Fix ITAPDLY for HS400 timing
Date: Tue, 30 Jan 2024 18:37:06 -0600
Message-ID: <20240131003714.2779593-6-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131003714.2779593-1-jm@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

While STRB is currently used for DATA and CRC responses, the CMD
responses from the device to the host still require ITAPDLY for
HS400 timing.

Currently what is stored for HS400 is the ITAPDLY from High Speed
mode which is incorrect. The ITAPDLY for HS400 speed mode should
be the same as ITAPDLY as HS200 timing after tuning is executed.
Add the functionality to save ITAPDLY from HS200 tuning and save
as HS400 ITAPDLY.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 61f95aad3f80..0f0178936a6d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -151,6 +151,7 @@ struct sdhci_am654_data {
 	u32 flags;
 	u32 quirks;
 	bool dll_enable;
+	bool hs200_tunning;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
@@ -252,6 +253,10 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock,
 		return;
 	}
 
+	/* HS400 ITAPDLY should be the same as HS200 ITAPDLY*/
+	if (timing == MMC_TIMING_MMC_HS400)
+		sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel[timing - 1];
+
 	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
 				  sdhci_am654->itap_del_ena[timing]);
 }
@@ -311,6 +316,9 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
+
+	if (timing == MMC_TIMING_MMC_HS200 && sdhci_am654->dll_enable)
+		sdhci_am654->hs200_tunning = true;
 }
 
 static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
@@ -543,6 +551,10 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	sdhci_am654_write_itapdly(sdhci_am654, itap, 1);
 
+	/* Save ITAPDLY for HS200 */
+	if (sdhci_am654->hs200_tunning)
+		sdhci_am654->itap_del_sel[MMC_TIMING_MMC_HS200] = itap;
+
 	return 0;
 }
 
-- 
2.34.1


