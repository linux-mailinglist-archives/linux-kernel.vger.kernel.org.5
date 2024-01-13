Return-Path: <linux-kernel+bounces-25311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B28B82CD4F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E20EB21AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED915CB;
	Sat, 13 Jan 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kir44wnK"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91336B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id OfSwrfydhx8edOfSxrsth3; Sat, 13 Jan 2024 15:58:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705157912;
	bh=JnYvDd18VWfo35gKMLVjd5/prLW9/VQp7P6Jqnl9/PA=;
	h=From:To:Cc:Subject:Date;
	b=kir44wnK0wf42PsE79s0lV9ZTnMfWBhvwoFSmBcMPQKDwVet/JFReH2/+/oTn5M4l
	 E2Ycs4G9JwTur31pF2vUm6uzAKojoF9CbBF6Xki9uO/Re1MfxY2UoHdfPQ8+GmoKcG
	 UIluLf1z2Oj2jXBZZmy6oB2JTN5udG9ehstu4mB9eOw+abQ/T3joGBhU/M0xdTYs+w
	 lSfUI6GCu6r95412oBHX0GAnzk0XAy9+GArbQiCMYaeeEuMLHGJ6JtAeywHadOB66h
	 XFS2EF7jAojlK7V3YlWmIpcoxTvKzMNp7GHtMfvTmU6C5M53qy7QYAGFI7z2Qe/FID
	 m2+8cURNSRpGg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Jan 2024 15:58:32 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Roman Li <roman.li@amd.com>,
	Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix a switch statement in populate_dml_output_cfg_from_stream_state()
Date: Sat, 13 Jan 2024 15:58:21 +0100
Message-ID: <e597276a8240329a5ece90762425c7cde2ddd7a2.1705157202.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is likely that the statement related to 'dml_edp' is misplaced. So move
it in the correct "case SIGNAL_TYPE_EDP".

Fixes: 7966f319c66d ("drm/amd/display: Introduce DML2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index fa6a93dd9629..64d01a9cd68c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -626,8 +626,8 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 		if (is_dp2p0_output_encoder(pipe))
 			out->OutputEncoder[location] = dml_dp2p0;
 		break;
-		out->OutputEncoder[location] = dml_edp;
 	case SIGNAL_TYPE_EDP:
+		out->OutputEncoder[location] = dml_edp;
 		break;
 	case SIGNAL_TYPE_HDMI_TYPE_A:
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
-- 
2.43.0


