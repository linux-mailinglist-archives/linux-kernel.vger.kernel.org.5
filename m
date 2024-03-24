Return-Path: <linux-kernel+bounces-115013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25491888CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CC2B26A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65892E82C4;
	Mon, 25 Mar 2024 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT08DQLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3D17C648;
	Sun, 24 Mar 2024 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323778; cv=none; b=XG1jsId9tg/h+TSHkVpKSsK74qhllJNaWWwfldGMjfRL42KM4AoTOoXm79qk259FULICOlq7FwsQFsA6plp3yr+S1PYKNy5SLF3RWWA9YCDyJcNIAfb7JjhsO85HBNc372qgsPFf1sa4xocs8hi3YwNjiYPsvGqWnDsjMg1CAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323778; c=relaxed/simple;
	bh=R4fpI3nUxblZ9piHZOY3BrzsEQgwRd80qaLogd7/6gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gdzz45/MhV2CUn+xxXjoJMwdholD8R34usFFtfE5JAnvHy4sk4hVM5jCalVFgrMjVZyi7ui1sf+jWzd86ByrfApxWOmIZk4yNG3KTPvD1D4GblTwAEQJl/OXzcAnTIDhTP2h7wNJql08T5F7gDEMIyKR+Vv8AKaN7fdvZ/k6n88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT08DQLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C359BC433F1;
	Sun, 24 Mar 2024 23:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323777;
	bh=R4fpI3nUxblZ9piHZOY3BrzsEQgwRd80qaLogd7/6gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NT08DQLKI50Ud9lrHhtpa6aEepzdxe7vL9QBAQt5MBzwD09E19dauyoMrSsyzXOsZ
	 R+pqIV6orSqFuYU6ZHmTc7nch4tNn4Cq1a3+CEvEDfh+hTUbVp5UDMTIzCw5qcGx+2
	 7wI/CCFx0Bh+kF3SDiO0f+bBk3nhJvC5yssCKjlLk+Tof0AttOv6WgUliACLilapQQ
	 5DfZglD0zIrJuFQGdyQ8qiN17lj9Cvl/kXLF0Pv2Lge92ibSvhGiduY8vzjulOvJxY
	 kLv5E+NZWuny8g7ynHrOfblIDJH9hS+oXNkv+hnff6rpQBXnK6ha5HU3deMjX5Ah3G
	 41HQFGwbMG6yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 153/238] media: sun8i-di: Fix chroma difference threshold
Date: Sun, 24 Mar 2024 19:39:01 -0400
Message-ID: <20240324234027.1354210-154-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit 856525e8db272b0ce6d9c6e6c2eeb97892b485a6 ]

While there is no good explanation what this value does, vendor driver
uses value 31 for it. Align driver with it.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index cb6d32c59191f..f0d2bcbe20b0d 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -304,7 +304,7 @@ static void deinterlace_init(struct deinterlace_dev *dev)
 
 	deinterlace_clr_set_bits(dev, DEINTERLACE_CHROMA_DIFF,
 				 DEINTERLACE_CHROMA_DIFF_TH_MSK,
-				 DEINTERLACE_CHROMA_DIFF_TH(5));
+				 DEINTERLACE_CHROMA_DIFF_TH(31));
 }
 
 static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
-- 
2.43.0


