Return-Path: <linux-kernel+bounces-35919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854648398CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4241F2732B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39A91272A3;
	Tue, 23 Jan 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yMgqvkab"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281B86ADB;
	Tue, 23 Jan 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035760; cv=none; b=XtHR/RRzEllHF5Uof+pM7Ozo7Lk/2apy8S/jwpmUglhncVc248gNi3DxWnfg7FqbtKbj/WLAI0uBZHAKux6RQri5Dwa59HsJJZXFPSeDp6sufhNwO3XpOrq0ffn3deY3aIedNZQi3mbM8H+tiPDd3LWv7oQLDKJaSK1LOa9GrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035760; c=relaxed/simple;
	bh=ziifyqt5mU3xrxAImR3qI90L5+NR/EzJoN8S2id1cGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iX2z4BhpxOO/aUwnJ5lUc3DLaPwc64gHMOcZYvOkqrIIoWCgShAnD/d6R+8b5rMznpSZD2p+8y9P7nedaqQ10lmM3dr+YMR8aEd9rKgV2ptkTd7AC8gtw76L4YzzXnVlGdEo7r4tW50zGO3+6HOXJuUGJEoA0vLbOwx9N9magXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yMgqvkab; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NInE3v112938;
	Tue, 23 Jan 2024 12:49:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035754;
	bh=pq06AaMBe18J+alDgo4OsOqx/WLRXlVm9FbURKig6Vk=;
	h=From:To:CC:Subject:Date;
	b=yMgqvkabZksP+QSVdS4wp0hyUdHdLA+iSTOzAA/keebGoj1Pb01KiH1KIVRH2ETwu
	 /vvWXt2zGYqAsb1H4dLUdcaP3/EgewWX7Y1aj4kHXfN3xMXsgW2vu9rBJw2qaBNog6
	 u7GjqQ23dPHRrUmfdBhmzFi7rmKN6w60eo3PTAwA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NInEAv013651
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:49:14 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:49:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:49:14 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NInEnI066395;
	Tue, 23 Jan 2024 12:49:14 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 1/8] remoteproc: k3-dsp: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:49:06 -0600
Message-ID: <20240123184913.725435-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed allocation function. This helps prevent
mistakes like freeing out of order in cleanup functions and forgetting to
free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index ab882e3b7130b..93fbc89307d6a 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -690,8 +690,8 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to parse firmware-name property\n");
 
-	rproc = rproc_alloc(dev, dev_name(dev), &k3_dsp_rproc_ops, fw_name,
-			    sizeof(*kproc));
+	rproc = devm_rproc_alloc(dev, dev_name(dev), &k3_dsp_rproc_ops,
+				 fw_name, sizeof(*kproc));
 	if (!rproc)
 		return -ENOMEM;
 
@@ -707,12 +707,9 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	kproc->data = data;
 
 	kproc->ti_sci = ti_sci_get_by_phandle(np, "ti,sci");
-	if (IS_ERR(kproc->ti_sci)) {
-		ret = dev_err_probe(dev, PTR_ERR(kproc->ti_sci),
-				    "failed to get ti-sci handle\n");
-		kproc->ti_sci = NULL;
-		goto free_rproc;
-	}
+	if (IS_ERR(kproc->ti_sci))
+		return dev_err_probe(dev, PTR_ERR(kproc->ti_sci),
+				     "failed to get ti-sci handle\n");
 
 	ret = of_property_read_u32(np, "ti,sci-dev-id", &kproc->ti_sci_id);
 	if (ret) {
@@ -810,8 +807,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	ret1 = ti_sci_put_handle(kproc->ti_sci);
 	if (ret1)
 		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret1));
-free_rproc:
-	rproc_free(rproc);
 	return ret;
 }
 
@@ -844,7 +839,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret));
 
 	k3_dsp_reserved_mem_exit(kproc);
-	rproc_free(kproc->rproc);
 }
 
 static const struct k3_dsp_mem_data c66_mems[] = {
-- 
2.39.2


