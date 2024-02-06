Return-Path: <linux-kernel+bounces-54459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E1F84AF80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251D41C23372
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB212B17E;
	Tue,  6 Feb 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HSJ+Ip0w"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BBD12A159;
	Tue,  6 Feb 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206555; cv=none; b=rYBpegD4Rw/8mNcUGxzESjzNuXniQ5pro7qfLTIlZ+s/P6GFUBxRz+eoCTuorKVaCI2BP7xqxNZW3w03dT3tvKfNuXRte4wI/efyPWWXZKgT4Ph6VOEuUD6uuqt5Ns7VGNqa18xUKEgC2JUpbbvR0kAlRV+n90JgbRh9S/WYNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206555; c=relaxed/simple;
	bh=qivh6TydDKfcZbVPYc7spMw2cRqVCzEb9YVNhr43HUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZK2xGS+2hH+DVG0YNt1rdpyB36gjrOkc94tiOaGnZim7od/2VKDZpgF3KTPmHb2iMNMhO/3kSR6kqCEcWgtgeBmODuNDtLXnbL9dKfbeIi4NyAARGvGNRF7e77c193MK7I9XDFNjU6fxfe7YLPTTujJnd5I/46hTC9mLlShYwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HSJ+Ip0w; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707206547;
	bh=qivh6TydDKfcZbVPYc7spMw2cRqVCzEb9YVNhr43HUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSJ+Ip0wnif15x1TS1JFO1HQlTerrdbXJxROlF4qMpi03mQWSgJt9Y7ESvK68OjhT
	 BYrNlMujMm/8qyU94NaT37ocW9/flsodnflK2nJsM3VBDEUgGirT53ZQ6IlgptK3Rl
	 RBcjg8p+tf0Hyv8rTHMKjq+CpPMm1J6GC9jIA2NjxBM6lhnbRC8i5CGSAmivR7TgDr
	 W6chRb5VoYw7d93cCHzLaFAbTXZR5x8lVbBCuTRPVqOxwWjFnUjcmv8ILXpEI0yiJk
	 pKCf/f+dbsovpucP3qm8UlDG3bsF5tuziTjDx7JzRuf9aeW84HNURGvWfg7CkM8ipW
	 uevS0aHd3F5Rg==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C9BDD3782072;
	Tue,  6 Feb 2024 08:02:26 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v19 3/9] media: test-drivers: Set REQBUFS minimum number of buffers
Date: Tue,  6 Feb 2024 09:02:13 +0100
Message-Id: <20240206080219.11951-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
References: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
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


