Return-Path: <linux-kernel+bounces-51833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C5848FCF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEBC2837FD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA102249FA;
	Sun,  4 Feb 2024 17:45:34 +0000 (UTC)
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91224205
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707068734; cv=none; b=TECRpzy0sD5I4cI5yd878xGUcgx7VrhK2x7tlI92TkkYkmYu2+53Ik0Rxw1AfP7YHWL6xJEDb9BykUwwV19DV+ryztSiK11jf6w11J5rXMSByfegX2yMO97wclSjUQtMemQEfYruZWvR6arPaazPm1f/3y3s6kenjspAptYGrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707068734; c=relaxed/simple;
	bh=eJbZT3mdrNA2RzxGIe/uKdeOxu+kH6M/tWk7d/atqWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RqEECSrmSVrL36dRLEvpN8TaRlDrqWx1PGv5RubrpMPuuyhymDiwX3hkSkwaHM9LFxohMNfFeT70sQt5zrESq1rPq8darU3qMlWogIxt8NG7PeMMcbpWPL/mFBO6CcXMoGufcBATvDBlURA4WGFX1MJFwxrYJyhl9xuEfek4t54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-Book.localdomain (2a02-a420-67-c93f-164f-8aff-fee4-5930.mobile6.kpn.net [IPv6:2a02:a420:67:c93f:164f:8aff:fee4:5930])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7360D3F092;
	Sun,  4 Feb 2024 18:45:28 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Date: Sun, 04 Feb 2024 18:45:27 +0100
Subject: [PATCH] drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge
 is enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-dpu-dsc-multiplex-v1-1-080963233c52@somainline.org>
X-B4-Tracking: v=1; b=H4sIADbNv2UC/x3MQQqAIBBA0avErBswE6KuEi1KxxowE80IorsnL
 d/i/wcSRaYEQ/VApIsTH76gqSvQ2+xXQjbFIIVUQgqFJmQ0SeOe3cnB0Y2q141auta2JKB0IZL
 l+3+O0/t+A1HiRmMAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.4

When the topology calls for two interfaces on the current fixed topology
of 2 DSC blocks, or uses 1 DSC block for a single interface (e.g. SC7280
with only one DSC block), there should be no merging of DSC output.

This is already represented by the return value of
dpu_encoder_use_dsc_merge(), but not yet used to correctly configure
this flag.

Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
Note that more changes are needed to properly support the proposed 2:2:2
and 1:1:1 topology (in contrast to the already-supported 2:2:1 topology),
but this could be a trivial patch to get going separately before all that
extra work is done.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 83380bc92a00..6d3ed4d870d7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1857,7 +1857,9 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	dsc_common_mode = 0;
 	pic_width = dsc->pic_width;
 
-	dsc_common_mode = DSC_MODE_MULTIPLEX | DSC_MODE_SPLIT_PANEL;
+	dsc_common_mode = DSC_MODE_SPLIT_PANEL;
+	if (dpu_encoder_use_dsc_merge(enc_master->parent))
+		dsc_common_mode |= DSC_MODE_MULTIPLEX;
 	if (enc_master->intf_mode == INTF_MODE_VIDEO)
 		dsc_common_mode |= DSC_MODE_VIDEO;
 

---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240204-dpu-dsc-multiplex-49c14b73f3e0

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>


