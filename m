Return-Path: <linux-kernel+bounces-75047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A7D85E224
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6611F233CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B465C82D8B;
	Wed, 21 Feb 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2e4mvyoO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C382870;
	Wed, 21 Feb 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530891; cv=none; b=CpCCmnrpF9Eytqm4+6u4PEV6S50XoaTIexFJnwTglRfrzu8NWTptZCGFeYj5SJX5wThczJ5M6Ob6aOZ3ToCurJ6UGrsnmoSvbYP8Evl0yHFufzhOHGG55NKfL7zi3s9ttlokdrC+XXulzTp56cu3w2dUiv9TXfqPz+5WHyDL5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530891; c=relaxed/simple;
	bh=xkha4D8zVSPTP3prmB5KEcjW0rkv3j+VZiNxrnoa80M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvm04aHZWRPjV/0RfG+Rec5d7pIwhTUTBengVfjE8Ffgflb0/X51N/Uc2UP6CUjEVuCw9s/AXTiCgujU6Of02vPY7RPeE1Rn5wxUiwcjjVwSI4X3C6RD+ry+fYeqcnqYjFfttTEMIgwNfJNbtqEamrn6tkNIfyd3OunLHHv02lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2e4mvyoO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708530888;
	bh=xkha4D8zVSPTP3prmB5KEcjW0rkv3j+VZiNxrnoa80M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2e4mvyoOeIXC48yaN3hIVxFb884yiG49Qk9Gl+RPrOQ5EA8QawrdcgDXnS2vNWioy
	 8LlxDn/GCJLV9/vF/zQ0jlyYfP78zBGSfxUAYCRPeyovNnfEpsYo3odix458VBWaeq
	 jqiREMJ1gkYb4z0qeY/wk9mJEeryy9qFiNESySWG2zbO5MEpD5Hu5IlGsoYRwzPo90
	 MVq0zvglbrn5fPmTHGgkRBfNwP9vQeHcC6Sg53wJZaKi7WekI8uRWNGrjvRFwXTjrc
	 ZHxEZ+KfFkDrAwVE+qLKGeyww+K5pPrkmWCIQckPp1j+TFSpRr9a4j1pGF5SYe3Y4K
	 LSEPlWVSs7FpA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C78D937820D5;
	Wed, 21 Feb 2024 15:54:47 +0000 (UTC)
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
Subject: [PATCH v20 8/9] media: v4l2: Add mem2mem helpers for REMOVE_BUFS ioctl
Date: Wed, 21 Feb 2024 16:54:34 +0100
Message-Id: <20240221155435.100093-9-benjamin.gaignard@collabora.com>
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

Create v4l2-mem2mem helpers for VIDIOC_REMOVE_BUFS ioctl and
make test drivers use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c |  1 +
 drivers/media/test-drivers/vim2m.c                |  1 +
 drivers/media/test-drivers/vimc/vimc-capture.c    |  1 +
 drivers/media/test-drivers/visl/visl-video.c      |  1 +
 drivers/media/test-drivers/vivid/vivid-core.c     |  1 +
 drivers/media/v4l2-core/v4l2-mem2mem.c            | 10 ++++++++++
 include/media/v4l2-mem2mem.h                      |  2 ++
 7 files changed, 17 insertions(+)

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
diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index 3e3b424b4860..14aff4ad576b 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -960,6 +960,7 @@ static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
 	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
+	.vidioc_remove_bufs	= v4l2_m2m_ioctl_remove_bufs,
 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
 
 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
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
index 75517134a5e9..ba21c60f1ed3 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1386,6 +1386,16 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
 
+int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
+			       struct v4l2_remove_buffers *remove)
+{
+	struct v4l2_fh *fh = file->private_data;
+
+	return vb2_core_remove_bufs(v4l2_m2m_get_vq(fh->m2m_ctx, remove->type),
+				    remove->index, remove->count);
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


