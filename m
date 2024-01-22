Return-Path: <linux-kernel+bounces-33364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91198368CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F1E283ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BF6A323;
	Mon, 22 Jan 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjujWZfn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F436A028;
	Mon, 22 Jan 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935979; cv=none; b=CGTWlNSVuXh7aVmcMYiJT8yizoCVxYIvtRtUSIB97rGaq6QgDzgj9BjzqIXFmL5OXBxC1sXwlWucyxRKvlrGlUbQ9aZETQXLJI/4PBLqTEGCWIFJjzkVg6zdPvzMFcNHSrScNkYstJw8APfNdor978Cv0xBnbxaLocXmEVTAolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935979; c=relaxed/simple;
	bh=HGOCg8QCESbMBp+Vvz68wAce56BtcZzkWLlp7eLqbIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfvILkjNjWWSblYO41sh7jZgCaOcfrvkIxgnPrTMhwguND5RRksfogfFLSj8+WOgripV4MdkV2N8rBllmXgDvCGJDoDhGZuoKXxlJHoeA6sYBxQbd/jsGFxweA5R7rIwBh72ZChgkXopSMY335Yu667xDtUIk7yXtB8w17kMxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjujWZfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9EFC433F1;
	Mon, 22 Jan 2024 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935979;
	bh=HGOCg8QCESbMBp+Vvz68wAce56BtcZzkWLlp7eLqbIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjujWZfnyujklS2Eb5lUSACyicUJysDjAl1ByZ22tMfUL9N8i+dajqKufXINz8EyU
	 9YBp/Lt4EifYg/kX+62RGP+D+twupCWlf7RHNpJr9TM5lh7mVKsQmHtEPq9hefjnyE
	 Elofh1TgM9sYH4iT8p6AJGyVJQ2bCwMGIqXS+m0dD52j9q4DhTrv0dU8y8sO3miD8Y
	 4bDzBzoc8quLVy3B9Br1aVZWCtd5oPyo2jbiqyi3cUG6RMTow7zY+/RArkmXuJGS8g
	 jpE65Ox93W/tYZ/Lzk6opV69NPrMU+VL2PfZvzlOoNo26Yo/pukAtTNaixA4SgDNe2
	 B8q+TktQN2S3w==
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
Subject: [PATCH AUTOSEL 6.6 42/73] media: i2c: imx335: Fix hblank min/max values
Date: Mon, 22 Jan 2024 10:01:56 -0500
Message-ID: <20240122150432.992458-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 482a0b7f040a..26869abd77a6 100644
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


