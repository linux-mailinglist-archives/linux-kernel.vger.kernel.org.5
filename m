Return-Path: <linux-kernel+bounces-33268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D78367B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE37B287B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5DA3FB32;
	Mon, 22 Jan 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKtMfBap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C875810B;
	Mon, 22 Jan 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935526; cv=none; b=CrEgnd7y/jvN7YNJuTjQNz33JjCLDskTjiVdNDaIkIQStqzjdkVjjddjVw02nQ3ql7QJ9jhgTF/JhdY7C2abVoTsipTA/wg0aYYF72W3rfTs/1JIFSLoTyOLSS8E0mbp4RhvL2dR8p9y4Ku812aO2Y2zaUaPQc7Jzy12dA0c0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935526; c=relaxed/simple;
	bh=BxkbzB02hWQbQjzM2m4HskZst9ihfxAqm88x70Uynb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPdiYW/FAt08Whmga0IFibiYyvd7W4aD69ClV8sLgHy039x78sA9fkytIWn8GH9BDAAhS41Y6rQwnihmtRon/FwI3qm71vSj8ucDcpK1JnNMVppe4vZt+N5BW1TL5IQb1zLSL3ut6AHIoOZek7UTbVUkbMhTGDeAlfDh7pvEAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKtMfBap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80DDC43394;
	Mon, 22 Jan 2024 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935526;
	bh=BxkbzB02hWQbQjzM2m4HskZst9ihfxAqm88x70Uynb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKtMfBap5eKFo1GWrqxuDgd4DY80lforrwUWZx9T2Fqm/U0SBuphKrqCsWa1mpfus
	 IDsxqUwXCY7KUMorLwOvDOAZIf5FFFXsTUh6U+j4NPVESv7977pxTZBqhLR+a/8Ys5
	 Yc+vx9RTnMZmyxMOuCc8/Xx7f5Cn8Hy05LbaReBKhT0DOVOoNCjjKJwEZ8UROzQktv
	 XHsLzRBakARD9EohCJmeL5f8lJqhAkOROZC3k3n474YecMctVsCmP9lSV9hcRGNqay
	 JLK/zWoFIA+8oWNITgEbEwjTEuAAZ+LElpaNw5WG/FPwp+OnoAIhro0LmFaSSwCqgm
	 YK6RkjK3nnEIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	tian.shu.qiu@intel.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 48/88] media: ov2740: Fix hts value
Date: Mon, 22 Jan 2024 09:51:21 -0500
Message-ID: <20240122145608.990137-48-sashal@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 3735228bbe3511f844e03dfcc4003fadb59dde23 ]

HTS must be more then width, so the 1080 value clearly is wrong,
this is then corrected with some weird math dividing clocks in
to_pixels_per_line() which results in the hts getting multiplied by 2,
resulting in 2160.

Instead just directly set hts to the correct value of 2160 and
drop to_pixels_per_line().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2740.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 24e468485fbf..6be22586c3d2 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -310,7 +310,7 @@ static const struct ov2740_mode supported_modes[] = {
 	{
 		.width = 1932,
 		.height = 1092,
-		.hts = 1080,
+		.hts = 2160,
 		.vts_def = OV2740_VTS_DEF,
 		.vts_min = OV2740_VTS_MIN,
 		.reg_list = {
@@ -357,15 +357,6 @@ static u64 to_pixel_rate(u32 f_index)
 	return pixel_rate;
 }
 
-static u64 to_pixels_per_line(u32 hts, u32 f_index)
-{
-	u64 ppl = hts * to_pixel_rate(f_index);
-
-	do_div(ppl, OV2740_SCLK);
-
-	return ppl;
-}
-
 static int ov2740_read_reg(struct ov2740 *ov2740, u16 reg, u16 len, u32 *val)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
@@ -598,8 +589,7 @@ static int ov2740_init_controls(struct ov2740 *ov2740)
 					   V4L2_CID_VBLANK, vblank_min,
 					   vblank_max, 1, vblank_default);
 
-	h_blank = to_pixels_per_line(cur_mode->hts, cur_mode->link_freq_index);
-	h_blank -= cur_mode->width;
+	h_blank = cur_mode->hts - cur_mode->width;
 	ov2740->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &ov2740_ctrl_ops,
 					   V4L2_CID_HBLANK, h_blank, h_blank, 1,
 					   h_blank);
@@ -842,8 +832,7 @@ static int ov2740_set_format(struct v4l2_subdev *sd,
 				 mode->vts_min - mode->height,
 				 OV2740_VTS_MAX - mode->height, 1, vblank_def);
 	__v4l2_ctrl_s_ctrl(ov2740->vblank, vblank_def);
-	h_blank = to_pixels_per_line(mode->hts, mode->link_freq_index) -
-		mode->width;
+	h_blank = mode->hts - mode->width;
 	__v4l2_ctrl_modify_range(ov2740->hblank, h_blank, h_blank, 1, h_blank);
 
 	return 0;
-- 
2.43.0


