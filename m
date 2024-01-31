Return-Path: <linux-kernel+bounces-47203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4F844A82
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BEE1F25320
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21703C487;
	Wed, 31 Jan 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h6ZidhzT"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685353BB24;
	Wed, 31 Jan 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737849; cv=none; b=qwUTYZ2bTiQ5cGmMQAs01E8ge0pB39xHsJE4LmQWe5O7D5/dZdNXxR8quanfHcdMTr+l5+L+x5iyXCSswQ3oDpPLduJYbRYd8mjfkEbvBvYhvrq66PGW9oO1V3vQWfBnhBzDzzwC9OIRNrKYYoMD1Aomrp/kWOvwoWMwdWymaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737849; c=relaxed/simple;
	bh=IVwl22V66+iZHjkuJII1kYOWnJyoRAFMYxv9KsU1hW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7h03EYPruh5/9fLP/UYw/WftNPTDH4kybKO40ais17eZ3a5WCfhVmei1CKBlFFcqhp02jhUoe8pSpd1XH6KdsxezhYTbcS6/oJlf8ypRbf5miADLB6iW+epCLtR94UiUxHa1sEC4vCwA+8I21eYgxvDQm3SGSM8SKnEWG1VC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h6ZidhzT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoj6Q123748;
	Wed, 31 Jan 2024 15:50:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706737845;
	bh=onc9QM9ukgmYukraFs8da86DAT/6E9TriZDUxBTiRZ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h6ZidhzToGBvckW3AtE7TWzfZFs/tveX1rn0W5eVWw0D+8nXkCsyVBC6qbHK4MZG/
	 izTDWolbE8X1hOGd1s70XUAoSaLqggvz6CQ4GsMXT1R7Ms3sviEUL6SPYhMWJywO53
	 EXZNnQq4VeuA2sY/bfeXwVJVxxkaPoFM9cR8h6+0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLojkx044713
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:50:45 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:50:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:50:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoig6062479;
	Wed, 31 Jan 2024 15:50:44 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 4/5] mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
Date: Wed, 31 Jan 2024 15:50:43 -0600
Message-ID: <20240131215044.3163469-5-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131215044.3163469-1-jm@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add ITAPDLYSEL to sdhci_j721e_4bit_set_clock function.
This allows to set the correct ITAPDLY for timings that
do not carry out tuning.

Fixes: 1accbced1c32 ("mmc: sdhci_am654: Add Support for 4 bit IP on J721E")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 5ac82bc70706..f5dc981c470d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -321,6 +321,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
 	u32 itap_del_ena;
+	u32 itap_del_sel;
 	u32 mask, val;
 
 	/* Setup Output TAP delay */
@@ -329,12 +330,17 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 	val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
 
+	/* Setup Input TAP delay */
 	itap_del_ena = sdhci_am654->itap_del_ena[timing];
+	itap_del_sel = sdhci_am654->itap_del_sel[timing];
 
-	mask |= ITAPDLYENA_MASK;
-	val |= (itap_del_ena << ITAPDLYENA_SHIFT);
+	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT) | (itap_del_sel << ITAPDLYSEL_SHIFT);
 
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
-- 
2.34.1


