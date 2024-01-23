Return-Path: <linux-kernel+bounces-36123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D7839BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6131F21AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC74F88E;
	Tue, 23 Jan 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p2IuT1J4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB081A27C;
	Tue, 23 Jan 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047963; cv=none; b=oEREVZ3rtazffxgZ3VQMl0zflGVRaP3ofbHmzAsQmn9YtvedkCMPI5Z/CXhLT4mqzjK5z+IZWBgzTROJoqAxzQ5FRftyDxYu8vW56i/ACDwLx83XdrAdCL3BruEGtelzGIhlcE55wy/8GQ6MbmIuY3TNT+TvTesXGnfo68Eqs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047963; c=relaxed/simple;
	bh=CN3luUJCGKbrlvtvv2WxMm/DQFJmECihVCV8vA4TB78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzIL0OcFJJoX0ozEenh5hogM4v2O1e4lIx7ZkWrza4OfOLc0TYmwtIhCPtqN8p83u2bYI6/0xRCINNJS3/lMmvQ6X3/Ru8l09pNpRDHy+r+h+nsVetYGucIXVFJETn/RCD/V77epaiV2PEriTYCM5PiBdgPayJWqb3dScqozofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p2IuT1J4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NMCUrm016652;
	Tue, 23 Jan 2024 16:12:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706047950;
	bh=sknuwzcV0wPaLHOK1zr7w6OmYOJwUVklzNLaSRJo1ZQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=p2IuT1J44N91rtMKoKXS2hMU8xPdWjDirWcLgVWfPPoBCLE8OfzpWJecTPL6kleDL
	 fmfJ7ZfEyGcsBR7f8SIa5yd+Gn05Nj76Ujr9VdRG4CAwCCDaVKM9I5COFWjVx0InjB
	 WK5h3efgJwLsSrz8usrwjOjK24LYwrnkovFdtkpA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NMCUcx077867
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 16:12:30 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 16:12:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 16:12:29 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NMCSuU068795;
	Tue, 23 Jan 2024 16:12:29 -0600
From: Andrew Davis <afd@ti.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Paul Cercueil
	<paul@crapouillou.net>
CC: <dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 3/3] udmabuf: Use module_misc_device() to register this device
Date: Tue, 23 Jan 2024 16:12:27 -0600
Message-ID: <20240123221227.868341-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123221227.868341-1-afd@ti.com>
References: <20240123221227.868341-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Now that we do not need to call dma_coerce_mask_and_coherent() on our
miscdevice device, use the module_misc_device() helper for registering
and module init/exit.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/dma-buf/udmabuf.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index ab6764322523c..3028ac3fd9f6a 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -392,34 +392,6 @@ static struct miscdevice udmabuf_misc = {
 	.name           = "udmabuf",
 	.fops           = &udmabuf_fops,
 };
-
-static int __init udmabuf_dev_init(void)
-{
-	int ret;
-
-	ret = misc_register(&udmabuf_misc);
-	if (ret < 0) {
-		pr_err("Could not initialize udmabuf device\n");
-		return ret;
-	}
-
-	ret = dma_coerce_mask_and_coherent(udmabuf_misc.this_device,
-					   DMA_BIT_MASK(64));
-	if (ret < 0) {
-		pr_err("Could not setup DMA mask for udmabuf device\n");
-		misc_deregister(&udmabuf_misc);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void __exit udmabuf_dev_exit(void)
-{
-	misc_deregister(&udmabuf_misc);
-}
-
-module_init(udmabuf_dev_init)
-module_exit(udmabuf_dev_exit)
+module_misc_device(udmabuf_misc);
 
 MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
-- 
2.39.2


