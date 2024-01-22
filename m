Return-Path: <linux-kernel+bounces-33269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF68367C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4529DB2593C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968F58223;
	Mon, 22 Jan 2024 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRNL/2KE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612358201;
	Mon, 22 Jan 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935528; cv=none; b=rwAHGlXlvuNprUGVTuFvU5pj7B8eOxCd8tQ8B6yQwhJbgv0nHKKMN4mzTmcuRllXQGoLBU9krT3Bzew5o1D5CItvoxU7bpOAzadm9cE3aDXniAH6uXy/x5hm9PROf4XlHxRdxBCZ/6LrH8dojpV64MZ7QJyNfWijNs6UjJVDrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935528; c=relaxed/simple;
	bh=TfnasqSfTCxphqMuQoT5bjKN0l517hxJjLPMJtn0J0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6dt3K5aj6jwHrXqIjaQOYAXDBfDR9iF0nye5Y36/NU8fToWR67ghF3UAFwjqANu1SieulQG92AEW3SZlUsOGbf2K46LAIWNSfrdXsMN7QoHZAOzlDHMrDGx93N6hhxtt7AJfh0OD4g3Es74cGxHxc6ecHh/OknmgBP6B1U/G00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRNL/2KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E51C433A6;
	Mon, 22 Jan 2024 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935527;
	bh=TfnasqSfTCxphqMuQoT5bjKN0l517hxJjLPMJtn0J0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRNL/2KEH4FzzPdCQo003LJy2f05CKD7m/PNoWDpK6lQWXapHUokj+mLmjp8cgBNG
	 EVxNQ3ZIb5w8BO5m8J7nFfImZyl6BA2ss4q4y/f5WIFy2aW8jceYZMEZTBz78tpep2
	 /tj7lcD3BwHmhrXMnX4btXdXZVldPTEdN392zTSLoIbnmLKbU+GjcCoGvpu0J/5/i1
	 f8pYqDLb55y6QDfzBvPjn0txWPSjUO4PVZb6Hsl0ehYZcgfC/HewkUIcn/AArluyKY
	 D3tkH+eZiDM+Jcnkzx8Iu4LxBdhJmJvoeOeAf3fhxYLwdr4iRXxj4QpKqcu5heCb8N
	 c0AMS4PI8CqFw==
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
Subject: [PATCH AUTOSEL 6.7 49/88] media: i2c: imx335: Fix hblank min/max values
Date: Mon, 22 Jan 2024 09:51:22 -0500
Message-ID: <20240122145608.990137-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index ec729126274b..964a81bec5a4 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -962,8 +962,8 @@ static int imx335_init_controls(struct imx335 *imx335)
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


