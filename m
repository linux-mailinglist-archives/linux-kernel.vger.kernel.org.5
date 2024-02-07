Return-Path: <linux-kernel+bounces-55784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E984C1BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B11C24609
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D0415E97;
	Wed,  7 Feb 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qREzwEmJ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542910A0D;
	Wed,  7 Feb 2024 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268530; cv=none; b=hEy6mKYgFWhO061l+l1x+J/fiBbWj7FZ+hUiiIwdat6u3eflf1tWQPKBE/eBGOuc6AI3w7YnXvvh5y2QlXvCKrwwgo0U5RzjFW7OsvMW5cKvc/ZcRPaCNb30Zo1R6oHyzg47uGlBn5zhTScdrVKWCN6j0b7cHdzENzgJvXBVD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268530; c=relaxed/simple;
	bh=H5Q3ZZyiKSJvEbGy2GJNYOLC//I8vimE87KP0CslkM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNPwpjO9JxWWf19fh+SZrareuJUAbCsu9qAR6YDwAfUceIYtm9rVJULVIPodeQOES2ByYZ/+WF7dpULDg1oyc57qvCLpiescjU3JO2IlWLOhLTRcpT6OlTFf3vSXDZ2/++VhEgWOnJH9ZfTaIPDP1OZMvzCocctlarT/lpGbS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qREzwEmJ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKq9101969;
	Tue, 6 Feb 2024 19:15:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707268520;
	bh=ixLIn8/4MEod1tNhTGI8xmWaSLqcdeGvGzPBaoWSn1w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qREzwEmJFsvpIAPNtDJSF+wj00IjO9lqjeeR8aasrWD/i0eSuBbe+ZD0v30Lbjtn/
	 M9eeWLbL36v3zV2V5ZM2eSlPMGgNOmcd6CbrWEUifx2+G8VtnVmjL8c9vraXwaYEYa
	 ++yFg9uO4cIEdUhkkVA8ZXaxMQPhbKfFK/S22CGs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4171FKuS114472
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 19:15:20 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 19:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 19:15:20 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKMq122103;
	Tue, 6 Feb 2024 19:15:20 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Date: Tue, 6 Feb 2024 19:15:15 -0600
Message-ID: <20240207011520.3128382-3-jm@ti.com>
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

For DDR52 timing, DLL is enabled but tuning is not carried
out, therefore the ITAPDLY value in PHY CTRL 4 register is
not correct. Fix this by writing ITAPDLY after enabling DLL.

Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changelog:
v1->v2:
- Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
 instead of sdhci_am654_setup_dll()
---
 drivers/mmc/host/sdhci_am654.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 2c66a965c225..b50db5d4a452 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -299,6 +299,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
+		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
 		sdhci_am654->dll_enable = true;
 	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
-- 
2.43.0


