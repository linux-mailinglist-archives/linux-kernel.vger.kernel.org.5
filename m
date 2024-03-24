Return-Path: <linux-kernel+bounces-113251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488F8882A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F791F222CF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E121870C3;
	Sun, 24 Mar 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N49H5tpA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094B1870A8;
	Sun, 24 Mar 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320051; cv=none; b=IpGe1RLGHtaodEa3oI1YZKNpqu94Ryq4TuaKxpTRkWmHkSpcwA5dMXxXh29LWR6yNwzjjE2AyVoVMAKdHGXB04OkuYCiyT/1zMzT4YCq18mY6qfG7b485UAMPzd1w5hF6boapec7nT+7DOK7PqSD3a2uVtQHNgtWylpM/IpspQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320051; c=relaxed/simple;
	bh=r94iDyI3IDylZBFHddqhoES6VAbPF+0tOiw1jowT+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cohg0yCbvHgjEtAL2zDPzyUNhFWV+9bbGZ9hp0pwRMVw2M1h+1czH7EKNTVBrh/uoK9H4tXI6LSuaBbiMne8gNZSneMrmMBJiDqqrd3U7gkA49qIkR+MTyR0/1lAgoGDW4Z0hzJpqJtwrcpjyZTfwNtCfRjBThXnkGJ02qsBcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N49H5tpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CD8C43390;
	Sun, 24 Mar 2024 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320051;
	bh=r94iDyI3IDylZBFHddqhoES6VAbPF+0tOiw1jowT+zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N49H5tpAhuxXiOKPkfrSAZ+WZtEXTA64tDCH0gHjTYCaKjLDTDhoBMPvRIh2HpVLh
	 VJkG+f5WgvZ3+Tj0qC7pG/8r9nyOLav5XI8lT24+t491IK2IVCqJMK8HSnatFC005W
	 Fvw0i4F9WT7bOcFfdzz8SbTB6XcgVKX8b6nwmvdSflJVHJiOWIGolEQ0scJwy5s+hV
	 b4byKr117l3mqcuKKwJdxl1Ctkv1Dk+oZPJYUFdL0lrKfA66dgfS9VTSPlDI4C9860
	 YX8+BqBSyw9uvtvaAIB1Wo0owAxkFmVwjGAcGpjfz5Ox1zx8YsNqTFFTR1jHDTD8QD
	 7e454nM2YRieQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 360/715] drm/vkms: Avoid reading beyond LUT array
Date: Sun, 24 Mar 2024 18:28:59 -0400
Message-ID: <20240324223455.1342824-361-sashal@kernel.org>
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

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit 2fee84030d12d9fddfa874e4562d71761a129277 ]

When the floor LUT index (drm_fixp2int(lut_index) is the last
index of the array the ceil LUT index will point to an entry
beyond the array. Make sure we guard against it and use the
value of the floor LUT index.

v3:
 - Drop bits from commit description that didn't contribute
   anything of value

Fixes: db1f254f2cfa ("drm/vkms: Add support to 1D gamma LUT")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Cc: Arthur Grillo <arthurgrillo@riseup.net>
Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231108163647.106853-6-harry.wentland@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 3c99fb8b54e2d..e7441b227b3ce 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -123,6 +123,8 @@ static u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 chan
 				      enum lut_channel channel)
 {
 	s64 lut_index = get_lut_index(lut, channel_value);
+	u16 *floor_lut_value, *ceil_lut_value;
+	u16 floor_channel_value, ceil_channel_value;
 
 	/*
 	 * This checks if `struct drm_color_lut` has any gap added by the compiler
@@ -130,11 +132,15 @@ static u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 chan
 	 */
 	static_assert(sizeof(struct drm_color_lut) == sizeof(__u16) * 4);
 
-	u16 *floor_lut_value = (__u16 *)&lut->base[drm_fixp2int(lut_index)];
-	u16 *ceil_lut_value = (__u16 *)&lut->base[drm_fixp2int_ceil(lut_index)];
+	floor_lut_value = (__u16 *)&lut->base[drm_fixp2int(lut_index)];
+	if (drm_fixp2int(lut_index) == (lut->lut_length - 1))
+		/* We're at the end of the LUT array, use same value for ceil and floor */
+		ceil_lut_value = floor_lut_value;
+	else
+		ceil_lut_value = (__u16 *)&lut->base[drm_fixp2int_ceil(lut_index)];
 
-	u16 floor_channel_value = floor_lut_value[channel];
-	u16 ceil_channel_value = ceil_lut_value[channel];
+	floor_channel_value = floor_lut_value[channel];
+	ceil_channel_value = ceil_lut_value[channel];
 
 	return lerp_u16(floor_channel_value, ceil_channel_value,
 			lut_index & DRM_FIXED_DECIMAL_MASK);
-- 
2.43.0


