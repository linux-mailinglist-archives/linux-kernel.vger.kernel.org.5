Return-Path: <linux-kernel+bounces-30085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A28318F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276B328905C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568724A01;
	Thu, 18 Jan 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YgHT61KR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76A24B4B;
	Thu, 18 Jan 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580101; cv=none; b=Rd0j8IVcBQdYztFwg6ZVC3I7Mi6XBqX00IifmsUpbczAljLf4mVeIgPvoearAmD8FEiH1gXPJe0VATlynUbMNFh4IjzMmzQBUN5W0mJMcV8/f2iN1MJXVtsUHZoDILcgieHDui5la8MaseDz9RRApMJFzcvd5w9tOw4w09KKyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580101; c=relaxed/simple;
	bh=5ldk2WPitfpoAhauKKH3PXvB/qdyH5NyX4BxlP+a2cw=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=llmziOPohRHCh77z1m6sM5FGg4dec0eMyMiXzrMq2NTk6mmrnMgvYM3EfSOZ4aDbXPCNT1uBp0a29OLr42vc8kVcZRkga5zEu5xNjnnhi7rplt7bolTg1NX0dZTwi4zvc14lcVZ7Kr0VujgiTAbOxhu2bivhFTLCy427Bpl6vTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YgHT61KR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705580097;
	bh=5ldk2WPitfpoAhauKKH3PXvB/qdyH5NyX4BxlP+a2cw=;
	h=From:To:Cc:Subject:Date:From;
	b=YgHT61KRAtfiFw4AJj421fVsyofmpNM5gMP05z+kF+jJqUilJfnk2rSUDSG7jeF1/
	 SZpMOhuYo6EVEAa4UGTxVw2nXqQ4UN2V4h86Jc8pOyRrNYTg2UXX8kH90xEucAKcmn
	 WnTJHtzc8tco0k+ZWr/xt/JKSqTCw0oLP2EBlETlhwnPHkKYaVTp4RWdzcLx2uo+0q
	 kcCvbtDnb/zV1uDK3V3JCHuhc0Rn3MUlrIz/PTu4P6+AIVk22J0mKOaxy7yxB6mOuL
	 pZaJ7SijaaLG7e/qeJpzG9y99ibpyu3FDsXKPPhESuixc0DnMqkrwK2Xi8937pNh8w
	 SwiT+7L8DFooQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A13037813B7;
	Thu, 18 Jan 2024 12:14:57 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] media: media videobuf2: Stop direct calls to queue num_buffers field
Date: Thu, 18 Jan 2024 13:14:52 +0100
Message-Id: <20240118121452.29151-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2:
- Change vdev->queue->num_buffers to vb2_get_num_buffers(vdev->queue)
  in vb2_ioctl_create_bufs().
- Remove Fixes tag

 drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 41a832dd1426..b6bf8f232f48 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -989,7 +989,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	bool no_previous_buffers = !q_num_bufs;
 	int ret = 0;
 
-	if (q->num_buffers == q->max_num_buffers) {
+	if (q_num_bufs == q->max_num_buffers) {
 		dprintk(q, 1, "maximum number of buffers already allocated\n");
 		return -ENOBUFS;
 	}
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 54d572c3b515..6380155d8575 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -1029,7 +1029,7 @@ int vb2_ioctl_create_bufs(struct file *file, void *priv,
 	int res = vb2_verify_memory_type(vdev->queue, p->memory,
 			p->format.type);
 
-	p->index = vdev->queue->num_buffers;
+	p->index = vb2_get_num_buffers(vdev->queue);
 	fill_buf_caps(vdev->queue, &p->capabilities);
 	validate_memory_flags(vdev->queue, p->memory, &p->flags);
 	/*
-- 
2.40.1


