Return-Path: <linux-kernel+bounces-53856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217A284A75B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC39B212BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABC87CF15;
	Mon,  5 Feb 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qw5q5B3k"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99036745DB;
	Mon,  5 Feb 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162311; cv=none; b=gC8Au7Lujk8wWMFjp+tbTln0zyU9V2MmIZIXu2uo9zAHFuBGfvIBGOdQgyHmCUV9QZG1fiyJ6lsu6ncuFk4RVnzBFygObIdfcNzcUHOQ0K9RBqy1wI93B/MfHxJJcyrCDbBY5MUFYIcHKvsJBa8ZCmmNQEFJt07inPLIr4hPg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162311; c=relaxed/simple;
	bh=TcZggvWPAiMNrDjTaYr88pR3WYNyYJDkk6qpMPNTC3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqqY/Meyxxzmc64S719MeOYrEHpFrqJWLlNVJkKiN68+fxp1IUuPzvZrY8Rs7DLWn5Gr88GHbbR8B+igOjEXQsk/cUuhgoSj2cEU1NyqBD3IJdv2HY6fYIMyAQ5i3XCBtsSgnSf8OelL0FsbKBwmLuI7OY1331QKxfyfQJVVy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qw5q5B3k; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415JilnK101200;
	Mon, 5 Feb 2024 13:44:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162287;
	bh=5a2BDxvry/mDEJhidMjtTRkucrmFZYMP54rfoZVMxFg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Qw5q5B3keTde63yHWlZpQ7EVk4tQF9AphT2TKbB0uVKzxcP46i9J1hxwiPkvnhfU6
	 yx3v/eLF1zvt5mKdeJM+rw+fQHl9Lon2LkZyUxz6YoDK+bNLBBZrYfXipnLDENW0Ig
	 9naCSq3dVPMP2uMY58c+MhSsfrUKANATzLTuHB0w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JilEK073197
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:47 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:47 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQa028467;
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
Subject: [PATCH v2 13/19] power: reset: msm-poweroff: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 5 Feb 2024 13:44:31 -0600
Message-ID: <20240205194437.180802-14-afd@ti.com>
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

Use device life-cycle managed register function to simplify probe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/msm-poweroff.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index bcf04491e7022..c5831c46f69e2 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -13,35 +13,24 @@
 #include <linux/reboot.h>
 #include <linux/pm.h>
 
-static void __iomem *msm_ps_hold;
-static int deassert_pshold(struct notifier_block *nb, unsigned long action,
-			   void *data)
+static int do_msm_poweroff(struct sys_off_data *data)
 {
+	void __iomem *msm_ps_hold = data->cb_data;
+
 	writel(0, msm_ps_hold);
 	mdelay(10000);
 
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block restart_nb = {
-	.notifier_call = deassert_pshold,
-	.priority = 128,
-};
-
-static int do_msm_poweroff(struct sys_off_data *data)
-{
-	deassert_pshold(&restart_nb, 0, NULL);
-
-	return NOTIFY_DONE;
-}
-
 static int msm_restart_probe(struct platform_device *pdev)
 {
-	msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
+	void __iomem *msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(msm_ps_hold))
 		return PTR_ERR(msm_ps_hold);
 
-	register_restart_handler(&restart_nb);
+	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+				      128, do_msm_poweroff, msm_ps_hold);
 
 	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
 				      SYS_OFF_PRIO_DEFAULT, do_msm_poweroff,
-- 
2.39.2


