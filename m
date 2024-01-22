Return-Path: <linux-kernel+bounces-33481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF51836A33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB15D281EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B6251C59;
	Mon, 22 Jan 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfV+3m7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A71353E7;
	Mon, 22 Jan 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936450; cv=none; b=sxAE2gGGcQTdJxLLCX5EBw5Bs8rCFTDJRGCbqjTOSSlGXAktxbLe+BxlfbNRHhfWkWu09rDVgtGYHAE9PJXYWeHvsKni+aXpyHCUqHfadPaom4BZ/oioIreB02heagAE+DSERtvuDotdDrBojnkR6tOAQnu7RSyu0mCuDLBQ9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936450; c=relaxed/simple;
	bh=kV98eDgyXLfV4RiWgzkvQ2Yv8i26YS/c2nmW5HnR/jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3hm2AC716+G1+7t+fNNzPJ6f4iie4bx3NJTfNg3fjLYcWiFZxU5u/YOIgBJmZLiYDN0MApptj5QGrTZir5Q09XXAvuMV2Dr7A+QXePi+OO0DEYhUV9iWQpvBifayU43McJEut1N0ePsAFoEd3huIGnnSe7xqrrdLBYauGios54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfV+3m7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83C3C43399;
	Mon, 22 Jan 2024 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936450;
	bh=kV98eDgyXLfV4RiWgzkvQ2Yv8i26YS/c2nmW5HnR/jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfV+3m7zhUNv98ySpfhkEU9PgMZGfy2/XfqszkfStbYuOhmOeoDqeAfeEjSTADN0s
	 JzFYdXK+j80+DeeX5e21itzyi8XYz52i+zf8IlsnCku6WaHM04nAAemieCW9/gKXNX
	 q8Pomsj+4abXMqb6KMz5o5GrYnGXp+noFe6ICaD3e+4dU/j/+Vy0GgmuEJ/ol+s/CM
	 ensobMklcueGxNwrHMYNludabIYfpg9C3zrfLAPA0p1RX8Nszab/RFCPVdaI2aVsEO
	 o4qD6P4/MgiLjj8oisyfd9kXZnRDRvBxpMYS/O3RA8R/JKcaq2BH3nAT0jEYMDwarR
	 LNSySplRu/CQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 24/35] media: i2c: imx335: Fix hblank min/max values
Date: Mon, 22 Jan 2024 10:12:21 -0500
Message-ID: <20240122151302.995456-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

[ Upstream commit d7b95ad7a8d56248dfc34f861e445fad7a4004f4 ]

The V4L2_CID_HBLANK control is marked as readonly and can only be a
single value.

Set the minimum and maximum value to match the mode value.

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx335.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 410d6b86feb5..780eb68b1894 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -971,8 +971,8 @@ static int imx335_init_controls(struct imx335 *imx335)
 	imx335->hblank_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
 						&imx335_ctrl_ops,
 						V4L2_CID_HBLANK,
-						IMX335_REG_MIN,
-						IMX335_REG_MAX,
+						mode->hblank,
+						mode->hblank,
 						1, mode->hblank);
 	if (imx335->hblank_ctrl)
 		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-- 
2.43.0


