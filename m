Return-Path: <linux-kernel+bounces-147771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C698A7977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4175E1C2219C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989CC13AD1C;
	Tue, 16 Apr 2024 23:57:50 +0000 (UTC)
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E713A890;
	Tue, 16 Apr 2024 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311870; cv=none; b=ivxsKH5eNuDgn6L2I2V+LqSeFUXAe/YJnL98WBbzAH+spJNUxqM5LhquSLgMySfDISXY5EooSUTUFXztoDEnQ92ihXgLCe6cwOmYx4zPtF5PwAWfSdcHb34eYB0CNzYquBKH7VUrx5r3Mni9EC6gHQYwSpzcx0Nb0QoECeTRTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311870; c=relaxed/simple;
	bh=EdVhzTAQppDa6zO4jSvemRUuERn806FYYnZThpRKfao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Muxl1ikOfzhIPdAElrQFFrVw1J7q0YkLNcEKMxKk4hK66I+hSJRRSMSckzY3TAowjoUTlscRZsK814ICLmDnrX0cdxn+k1UaEdBbp/bb/bFmACwm5Hy+x6ib94BBwqIVtRCXqwsR8To67Q/p/1VhSp2UA7PF7TZHnSUG0L+I9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id CB12E3F00E;
	Wed, 17 Apr 2024 01:57:45 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Wed, 17 Apr 2024 01:57:42 +0200
Subject: [PATCH 2/7] drm/msm/dsi: Pass bonded-DSI hdisplay/2 to DSC timing
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-2-78ae3ee9a697@somainline.org>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Archit Taneja <architt@codeaurora.org>, 
 Chandan Uddaraju <chandanu@codeaurora.org>, Vinod Koul <vkoul@kernel.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jordan Crouse <jordan@cosmicpenguin.net>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.13.0

When configuring the timing of DSI hosts (interfaces) in
dsi_timing_setup() all values written to registers are taking bonded
DSI into account by dividing the original mode width by 2 (half the
data is sent over each of the two DSI hosts), but the full width
instead of the interface width is passed as hdisplay parameter to
dsi_update_dsc_timing().

Currently only msm_dsc_get_slices_per_intf() is called within
dsi_update_dsc_timing() with the `hdisplay` argument which clearly
documents that it wants the width of a single interface (which, again,
in bonded DSI mode is half the total width of the mode).  Thus pass the
bonded-mode-adjusted hdisplay parameter into dsi_update_dsc_timing()
otherwise all values written to registers by this function (i.e. the
number of slices per interface or packet, and derived from this the EOL
byte number) are twice too large.

Inversely the panel driver is expected to only set the slice width and
number of slices for half the panel, i.e. what will be sent by each
host individually, rather than fixing that up like hdisplay here.

Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index c80be74cf10b..9d0c940dcb28 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -987,7 +987,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
 		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
+			dsi_update_dsc_timing(msm_host, false, hdisplay);
 
 		dsi_write(msm_host, REG_DSI_ACTIVE_H,
 			DSI_ACTIVE_H_START(ha_start) |
@@ -1008,7 +1008,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
 	} else {		/* command mode */
 		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
+			dsi_update_dsc_timing(msm_host, true, hdisplay);
 
 		/* image data and 1 byte write_memory_start cmd */
 		if (!msm_host->dsc)

-- 
2.44.0


