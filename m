Return-Path: <linux-kernel+bounces-109464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79566881991
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F611F22863
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6C8625E;
	Wed, 20 Mar 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w8k3pOWt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03C1EB45;
	Wed, 20 Mar 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974323; cv=none; b=h74YnUAAFuEjdr8cYuEZR6GNkLDT6OPlaiLwLvTbgl2bWb7U2AVvg7dqgJrOTyxokVf2DxYr0WvTqIaQfBxSotsJIXQmB9rmSOBzsr62vU5O2Y12p05GafU/MVshN+c9y9gfYmusRFvRToajkHo6aj9mPD7BPQf4LTixYcw8584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974323; c=relaxed/simple;
	bh=ZpMB6Q5cp8ZRrhP708OMaprB/IohC17+u+vXbcKEe2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OduHyjU9gsN8dLOHRJJ848vlyPigjQlkqHfAq4cEOeR5TmvRIdj8c8+6e/TFs4yRstSdXK8AZ6hTYaIusd9cC7x7aAp8x/jeEn5cqbbrfMp60Uzx9IgFnKvXdQuqI47V50/tahYmxO91YR2v7kQq5isISLHJPdjHmTyCC2RE1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w8k3pOWt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42KMcbIe010270;
	Wed, 20 Mar 2024 17:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710974317;
	bh=GkrZlN7gV/gK58n0ZPySKV4Dm+pNJIOFplUWJ6oeA4M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=w8k3pOWtsz+bvrlzwgbHuPJQ9JEp4eWdXYf8isDJQnikGZ53tjmrrbXpDXqxfh9OF
	 1w4ktSEcMq16/w06asfGd+TTud9rOkBa20gCWD1vBcvrgYZ/06hry/SA/X0ghamrSA
	 0i5t4/d8iyHnwurr53jttDnPwLAnskrw6sp07Dzo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42KMcbs7109026
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Mar 2024 17:38:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 17:38:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 17:38:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42KMcbuo036138;
	Wed, 20 Mar 2024 17:38:37 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Date: Wed, 20 Mar 2024 17:38:32 -0500
Message-ID: <20240320223837.959900-3-jm@ti.com>
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

For DDR52 timing, DLL is enabled but tuning is not carried
out, therefore the ITAPDLY value in PHY CTRL 4 register is
not correct. Fix this by writing ITAPDLY after enabling DLL.

Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
v4->v5:
- no change
---
 drivers/mmc/host/sdhci_am654.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d8c9821b0b66..cfb614d0b42b 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -300,6 +300,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
 		sdhci_am654->dll_enable = true;
+		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
 	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
 		sdhci_am654->dll_enable = false;
-- 
2.43.2


