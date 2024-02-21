Return-Path: <linux-kernel+bounces-75048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E217B85E226
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F79B1F21643
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D7082D9D;
	Wed, 21 Feb 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yjLWpG6E"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F382885;
	Wed, 21 Feb 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530892; cv=none; b=RJsoSbVxPwpSdVyLToIZw88jI20dYRb23itjg7KbC8grrh6Nl4RHsmUW3DZLO16FWaX/rIZV+QZU+/cuXMNKEivjQAEd/Z0unaqR7Nhl8q3q3e8JUvUxWE0zsh7ZlQDxUJAXWYGGGSTpBcsa5bW+K//QyzS32H+oNqXrhrVpNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530892; c=relaxed/simple;
	bh=fp7Af2JavyVIFNlDhfBtLvTU8aA7T4w2d45EtkwuBHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJQNg3VNjoqC8My862LUgkx4qKqF7tWgteKR7BmYRB3h0Rz48lbrXXqAIt+jl5UHmExT0qGmK74AX+XXg84r7ThBZZhzjzz/EDer76Zs94wVpDtJE1F4S+F7SViWpzrD/mY9u01HqZ6b6a5o/h3yilu0Y2xjN523R62zqnjw0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yjLWpG6E; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708530889;
	bh=fp7Af2JavyVIFNlDhfBtLvTU8aA7T4w2d45EtkwuBHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yjLWpG6EANx78oYE9sH5do7GUj0U7n+V9eQoJ6/nfjsLYYzECcc6/ECZpDD9kqRtk
	 +byzVefibEpLtL+FIeZV1iV6rLOzAIP0DuDL5f7lrNH4A3W9gTYUtqdzXYuvNTlkZv
	 7ltm40Pw0xAGZF79l1BR8vRBUR3FDrt2s2W4nT0L8CSALgnY7CW5xXfgpnD0NS5EnL
	 1UZENZGIDlsBycNcwrRDG8aYJCdib2Tyg+usqMjgRCqnm6oyFy5rYc2TVSNU51tjKf
	 NwJqXMS6b3P/5Kvc/F+yRC4kZbj3zB6+eSUBdikETFRcr1OkJqIofofDORBqvK9Vuy
	 JAopl0JowHDdg==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 967903780629;
	Wed, 21 Feb 2024 15:54:48 +0000 (UTC)
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
Subject: [PATCH v20 9/9] media: verisilicon: Support removing buffers on capture queue
Date: Wed, 21 Feb 2024 16:54:35 +0100
Message-Id: <20240221155435.100093-10-benjamin.gaignard@collabora.com>
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

Allow to remove buffers on capture queue because it the one which
own the decoded buffers. After a dynamic resolution change lot of
them could remain allocated but won't be used anymore so deleting
them save memory.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 941fa23c211a..df6f2536263b 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
 	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_remove_bufs = v4l2_m2m_ioctl_remove_bufs,
 	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
 
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
-- 
2.40.1


