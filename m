Return-Path: <linux-kernel+bounces-106555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641BC87F03C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9414C1C20CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190625A11C;
	Mon, 18 Mar 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="axCbMvJP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524D59B5B;
	Mon, 18 Mar 2024 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789113; cv=none; b=sm4Z7LZAPFDAeeSjb7Gj7YxR0XHq+FMDEGjhXy7q1LIhL1hmsoUUXhIQHHRAphbOxRLgZ4OCnQgAXBoJiFhcG7jdGQCnhwc8i21PfNE/q56RBOWzCdK4ywNFpu0Q9PvZjd5ojqn87mAlUnoiunrEP1Ex4NxYgpZylP/mPnGGHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789113; c=relaxed/simple;
	bh=w+U8dd24WK1O+NzyyQAzyJz36Ga+IMWO8GLVjDe9OFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE+2+p4vmsqZCEN8Pcj1kXCe8RE9jqeIjcRXE3JVGvZjkaXfUorcMTXmjNE1Qfp7XjCsNeD2FyR3qcwC0sD3U7QJvSUQQqQNrgLsoqUPX6DRBras1X8OgruVptLQ5VWapJOwyW+A1f7t1TcRc/jIo/jWtNS2RNGtl+xbBAu/3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=axCbMvJP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhGe011619;
	Mon, 18 Mar 2024 14:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710789103;
	bh=Sjnv3EHyIk3g36tJhda/Ig6DJdjN+/yL0V89SeofzHo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=axCbMvJP7O3hoiYoKOb3PVtZv5tLJd1tEcyoZh1LeOK2pnrJ2HeoUyO5BtU+5YXBo
	 KJkgiiOX5keNhoEmCUHViFtdK4I4T2hfmCasbyX4vVMCFt690xh1ajOcM49Y06Ds79
	 BPa9hu8FPdF1OcrdujVMEY+kJH3n/ng23qAKnpCY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IJBhE5021311
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 14:11:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 14:11:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 14:11:43 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhcA077624;
	Mon, 18 Mar 2024 14:11:43 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/7] mmc: sdhci_am654: Update comments in sdhci_am654_set_clock
Date: Mon, 18 Mar 2024 14:11:40 -0500
Message-ID: <20240318191143.27638-6-jm@ti.com>
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

The sdhci_am654_set_clock function is also used to enable
delay chain, therefore fix comments to be more generic in
case we are not enabling DLL.

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
index db25efda60f5..076229887d0b 100644
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


