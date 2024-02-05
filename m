Return-Path: <linux-kernel+bounces-53216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829FC84A247
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE031F2389C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BDC48CFC;
	Mon,  5 Feb 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pwPX+TFq"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62A482EC;
	Mon,  5 Feb 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157681; cv=none; b=oHz/ujxCjEzudUqO2vkXov//YFMz+3Cs2lysT4EIYhi/CHzMgM3AIqdE3MFSVr4vl8RY2j2ju77YOE77JnGjI3xbXQaGCe1TaZIlmAqaiaDwN2WwpN9EKWtLUMsBcM3AyT2yekyDfXBmf7jkzqntaHSHnc8ZUoa9YRA0kIaQHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157681; c=relaxed/simple;
	bh=BZRn5HxmV1kTcaDGI1DqUA2GdRQp+wL20o190NF3od0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om5SwrGsuA5ja+zxT5srhiciBT4F4vb3h6B9tdLrFfIB5nK7ZlZelssEIYt2kL5shtg/h0uFyOJS+7ZivV7yZ40uvRpFscttPMUkrD3HaJzuxbsBpo61/AJZfjwa74G6JOpr8eQJ0xCVlwu63Zje7LdA9yJVzv0l9XMtLYF2w7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pwPX+TFq; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415IRtY3004117;
	Mon, 5 Feb 2024 12:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707157675;
	bh=g1q4FekfzRMSbOBtJtjziYmh6/fEDmEyxKNCwbQkyVA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pwPX+TFqEibVAR0LKRl4aBT/N7JSyGxWWcF51fOkcpb1oczyj0iJQHqL06f6ERqId
	 AFg0TBSY7vAmasMXGQoMq+xBYKb/K1/ChF3XH003f/E0Spp+/CRNNWhCEetrvwfeUI
	 nNl+/tyH6hSHFjV27iNMFlj2xLIWhEhKHgdUqphY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415IRt4I017727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 12:27:55 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 12:27:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 12:27:55 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415IRsX6058567;
	Mon, 5 Feb 2024 12:27:54 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 2/5] remoteproc: k3-dsp: Use devm_kzalloc() helper
Date: Mon, 5 Feb 2024 12:27:50 -0600
Message-ID: <20240205182753.36978-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205182753.36978-1-afd@ti.com>
References: <20240205182753.36978-1-afd@ti.com>
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
index 64ec5759c4ec1..b9332c66a52ab 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -659,7 +659,7 @@ struct ti_sci_proc *k3_dsp_rproc_of_get_tsp(struct device *dev,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	tsp = kzalloc(sizeof(*tsp), GFP_KERNEL);
+	tsp = devm_kzalloc(dev, sizeof(*tsp), GFP_KERNEL);
 	if (!tsp)
 		return ERR_PTR(-ENOMEM);
 
@@ -730,7 +730,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	ret = ti_sci_proc_request(kproc->tsp);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "ti_sci_proc_request failed\n");
-		goto free_tsp;
+		return ret;
 	}
 
 	ret = k3_dsp_rproc_of_get_memories(pdev, kproc);
@@ -797,8 +797,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	ret1 = ti_sci_proc_release(kproc->tsp);
 	if (ret1)
 		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret1));
-free_tsp:
-	kfree(kproc->tsp);
 	return ret;
 }
 
@@ -824,8 +822,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 	if (ret)
 		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret));
 
-	kfree(kproc->tsp);
-
 	k3_dsp_reserved_mem_exit(kproc);
 }
 
-- 
2.39.2


