Return-Path: <linux-kernel+bounces-53849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC984A744
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFA11C26929
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A1745FD;
	Mon,  5 Feb 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y4LH4b6u"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE467C7A;
	Mon,  5 Feb 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162308; cv=none; b=DNoj2bvLhNjahc+J+NMxs4/UfwxUydXys5eSRSFOUBVyozEKJ56XFgc6VriTaomqEeULPmjN1nfAlc0IJvrnyLiufaaElduFz5PX6sdgM4oGGe1seQt01cygyOWFVnPievppovw0VQc8voL4sF1sqh0TUwM6SViuxN7ZIrk4UoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162308; c=relaxed/simple;
	bh=HDoP9l78EFZDdW16hNeR9IATxUCA5uyr6j+jeh40ipg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/95H5snnlrewyBrVXpce/bscwr1BPwlDGKxdBxtn7C/5DJ4j147ivWlZIZFB2ZoaQWeFn+YEoTA6I+gWxsJmK/q+2oHv0y51soVtDmiuEqao+pD6zsr3foc2x+R3Ps+ZrLMNvAGAkK1lgRg/e7AgXsycjE1IvDzgZ/K6i2HOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y4LH4b6u; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jinrd016369;
	Mon, 5 Feb 2024 13:44:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162289;
	bh=WzOWw71XNiTDn9UhRVmQ1YL+kbl79QddxFr5AngwFzk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=y4LH4b6ulzamJwhySTEphCv6EwMNeefDtvs7/wzFB6NaU4Gdt0Bk9TUO+GSzvRwO7
	 twYh7leGt6uelYy7EethThSJuViNEc/ojFMl2KFWpJ9bCXO9SeKMGcsiqvkg65hHDZ
	 5/Xnzc0VdrZE5ff69Io4pqpnRvnRUlkuVMsi7Joo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JinAb073217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:49 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:49 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQd028467;
	Mon, 5 Feb 2024 13:44:48 -0600
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
Subject: [PATCH v2 16/19] power: reset: gemini-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Mon, 5 Feb 2024 13:44:34 -0600
Message-ID: <20240205194437.180802-17-afd@ti.com>
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
 drivers/power/reset/gemini-poweroff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/gemini-poweroff.c b/drivers/power/reset/gemini-poweroff.c
index d309b610142ce..06d6992dec892 100644
--- a/drivers/power/reset/gemini-poweroff.c
+++ b/drivers/power/reset/gemini-poweroff.c
@@ -70,12 +70,9 @@ static irqreturn_t gemini_powerbutton_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/* This callback needs this static local as it has void as argument */
-static struct gemini_powercon *gpw_poweroff;
-
-static void gemini_poweroff(void)
+static int gemini_poweroff(struct sys_off_data *data)
 {
-	struct gemini_powercon *gpw = gpw_poweroff;
+	struct gemini_powercon *gpw = data->cb_data;
 	u32 val;
 
 	dev_crit(gpw->dev, "Gemini power off\n");
@@ -86,6 +83,8 @@ static void gemini_poweroff(void)
 	val &= ~GEMINI_CTRL_ENABLE;
 	val |= GEMINI_CTRL_SHUTDOWN;
 	writel(val, gpw->base + GEMINI_PWC_CTRLREG);
+
+	return NOTIFY_DONE;
 }
 
 static int gemini_poweroff_probe(struct platform_device *pdev)
@@ -148,8 +147,11 @@ static int gemini_poweroff_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pm_power_off = gemini_poweroff;
-	gpw_poweroff = gpw;
+	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    gemini_poweroff, gpw);
+	if (ret)
+		return ret;
 
 	dev_info(dev, "Gemini poweroff driver registered\n");
 
-- 
2.39.2


