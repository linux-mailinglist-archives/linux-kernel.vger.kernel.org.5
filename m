Return-Path: <linux-kernel+bounces-53215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90084A246
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E261C2322A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813048CD5;
	Mon,  5 Feb 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v6BO4m/Y"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D4482FC;
	Mon,  5 Feb 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157681; cv=none; b=gqlRD9gqyVtI+3nR9P5egBAMgP1QkFyz2VhQxd1BF+pvwEweWL/tfrRu/Gb2eSuvfFc6o8O0G+gYBnZcit952jaSvscxxI+juqzdfWIr/BnEhUtNEkclLxBS7MBxddYTjsQpgtHgkLcC/gmvdMh7EE9bbsIPMhc0YEoHWNPDCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157681; c=relaxed/simple;
	bh=9iDV+TWD82fWrLcAZkquAWHpDR8++tqogomRz7LQ/tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFa6mdd3oHBI+ASnBQGc4slgTNi40nWUZRRy/iNKrn5iZ1aGYp9YlBfrqOLb1la2vBQD4oIRNK+b31t1+Dkqv53gN0J9VG+QeubQ2nBFr7tIL3WfCRzyYT5A4md+evKa2REyC2h1HPdotjmg0ugHzqzgrf8py2jh0uyGoZlES/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v6BO4m/Y; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415IRtVe084706;
	Mon, 5 Feb 2024 12:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707157675;
	bh=iLQKTUIwbNg31poUm3Ar1AjBEmtluF3zLOK8jLkIqzE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=v6BO4m/Yz2DvDtM2ldPW3ouwQDnwLvoQ19T/eKOQ5cuW+K46sHlyPKEWh+ybkTVcu
	 G5AkL2T8bLkYYkxtX/03X9HGnNYnhZ+DN/KnNnl5ZD8aaizZhBZYGvWREqd/exY3dV
	 LILFVMTkrfbaS75kvRRqrXIHU0sXkWj/haCqKd2I=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415IRtQ7017734
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 12:27:55 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 12:27:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 12:27:55 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415IRsX7058567;
	Mon, 5 Feb 2024 12:27:55 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 3/5] remoteproc: k3-dsp: Add devm action to release tsp
Date: Mon, 5 Feb 2024 12:27:51 -0600
Message-ID: <20240205182753.36978-4-afd@ti.com>
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

Use a device lifecycle managed action to release tps ti_sci_proc handle.
This helps prevent mistakes like releasing out of order in cleanup
functions and forgetting to release on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 27 +++++++++++------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index b9332c66a52ab..800c8c6767086 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -646,6 +646,13 @@ static void k3_dsp_reserved_mem_exit(struct k3_dsp_rproc *kproc)
 		iounmap(kproc->rmem[i].cpu_addr);
 }
 
+static void k3_dsp_release_tsp(void *data)
+{
+	struct ti_sci_proc *tsp = data;
+
+	ti_sci_proc_release(tsp);
+}
+
 static
 struct ti_sci_proc *k3_dsp_rproc_of_get_tsp(struct device *dev,
 					    const struct ti_sci_handle *sci)
@@ -682,7 +689,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	const char *fw_name;
 	bool p_state = false;
 	int ret = 0;
-	int ret1;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
@@ -732,16 +738,17 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		dev_err_probe(dev, ret, "ti_sci_proc_request failed\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, k3_dsp_release_tsp, kproc->tsp);
+	if (ret)
+		return ret;
 
 	ret = k3_dsp_rproc_of_get_memories(pdev, kproc);
 	if (ret)
-		goto release_tsp;
+		return ret;
 
 	ret = k3_dsp_reserved_mem_init(kproc);
-	if (ret) {
-		dev_err_probe(dev, ret, "reserved memory init failed\n");
-		goto release_tsp;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "reserved memory init failed\n");
 
 	ret = kproc->ti_sci->ops.dev_ops.is_on(kproc->ti_sci, kproc->ti_sci_id,
 					       NULL, &p_state);
@@ -793,10 +800,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 
 release_mem:
 	k3_dsp_reserved_mem_exit(kproc);
-release_tsp:
-	ret1 = ti_sci_proc_release(kproc->tsp);
-	if (ret1)
-		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret1));
 	return ret;
 }
 
@@ -818,10 +821,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 
 	rproc_del(kproc->rproc);
 
-	ret = ti_sci_proc_release(kproc->tsp);
-	if (ret)
-		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret));
-
 	k3_dsp_reserved_mem_exit(kproc);
 }
 
-- 
2.39.2


