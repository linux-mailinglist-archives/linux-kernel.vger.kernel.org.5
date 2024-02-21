Return-Path: <linux-kernel+bounces-75042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB685E214
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21711B263DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B11823A8;
	Wed, 21 Feb 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mo7CVcNR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EF81724;
	Wed, 21 Feb 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530887; cv=none; b=D6k03wsaPsa/ELcGjmmPtbD9JsC9tUiw10wTBsAeNA8INsNwCgE+6gVsi1wb1N+Ih8gHFTH1XH8621A+szbZ6Y5gHuAS/vuLydOFklbirKU0Mjwm+u0cnTGA3H0JoMDvsfzdE2h+Bq99imvEVjZg/e28ScB0Pgfr7F6Ml6cxjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530887; c=relaxed/simple;
	bh=qivh6TydDKfcZbVPYc7spMw2cRqVCzEb9YVNhr43HUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHssLi3Bz3Uiy6eOUAZjRq+13uoEQh0iMeYIe7HvBDmW6czURg3EX3+jsh06zIOPEusV4XInZ/4as32t0JbI38dHNPZmemPckMBedhTnrycz1nQqCsUTEskHnLkbGLGbvwl1F8Oj4novlTSsiK0lLYn5py96hSJs0D/wv0l5Uvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mo7CVcNR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708530884;
	bh=qivh6TydDKfcZbVPYc7spMw2cRqVCzEb9YVNhr43HUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo7CVcNRkNEnOCUwPUwGEKTgSn9c+7jl5okXJy7nJmfldpDtSCxsozIxuessgjTdY
	 EGK56JNDqAbIy03IC+ExWO5g/7UAOpDPk6bnxKmnJL7MDF36GXV58Hcr5TUnUD10is
	 9jjHqtv2t5otztlllK6eHWVOL76M/29LPw0gxOwO3MxZvqP5VksDpljVSN2Q8SOteG
	 9VeOQUsEltsudZ1yVoktG3M5yQCZOGcuhUVpKEYYVVwE3S/gm5myMSXTeLc/879EJy
	 iNxbsttBLDvv6pNvu21Xyq1RVnZtCndg8KHr94Q8DPSGSVPCRvf7E3AzX8+d3aUntW
	 lfR/3y9OKk7sA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C505237820CC;
	Wed, 21 Feb 2024 15:54:43 +0000 (UTC)
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
Subject: [PATCH v20 3/9] media: test-drivers: Set REQBUFS minimum number of buffers
Date: Wed, 21 Feb 2024 16:54:29 +0100
Message-Id: <20240221155435.100093-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221155435.100093-1-benjamin.gaignard@collabora.com>
References: <20240221155435.100093-1-benjamin.gaignard@collabora.com>
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

While at it rename vivid_create_queue() parameter.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/test-drivers/vimc/vimc-capture.c | 2 +-
 drivers/media/test-drivers/vivid/vivid-core.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 159c72cbb5bf..11b8520d9f57 100644
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
-- 
2.40.1


