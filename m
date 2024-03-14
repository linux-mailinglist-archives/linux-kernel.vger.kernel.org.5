Return-Path: <linux-kernel+bounces-103505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495587C058
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306A0281BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97474C0F;
	Thu, 14 Mar 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mbqxPj3H"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89F74421;
	Thu, 14 Mar 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430362; cv=none; b=SajWJGinzXiV4DWO1O+fYvJFzfMO9F/HDrRNJcYEf0LRda1eJQJTaEaH/y16TYisZ3TuBSsnoGT7ae5jhnIr6NSwJdgO9ffnXUZrrQlMe5nqeeEZSzZl0spfmCwh3oJbf16stqNacRNRrQJRdw/2gNsethirWpdVf7mXMNA5i24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430362; c=relaxed/simple;
	bh=S8BY+YnoHLjL4nNyT8UzD8yD98Cb9AAqKgtqpMGHJiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5r47p7b3lyI+1wtaSKXAvJBYBm4Y3eaaKMo6xlowvqUNCOLC0OMwPfaSD6tp6nYuz7Xs5EwltQhX3CzakseNTqaZYA8JBYsbO6FjW/VHXC6qJZ6a8/Cwbb0H4N9Ep3g8d6TMA1ra6LUj+Np4Fk8eK2cK6P3g5+gkmSCe0Yx2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mbqxPj3H; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710430359;
	bh=S8BY+YnoHLjL4nNyT8UzD8yD98Cb9AAqKgtqpMGHJiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbqxPj3Hqp+HnBC/OztP1uSvHr3X9Hv0Oi2/teHC5NWUI9ab0Bk7eabZZNRw2mi+T
	 L/HZpMkcc9RFLsXI7fLC1wY4HkHBlFFk52FViixLlXF8WdHV/3QUimRlEibzD12z88
	 FF1FAFnJB53vfUhjBfGnqlQCGbGHoFqYQXtumQekq01+weHEsJ1cttw/1PhW9aIMEU
	 Xfs1LQpO9pI2o43TSoCZJwYvku2gr7Ec5lYB0CfKmNga2rM9OfYCqKGRGA8XzNjRIl
	 YJbwMS5/e19Fa5gNMo6+udn4THCuCy+3KVks0saPdxby53S86/7u1UtTNc/4Ky8t1h
	 D6COXqgBgHD8g==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 975B9378210F;
	Thu, 14 Mar 2024 15:32:38 +0000 (UTC)
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
Subject: [PATCH v21 8/9] media: v4l2: Add mem2mem helpers for REMOVE_BUFS ioctl
Date: Thu, 14 Mar 2024 16:32:25 +0100
Message-Id: <20240314153226.197445-9-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create v4l2-mem2mem helpers for VIDIOC_REMOVE_BUFS ioctl and
make test drivers use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
changes in version 21:
- In v4l2_m2m_ioctl_remove_bufs() check if the queue exists and
  if it type macth request type.
- Do not set vidioc_remove_bufs for vim2m driver.

 drivers/media/test-drivers/vicodec/vicodec-core.c |  1 +
 drivers/media/test-drivers/vimc/vimc-capture.c    |  1 +
 drivers/media/test-drivers/visl/visl-video.c      |  1 +
 drivers/media/test-drivers/vivid/vivid-core.c     |  1 +
 drivers/media/v4l2-core/v4l2-mem2mem.c            | 15 +++++++++++++++
 include/media/v4l2-mem2mem.h                      |  2 ++
 6 files changed, 21 insertions(+)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index e13f5452b927..3e011fe62ae1 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1345,6 +1345,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
+	.vidioc_remove_bufs	= v4l2_m2m_ioctl_remove_bufs,
 
 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index 97693561f1e4..ba7550b8ba7e 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -221,6 +221,7 @@ static const struct v4l2_ioctl_ops vimc_capture_ioctl_ops = {
 	.vidioc_expbuf = vb2_ioctl_expbuf,
 	.vidioc_streamon = vb2_ioctl_streamon,
 	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_remove_bufs = vb2_ioctl_remove_bufs,
 };
 
 static void vimc_capture_return_all_buffers(struct vimc_capture_device *vcapture,
diff --git a/drivers/media/test-drivers/visl/visl-video.c b/drivers/media/test-drivers/visl/visl-video.c
index b9a4b44bd0ed..f8d970319764 100644
--- a/drivers/media/test-drivers/visl/visl-video.c
+++ b/drivers/media/test-drivers/visl/visl-video.c
@@ -539,6 +539,7 @@ const struct v4l2_ioctl_ops visl_ioctl_ops = {
 	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_expbuf			= v4l2_m2m_ioctl_expbuf,
+	.vidioc_remove_bufs		= v4l2_m2m_ioctl_remove_bufs,
 
 	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 11b8520d9f57..771392f67dda 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -769,6 +769,7 @@ static const struct v4l2_ioctl_ops vivid_ioctl_ops = {
 	.vidioc_expbuf			= vb2_ioctl_expbuf,
 	.vidioc_streamon		= vb2_ioctl_streamon,
 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+	.vidioc_remove_bufs		= vb2_ioctl_remove_bufs,
 
 	.vidioc_enum_input		= vivid_enum_input,
 	.vidioc_g_input			= vivid_g_input,
diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 75517134a5e9..eb22d6172462 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1386,6 +1386,21 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
 
+int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
+			       struct v4l2_remove_buffers *remove)
+{
+	struct v4l2_fh *fh = file->private_data;
+	struct vb2_queue *q = v4l2_m2m_get_vq(fh->m2m_ctx, remove->type);
+
+	if (!q)
+		return -EINVAL;
+	if (q->type != remove->type)
+		return -EINVAL;
+
+	return vb2_core_remove_bufs(q, remove->index, remove->count);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_remove_bufs);
+
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
 				struct v4l2_buffer *buf)
 {
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index 7f1af1f7f912..0af330cf91c3 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -867,6 +867,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
 				struct v4l2_requestbuffers *rb);
 int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
 				struct v4l2_create_buffers *create);
+int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
+			       struct v4l2_remove_buffers *d);
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
 				struct v4l2_buffer *buf);
 int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,
-- 
2.40.1


