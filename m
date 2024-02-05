Return-Path: <linux-kernel+bounces-53884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6AD84A79F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9071F2AF2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9231292F1;
	Mon,  5 Feb 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIQPBF1D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717701292E3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163390; cv=none; b=nbu8KGjlltMaxvAwuPb4ws7+HTpov1sMjwcolfIy8JlNImzVjKaJqRFiEaWc73Btnqm8z1GtNg1IRCinx/yGgCIlNBBTGs3L2l7iZuAcfWBI4V9TBJ/6MHLHVIzo7m0n8SlsgJ/jICZe6mBx5WvId1ta6a9ovxbfvnxvWHAlOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163390; c=relaxed/simple;
	bh=/V90lZZSRGXXf05+8SHxHi+6QRtY/DfvuW/SQHQYyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP0T75tXUj1FfpspTAditNkWXX5xqfYOhO4NGnt5YfMkXcfQhgteixUFWpQ1OV4YkmAnJpfR2jDEw6qUXOM7GiZcmaM/9fEOGC4VT8hAL2ZgET3uUQpSWGpBlR0vgaUi+Uli3tlNGMh+GLnRc2vdSbYOsYhhZ0J39OMiVYhOrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIQPBF1D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707163387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJpKJpfoOFFg221gkKrq7FzbeWyIhT5uB2Ecy/dVoZU=;
	b=CIQPBF1DtkXpWY5I6D/I+NrizGwxwWcfhCDG+WM+viLDT6VO/102ww/DNPmtX70TtUUsyN
	hlaCqe89r2SXDKaVQhshP0I9Gszcd2gAogDe7c3zeGXxV9u+2xbpkfc4SQdJXJqpuXLOTO
	wdC9lGQrWnqVPGd44hyAKuVsP1glzxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-nVCxjYcQNTC-R1a0ywzJvg-1; Mon, 05 Feb 2024 15:03:02 -0500
X-MC-Unique: nVCxjYcQNTC-R1a0ywzJvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38C93846D6F;
	Mon,  5 Feb 2024 20:03:01 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.2.16.180])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E67F55012;
	Mon,  5 Feb 2024 20:02:59 +0000 (UTC)
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
	GR-QLogic-Storage-Upstream@marvell.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v6 4/4] uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
Date: Mon,  5 Feb 2024 12:02:57 -0800
Message-ID: <20240205200257.138376-1-cleech@redhat.com>
In-Reply-To: <20240201233400.3394996-5-cleech@redhat.com>
References: <20240201233400.3394996-5-cleech@redhat.com>
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
v6: fixed single char ',' -> ';' typo

 drivers/uio/uio_dmem_genirq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 5313307c2754a..d5f9384df1255 100644
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
+		uiomem->dma_device = &pdev->dev;
 		uiomem->addr = DMEM_MAP_ERROR;
 		uiomem->size = pdata->dynamic_region_sizes[i];
 		++uiomem;
-- 
2.43.0


