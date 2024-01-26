Return-Path: <linux-kernel+bounces-40024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44E83D8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE951F246AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F071BC28;
	Fri, 26 Jan 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qun8xc4R"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C318E3A;
	Fri, 26 Jan 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266914; cv=none; b=OFgWUHRJln5bfAOIFSBFx25n68oK31fwHkiR2JKhozu3VDSkB2Q/z72xiTkAIjqXVxlDGY7VyFbDMr3pyItP1WwlB+KEMNi5Fan0LPLnIHq9qNWjxn7p7RFlPE7NUmsXiSZxRDL9mI8TuMolkRV+X2oudSfNgnhHmluP7VeBa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266914; c=relaxed/simple;
	bh=Me0lX22ty881gD1hrvsq2lFM4h0noweFm9BxBaYyWZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyjS9w0e5pjkjnsuA7BmhfEZUfJ7NjdjklBIlRhE85dyhkm152F4WMxQCRJ1Dm3ep/u2p+6KfWwcukydQxRtMToWXMbE35D74WPh8LlXL28PQ41tZr5neDinUtSIDndDUG2sd3XNm/rGpyLSWE548DEeyyZ3UFstYgFTaQPCdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qun8xc4R; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266911;
	bh=Me0lX22ty881gD1hrvsq2lFM4h0noweFm9BxBaYyWZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qun8xc4RimRZsQknDydLw0IR+GhwixiaQtnevmSM0uO5wN3SDvaylebJlOFmKIjyy
	 vxq/VxCQy5RxmqUsHeloxDUTs4yCyVZrxqKGcpwnRFusE2ZvT+AXCJHrq35Pk56FeF
	 A1kbJF5byiraFNAtGgBBezYnN7/PIHGAzAfl7+Q0JeskZ/1O8INRiTKGSjKwvBwDm1
	 2FOGSnAz/OZaYlbKQ3RuE83dUZLwS+VsFic2nUrmwD2bcITYt6sR+za6kidPush0M1
	 D85xEuyJ+I9C08ZXnM6Vo2O8U6xs8elTBalVDptflXABO3J2tE1t6R1oS9/vhfSsrd
	 fq24lZHrS/Y7Q==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C1B303782075;
	Fri, 26 Jan 2024 11:01:50 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 8/9] media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
Date: Fri, 26 Jan 2024 12:01:40 +0100
Message-Id: <20240126110141.135896-9-benjamin.gaignard@collabora.com>
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

Create v4l2-mem2mem helpers for VIDIOC_DELETE_BUFS ioctl and
make test drivers use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 18:
- Direclty use vb2_core_delete_bufs() in v4l2_m2m_ioctl_delete_bufs().
  Remove useless static functions.

 drivers/media/test-drivers/vicodec/vicodec-core.c |  1 +
 drivers/media/test-drivers/vim2m.c                |  1 +
 drivers/media/test-drivers/vimc/vimc-capture.c    |  1 +
 drivers/media/test-drivers/visl/visl-video.c      |  1 +
 drivers/media/test-drivers/vivid/vivid-core.c     |  1 +
 drivers/media/v4l2-core/v4l2-mem2mem.c            | 10 ++++++++++
 include/media/v4l2-mem2mem.h                      |  2 ++
 7 files changed, 17 insertions(+)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index e13f5452b927..5a2d34ac12c2 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1345,6 +1345,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
+	.vidioc_delete_bufs	= v4l2_m2m_ioctl_delete_bufs,
 
 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index 3e3b424b4860..10bd8c92e340 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -960,6 +960,7 @@ static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
 	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
+	.vidioc_delete_bufs	= v4l2_m2m_ioctl_delete_bufs,
 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
 
 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index 97693561f1e4..adeb7727fade 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -221,6 +221,7 @@ static const struct v4l2_ioctl_ops vimc_capture_ioctl_ops = {
 	.vidioc_expbuf = vb2_ioctl_expbuf,
 	.vidioc_streamon = vb2_ioctl_streamon,
 	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_delete_bufs = vb2_ioctl_delete_bufs,
 };
 
 static void vimc_capture_return_all_buffers(struct vimc_capture_device *vcapture,
diff --git a/drivers/media/test-drivers/visl/visl-video.c b/drivers/media/test-drivers/visl/visl-video.c
index b9a4b44bd0ed..e8c4216e7526 100644
--- a/drivers/media/test-drivers/visl/visl-video.c
+++ b/drivers/media/test-drivers/visl/visl-video.c
@@ -539,6 +539,7 @@ const struct v4l2_ioctl_ops visl_ioctl_ops = {
 	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_expbuf			= v4l2_m2m_ioctl_expbuf,
+	.vidioc_delete_bufs		= v4l2_m2m_ioctl_delete_bufs,
 
 	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 11b8520d9f57..f772069fb1a4 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -769,6 +769,7 @@ static const struct v4l2_ioctl_ops vivid_ioctl_ops = {
 	.vidioc_expbuf			= vb2_ioctl_expbuf,
 	.vidioc_streamon		= vb2_ioctl_streamon,
 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+	.vidioc_delete_bufs		= vb2_ioctl_delete_bufs,
 
 	.vidioc_enum_input		= vivid_enum_input,
 	.vidioc_g_input			= vivid_g_input,
diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 9e983176542b..6e36a04d415c 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1380,6 +1380,16 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
 
+int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
+			       struct v4l2_delete_buffers *d)
+{
+	struct v4l2_fh *fh = file->private_data;
+
+	return vb2_core_delete_bufs(v4l2_m2m_get_vq(fh->m2m_ctx, d->type),
+				    d->index, d->count);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_delete_bufs);
+
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
 				struct v4l2_buffer *buf)
 {
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index 7f1af1f7f912..402bea36093b 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -867,6 +867,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
 				struct v4l2_requestbuffers *rb);
 int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
 				struct v4l2_create_buffers *create);
+int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
+			       struct v4l2_delete_buffers *d);
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
 				struct v4l2_buffer *buf);
 int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,
-- 
2.40.1


