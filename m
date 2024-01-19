Return-Path: <linux-kernel+bounces-30978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4D832705
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E2AB2464B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E23D56E;
	Fri, 19 Jan 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pg9chlwj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4D3D0B5;
	Fri, 19 Jan 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657798; cv=none; b=bZ+nZBx1cvV1Jb0sUq1XZrjgVVHquH4rsKsDFbMIx6+LYrIP3+oyaHgI+Z4juD9jwNkiwbNPmmnqZy8dRdKtl/NlN0SEV+e4FJMuBzbQtW1Mptq1OXrlCVL9zTDZDHTz2BjHlkp4zOWzBavaaO3HDDB3zcwueAmqQ0D5GgoExDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657798; c=relaxed/simple;
	bh=fLBUyGpx4ptCR4u0+nI0SI/vY0QxIITEt56gQ9tS950=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5vnk9iYPVR4Cv2trjv4iCN3F/u2paNhvL4EpGFjM0R4CdcHho0ZrdrkusY4uNiGw4j6N5q3u19C1az+YOD3dN+xClUaFuzO2oIAIdkqgL9bO/twd2PuTz3omEbhfanhrgWTjljQyd5aTAhEXix602mYn34fC0UsN4fr+q2PRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pg9chlwj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705657795;
	bh=fLBUyGpx4ptCR4u0+nI0SI/vY0QxIITEt56gQ9tS950=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pg9chlwjoHyrTA2NiIAkcTF2jCfjWWhutFa1umFQ5ZOD2q7syOCUcOy8WMJMvxef6
	 ubN9Snzzpa8fhPUdzzgaEUQ3mOFrX524oilX5DRPaJDzSfPN2QroPtAsWiq19PMu0U
	 X3z9zgQpbasYGzF5zcKl5wkmNdZwALnkhXt6OtLA83yjFc9GWXypWpFulhxo6U6JgK
	 FITi+0Q1TzyrSHDYI7xZPWwGMW03BnkMxJ0w4UM0CaKyI7k664jQsGqHSGUSuFl+cT
	 CLQxTj+XMxw5cySyR0lRl6k2cuyuYZqD1CEP0Ptq39FyipDrQX0Df47MPuHq9u6u1u
	 mfSELge+wfvQQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EB2B33782081;
	Fri, 19 Jan 2024 09:49:54 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v17 8/8] media: verisilicon: Support deleting buffers on capture queue
Date: Fri, 19 Jan 2024 10:49:44 +0100
Message-Id: <20240119094944.26763-9-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to delete buffers on capture queue because it the one which
own the decoded buffers. After a dynamic resolution change lot of
them could remain allocated but won't be used anymore so deleting
them save memory.
Do not add this feature on output queue because the buffers are
smaller, fewer and always recycled even after a dynamic resolution
change.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c  | 1 +
 drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index db3df6cc4513..f6b0a676a740 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -248,6 +248,7 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	dst_vq->lock = &ctx->dev->vpu_mutex;
 	dst_vq->dev = ctx->dev->v4l2_dev.dev;
+	src_vq->supports_delete_bufs = true;
 
 	return vb2_queue_init(dst_vq);
 }
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 941fa23c211a..34eab90e8a42 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
 	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
 	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
 
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
-- 
2.40.1


