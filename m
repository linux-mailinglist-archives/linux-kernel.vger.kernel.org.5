Return-Path: <linux-kernel+bounces-35925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 209888398DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D34B2A5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A7130E56;
	Tue, 23 Jan 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xl69Zkpn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E51272A6;
	Tue, 23 Jan 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035763; cv=none; b=Ojm4McnLaspaIRH2bvgzWJGaw5Yu8aYt4lx4GUhHwJ9qsS1lDtRxVfV+Rs8iyCBxepU5PO3H83vIfdDwhlWMCMfMpyESGDaol5h/pbve5WuUAOiHvKRwRCG6yHs8mvkPYLRAmR0bLXYAR0sE/S7+vWMDGXYoRuBngEMX9PBwf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035763; c=relaxed/simple;
	bh=f/UXk3eI7pPhv+84zVpn7DvL036hr2DZiqaA2LJq1JA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRuuN4uAcSqLnp8xssJMgI/+ThgXipj9dA3x0E7QwUULNS8lw+C1rZ1ywdQlWuRSw+Xx1haPI+N5QON0TG3AcFHKBycW2YGCYquBgMW5Y5v9AaLhp3p5udvv7BECJQnXTann+2WVoOdTTVzvxr7e8O6qk6Dcdm0UupGWpgikFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xl69Zkpn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NInGiT090417;
	Tue, 23 Jan 2024 12:49:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035756;
	bh=oHsVY77qQExvuwdv7UgIqo4ENzNkLIJgkSQvJCRvaBk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Xl69Zkpn8V9d1dgjiESsQzcssT0WVGC0ps2ooI3ARJ/VhfWv7TMpTq1d2Ovn/Pn4i
	 v2HrnwAu0HlFTZD4RgZiMqO9jZPK9oMuZCYHr0UvpDhUM+gTF8ufWtt8VgWu4+JOVz
	 lPyFxCJe+HHlHX83I1AAZfg0PAu5yF9g6ghCG390=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NInFxM128537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:49:16 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:49:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:49:15 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NInEnM066395;
	Tue, 23 Jan 2024 12:49:15 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 5/8] remoteproc: k3-dsp: Use devm_kzalloc() helper
Date: Tue, 23 Jan 2024 12:49:10 -0600
Message-ID: <20240123184913.725435-5-afd@ti.com>
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

Use device lifecycle managed devm_kzalloc() helper function. This helps
prevent mistakes like freeing out of order in cleanup functions and
forgetting to free on all error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 0240340a83e90..2aac25d013985 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -659,7 +659,7 @@ struct ti_sci_proc *k3_dsp_rproc_of_get_tsp(struct device *dev,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	tsp = kzalloc(sizeof(*tsp), GFP_KERNEL);
+	tsp = devm_kzalloc(dev, sizeof(*tsp), GFP_KERNEL);
 	if (!tsp)
 		return ERR_PTR(-ENOMEM);
 
@@ -729,7 +729,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	ret = ti_sci_proc_request(kproc->tsp);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "ti_sci_proc_request failed\n");
-		goto free_tsp;
+		return ret;
 	}
 
 	ret = k3_dsp_rproc_of_get_memories(pdev, kproc);
@@ -796,8 +796,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	ret1 = ti_sci_proc_release(kproc->tsp);
 	if (ret1)
 		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret1));
-free_tsp:
-	kfree(kproc->tsp);
 	return ret;
 }
 
@@ -823,8 +821,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 	if (ret)
 		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret));
 
-	kfree(kproc->tsp);
-
 	k3_dsp_reserved_mem_exit(kproc);
 }
 
-- 
2.39.2


