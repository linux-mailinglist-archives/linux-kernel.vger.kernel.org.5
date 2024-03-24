Return-Path: <linux-kernel+bounces-116076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8D889558
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5281C2F885
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A928BD47;
	Mon, 25 Mar 2024 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3hmVW8i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A627B108;
	Sun, 24 Mar 2024 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323504; cv=none; b=i10wOJ1agtAj+96z+S6sYdalOYGmMTgvVHcJ8Z9yV/C66/Lf2sbh2tIJToZ2gfCor8tt09bSXDQV6M/kKjVG/hmRfjx1epqwJP8R9wg2QPnptuxAYgTy2GAmbGLUjN9nA64hv3X2153C+ut4lz8Wi4hmBZOMfyR1S7RIkm0F/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323504; c=relaxed/simple;
	bh=Xuc3oBGo7liqs2HCz2Zg1SBZ8t+5y5rY/zRMJBrLpR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3dFnh3WpnGVG7ECqb2N8HvBfg9nCDfvneytXjmIKQ7RDj0EOQM918J45QbvrUZCT6qpsDzBBgmc7G544Qc0bP5OizjEtGpcV1kZ5AXjkZHpi7eFy4TJXg0tZxZFcX38rRkbCOGWFT0zgZQNQB5+q9GaVOnQNz8pnkUp6YY6krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3hmVW8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C97C433F1;
	Sun, 24 Mar 2024 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323503;
	bh=Xuc3oBGo7liqs2HCz2Zg1SBZ8t+5y5rY/zRMJBrLpR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3hmVW8iuCJw7i/TNYIS1sJ1hq/XM0XGn++tbUjwGRCiaV7FRkpD6o4/E+4V2x5dA
	 eMj3ZNMGd5OsoTZR9ntTPc1kxYDXlHByj9ZID8VP4gZwZEsi/t85L6nw1V3DeSPAgH
	 WQtdZnjrO37sraW2YBz/ClNRsw9z8OIqrFRYRfNvNld06osc3sToajK7EYkWMvQ+wM
	 ft/DjTzAZzpLWHEaz+SBdiUIreijSZNhDjHW8DrSSI2lZQC/1NPGwzFJoYek8MHkYJ
	 3LMxmIsI2uRPj9AwYlAOlEEwyOrmB3onJl80QJn24InSTViRzVyR9KqVcSA3BR2CDa
	 zgicY7zjVLM6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 209/317] media: sun8i-di: Fix chroma difference threshold
Date: Sun, 24 Mar 2024 19:33:09 -0400
Message-ID: <20240324233458.1352854-210-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 8faf93c418ed5..dd289c7c93bc2 100644
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


