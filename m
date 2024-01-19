Return-Path: <linux-kernel+bounces-31249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B90832B28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE821C20749
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7754750;
	Fri, 19 Jan 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VDmw/5dm"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61572524A0;
	Fri, 19 Jan 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673671; cv=none; b=A5TGi5JvxSgo7TbQ1sBhMe7FIOVFfsAs0auDCje0Zjwu/+BaTyty7Am7FYrsDFlkxuG4azpzEzbBR4S4TSEJB36mR9AlPAA63Km0oXaPscepZmUGQuTmhtlvPXMGSfUeIfg5fe34qHVb+erj3ts1B6Wp5MuqzMptgml0tCUl6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673671; c=relaxed/simple;
	bh=VQlUP12x+lQZqEvOl/IoBXRKwFSDxM+N+0FlrIbqdY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnB3xo13iWMwZkKVryrNWAKTLcDZxlM9Pz0d4edsWA6czqTYKds5KW17TXCHYl0rGe6lswWSGI5TWXhpgWN8vC0v3tkoVhAHQiKWEn5x3DTGrJ+x76tCDqUqhgRUPYaULHSihavA5cim1jpk+OqdGKeL5lHR/zA9JI+9GZarCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=VDmw/5dm; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705673652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iIxPbs0dWlzjgcaYm0qZReABojDho1rbr0/l/s8ieo=;
	b=VDmw/5dmFB8a7DjV5sQY6708zGHT8cN9da4xSjKPmDqd5JoGUoAWZFLA4iBJzYVtLoeMc0
	534O4/q85cvb0JyL4RkqR4fcFW36IeUqTLCBrV3EPttmKkeaTxQBZIvVT+hfm/hQr1U2rC
	b1Gx/QWvHOF3f7bFVi1IGm2UPpG4KrU=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 2/6] dma-buf: udmabuf: Implement .{begin,end}_access
Date: Fri, 19 Jan 2024 15:13:58 +0100
Message-ID: <20240119141402.44262-3-paul@crapouillou.net>
In-Reply-To: <20240119141402.44262-1-paul@crapouillou.net>
References: <20240119141402.44262-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Implement .begin_access() and .end_access() callbacks.

For now these functions will simply sync/flush the CPU cache when
needed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v5: New patch
---
 drivers/dma-buf/udmabuf.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index c40645999648..a87d89b58816 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -179,6 +179,31 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
 	return 0;
 }
 
+static int begin_udmabuf(struct dma_buf_attachment *attach,
+			 struct sg_table *sgt,
+			 enum dma_data_direction dir)
+{
+	struct dma_buf *buf = attach->dmabuf;
+	struct udmabuf *ubuf = buf->priv;
+	struct device *dev = ubuf->device->this_device;
+
+	dma_sync_sg_for_device(dev, sgt->sgl, sg_nents(sgt->sgl), dir);
+	return 0;
+}
+
+static int end_udmabuf(struct dma_buf_attachment *attach,
+		       struct sg_table *sgt,
+		       enum dma_data_direction dir)
+{
+	struct dma_buf *buf = attach->dmabuf;
+	struct udmabuf *ubuf = buf->priv;
+	struct device *dev = ubuf->device->this_device;
+
+	if (dir != DMA_TO_DEVICE)
+		dma_sync_sg_for_cpu(dev, sgt->sgl, sg_nents(sgt->sgl), dir);
+	return 0;
+}
+
 static const struct dma_buf_ops udmabuf_ops = {
 	.cache_sgt_mapping = true,
 	.map_dma_buf	   = map_udmabuf,
@@ -189,6 +214,8 @@ static const struct dma_buf_ops udmabuf_ops = {
 	.vunmap		   = vunmap_udmabuf,
 	.begin_cpu_access  = begin_cpu_udmabuf,
 	.end_cpu_access    = end_cpu_udmabuf,
+	.begin_access      = begin_udmabuf,
+	.end_access        = end_udmabuf,
 };
 
 #define SEALS_WANTED (F_SEAL_SHRINK)
-- 
2.43.0


