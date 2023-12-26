Return-Path: <linux-kernel+bounces-11226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468AE81E368
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C291F23ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9690C4A39;
	Tue, 26 Dec 2023 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbUOtfqE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743465F;
	Tue, 26 Dec 2023 00:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A2C433C7;
	Tue, 26 Dec 2023 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550107;
	bh=l1bu6sJvkRQeESXtDmr6quCUcJlzaRI0yOcXoP+DPj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbUOtfqEiGNuLYkY1TEZy9u50za3PdLHr2+5RpVdMbZ56FZbSoXjUHpAyoA0PKOnl
	 QRO7J2zHK1tDwCXBVbt70UriK0tiqT5i/kJavdQu4a7ONWqP8cS0gdH1aOlH+sssTk
	 0il35JKQvlcCKYD14L5GLhNSxpT5BFlw23qG23zPCGXHP5U/oyDvFxrPyolww92yc3
	 bHbkRQZ9qfkvOJStgzaB2PycgJpSFh9i1l8B8TzwaWv3ZJX1ormIspylAIIEucQGG9
	 uGOz8xa3txx2qXM90PgfVT4TXx2HeT3NMtQDZB+BYhqxa+CaJ6Yt42CXomi8rIDC85
	 mlvziXFlmkn3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Lin <wayne.lin@amd.com>,
	Roman Li <roman.li@amd.com>,
	Jun Lei <jun.lei@amd.com>,
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
	wenjing.liu@amd.com,
	Qingqing.Zhuo@amd.com,
	alvin.lee2@amd.com,
	samson.tam@amd.com,
	aric.cyr@amd.com,
	chiawen.huang@amd.com,
	gabe.teeger@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 33/39] drm/amd/display: Add case for dcn35 to support usb4 dmub hpd event
Date: Mon, 25 Dec 2023 19:19:23 -0500
Message-ID: <20231226002021.4776-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit 989824589f793120833bef13aa4e21f5a836a707 ]

[Why & how]
Refactor dc_is_dmub_outbox_supported() a bit and add case for dcn35 to
register dmub outbox notification irq to handle usb4 relevant hpd event.

Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a1be93f6385c6..8cdf380bf3665 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4865,18 +4865,28 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
-	/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
-	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	switch (dc->ctx->asic_id.chip_family) {
 
-	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1 &&
-	    !dc->debug.dpia_debug.bits.disable_dpia)
-		return true;
+	case FAMILY_YELLOW_CARP:
+		/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
+		if (dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
+		    !dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	case AMDGPU_FAMILY_GC_11_0_1:
+	case AMDGPU_FAMILY_GC_11_5_0:
+		if (!dc->debug.dpia_debug.bits.disable_dpia)
+			return true;
+	break;
+
+	default:
+		break;
+	}
 
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
+
 }
 
 /**
-- 
2.43.0


