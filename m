Return-Path: <linux-kernel+bounces-114270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECC888F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04B61F29C79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403A15CD69;
	Sun, 24 Mar 2024 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1vTajtR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE31EC4A2;
	Sun, 24 Mar 2024 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321634; cv=none; b=fH00R9Tx5uSfvT2z8e5GF6BtsCIrFevUqgrvI9K2i3h3zZcg8IivkUWfdP46fNFR/O5XPHDEh8kujwQQV43Io8Z1O2tOSm0LLM5NjL4wcESogqQsqhGMT6I6RDILmn+va1GWVD2Q90k1CK3I7d2mKGLfUj9CkO3pe97eyKRl9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321634; c=relaxed/simple;
	bh=YIjU+mzoWrV05oGV4xJxF2HQ8qDptrNj6HzENP7dNOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPdl9WAprvKfwOi4BQJTIwSzXdTlfaZnRUkArNoPmqak5zkR6sc3tBOshD/p3PCKD6WJ1b6Ym4XuF1xIJzdtrlV/1dxAJamjfEjqVS2jS7CDNZqF06HTDv8Q+vVXHfX/ddwkdLFNHQkAXp59SkTwdJ0I6pXp78voKaOu5uPdEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1vTajtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0741AC433C7;
	Sun, 24 Mar 2024 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321632;
	bh=YIjU+mzoWrV05oGV4xJxF2HQ8qDptrNj6HzENP7dNOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1vTajtRe0txE1Uv/lrxMHJ4Dz/axJuDDYbe8LhRxJE4OCX/OjhLRxNvpb8LVg4Le
	 3X3XCWLtXLG0H+EjKi2rOM2df9qlHtjZLFKIgGT6igPLab6Lo5yquUjmdl+RbAU10i
	 lJehaGiMoVC20G85cFeBYhrrX9y8W693vjUUpJuGzwG/fZWgPW0EcPWdqMglDqz9d/
	 XbHsPDM5Uogwu9q3g2mROnn0be79APrNBUZ4VtVIFEQZu6jNHcFJRm8FFKteDjwix5
	 x0TOmKj20IgBG32hZ/GGukMosH9uvA3itB4L2Tq/E8OAe/rko1ICMH+8vfvzE7FDZq
	 wmyKbPc8GQ3wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Massot <julien.massot@collabora.com>,
	Jai Luthra <j-luthra@ti.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 363/638] media: cadence: csi2rx: use match fwnode for media link
Date: Sun, 24 Mar 2024 18:56:40 -0400
Message-ID: <20240324230116.1348576-364-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 9231ee7e9b3a9..f2ce458ebb1df 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -319,7 +319,7 @@ static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
 
 	csi2rx->source_pad = media_entity_get_fwnode_pad(&s_subdev->entity,
-							 s_subdev->fwnode,
+							 asd->match.fwnode,
 							 MEDIA_PAD_FL_SOURCE);
 	if (csi2rx->source_pad < 0) {
 		dev_err(csi2rx->dev, "Couldn't find output pad for subdev %s\n",
-- 
2.43.0


