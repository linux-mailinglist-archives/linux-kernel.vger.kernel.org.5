Return-Path: <linux-kernel+bounces-26290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C982DE28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABDA1F22B37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270317C95;
	Mon, 15 Jan 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="25QRiGJl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B617C61;
	Mon, 15 Jan 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705338511;
	bh=qX0JBrJwefQ7pWQRva+R23CeHfbo5NiD/fAZV2/LQIM=;
	h=From:To:Cc:Subject:Date:From;
	b=25QRiGJlDlV37bWs1Dx2vddnBiCt5MQXoOY+2QVQjG2AbVPX83EUhny01eSUJPRZk
	 MLI5zsCbnutsp6KkstdKKlY6g5kayOoTBxaPhavJPbYIBR0eV+jWGu2YNqXoAc0f12
	 fox+l50qDn9q07q9ApEbdhsohGKOlq+1LIZlCcNPfYXkNeGBrMIRVxrLiU/6LQtngK
	 SlPp1xj072zbl8EEzNErcna2hjGkOfAZbu9IvsKalBcfImtkLa8DcBJvW5MlB5CoWo
	 YSMgDqt1u19yfxcfGzeLVypYOxlLUsyXIhCOxt5oSAuBO7ATU3u29vaGFArkQKGINp
	 HoH2y6xgE05cw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6A46C3780627;
	Mon, 15 Jan 2024 17:08:31 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: core: Refactor vb2_ioctl_create_bufs() to always set capabilities flags
Date: Mon, 15 Jan 2024 18:08:25 +0100
Message-Id: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vb2_create_bufs() takes care of setting V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS
flag and vb2_queue max_num_buffers field so call it instead duplicate the
same code in vb2_ioctl_create_bufs(). Testing p->count after calling
vb2_create_bufs() is safe since the function also check it.

Fixes: d055a76c0065 ("media: core: Report the maximum possible number of buffers for the queue")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-v4l2.c   | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 54d572c3b515..bf304a7234a0 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -1029,23 +1029,24 @@ int vb2_ioctl_create_bufs(struct file *file, void *priv,
 	int res = vb2_verify_memory_type(vdev->queue, p->memory,
 			p->format.type);
 
-	p->index = vdev->queue->num_buffers;
-	fill_buf_caps(vdev->queue, &p->capabilities);
-	validate_memory_flags(vdev->queue, p->memory, &p->flags);
+	if (vb2_queue_is_busy(vdev->queue, file)) {
+		res = -EBUSY;
+		goto failed;
+	}
+
+	res = vb2_create_bufs(vdev->queue, p);
+	if (res == 0)
+		vdev->queue->owner = file->private_data;
+
+failed:
 	/*
 	 * If count == 0, then just check if memory and type are valid.
-	 * Any -EBUSY result from vb2_verify_memory_type can be mapped to 0.
+	 * Any -EBUSY result from vb2_verify_memory_type() or
+	 * vb2_queue_is_busy() can be mapped to 0.
 	 */
 	if (p->count == 0)
 		return res != -EBUSY ? res : 0;
-	if (res)
-		return res;
-	if (vb2_queue_is_busy(vdev->queue, file))
-		return -EBUSY;
 
-	res = vb2_create_bufs(vdev->queue, p);
-	if (res == 0)
-		vdev->queue->owner = file->private_data;
 	return res;
 }
 EXPORT_SYMBOL_GPL(vb2_ioctl_create_bufs);
-- 
2.40.1


