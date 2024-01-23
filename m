Return-Path: <linux-kernel+bounces-35921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A28398D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF776B2952A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F11272C6;
	Tue, 23 Jan 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CeY8wlcN"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF786AF1;
	Tue, 23 Jan 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035761; cv=none; b=EaivFsFu3Lt7yPexER5BIrLzAedvQZ33BQIqp4jQm86l/U5K6LtguUUWu2iE4GvThJZYouu3kmSqhtYar8O3s/s0zX/fF0fdc9CHeCKd4yhAqZOfFeLPirSxcR4/apXJQ9AVIsq/MwIR/BKoQpvWys1Dekwg+QZDX2etGbZeuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035761; c=relaxed/simple;
	bh=ql2DF2gWb+wb/Fw+2uQLzt/qeLwBL6iqApd/BenJUHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVzcV4AMr4fD7/4yA+qCGIqjYZ8pdtwyl20kBPI7oXNnXDtZMDkd4Q3hB5k/fhn3Lb2m2okE5zo5bidmbiXw/8M9xP2vQSWxYP/mLsPYSRUkVy84Iw+0WIhabz70RysjmNeC/Zq2Gov4jYGKQf1u60V3wbwxy8YKwdrfTuK9gSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CeY8wlcN; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NInFI3112948;
	Tue, 23 Jan 2024 12:49:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035755;
	bh=cks8pS5hSxVEyXiud0SjS0OKfm6VxHIx7O3Mv8onWLs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CeY8wlcNvdB3VNGFpbhMHoSLkAzN/RlcfK+0iaTVgBEa52FZjIQRYVru7rlLmliIu
	 zQXfc6B+hVx25bOZF18Cq/r82jgOoLciSlrom7B+eXaresBXw8fSjogL6YjNVkdZ99
	 2KcQ3ClPzyqAMBJ8Hegx6tSSTgY+p9tlqaFgRm4A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NInFUY128522
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:49:15 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:49:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:49:15 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NInEnK066395;
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
Subject: [PATCH 3/8] remoteproc: k3-dsp: Use devm_kcalloc() helper
Date: Tue, 23 Jan 2024 12:49:08 -0600
Message-ID: <20240123184913.725435-3-afd@ti.com>
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

Use a device lifecycle managed action to free memory. This helps prevent
mistakes like freeing out of order in cleanup functions and forgetting to
free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 0cb00146fe977..a13552c71f440 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -591,7 +591,7 @@ static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
 		return ret;
 
 	num_rmems--;
-	kproc->rmem = kcalloc(num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
+	kproc->rmem = devm_kcalloc(dev, num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
 	if (!kproc->rmem)
 		return -ENOMEM;
 
@@ -635,7 +635,6 @@ static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
 unmap_rmem:
 	for (i--; i >= 0; i--)
 		iounmap(kproc->rmem[i].cpu_addr);
-	kfree(kproc->rmem);
 	return ret;
 }
 
@@ -645,7 +644,6 @@ static void k3_dsp_reserved_mem_exit(struct k3_dsp_rproc *kproc)
 
 	for (i = 0; i < kproc->num_rmems; i++)
 		iounmap(kproc->rmem[i].cpu_addr);
-	kfree(kproc->rmem);
 }
 
 static
-- 
2.39.2


