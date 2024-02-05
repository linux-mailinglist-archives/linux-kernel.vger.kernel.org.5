Return-Path: <linux-kernel+bounces-53843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918884A734
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF401C25D24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD36519F;
	Mon,  5 Feb 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pxWjPzPl"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7463120;
	Mon,  5 Feb 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162300; cv=none; b=kGBgBHa/mWrCNU1gDWdentemLW1wwr3dpuTPsyHbp6hKtrNHsUeUgH0W0tT0JGhc7q0qKHpq9BmlpYTOTuoLhAcYSbveIvKn0UEaSL5Bz/RYtxJAWFKkBEC1qduIZyuQHH9YdatveBEo1yN+zTrYAHTU3EZ3qQ8r3VaMVyc4pFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162300; c=relaxed/simple;
	bh=BvK8IwqnEFboy699PAEmSTVNPQ3C5pW/mK6yHdKKsaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIjcw0Y/FJ2Ddkv6N48OUJtUR0VTGTusf5H/Xa+MHSdVtLdUJeQT2etVrWU9OhnFy0ALLQYx4qucvotosJkfkOZ1rKihX9gmzF7txcF6dt8BcSc2meuOikvikIFIchcryTeETGPwaC35vcaWDOArnKnkvBnSlje9DeFsMhxZvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pxWjPzPl; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415JilQq019205;
	Mon, 5 Feb 2024 13:44:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162287;
	bh=+iboSw0kHr/XQ2F6mUqPjCZdFfbDSD+ql6zjttiLFSU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pxWjPzPlQJYhH1Zc4qnwsLtnX/Y5OfFu9DpbD9A0sa5WfVySkdz8nt+W+Q9IaRp/W
	 pcUr+Gw+WRmmWS9H3ERHsYSIsevbSsmXWXA4PkUwwM6Xer7ppREWG1Jwo7NUlhm5DM
	 1Ss6DaJg8qAyAb1DtMKQTyMSrmkDC4muqJtULvp0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Jil1l073190
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:47 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:46 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQZ028467;
	Mon, 5 Feb 2024 13:44:46 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Cristian Ciocaltea
	<cristian.ciocaltea@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 12/19] power: reset: msm-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Mon, 5 Feb 2024 13:44:30 -0600
Message-ID: <20240205194437.180802-13-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205194437.180802-1-afd@ti.com>
References: <20240205194437.180802-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use this helper to register sys_off handler. Drivers should move away from
setting pm_power_off directly as it only allows for one handler. The new
way allows for trying multiple if the first one doesn't work.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/msm-poweroff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index d96d248a6e25b..bcf04491e7022 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -28,9 +28,11 @@ static struct notifier_block restart_nb = {
 	.priority = 128,
 };
 
-static void do_msm_poweroff(void)
+static int do_msm_poweroff(struct sys_off_data *data)
 {
 	deassert_pshold(&restart_nb, 0, NULL);
+
+	return NOTIFY_DONE;
 }
 
 static int msm_restart_probe(struct platform_device *pdev)
@@ -41,7 +43,9 @@ static int msm_restart_probe(struct platform_device *pdev)
 
 	register_restart_handler(&restart_nb);
 
-	pm_power_off = do_msm_poweroff;
+	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
+				      SYS_OFF_PRIO_DEFAULT, do_msm_poweroff,
+				      msm_ps_hold);
 
 	return 0;
 }
-- 
2.39.2


