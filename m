Return-Path: <linux-kernel+bounces-33234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4DA8366EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757022889E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100E4C3C6;
	Mon, 22 Jan 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuMZnMNC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F74C3AE;
	Mon, 22 Jan 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935441; cv=none; b=a22k5aem9Bk8hJb686DyoH4mnigExojfEz2/6K+arUpB9WC9NWvw3Hilwk3PjXM/0Ft7MaBxb2xMrx+TNwpBr7q9Qz7KzclbsmD5C/+Om+BTfHczkwlFVPp169NqAX8jyQsxSOV3EeVr2jjwG/yHP6EFvW3eoKk5hu77kajqvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935441; c=relaxed/simple;
	bh=f9Sk/+C5kcX0il63I5n35DiRElG5AdEB1o+Ds2m2Xc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKnc04LI1uv70/27HEXqCG1CvIY/W4dFnrbGJK6zvMi2oEn/P4J3AdAQb2Eop+CFAW5ZPrYSNFnBeMicToXgtlfIY7XjwEwVO8OhLb9+owM+lRPPPX4MXyYSO11BN2FgxMYR1l44QKg1ltDWwXGyHpkoK2Qfpy7Bs/S3TIpSzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuMZnMNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A49C433F1;
	Mon, 22 Jan 2024 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935441;
	bh=f9Sk/+C5kcX0il63I5n35DiRElG5AdEB1o+Ds2m2Xc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuMZnMNCnOyqXSECFryi+JKq66wrIcKIVdf0qtKgGgiBXe5gY+nFIPVOC1Op4C6ip
	 I11waZXZE6yC4Wtsjr3obY5bx36n8Xb5ljQjVwjJZoDBZHnDe+Xf5x8HXPipVgd0X3
	 eYdZwt1rTZ/R3G0rnHeuQhykDdTVydk0KAdaGVsdM3iBf+t0ZSMJI7QqXnxbrGCZEp
	 r+saZLuhOKPHhjXtgQsTwkHGQEDI5Adkw+a3betZHQsUQB7JfEVQ5VKje+zxcPSjFx
	 jhHh76XaE8id0a8CA92KGNn855OA48IZUOizoZ8UbhoQ0CHqTRLzKLe2QnLvUDsYW9
	 blO4tbXg1Iq2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Susanto <nicholas.susanto@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	charlene.liu@amd.com,
	hamza.mahfooz@amd.com,
	sungkim@amd.com,
	yang.lee@linux.alibaba.com,
	ovidiu.bunea@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 19/88] drm/amd/display: Fix disable_otg_wa logic
Date: Mon, 22 Jan 2024 09:50:52 -0500
Message-ID: <20240122145608.990137-19-sashal@kernel.org>
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

From: Nicholas Susanto <nicholas.susanto@amd.com>

[ Upstream commit 2ce156482a6fef349d2eba98e5070c412d3af662 ]

[Why]
When switching to another HDMI mode, we are unnecesarilly
disabling/enabling FIFO causing both HPO and DIG registers to be set at
the same time when only HPO is supposed to be set.

This can lead to a system hang the next time we change refresh rates as
there are cases when we don't disable OTG/FIFO but FIFO is enabled when
it isn't supposed to be.

[How]
Removing the enable/disable FIFO entirely.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index d5fde7d23fbf..f3b0af2c0295 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -126,21 +126,13 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
 				     !pipe->stream->link_enc)) {
-			struct stream_encoder *stream_enc = pipe->stream_res.stream_enc;
-
 			if (disable) {
-				if (stream_enc && stream_enc->funcs->disable_fifo)
-					pipe->stream_res.stream_enc->funcs->disable_fifo(stream_enc);
-
 				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
 					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 
 				reset_sync_context_for_pipe(dc, context, i);
 			} else {
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
-
-				if (stream_enc && stream_enc->funcs->enable_fifo)
-					pipe->stream_res.stream_enc->funcs->enable_fifo(stream_enc);
 			}
 		}
 	}
-- 
2.43.0


