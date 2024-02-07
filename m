Return-Path: <linux-kernel+bounces-55783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89084C1B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AF81C246C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C544101EE;
	Wed,  7 Feb 2024 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e5yk/6Bh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B09441;
	Wed,  7 Feb 2024 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268527; cv=none; b=GD9ltGFgzHl1f26pHo8zKIOkv8B3iMZf7ZpFyUwLyG3uHMqtnA6uDiXRl7HuTmnRU3sDudRBn6tzJWzS/oHen0XXTQhmGf6r1GbrUyr8JwPs3iM6TLs2FSA1HgYxSR6xitXgzLrpiEXMRkbgnL9dgF8zPDkRSlkNGnZr7aVlqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268527; c=relaxed/simple;
	bh=/a2L8xXm02duQbOv1Y0ldmKia61Yd6B7SdEg5r4Pq2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKR8b5pc+tNHO6oGQwRi7qborcd0WwFtqF2Bhb+iLgbAqXW2ceILg/APPrYcmp1847ynAnmuAd3I645by7qUVfQT4kEglUoc8ppTQaIzdFrhC+jNFdSmCbK5VCa3M8JrQe3sT5NoBYgujcx9PWL6J3VfwPCvQ5T7p7pXjhHqlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e5yk/6Bh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKjp053893;
	Tue, 6 Feb 2024 19:15:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707268520;
	bh=3QkH5PeMfynv1lVwJeFYb8Izoef/fk3NGVZv22VOwP8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=e5yk/6Bh5kblxhAYUxvnE0VKSKY9Mo5TyvjJ+Fou0/xRLhE9Jj3skuH/7VKYIYKpm
	 YbPn9OwYO4Dx//vOViZXq4vVpyV9azWXTS3shhHDWK95MkIwIAPpAkpLug23S5R5A6
	 z3ip21B78mxKfoIcZhsc8TJN+ucYh9TxxGzRTslM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4171FKMa114476
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 19:15:20 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 19:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 19:15:20 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKMt122103;
	Tue, 6 Feb 2024 19:15:20 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/7] mmc: sdhci_am654: Update comments in sdhci_am654_set_clock
Date: Tue, 6 Feb 2024 19:15:18 -0600
Message-ID: <20240207011520.3128382-6-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011520.3128382-1-jm@ti.com>
References: <20240207011520.3128382-1-jm@ti.com>
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

Fixes: fe52e2fbc6ef ("mmc: sdhci_am654: Fix conditions for enabling dll")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 35ba7d921690..3755a015f328 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -279,7 +279,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_set_clock(host, clock);
 
-	/* Setup DLL Output TAP delay */
+	/* Setup Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
@@ -322,7 +322,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	u32 itap_del_ena;
 	u32 mask, val;
 
-	/* Setup DLL Output TAP delay */
+	/* Setup Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-- 
2.43.0


