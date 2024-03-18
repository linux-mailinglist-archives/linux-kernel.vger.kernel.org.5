Return-Path: <linux-kernel+bounces-106549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F087F02F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609F21C20D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643356755;
	Mon, 18 Mar 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HeLgqi1O"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FD56466;
	Mon, 18 Mar 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789107; cv=none; b=SsH6BS2thRAb9D5JXZDC5gDowBWRGnPG6oIkKSG4d2ntzQp1L3lu3HhJEuZ/AELqrpLKASc1HWfnILKJKX7SJwK8eU0hjTNprL/FZ26DmLQQ7H+w4UlT0YqHaK05AhKNFPwRrDNroknj6hodmcqnvuJRqWUaJNN1incQnzXRTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789107; c=relaxed/simple;
	bh=DVBB6f8RBOqvnxeHgqAmAZ5OeNCUhuyA8VP/bxlg7l0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN2unfSF8GAwOzLaJOsJVkXltiqvTrXvFJj/eamf/CeTdk+hDGcghj+/OtEgUDtmx4jiYfGpH3c2vwzIuiqLYp3vmqqTx8b4DzQfD/Rs4C+wkZw9+NBHj6ko/LeY3ICKYMQQwV0tQY/kPUDpiPvGdcH+RJyAEgixemERwqunPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HeLgqi1O; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhlw011615;
	Mon, 18 Mar 2024 14:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710789103;
	bh=cH2cFKNtdYorChkU6clQOrtUtAXIHKJqchj1C++HLaU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HeLgqi1ONYK9/kaPKpo28GbG8NASq51XgSszt8ieEn5N8JQ8QQ579XWo2Zi+5OEwF
	 pI7876AlMb/tNRbwKcGN27dmjIY9c8kD36+fvVSy6B2UFEhzuoB5FI1uuIQxfaceHZ
	 75lyrAnwhTZTuza616sxW375fo6y5XpKwZKVjKl4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IJBhvK054633
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 14:11:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 14:11:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 14:11:43 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhc9077624;
	Mon, 18 Mar 2024 14:11:43 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/7] mmc: sdhci_am654: Fix itapdly/otapdly array type
Date: Mon, 18 Mar 2024 14:11:39 -0500
Message-ID: <20240318191143.27638-5-jm@ti.com>
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

While integer type works, the otap_del_sel and itap_del_sel
arrays are manipulated as u32, so change array types to u32.

Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
v3->v4:
- Add acked-by
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index ac264b1455af..db25efda60f5 100644
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


