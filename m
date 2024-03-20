Return-Path: <linux-kernel+bounces-109467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6F881996
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25B1B25138
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F486AD5;
	Wed, 20 Mar 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fepC2Eiy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FA8662E;
	Wed, 20 Mar 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974327; cv=none; b=Xasq9j9dfi0B5ee6XVnQQdCaC6mNcBnXt4+3GrIQQZTz+O0fDIGzcTra7fGeQgNK4/xnvZgs05VXj+AOjFT54Shrwu15KUZTSc0MnJ4AbRKa+vN5b5bTh0budS7xN9uoDnPFJf8vMu6vOWDTlGcpZGRI9wcai22j+hvf4fzck94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974327; c=relaxed/simple;
	bh=h/O50Lg9JnAroVs57ilf/QJAIZ1Rle74iwiFJpJFcec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxZRl7qSPYFpMewMzbZZkSpm5yWoHlysXBOwqfMYO/ldoU//wfC4u3T+TVecWBOOAGj3DY57S8EBP7H64S/ba9DtkjqzP/8B+vgotwluoIgQVGxHpL8XI2+w8IMVPnh3jIgdTrGJ18Xce60tM9BkpHa9usRQzx+I4ZoIKW3CCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fepC2Eiy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42KMccMS062295;
	Wed, 20 Mar 2024 17:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710974318;
	bh=sGg6CLiEq6JHNlcRjtkud01njgDhp3OeW0iJdxiDPhQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fepC2EiygpsSaOpBoImL7lfcXTDn6oXGoe3A0wffxsSihklee9VLnujPbxSCA1Xn5
	 +8fLRMdAwSkHba/4hs1h5hYbO5VEcOln17ipoMQIYEQUJEEZAv3Tu4Rdxxl3tmrpOP
	 VMhxuOBY8kSc8vRtxOs/Ge9wpId7QdC+kRK1qCbc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42KMcc1t109034
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Mar 2024 17:38:38 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 17:38:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 17:38:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42KMcbuq036138;
	Wed, 20 Mar 2024 17:38:37 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/7] mmc: sdhci_am654: Fix itapdly/otapdly array type
Date: Wed, 20 Mar 2024 17:38:34 -0500
Message-ID: <20240320223837.959900-5-jm@ti.com>
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

While integer type works, the otap_del_sel and itap_del_sel
arrays are manipulated as u32, so change array types to u32.

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
index 888bfda0ebc0..ebef68308fd8 100644
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


