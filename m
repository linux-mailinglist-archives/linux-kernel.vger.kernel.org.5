Return-Path: <linux-kernel+bounces-33289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF7D8367FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579E6289240
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C064120C;
	Mon, 22 Jan 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAEzrwXP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D65C8F8;
	Mon, 22 Jan 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935631; cv=none; b=RkvqAjbaXdFXNRNIatZUtWAtI+HGpUSbMTY+Hn1fIEYbCr/h2uAir0z6CV0XUg8mC4lAB+APMou4liZX4/4BgMXE7YGY938WM2E2VG4ZOdkLq2N/myjG1FhgF0QCEHsedTINcEK1zt+ShSvZ+Gg4WDNP2Via/t4GhT73JRC1JeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935631; c=relaxed/simple;
	bh=6ZXLAZ3CUd7RckLL3TGYSlSEb3X1k/ch4z1/v29BQPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9Ouiw955tmaq+modq+uZN89GRW0FXmDU1IDYkcPWavQ1VBVEzb8SZYlqV+CvOQwnMilIxU/3o8DGLQj+3U+Kr0Jiv1YBZFtnFJ8KZ2KRfnLuYr4Y9NbFknesV88Vwr542qttktq4pNw7/OkB0o737GbN3QA+e2BIav+5Ozm87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAEzrwXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E686BC433F1;
	Mon, 22 Jan 2024 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935631;
	bh=6ZXLAZ3CUd7RckLL3TGYSlSEb3X1k/ch4z1/v29BQPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAEzrwXP663CBCxl5C1oxV+iOTiexH2M33bMSLwAh2RPwOWHiizIrivZBDHDhHRFd
	 xtItIAXd0IXA+mDM6qiWizjSzIQugw9wEBsu7IkjbqJZNYjj+KdJQcoB7ixFcZjr4/
	 QH97JAhcGwVP91e/z0yPHxBlBBr7dy350qRl6qI7o/Itkr5yF74T+AZEAkNYwjK9CJ
	 NUDQjSq5UumoXxTPf3qLnIQ4KcGwwhACKry9NJo/SMul231vDp5c/4fZ8nEz6wC5L6
	 8FDbHFPFe2V2eSlmfLk73PY/6WirVWyO4oJdpgn2+j13e9LnJbbEinUlEHoVir3+vG
	 CPX1tYqi3R0pA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Allen Pan <allen.pan@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 67/88] drm/amd/display: fix usb-c connector_type
Date: Mon, 22 Jan 2024 09:51:40 -0500
Message-ID: <20240122145608.990137-67-sashal@kernel.org>
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

From: Allen Pan <allen.pan@amd.com>

[ Upstream commit 0d26644bc57d8737c8e2fb3145366f7d0b941935 ]

[why]
BIOS switches to use USB-C connector type 0x18, but VBIOS's
objectInfo table not supported yet. driver needs to patch it
based on enc_cap from system integration info table.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index f91e08895275..da94e5309fba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -256,6 +256,10 @@ void dcn35_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
+		if (bp_cap_info.DP_IS_USB_C) {
+			/*BIOS not switch to use CONNECTOR_ID_USBC = 24 yet*/
+			enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+		}
 
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
@@ -264,4 +268,5 @@ void dcn35_link_encoder_construct(
 	}
 	if (enc10->base.ctx->dc->debug.hdmi20_disable)
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
+
 }
-- 
2.43.0


