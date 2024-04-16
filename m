Return-Path: <linux-kernel+bounces-147770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206488A796F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA061F23F72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192713AA47;
	Tue, 16 Apr 2024 23:57:50 +0000 (UTC)
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6724137C33
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311869; cv=none; b=Y/cSzIM3Afin9oGYz5pG1KO8aRa2JkMF3B0KbjiuBJsdqxu2HkvJvh+UbDIRgQDR67JtWzspt/MLrV/qpOgDAgG5eiRUxeLv8Ei43H3K2OIvFTEZt8HFTC0+Ot6CqlmrVYk2uASUtKVE2m6EiaEFDlgko5Y78JK4Gk7SJ+jdD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311869; c=relaxed/simple;
	bh=2ldmQuH+692mGKxbuAWUUy4JRVVa9UmxmBnOWJ4k5ms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lc7i7bWDAHe8PGQuKlhNF2LOn4ZguLZ3079Z5Z7QGJa79U1wZjXHq1cQrYkTD/N/1P1jwgFlq+gJhiDvyvgHEf0x14vh9Hz/9YSKydjxP9MPEu6Nucnu3kijhaTlZPne1C8CfWfg6YzqOuZssdeiq1QoT6lBSRypIW/pnvO1YS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B6BC33EFF8;
	Wed, 17 Apr 2024 01:57:43 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH 0/7] drm/msm: Initial fixes for DUALPIPE (+DSC) topology
Date: Wed, 17 Apr 2024 01:57:40 +0200
Message-Id: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUQH2YC/x3MQQqDMBBG4avIrDuQaKrgVUoX0UzqDyYNmbYUx
 Ls3dPnx4B2kUiFKc3dQlQ8Uz9xgLx2tm88PYYRm6k3vjLMjh5o4aWJkvOB3Dm+/FxThoCtHfEV
 5iGay18UMS3TURqXKP7TP7X6eP3beIJV0AAAA
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

This series covers a step-up towards supporting the DUALPIPE DSC
topology, also known as 2:2:2 topology (on active-CTL hardware).  It
involves 2 layer mixers, 2 DSC compression encoders, and 2 interfaces
(on DSI, this is called bonded-DSI) where bandwidth constraints (e.g. 4k
panels at 120Hz) require two interfaces to transmit pixel data.

Enabling this topology will be hard(er) than downstream as hacking a
layout type in DTS won't be describing the hardware, but "dynamically"
determining it at runtime may pose some of a challenge that is left to a
future series.  Such changes will also involve the 1:1:1 topology needed
for constrained hardware like the Fairphone 5 on SC7280 with access to
only one DSC encoder and thus ruled out of the current 2:2:1 topology.

Likewise, the patches and discussions around improving active-CTL
configuration to support bonded interfaces (that share a single CTL
block) are still in full swing and hence elided from this series, apart
from one patch to fix the ACTIVE_DSC register coding to support updates,
so that it is not forgotten about.

Note that some patches are applicable to DSC-less DUALPIPE bonded mode
as well, such as the patch that allows the slave interface to always be
flushed as that is only supposed to be excluded in the yet-unsupported
PPSPLIT topology.

This series also contains some patches that I'm not too sure about:

  drm/msm/dpu: Correct dual-ctl -> dual-intf typo in comment

    Downstream doesn't skip the slave INTF flush on active-CTL [1]
    (again, just like cmdmode, only when PPSPLIT is enabled [2]), and
    even added an extra comment [1] explaining this case.  Hence a
    dual-intf but single-flush case doesn't seem to exist as there's
    only one CTL according to the remainder of the comment.
    Maybe the whole comment is wrong?

  drm/msm/dsi: Set PHY usescase before registering DSI host

    It seems intentional to only set the usecase after
    msm_dsi_host_register() in case it fails, so maybe a non-zero `ret`
    here should reset the usecase?  Likewise should the function call be
    moved in !IS_BONDED_DSI() above?

    Ideally we also understand what I am doing differently (maybe
    wrongly) in my panel driver that makes the PLL turn on and configure
    before the usecase has been set, even though these calls are messy
    and error-prone nevertheless.

[1]: https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/display-kernel.lnx.5.4.r1-rel/msm/sde/sde_encoder_phys_vid.c?ref_type=heads#L794-804
[2]: https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/display-kernel.lnx.5.4.r1-rel/msm/sde/sde_encoder_phys_cmd.c?ref_type=heads#L1131-1139

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
Marijn Suijten (7):
      drm/msm/dsi: Print dual-DSI-adjusted pclk instead of original mode pclk
      drm/msm/dsi: Pass bonded-DSI hdisplay/2 to DSC timing configuration
      drm/msm/dpu: Always flush the slave INTF on the CTL
      drm/msm/dpu: Allow configuring multiple active DSC blocks
      drm/msm/dpu: Correct dual-ctl -> dual-intf typo in comment
      drm/msm/dsi: Set PHY usescase before registering DSI host
      drm/msm/dpu: Rename `ctx` parameter to `intf` to match other functions

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 ---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c           |  9 ++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 14 +++++++-------
 drivers/gpu/drm/msm/dsi/dsi_host.c                   | 14 +++++++-------
 drivers/gpu/drm/msm/dsi/dsi_manager.c                | 15 +++++++++++----
 6 files changed, 32 insertions(+), 25 deletions(-)
---
base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
change-id: 20240416-drm-msm-initial-dualpipe-dsc-fixes-3f0715b03bf4

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>


