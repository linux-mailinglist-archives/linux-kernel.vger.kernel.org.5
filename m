Return-Path: <linux-kernel+bounces-49000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532CE846486
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E711F25829
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D92487A5;
	Thu,  1 Feb 2024 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dojqep+/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBA482E3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830469; cv=none; b=qPAD5VJnOkysQct3aDjhgcQ/0F7+m7s/A7PEDdjYgTRvVo9Q+szjsu/tRYPQvRtaLYiLU6/Pjj4bMpm4fyhwLP0CqOixfHkIpNrpUckY1KCdaaMEASqUgCl0PirxXucTK3Y/wnlky4rhDP2Eb/iZ8bb1ndnQ8lIm5v+mGi1x/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830469; c=relaxed/simple;
	bh=J66uGdblJybSdIyISNAiXxVD4U/ZxuF3S6nfLo54RFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzDehh13/JlgovuI5r1vYP4K6j2BLzlxxoPNt/boAuJJDeguDEPY0kPIZ8y/fQP1Mbx95AreMKZGAEELET3EsZtmPg30pHjZu+T8sxsScRzlK5QSAtXO5lsimSkk75+SFU8VafYy/ShHe/uqlj89oNeuFX87dOSMEJybx/SF6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dojqep+/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706830466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kviV4OEyGv0IXC67TnkXo6XXxah3+E8Y2hWZv9VjMFo=;
	b=dojqep+/fbFDnxWRQVYaQDWK9R2eet3vXO0kyG3W+4ia2yoLdXskiXAlT4xqPe0cYYTROO
	fFVpEXFHb+d+72FgowKrrqKQdZK72JNMGEq/z1/rzCllQzxqqhSp040wu54jzce4e2Xw3w
	vsBHom8Imp6VkClF9NvRmJsJHoLvx9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-9it-QiwGMCWzk2Dtrm9xXw-1; Thu, 01 Feb 2024 18:34:23 -0500
X-MC-Unique: 9it-QiwGMCWzk2Dtrm9xXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8569E810BB0;
	Thu,  1 Feb 2024 23:34:22 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.rmtusor.csb (unknown [10.2.16.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 552AE111F9;
	Thu,  1 Feb 2024 23:34:21 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>
Cc: Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH v5 4/4] uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
Date: Thu,  1 Feb 2024 15:34:00 -0800
Message-ID: <20240201233400.3394996-5-cleech@redhat.com>
In-Reply-To: <20240201233400.3394996-1-cleech@redhat.com>
References: <20240201233400.3394996-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Conversion of this driver to use UIO_MEM_DMA_COHERENT for
dma_alloc_coherent memory instead of UIO_MEM_PHYS.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/uio/uio_dmem_genirq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 5313307c2754a..8634eba0ef2ab 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -36,7 +36,6 @@ struct uio_dmem_genirq_platdata {
 	struct platform_device *pdev;
 	unsigned int dmem_region_start;
 	unsigned int num_dmem_regions;
-	void *dmem_region_vaddr[MAX_UIO_MAPS];
 	struct mutex alloc_lock;
 	unsigned int refcnt;
 };
@@ -50,7 +49,6 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 {
 	struct uio_dmem_genirq_platdata *priv = info->priv;
 	struct uio_mem *uiomem;
-	int dmem_region = priv->dmem_region_start;
 
 	uiomem = &priv->uioinfo->mem[priv->dmem_region_start];
 
@@ -61,11 +59,8 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 			break;
 
 		addr = dma_alloc_coherent(&priv->pdev->dev, uiomem->size,
-				(dma_addr_t *)&uiomem->addr, GFP_KERNEL);
-		if (!addr) {
-			uiomem->addr = DMEM_MAP_ERROR;
-		}
-		priv->dmem_region_vaddr[dmem_region++] = addr;
+					  &uiomem->dma_addr, GFP_KERNEL);
+		uiomem->addr = addr ? (phys_addr_t) addr : DMEM_MAP_ERROR;
 		++uiomem;
 	}
 	priv->refcnt++;
@@ -80,7 +75,6 @@ static int uio_dmem_genirq_release(struct uio_info *info, struct inode *inode)
 {
 	struct uio_dmem_genirq_platdata *priv = info->priv;
 	struct uio_mem *uiomem;
-	int dmem_region = priv->dmem_region_start;
 
 	/* Tell the Runtime PM code that the device has become idle */
 	pm_runtime_put_sync(&priv->pdev->dev);
@@ -93,13 +87,12 @@ static int uio_dmem_genirq_release(struct uio_info *info, struct inode *inode)
 	while (!priv->refcnt && uiomem < &priv->uioinfo->mem[MAX_UIO_MAPS]) {
 		if (!uiomem->size)
 			break;
-		if (priv->dmem_region_vaddr[dmem_region]) {
-			dma_free_coherent(&priv->pdev->dev, uiomem->size,
-					priv->dmem_region_vaddr[dmem_region],
-					uiomem->addr);
+		if (uiomem->addr) {
+			dma_free_coherent(uiomem->dma_device, uiomem->size,
+					  (void *) uiomem->addr,
+					  uiomem->dma_addr);
 		}
 		uiomem->addr = DMEM_MAP_ERROR;
-		++dmem_region;
 		++uiomem;
 	}
 
@@ -264,7 +257,8 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 					" dynamic and fixed memory regions.\n");
 			break;
 		}
-		uiomem->memtype = UIO_MEM_PHYS;
+		uiomem->memtype = UIO_MEM_DMA_COHERENT;
+		uiomem->dma_device = &pdev->dev,
 		uiomem->addr = DMEM_MAP_ERROR;
 		uiomem->size = pdata->dynamic_region_sizes[i];
 		++uiomem;
-- 
2.43.0


