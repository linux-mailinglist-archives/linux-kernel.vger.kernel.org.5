Return-Path: <linux-kernel+bounces-54466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5784AF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C67B244EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7677B12D74E;
	Tue,  6 Feb 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MiTtNqiC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B712BF0F;
	Tue,  6 Feb 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206559; cv=none; b=Ave1eBM5hHrwzVskrNXcpA0I7JKX0veRXC/kKPSHEzWukq8tD+PNF73y5cjRIL4TD1UlDXp7CnlAQw0sXxj7NeYfHEjhIBx9KNTb7hJHv05WEnpLZl3/xynBN4FBfZOTGqYA0RjM5X8SSYXGc0ov5WP4TbW7eB9X6BsmKwEZ8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206559; c=relaxed/simple;
	bh=pOBMf2guesXNH6vUwvSx6EUngxizNRYUxTMvSY6wvpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jy7hd0ozjBlfq2uOeQ2AA3DSDHKJomEILqwDeGIJerOrGZe5D7SpGMwKoAV4sO72kYZovba63oxjPoY1c8IqKyeAb2Ll8vPL6V17TRUIawrUOXLw/I4eyW6TTLginqZX1AUcD2wvuTy/cltuPMVFe3EtFBaKReQhZIb6/1Zixwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MiTtNqiC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707206550;
	bh=pOBMf2guesXNH6vUwvSx6EUngxizNRYUxTMvSY6wvpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MiTtNqiCnj+U3nL1lb1MjjqENAAaLb0WsV+insn8X4ytfD87AIMGuN4ilGjz4KKAE
	 zTefrPCciNk8aHAAwuHTBQAo9f/3AR2j4vsjnZf88TD9LbLxdrGJlArjRA2xn1Hje/
	 ASqDDgqqvynzYAkVFLdXj/HPaxj9EWCVmIJ/irjcrqt/8/eO9QpCzevJ2fczvhYt8I
	 +UAEZlRABsk3LzFI68c3NZit377ANirkCu69oyu3oqZl4Z0Md2IIc5jYfIDwlUpxlZ
	 WTxgWZV+m3QsrkF9r9rtU6jfPqHVD8RpmmNOqZwDqsgd0+xnNJGLSS3VfQsfgNd0uh
	 Tl6Vl6R4UII/g==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3861D3782087;
	Tue,  6 Feb 2024 08:02:30 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v19 9/9] media: verisilicon: Support deleting buffers on capture queue
Date: Tue,  6 Feb 2024 09:02:19 +0100
Message-Id: <20240206080219.11951-10-benjamin.gaignard@collabora.com>
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

Allow to delete buffers on capture queue because it the one which
own the decoded buffers. After a dynamic resolution change lot of
them could remain allocated but won't be used anymore so deleting
them save memory.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
 1 file changed, 1 insertion(+)

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


