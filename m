Return-Path: <linux-kernel+bounces-113327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64183888370
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187A61F22906
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62091959AA;
	Sun, 24 Mar 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix5E9tan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79A19598E;
	Sun, 24 Mar 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320128; cv=none; b=YPXboBy1w9Nk4hqvZLTYUI/FXJjRDc3eSfK0WKFnREAi2hDhFkdnbxY7hQwIDQDVQkBeZzAH/e6auOzjkH3ysK4BHQzthmxGnNKB9rs0b1gpzApukZ/890pcNmvJRLC/yssEAb+Wbzcsv5zCAWgDYY8+Ul8KCHyajq3u5s2ZN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320128; c=relaxed/simple;
	bh=zDxp0X0bOAEC9vzerTtKQqP0T4Kf9x+qIRrMhp7/2mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB56AzCl2JxzWj4mwWjjcZzuPxMD49wh1/JtQwncVdzMC1CIaqi4oKrlkKksG13J9uBrE0IkaHWJ4aHDSqbLDw6vopJrrCQWKmoVWdImC3pt0UAN+XiTcz75zgWHlE6JmNMiR1WE5mEICpkklNE6kuW+USuFFOIpyD+8jzj6UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix5E9tan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16161C433A6;
	Sun, 24 Mar 2024 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320128;
	bh=zDxp0X0bOAEC9vzerTtKQqP0T4Kf9x+qIRrMhp7/2mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ix5E9tanjI+Iy6IQp8JsA1aLPgiXfZ8kittpALUKoYLFStAhIodOo0RaJzVUP4HpV
	 Q4g7fRG+vYaFyAlOqJemPJX3SYjRT2aCuXriLdSrNIXKnd3OVLZuKkaHlCAeKN7IU8
	 EGJpujQkmmp0HNG0G5WDJ+ZO/0mXHfLyKC0MazogIWLbOtnY9ihOfH3NHThs/lABMW
	 kOvuY06UuUPYxsug0dsicNwuJuYAfbrZIbQUwOllyLVfjlP+4/4aub7nMG34huc5VW
	 1f/WO/WJHl+wjXWOhj3syeD8JpFRHbYBk8S3cFZo10Ui8gA/rSouTfz4yxu/Qz6hrL
	 tRBHnfk6mEvEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 436/715] media: sun8i-di: Fix chroma difference threshold
Date: Sun, 24 Mar 2024 18:30:15 -0400
Message-ID: <20240324223455.1342824-437-sashal@kernel.org>
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
index 5d58a5e781371..a1c35a2b68ed9 100644
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


