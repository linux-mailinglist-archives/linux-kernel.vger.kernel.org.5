Return-Path: <linux-kernel+bounces-109461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8681388198B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468061F224F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9286130;
	Wed, 20 Mar 2024 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t+J14QCf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE86BFDB;
	Wed, 20 Mar 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974322; cv=none; b=MVUwWM6l3GeSls049+IxmWcv6JzhDhhIHIIMEbHXUpdwSD9tRCJX3AoWx9wAGIJZwou+aWJNMcZwOC7Yu8hlgAQevYMRnhoPMHBVl7eY43/dMdPB0tXXmlOXOFiC3KRb+NOgdBPRAQK6s35SFMAAQVpAS6pd00Nl+THX468fykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974322; c=relaxed/simple;
	bh=vTwLiaDm8NpFeYzOTE6FJzkGXeSfGL18KKgDJorzWi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4CnLK50h36GyYtwMWbwkOUsu4nsWrmo/wzo3cl4g5UbOlb6efIr4Zs2fgtfA4XKCmQf4LPyheQ9oZbaygblJG+RaVfimIMJYInowrjBYBZJ1u/UUdffMNgKIBlcioZbGShLSLK3aU4jGBufSeghPq8Z+V+WMu0PEf0W+3u9kQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t+J14QCf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42KMcc05010279;
	Wed, 20 Mar 2024 17:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710974318;
	bh=LCKRh5W0UdX+RnH7S2f7tGf2DHc8PTQ/7kkKN/7lmZ4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=t+J14QCfYN26rsI1VEZtrNXiNyzHCmGLP5Jd72CcbxS1JFi9NepP94/EWLaXe1hR+
	 mgWLy1vYoJNmw9b+FG7Kl2cVSLi058kpi6VMJHAHdy8kJ7hX4v3V4Ir9SKSDvIx+NU
	 WVHZUPcqQVDo4inlOCs9Od7sxU5tWm+q1wCpi2CI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42KMccVN109038
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Mar 2024 17:38:38 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 17:38:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 17:38:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42KMcbur036138;
	Wed, 20 Mar 2024 17:38:37 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/7] mmc: sdhci_am654: Update comments in sdhci_am654_set_clock
Date: Wed, 20 Mar 2024 17:38:35 -0500
Message-ID: <20240320223837.959900-6-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240320223837.959900-1-jm@ti.com>
References: <20240320223837.959900-1-jm@ti.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
v4->v5:
- no change
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index ebef68308fd8..119e41005342 100644
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
2.43.2


