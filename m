Return-Path: <linux-kernel+bounces-40019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E583D8DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17E428F29B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9E18E2C;
	Fri, 26 Jan 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DE/A6b+M"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51250134BD;
	Fri, 26 Jan 2024 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266912; cv=none; b=EcuRA7vtzMVNuuBtdrHjs1clC1ex0XQ5SZQAmwCLM1g95G6YGUYY1CsHNDSy9ICDb0Q0oZSnc90lhF8rkeDdYGPHOxvxR0kW/Is41NscYBglck5hfpUXlZqpRmZCYXxp3+bb3Gxyd+XcfmZbQs/CMdjpaY7IxZfFIB5v6Twn8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266912; c=relaxed/simple;
	bh=qivh6TydDKfcZbVPYc7spMw2cRqVCzEb9YVNhr43HUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jadX5h0VO11f0z85tOnsYtT1GLZumyemH86lxOm7OBa/Eo83RIDG1IO7tRL+3rTosPMMW9Rfj34/U+vwNj8lwn6MdiUtXLM/oyYFABAS2B0fh9Cn0VNMA1A3q+G7JovxiWcQSQYo7xp5o11wJC73g7z2MXnqVb7/e1FpOJqU+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DE/A6b+M; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266908;
	bh=qivh6TydDKfcZbVPYc7spMw2cRqVCzEb9YVNhr43HUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DE/A6b+M9I/fKxelSO3AUaC3vTm4NgzNdvGB+EAsNfNFIDo1vBid49NDfN4cYxAqH
	 Z2HNW4gqt3osCxV04/Tj7JnOa7N9kcxaQCl0qNuv8et/Fm8Omfj4EaF20oHn3dIxfB
	 JAGP3mFxUYUAoILP9waJ2DMcitvbKpOO5zlxMD5bf17Z1kBkJ93AsIqgK7TTWwuMf0
	 T6mSgKOSusV6e5f2CcLnlk91PDDigaLbfORRex6tqCTop2ctvWMVdq64hgbqFAD4vk
	 2pASlsJbZZSGCU4UxXbrtJ+qHDYvHivDAZNUPBm8HMMltHZRQV0bJNZHPaqYBQE17y
	 VazVG+2TL8tiw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 259553782077;
	Fri, 26 Jan 2024 11:01:48 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 3/9] media: test-drivers: Set REQBUFS minimum number of buffers
Date: Fri, 26 Jan 2024 12:01:35 +0100
Message-Id: <20240126110141.135896-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
References: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
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


