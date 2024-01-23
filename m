Return-Path: <linux-kernel+bounces-35924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A03D8398DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01345B29C01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4D12FF63;
	Tue, 23 Jan 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q6Bw1OMm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16741272A2;
	Tue, 23 Jan 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035762; cv=none; b=h0xVcdzA0j3h3ZcDNMfrIgrS3HCNSREfif2gS7XMFyNmYYTd0Ga6wE7NDhVW2lRtRryHQ4QMP1Aaz3vsop/ou0Gryx+TSKdahtiH9GyrAolfcZPTeb9DdFiQc8iey1sPiuyW65kxzMDFU0+8jga7lWlj65921QU9Nx2vh4zOTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035762; c=relaxed/simple;
	bh=ayZ2nhNGWlLRyCN/ixD3RqwmKoxDFKmlndW7u/MzhS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWZjgXY5F/4ov46hNrF1FXh/bcDUQfk43J5Vz5WC4xBnwY5FAh6ZfuGKuEpUy06QBoIdGz4LMzSy5iZOjioetkgmiAcAYV3Kw/dOPYuofwUPgvCdoINqeK02GOmvdiCz0aUfoiTyW8yP/1ieSG3b4eqXz5W87wluW/6CwMoGca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q6Bw1OMm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NInGAX112956;
	Tue, 23 Jan 2024 12:49:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035756;
	bh=XCXZxruqA8lrGMCNwWZAu5EPSG9vI2uddVwOuAHoO/I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Q6Bw1OMmsN4x3dOuCLMTArJM2Wt8WnJO0cNHEpxwtjJbGR1ecwriDxO93QIH5qIff
	 dI1ODyos9ED+8vKnKBnwbJUH/sthq1usNtq3ZqDskY+fTvuqhsp44hXGriezxA+dhv
	 7qd2YZ4T1B/F9IpJ5EM5wbMqBYuGBTSFmZBf+ioE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NInG4A013678
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:49:16 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:49:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:49:16 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NInEnN066395;
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
Subject: [PATCH 6/8] remoteproc: k3-dsp: Add devm action to release tsp
Date: Tue, 23 Jan 2024 12:49:11 -0600
Message-ID: <20240123184913.725435-6-afd@ti.com>
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

Use a device lifecycle managed action to release tps ti_sci_proc handle.
This helps prevent mistakes like releasing out of order in cleanup
functions and forgetting to release on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 2aac25d013985..800c8c6767086 100644
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
@@ -731,16 +738,17 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
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
@@ -792,10 +800,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 
 release_mem:
 	k3_dsp_reserved_mem_exit(kproc);
-release_tsp:
-	ret1 = ti_sci_proc_release(kproc->tsp);
-	if (ret1)
-		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret1));
 	return ret;
 }
 
@@ -817,10 +821,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 
 	rproc_del(kproc->rproc);
 
-	ret = ti_sci_proc_release(kproc->tsp);
-	if (ret)
-		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret));
-
 	k3_dsp_reserved_mem_exit(kproc);
 }
 
-- 
2.39.2


