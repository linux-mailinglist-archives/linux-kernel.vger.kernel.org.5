Return-Path: <linux-kernel+bounces-96401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD071875BAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEED1F2223E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F66224EC;
	Fri,  8 Mar 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IovuuGIg"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28849210EC;
	Fri,  8 Mar 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859471; cv=none; b=CZvd/upKcLYzBezabgKy5WsXZlBzWSnzJZ/zhOdoewM8JEemMiUfLq9yzhP/jauLTDUxRee+YitEjBLLOMk3NziPXS5c0P8Wng1hpM0GrBb8f3oDUcrvXQ24ul2mhX+suk9RjhDTv4/MEc8whm+q9HLlUcOvwUOt/ZrHS/Gs8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859471; c=relaxed/simple;
	bh=m7cPWm7CHyHyZ/scoazHYD/a9psgq8E48J3G7q+lIWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjwxTAvz+569jbxAR4dbFNRKet4oJbiBBJOXdrUCcW+iMNQjbbH4GrSfUiKO6GKHFkk2LoMUCpyrZ2F+que6uzMAG0C0p/Jzk07ytjbd05ZvH+EDss0um6ADINmsAHnWR4kXcNNBC3Ss02iU48jiLxp7bZE+bGL0Uu7wgDNxVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IovuuGIg; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4280vk57130646;
	Thu, 7 Mar 2024 18:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709859466;
	bh=+3heyIuVkeci1TwGq7t6Bc47L5KCC1fix4g7mu12P6w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IovuuGIgaur0A2VTBOOgaRxMiH3xh3GVdCanmuMm5Y3Tos5kRYJTumvcbOiRQPOcB
	 NutNeZ+a9D2acJ+PCT+par4O/9jv2Ca+1sCvC7Nikz3avPJC6S2GUyeXe61H9cKqSd
	 uGQ8Jv4Fwaf73t0ygBNsb948AqbvkaVmQx052v+U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4280vkD6122489
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Mar 2024 18:57:46 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Mar 2024 18:57:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Mar 2024 18:57:46 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkjV055151;
	Thu, 7 Mar 2024 18:57:46 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] mmc: sdhci_am654: Fix itapdly/otapdly array type
Date: Thu, 7 Mar 2024 18:57:43 -0600
Message-ID: <20240308005746.1059813-5-jm@ti.com>
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

While integer type works, the otap_del_sel and itap_del_sel
arrays are manipulated as u32, so change array types to u32.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changelog:
v2->v3:
- Remove fixes tags when not needed
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e7ff6b841c4d..75f55b07bae9 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -141,8 +141,8 @@ static const struct timing_data td[] = {
 
 struct sdhci_am654_data {
 	struct regmap *base;
-	int otap_del_sel[ARRAY_SIZE(td)];
-	int itap_del_sel[ARRAY_SIZE(td)];
+	u32 otap_del_sel[ARRAY_SIZE(td)];
+	u32 itap_del_sel[ARRAY_SIZE(td)];
 	u32 itap_del_ena[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
-- 
2.43.2


