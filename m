Return-Path: <linux-kernel+bounces-103506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC287C05C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677611F2367E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3A374E0A;
	Thu, 14 Mar 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nizA5TvM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D27175F;
	Thu, 14 Mar 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430363; cv=none; b=DrwD1jJyxgveiipEyB3DW7hic4JlVYQbNVsDVYQ6Sq1MhCG0tmopepLtuw1GOA/PLeaqByzsLtfgvQ7iltCTMkjqM5V7ybMTTDZXKU+9RS7FF3uMenv77oKPFe6W/rqm2nAOvx7FRX0CvrrIH3CgvjmNACtAHRq5Mx5jyNT0Fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430363; c=relaxed/simple;
	bh=fp7Af2JavyVIFNlDhfBtLvTU8aA7T4w2d45EtkwuBHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1URIfDBL7HTgShogRC8xEglLPWdI81FkIMSp3HtxuKv7W8eIN7CLHK9/DMM5DdEuNXZoT1YM+bCO8HmVVV2yv6ElzPXX3h8yYtVH+L1I9V2xC0xjmmHz3LKB63J2djxkOmi9gLEmMC0YUT3nvFa7rJhjpjbT/XjvV3JndcAQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nizA5TvM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710430359;
	bh=fp7Af2JavyVIFNlDhfBtLvTU8aA7T4w2d45EtkwuBHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nizA5TvMSzzIeyxiXDWgki9UWAqVxzJkaLYGC/80nJOA5prXfiDLCBVXi/X2dRDoL
	 6KnGhM+CXIpInKMkGUYjIl+clJcdcAttzgw7sB8q8uVPxRYGibXb6QHq54yd6D1ai/
	 dsz2Fj/cW5LntaWZO5AhKAil9wYURWh/xO1TaB97acGgE9Y042qj+0WzQ+Kqs28Wv5
	 103qAPU1N2Ecs55GG61oRLsRbLhXMTDrfEz2wHBtajq12K08iK0dlCWD68W9O+FHTh
	 E2JHXDE/iI46Kzgz5xvAShPyZIL5307mqL+SV9mNRy7W9JC+WLXiY55BaV47XxoRmt
	 DGx1GyqaN72/w==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 585593782110;
	Thu, 14 Mar 2024 15:32:39 +0000 (UTC)
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
Subject: [PATCH v21 9/9] media: verisilicon: Support removing buffers on capture queue
Date: Thu, 14 Mar 2024 16:32:26 +0100
Message-Id: <20240314153226.197445-10-benjamin.gaignard@collabora.com>
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


