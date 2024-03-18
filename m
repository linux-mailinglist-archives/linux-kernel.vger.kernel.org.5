Return-Path: <linux-kernel+bounces-106179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0C87EA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1814328368F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A84AECD;
	Mon, 18 Mar 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="abOwOHg1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2E4CB20;
	Mon, 18 Mar 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769750; cv=none; b=DnVJtgyOA7o1PoQGxZiV2q2fQ4CLQ1Nh6eKsyi75XFHMG8b0TFlxwMGNiItIIard5uHI1qQ+lorXr1klZg+aNfW1SpTn67GJnBduchNErLJUNeT52REG7oPD27fCzMfXWxCZRRPYZLeaFgDMzvCXH7IWHR7hEqlSRMDsNbgFQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769750; c=relaxed/simple;
	bh=JLG8sukgDM2O23Tr0HIpeWmUSEr+XlkIyVAeaAqkV9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FkzqLCBK1SkgS16NBWKfFRFd1zisDZOvHXt3efFdiLiiw4LJrF2JhzcJZZ3qaMN4nD9C0MNVyc8lHWWcKhrwp/NmZWgut1yVj12VN8CV+2RITxujiGBuJcWID++4RF5m7Od9mw/ZgEL9wON4CmTvnZgIPGEFCa1EsajSPG9W4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=abOwOHg1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710769746;
	bh=JLG8sukgDM2O23Tr0HIpeWmUSEr+XlkIyVAeaAqkV9w=;
	h=From:To:Cc:Subject:Date:From;
	b=abOwOHg1MxXA9XUrHhafmXL36GzADANXBqlafBo90/SEwYHmogN5aclvdhIWQ/FE7
	 ZM2Hi5vA0vCJv+XQaYLWaGhmF/SsLXHZ5k3uNf2KPLTdnZKWM76LHu6w1AQCyvMC5v
	 NHszyuYNY5oQkwZXBPzbujX6NPX5A6DpS2wr6p6KAi3xpZLv94/TOlakQFbGhc+enj
	 ldebTtMNhSTnbQe1Qz3NQOWGV9Uv+uGwCgJbGTv0oIMe+Lnb7VwF5onbeTrFd8UptC
	 rHL0GU6aOSPH27LUwjaAYQa5B7v1qwEqgt/LIHOGmBkrHfMXUKMCqKLjs2iZb38ix9
	 KXScahMujO8wQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A6EB3781183;
	Mon, 18 Mar 2024 13:49:06 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v21.1 3/9] media: test-drivers: Set REQBUFS minimum number of buffers
Date: Mon, 18 Mar 2024 14:48:56 +0100
Message-Id: <20240318134856.110687-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using 'min_queued_buffers' field to specify the
minimum number of buffers to be allocated when calling REQBUF
use 'min_reqbufs_allocation' field which is dedicated to this
purpose.

Change the minimum requested buffers to 2 for vivid-meta-out
and vivid-touch-cap drivers when creating the queues.
That allows to remove code which prohibe to allocate only
one buffer in their respective queue setup functions.

While at it rename vivid_create_queue() parameter.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 21.1:
- Change min requested buffers for vivid-meta-out and vivid-touch-cap.
- Remove useless call in their queue setup functions.

 drivers/media/test-drivers/vimc/vimc-capture.c     | 2 +-
 drivers/media/test-drivers/vivid/vivid-core.c      | 8 ++++----
 drivers/media/test-drivers/vivid/vivid-meta-out.c  | 4 ----
 drivers/media/test-drivers/vivid/vivid-touch-cap.c | 4 ----
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index 2a2d19d23bab..97693561f1e4 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -432,7 +432,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 	q->mem_ops = vimc_allocator == VIMC_ALLOCATOR_DMA_CONTIG
 		   ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_queued_buffers = 2;
+	q->min_reqbufs_allocation = 2;
 	q->lock = &vcapture->lock;
 	q->dev = v4l2_dev->dev;
 
diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 159c72cbb5bf..e2d4f10003f3 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -861,7 +861,7 @@ static const struct media_device_ops vivid_media_ops = {
 static int vivid_create_queue(struct vivid_dev *dev,
 			      struct vb2_queue *q,
 			      u32 buf_type,
-			      unsigned int min_queued_buffers,
+			      unsigned int min_reqbufs_allocation,
 			      const struct vb2_ops *ops)
 {
 	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE && dev->multiplanar)
@@ -898,7 +898,7 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	q->mem_ops = allocators[dev->inst] == 1 ? &vb2_dma_contig_memops :
 						  &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_queued_buffers = supports_requests[dev->inst] ? 0 : min_queued_buffers;
+	q->min_reqbufs_allocation = min_reqbufs_allocation;
 	q->lock = &dev->mutex;
 	q->dev = dev->v4l2_dev.dev;
 	q->supports_requests = supports_requests[dev->inst];
@@ -1364,7 +1364,7 @@ static int vivid_create_queues(struct vivid_dev *dev)
 	if (dev->has_meta_out) {
 		/* initialize meta_out queue */
 		ret = vivid_create_queue(dev, &dev->vb_meta_out_q,
-					 V4L2_BUF_TYPE_META_OUTPUT, 1,
+					 V4L2_BUF_TYPE_META_OUTPUT, 2,
 					 &vivid_meta_out_qops);
 		if (ret)
 			return ret;
@@ -1373,7 +1373,7 @@ static int vivid_create_queues(struct vivid_dev *dev)
 	if (dev->has_touch_cap) {
 		/* initialize touch_cap queue */
 		ret = vivid_create_queue(dev, &dev->vb_touch_cap_q,
-					 V4L2_BUF_TYPE_VIDEO_CAPTURE, 1,
+					 V4L2_BUF_TYPE_VIDEO_CAPTURE, 2,
 					 &vivid_touch_cap_qops);
 		if (ret)
 			return ret;
diff --git a/drivers/media/test-drivers/vivid/vivid-meta-out.c b/drivers/media/test-drivers/vivid/vivid-meta-out.c
index 4a569a6e58be..82ab3b26914e 100644
--- a/drivers/media/test-drivers/vivid/vivid-meta-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-meta-out.c
@@ -18,7 +18,6 @@ static int meta_out_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
-	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	unsigned int size =  sizeof(struct vivid_meta_out_buf);
 
 	if (!vivid_is_webcam(dev))
@@ -31,9 +30,6 @@ static int meta_out_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 		sizes[0] = size;
 	}
 
-	if (q_num_bufs + *nbuffers < 2)
-		*nbuffers = 2 - q_num_bufs;
-
 	*nplanes = 1;
 	return 0;
 }
diff --git a/drivers/media/test-drivers/vivid/vivid-touch-cap.c b/drivers/media/test-drivers/vivid/vivid-touch-cap.c
index 4b3c6ea0afde..3888c21b4d0c 100644
--- a/drivers/media/test-drivers/vivid/vivid-touch-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-touch-cap.c
@@ -13,7 +13,6 @@ static int touch_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				 struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
-	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	struct v4l2_pix_format *f = &dev->tch_format;
 	unsigned int size = f->sizeimage;
 
@@ -24,9 +23,6 @@ static int touch_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 		sizes[0] = size;
 	}
 
-	if (q_num_bufs + *nbuffers < 2)
-		*nbuffers = 2 - q_num_bufs;
-
 	*nplanes = 1;
 	return 0;
 }
-- 
2.40.1


