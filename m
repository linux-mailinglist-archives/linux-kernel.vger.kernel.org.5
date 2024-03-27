Return-Path: <linux-kernel+bounces-122186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C588F337
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92809B2151C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87399154BF0;
	Wed, 27 Mar 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UMI5QwJy"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD52152505;
	Wed, 27 Mar 2024 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582367; cv=none; b=L/9EQEhzcUXOTTAkGIhCrSefCkTDT/eBmyFDT5inXkuC0oXvIUPOlp5W1GiQemCZ38M7k/e7D+Y9moUUqE1VtZz/1Vr33e7KzYUeTLgdsdsKeCGIy6LGH0zHoIGXSG9wpoL2b8J6XyGv5uvf4gIcNpPQuuXqCFA0TSUDNX2C1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582367; c=relaxed/simple;
	bh=eHSSgsbK1rqU2YbdPmS6PWjfXAy5g8Zq7TGAJaYLS8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBkSn0YIC4v8BgX8SD5CzChfYGW7hcT4mqZUgXgh9yLiW5+ppTYcejN2kIiMN1c/BL90E40vzL4+/7p9T4bmjexhlquuXBbagN8RN2gq7cPOvd/1BcueEDI0ydtPXro3N7ojl1QYVre+C83Zx0L5jAUEBm9ZtYI90VWDcHo4qIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UMI5QwJy; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [178.176.72.89])
	by mail.ispras.ru (Postfix) with ESMTPSA id 270DC4076743;
	Wed, 27 Mar 2024 23:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 270DC4076743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1711582355;
	bh=woxLEnCoTio3lIKiy9FPxfvzbuc49vi+0knM8PWIYrg=;
	h=From:To:Cc:Subject:Date:From;
	b=UMI5QwJyKrA0XUM7tYplkhayU8OvaHyeJaFK+Y4Rxy6cfrJo8roYbtwezferRTr4w
	 LBjQyNgSAqngUfRhIEtUDM9I1Ob08V0Dq6LF3LvfmbptOvE3sauPu3h2zfiK1KVVhC
	 +pdZoJPRWm3sekUHW4jEwYMoiWLD8QeBQW3BJdpA=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Andy Walls <awalls@md.metrocast.net>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] pci: ivtv: Add check for DMA map result
Date: Thu, 28 Mar 2024 02:32:23 +0300
Message-ID: <20240327233226.5919-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case DMA fails, 'dma->SG_length' is 0. This value is later used to
access 'dma->SGarray[dma->SG_length - 1]', which will cause out of
bounds access.

Add check to return early on invalid value. Adjust warnings accordingly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1932dc2f4cf6 ("media: pci/ivtv: switch from 'pci_' to 'dma_' API")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
---
 drivers/media/pci/ivtv/ivtv-udma.c | 8 ++++++++
 drivers/media/pci/ivtv/ivtv-yuv.c  | 6 ++++++
 drivers/media/pci/ivtv/ivtvfb.c    | 6 +++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-udma.c b/drivers/media/pci/ivtv/ivtv-udma.c
index 99b9f55ca829..f467a00492f4 100644
--- a/drivers/media/pci/ivtv/ivtv-udma.c
+++ b/drivers/media/pci/ivtv/ivtv-udma.c
@@ -131,6 +131,8 @@ int ivtv_udma_setup(struct ivtv *itv, unsigned long ivtv_dest_addr,
 
 	/* Fill SG List with new values */
 	if (ivtv_udma_fill_sg_list(dma, &user_dma, 0) < 0) {
+		IVTV_DEBUG_WARN("%s: could not allocate bounce buffers for highmem userspace buffers\n",
+				__func__);
 		unpin_user_pages(dma->map, dma->page_count);
 		dma->page_count = 0;
 		return -ENOMEM;
@@ -139,6 +141,12 @@ int ivtv_udma_setup(struct ivtv *itv, unsigned long ivtv_dest_addr,
 	/* Map SG List */
 	dma->SG_length = dma_map_sg(&itv->pdev->dev, dma->SGlist,
 				    dma->page_count, DMA_TO_DEVICE);
+	if (!dma->SG_length) {
+		IVTV_DEBUG_WARN("%s: DMA map error, SG_length is 0\n", __func__);
+		unpin_user_pages(dma->map, dma->page_count);
+		dma->page_count = 0;
+		return -EINVAL;
+	}
 
 	/* Fill SG Array with new values */
 	ivtv_udma_fill_sg_array (dma, ivtv_dest_addr, 0, -1);
diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index 582146f8d70d..2d9274537725 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -114,6 +114,12 @@ static int ivtv_yuv_prep_user_dma(struct ivtv *itv, struct ivtv_user_dma *dma,
 	}
 	dma->SG_length = dma_map_sg(&itv->pdev->dev, dma->SGlist,
 				    dma->page_count, DMA_TO_DEVICE);
+	if (!dma->SG_length) {
+		IVTV_DEBUG_WARN("%s: DMA map error, SG_length is 0\n", __func__);
+		unpin_user_pages(dma->map, dma->page_count);
+		dma->page_count = 0;
+		return -EINVAL;
+	}
 
 	/* Fill SG Array with new values */
 	ivtv_udma_fill_sg_array(dma, y_buffer_offset, uv_buffer_offset, y_size);
diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 410477e3e621..d1ab7fee0d05 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -281,10 +281,10 @@ static int ivtvfb_prep_dec_dma_to_device(struct ivtv *itv,
 	/* Map User DMA */
 	if (ivtv_udma_setup(itv, ivtv_dest_addr, userbuf, size_in_bytes) <= 0) {
 		mutex_unlock(&itv->udma.lock);
-		IVTVFB_WARN("ivtvfb_prep_dec_dma_to_device, Error with pin_user_pages: %d bytes, %d pages returned\n",
-			       size_in_bytes, itv->udma.page_count);
+		IVTVFB_WARN("%s, Error in ivtv_udma_setup: %d bytes, %d pages returned\n",
+			       __func__, size_in_bytes, itv->udma.page_count);
 
-		/* pin_user_pages must have failed completely */
+		/* pin_user_pages or DMA must have failed completely */
 		return -EIO;
 	}
 
-- 
2.44.0


