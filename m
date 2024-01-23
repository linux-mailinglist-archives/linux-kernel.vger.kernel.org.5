Return-Path: <linux-kernel+bounces-35926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21718398DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A8B1C23218
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29A130E53;
	Tue, 23 Jan 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xwPDnHcs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8171272AE;
	Tue, 23 Jan 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035762; cv=none; b=D+oYrht+u7+LAFBNmtMzYPxoWqujcBvPKPVeyGG0FLOwwvaAtsDMeH0Zdj9gCqv3nW4Z0mufpp34BFiKp+T6yOtUFXZD2L+MGs7pbq9joyDZw3KStjJUtnW+/YMPib+XeEEeBvlprQCrTUFSvUVquSPFe5DhRSRKsggPlkYdC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035762; c=relaxed/simple;
	bh=UTKjnl02zRrNFWyX0e1HTEuHJnpztcqmM5wI4qOg/PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQRjCRjDRJb4LZncXKqfZ+SlId+fmpwZdaQsF2QavwZ8fn7uSFcTzYOBBUqCXv+nQEPU8NPssq1+1S4ZLiOvj2PRV+o3Uarzx6i6LNs6UjnE34NgGFFy1lprINxnbYlHYsAJdzWOK7OwpVkKOOsufovSwhJYBhasBE8lNLnNW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xwPDnHcs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NInGF4090422;
	Tue, 23 Jan 2024 12:49:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035756;
	bh=cCOdsqhr20y5QKXtiSnCUsddUxH/Yci+gnu7HPlrDyE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xwPDnHcsnnVlQzOYPh1Xrs/Qo6IxTDH0mZMKxwzhVDJETtCC2M8gwfRqTZ2NOxntN
	 VVTcyZMneXSwVKNz3yccMHJBBEm+YGrcEe92euVt3fo0Q2wTemtzojvRGWG/Xy06Y5
	 DVGSC5pLU89NbbIGmYekd2HkBGsLJJksgROw5XA4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NInGLZ011995
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:49:16 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:49:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:49:16 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NInEnP066395;
	Tue, 23 Jan 2024 12:49:16 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 8/8] remoteproc: k3-dsp: Use devm_rproc_add() helper
Date: Tue, 23 Jan 2024 12:49:13 -0600
Message-ID: <20240123184913.725435-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123184913.725435-1-afd@ti.com>
References: <20240123184913.725435-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device lifecycle managed devm_rproc_add() helper function. This helps
prevent mistakes like deleting out of order in cleanup functions and
forgetting to delete on all error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index f799f74734b4a..3555b535b1683 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -768,7 +768,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = rproc_add(rproc);
+	ret = devm_rproc_add(dev, rproc);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add register device with remoteproc core\n");
 
@@ -786,14 +786,9 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 
 	if (rproc->state == RPROC_ATTACHED) {
 		ret = rproc_detach(rproc);
-		if (ret) {
-			/* Note this error path leaks resources */
+		if (ret)
 			dev_err(dev, "failed to detach proc (%pe)\n", ERR_PTR(ret));
-			return;
-		}
 	}
-
-	rproc_del(kproc->rproc);
 }
 
 static const struct k3_dsp_mem_data c66_mems[] = {
-- 
2.39.2


