Return-Path: <linux-kernel+bounces-106550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CAF87F032
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F1C1F21EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190D56B8C;
	Mon, 18 Mar 2024 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m0iKQeUf"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B856463;
	Mon, 18 Mar 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789108; cv=none; b=hcFibhqzMBXYRNGXslEcI0ZV/EYbZ/+Lsz4xDVoIXcYW1afH09ibebXD2K3sDzFjAhdlGVwA+G7BclSU5eh/MOfuW0Vkl2XoMAYbiMh4aoogaQdnkDZTBvZIatlwH3mkBNjD73fcceuBv8dmEFQTu3ylhakxcB4sar2eIwFZgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789108; c=relaxed/simple;
	bh=U87dA6MIbpg032jZoEv+6LSoxOya5+XwhE1oUX/810s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUKUWYhJBlOO5Bx8WvK2ktRg4WiRCnELDsEOuAKmXqogDhnafBYstcOVXwLnEJnPnp3CqLAP2q4Ru52mZ036JyuT7/j27lB4arzXQKDrNZNNCMR9Suka0JNOt1rhaDxTXiXaZt0Dz9hhDibqZZNmJwxF32XmYDSaUAC/pSMab2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m0iKQeUf; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhqg011607;
	Mon, 18 Mar 2024 14:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710789103;
	bh=DJaVQGg+UoAiX6uyyVayXQ64RTqYH76iuF67zkFhsjQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=m0iKQeUfWGT5q8HTAQCW2c1isfx9j8MFR21peyTRibpOoFk26fEySLAHy4KZ01XrV
	 iGS2aSrpWzO3SOivLeBM4Qao/fHaYX9OUbxzCCYdsbEurqazVTDwwQFeQcLZTRsd3P
	 XbasKjK+/v1mwuRQ2DLuv+ACn9FtYOeMgdrLd25M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IJBhHI052297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 14:11:43 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 14:11:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 14:11:43 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhc7077624;
	Mon, 18 Mar 2024 14:11:43 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Date: Mon, 18 Mar 2024 14:11:37 -0500
Message-ID: <20240318191143.27638-3-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240318191143.27638-1-jm@ti.com>
References: <20240318191143.27638-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

For DDR52 timing, DLL is enabled but tuning is not carried
out, therefore the ITAPDLY value in PHY CTRL 4 register is
not correct. Fix this by writing ITAPDLY after enabling DLL.

Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
v3->v4:
- Add acked-by
---
 drivers/mmc/host/sdhci_am654.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index fb802bf7ad1c..d079b25ef4c9 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -300,6 +300,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
 		sdhci_am654->dll_enable = true;
+		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
 	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
 	}
-- 
2.43.2


