Return-Path: <linux-kernel+bounces-106551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74887F036
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC44281CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B157882;
	Mon, 18 Mar 2024 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gHmndzmh"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772C5645C;
	Mon, 18 Mar 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789108; cv=none; b=dGgXDpYIYd6GRxWImMJS803HDkp6WhVClPpexZYih98Cvg0e4r2anOPmQfv2yIvr0E6hSZgTK7eNTcY+mv7oqwHdFgWV6GjqEPlNhlAH5LeyyniFbjgOalLXCpNwYxNxWT7OkBOeSs9K/+Ux5Ifiz1EX1j6FzkQkFU2QQ3jg85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789108; c=relaxed/simple;
	bh=+6AYu3VSjMWeJ4/aWw+ZCPZ6MHhaJcTcGflGaxMZwwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQcLrt5GIlg3+GSLY1FSJBp9eDRZCXJ8HvH5tebCKVKbFVFLL7KiL+FHO6wLxODwBbFXbDm/ZCGLCexwyXn7025YzJODJ28QJZW5lJaS+FTpC+idJutMkqXZdAu6KJMaCZvBkUNSMZV8f62Oa8gPbXUwwq0mkLeIpsTNF5GGges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gHmndzmh; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBheE029408;
	Mon, 18 Mar 2024 14:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710789103;
	bh=eyEIxDMsW+MuxVXJp2sBNjoeesZk+uP80xq4OnZBbZM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gHmndzmhgf571nWl83cy2dQwTYgO+VTCJ4NVF1rXNESn9/chGty8DoyGzcmsPAuOA
	 MRcHhfcijLqMthlc7QKfN20InQG4E3TZ2xMWLUF6Sqsvx131e5TUeqF/8mwOXd7Dao
	 nKK8J8NKzU2Fjz3XKMY+o+hZzQWyPdc+47sBhBOc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IJBhmo052300
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 14:11:43 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 14:11:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 14:11:43 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IJBhcC077624;
	Mon, 18 Mar 2024 14:11:43 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/7] mmc: sdhci_am654: Fix ITAPDLY for HS400 timing
Date: Mon, 18 Mar 2024 14:11:42 -0500
Message-ID: <20240318191143.27638-8-jm@ti.com>
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

While STRB is currently used for DATA and CRC responses, the CMD
responses from the device to the host still require ITAPDLY for
HS400 timing.

Currently what is stored for HS400 is the ITAPDLY from High Speed
mode which is incorrect. The ITAPDLY for HS400 speed mode should
be the same as ITAPDLY as HS200 timing after tuning is executed.
Add the functionality to save ITAPDLY from HS200 tuning and save
as HS400 ITAPDLY.

Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
v3->v4:
- Add acked-by
---
 drivers/mmc/host/sdhci_am654.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 887808db830f..f9bd27c09fc7 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -301,6 +301,12 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
 		sdhci_am654->dll_enable = true;
+
+		if (timing == MMC_TIMING_MMC_HS400) {
+			sdhci_am654->itap_del_ena[timing] = 0x1;
+			sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel[timing - 1];
+		}
+
 		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
 					  sdhci_am654->itap_del_ena[timing]);
 	} else {
@@ -530,6 +536,9 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
 
+	/* Save ITAPDLY */
+	sdhci_am654->itap_del_sel[timing] = itap;
+
 	return 0;
 }
 
-- 
2.43.2


