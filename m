Return-Path: <linux-kernel+bounces-113264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA538882F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6AA1F22A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F2189A2D;
	Sun, 24 Mar 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhBtUHlZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED1189282;
	Sun, 24 Mar 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320064; cv=none; b=ooMWPLC43mscegf/6NE+RKLqE7xn8bDsgZGcNHNnxInJASH+/mJgfY9JzQ1o+XxSLYVddB+ygUkuzI6gEFVs3XiuDbkHDcu0vbbG08NfA42c60xGi8ChzM9TtigejASi/YLskPbv2iKuB5utnCPt0DAjIeF5N2XhQeOJBMHWb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320064; c=relaxed/simple;
	bh=VNH8aazt+hgmi98g0sVxWScnSlD7pb3NGFc4YISxvsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBS7TEaqIzBFHtqrhS2ygtiLPb60pVaPXGsXI2i8Ry3q7kij8EAFoJ05E2Ku2t56kQSH6ZiXuop5Y5XkDBGDIqvQmCL68rSeUq/YaxKoMVI106ZT/0Y5B33vHM67UQoqpUaKQu46LPl/5SKDTjCzjq19qSZarOSW3WdMLaLwsB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhBtUHlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C609C433C7;
	Sun, 24 Mar 2024 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320063;
	bh=VNH8aazt+hgmi98g0sVxWScnSlD7pb3NGFc4YISxvsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhBtUHlZhal4e8XuhF2nFS4EoxLGLWyM29ZKEQPmw9bLLvd7hK19vkQP2vK270jnG
	 DJSD7ian7wIVeFUAr5/EIvb4oS2vs5VyK7jGmx/MygyGDqizLTG5lmGwzwaMvNGr8w
	 Y3ijdMpKeiVq09Aq7yjI+HYYqASpaJ7tePh0oaTdgkKBzJCfPcV+BfXkcyKTCCdeDU
	 J1fbqn1Mc6ePpeLU/Sydap4QcuxFXK6o4NfIxW6f2ER7w4lhvJNaRAm50yPRvcLjrN
	 5UWJt44pci4SoI6QJ/pN4vqf+KnzDY+zX6BYffMfDnIgYVbNxJPqgVKkLwcLbFr2ib
	 8dIbZqewDmQnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Massot <julien.massot@collabora.com>,
	Jai Luthra <j-luthra@ti.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 373/715] media: cadence: csi2rx: use match fwnode for media link
Date: Sun, 24 Mar 2024 18:29:12 -0400
Message-ID: <20240324223455.1342824-374-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Julien Massot <julien.massot@collabora.com>

[ Upstream commit 448699c522af9e3266f168c3f51f4c3713c7bee1 ]

Since commit 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching"),
async connections are matched using the async sub-device fwnode, not that
of the endpoint. Fix this by using the fwnode of the connection match to
find the pad.

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index fead5426830e8..0ea5fa956fe9a 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -468,7 +468,7 @@ static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
 
 	csi2rx->source_pad = media_entity_get_fwnode_pad(&s_subdev->entity,
-							 s_subdev->fwnode,
+							 asd->match.fwnode,
 							 MEDIA_PAD_FL_SOURCE);
 	if (csi2rx->source_pad < 0) {
 		dev_err(csi2rx->dev, "Couldn't find output pad for subdev %s\n",
-- 
2.43.0


