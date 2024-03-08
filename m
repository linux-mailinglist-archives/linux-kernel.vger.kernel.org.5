Return-Path: <linux-kernel+bounces-96402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021EB875BAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FDC28355E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB63224EF;
	Fri,  8 Mar 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OQA5kkvK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AB21103;
	Fri,  8 Mar 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859471; cv=none; b=lYKmfzJgahbq9y0g/qlcV5Cgd6rUckKqlfkPakM0J9VLer0Kow1SauzrGd/+seFDfW1JR7K0WqQ1LwzpjTIeBYxQJgikqSkC7hXMoglQ2qF0c/oofBX+e0eIscG9IGj7OcukG9RLN7J1T/wczGDTjkV4GxbUKLpmeMALYJ5+Wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859471; c=relaxed/simple;
	bh=kgs96WRHvI/MhLTwOw6aiWAxJgcwSxY0VlOMseLvivo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WH2cb0GLLBfqdWfQEwNn+oXS5Ba5B6kYyf/k8RD7+CSMEWI6ihoDWmDMccspk9kW7sMRUQwWcpnGl5rxgzkrW9btcDFrrL+AvTH/FnglBgdrVmoKg8y6qYp71pJU/j/TOMjo8gUmPEUeHkyHkfkjlOz0RwP7nIGgNcdhFeCUBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OQA5kkvK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkEt019067;
	Thu, 7 Mar 2024 18:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709859466;
	bh=TqqFQc5HBafwhYld7ftwbyfKu5k/vsxbtZjX/ELy35k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OQA5kkvKDg/k9wnVYwl0eGjg3E8LO3Y2nn7xxeNPzL+Rb9rjMlXWgwrrHzf8O39Rq
	 us6oxkvpzc51YoCbRL0FXjWQnCcXNBO75j2t/WMEZbTNgEJs1nuWaElFWfF+AIqY+3
	 +k3dTAFCNsJ7QYdXc0FUFRLk88uAX1Gnj6om/Kp0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4280vk1W007727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Mar 2024 18:57:46 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Mar 2024 18:57:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Mar 2024 18:57:46 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkjT055151;
	Thu, 7 Mar 2024 18:57:46 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Date: Thu, 7 Mar 2024 18:57:41 -0600
Message-ID: <20240308005746.1059813-3-jm@ti.com>
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

For DDR52 timing, DLL is enabled but tuning is not carried
out, therefore the ITAPDLY value in PHY CTRL 4 register is
not correct. Fix this by writing ITAPDLY after enabling DLL.

Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
Reviewed-by: Andrew Davis <afd@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changelog:
v2->v3:
- no change
---
 drivers/mmc/host/sdhci_am654.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d11b0d769e6c..896d4660b535 100644
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


