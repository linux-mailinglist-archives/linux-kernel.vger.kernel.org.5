Return-Path: <linux-kernel+bounces-35920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907A8398D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955FEB29532
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E671272A5;
	Tue, 23 Jan 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F5gjTHQA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AA86AE0;
	Tue, 23 Jan 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035760; cv=none; b=EH0QBI0cubIT+F4ZChCha3I+GGTEwh7rLP23qc7NhNjmWB+RnuiBwmffWBA1I6qY64zjEbSPoX3VMow7QvjorjVLL7AI8mgdJ0c3qtHqSeCY9tSX1CV3KH4DujTy3uU/ueDCIBcWE96tmxzQtQyrl/ivJMyqF1+1tbK/ir1lbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035760; c=relaxed/simple;
	bh=LoWVNWUT+j/4/irRBLK0PZ7eTWDL/slj9ebsnJ9tVGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GueymkfUrzmGZ0+sj+OuOt6qpml/prKQuPktu8bWakJDnX+17l4YHlMjJnHnLqG2+NvDAuheLjN0aWVOy1lf+R7WmX0s/ovZQdMZU0EXLMyVv+eOeOV7AIuOepCKd2g/IsBKcEvGHxiRJ2jSyJ4gV0uJ5Oo6GuRJ+Y+wuM2d4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F5gjTHQA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NInFgF120618;
	Tue, 23 Jan 2024 12:49:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035755;
	bh=T7Xr7ohJgMcm1889A6P/VN3hW1DAm6KSVuRJXF+scHY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=F5gjTHQAYrxuH5YtdUVBzYw9/B/OJw2IzU60vOdyJzGCJztj0pWR8HovLmC/3AfmK
	 G29sTLdOSAL4jbeO/+jYI4nznkERFFZ+7lWhjQmxaM95AGweRqTu/JcDZjr/K5MevT
	 +gTgOxyVanG98za/uqrnXcw2hSKCe1heU5nQF3Lw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NInFra128519
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:49:15 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:49:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:49:14 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NInEnJ066395;
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
Subject: [PATCH 2/8] remoteproc: k3-dsp: Add devm action to release reserved memory
Date: Tue, 23 Jan 2024 12:49:07 -0600
Message-ID: <20240123184913.725435-2-afd@ti.com>
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

Use a device lifecycle managed action to release reserved memory. This
helps prevent mistakes like releasing out of order in cleanup functions
and forgetting to release on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 93fbc89307d6a..0cb00146fe977 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -550,6 +550,13 @@ static int k3_dsp_rproc_of_get_memories(struct platform_device *pdev,
 	return 0;
 }
 
+static void k3_dsp_mem_release(void *data)
+{
+	struct device *dev = data;
+
+	of_reserved_mem_device_release(dev);
+}
+
 static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
 {
 	struct device *dev = kproc->dev;
@@ -579,13 +586,14 @@ static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
 			ERR_PTR(ret));
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, k3_dsp_mem_release, dev);
+	if (ret)
+		return ret;
 
 	num_rmems--;
 	kproc->rmem = kcalloc(num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
-	if (!kproc->rmem) {
-		ret = -ENOMEM;
-		goto release_rmem;
-	}
+	if (!kproc->rmem)
+		return -ENOMEM;
 
 	/* use remaining reserved memory regions for static carveouts */
 	for (i = 0; i < num_rmems; i++) {
@@ -628,8 +636,6 @@ static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
 	for (i--; i >= 0; i--)
 		iounmap(kproc->rmem[i].cpu_addr);
 	kfree(kproc->rmem);
-release_rmem:
-	of_reserved_mem_device_release(kproc->dev);
 	return ret;
 }
 
@@ -640,8 +646,6 @@ static void k3_dsp_reserved_mem_exit(struct k3_dsp_rproc *kproc)
 	for (i = 0; i < kproc->num_rmems; i++)
 		iounmap(kproc->rmem[i].cpu_addr);
 	kfree(kproc->rmem);
-
-	of_reserved_mem_device_release(kproc->dev);
 }
 
 static
-- 
2.39.2


