Return-Path: <linux-kernel+bounces-63452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878AA852FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447A428AD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D5381A0;
	Tue, 13 Feb 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGgT/ET7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA393376F3;
	Tue, 13 Feb 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824521; cv=none; b=KJmIemVvSu9Ih3vwwjBscVbZtCSKu172ys2eLgh6K5NCv7s+dIll4x524zdlPCD+7LTWpRGd5xOBi1mtkVe9UObFZJ3HFdjigtDEQ6Nizjrt28YuJ54HIvAVN7IMxIYZz759pEcblGMOTTPpYmlKExwsZSgBPn9kp3TAk012Y1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824521; c=relaxed/simple;
	bh=1GtEqKV+wQs0MT2SIs+9S6c4LRpp7sxXEmK272Gtxpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S32zIvEFuX6zTXkA5Qg9jiaUT8nleJrj8N0vi7s4otDpvMiU8qowEtlENoDSAqdhhUAsDeZKlUmKPqosq2ItYwAWI/jTwe6w3skbv9eVMEDrDKn2axadAcX68Cs071oeZ0+Pg/a4WoeXI/65xUlCjqu75ohduPWkxbn5jfmTVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGgT/ET7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED0DC433C7;
	Tue, 13 Feb 2024 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707824521;
	bh=1GtEqKV+wQs0MT2SIs+9S6c4LRpp7sxXEmK272Gtxpg=;
	h=Date:From:To:Cc:Subject:From;
	b=ZGgT/ET7ls9NrBGdLxIAC0UWI4xJYDbxoV9/v+C/uAWRn0JFRVxM93plQwxAKyLBb
	 Hly2wL+syAtopYQ6Vb0znNINhkDdxjsOgd6XDrJ/vYfJnBPNgL70AQ6H4UdXSvYzRn
	 Zx1Qzk++dZx9WWT/Iuwgjuo7p5Fd0dchYjhkL2a9GRD1nLavEoBWbEp0L4ySefp8Zf
	 HN1WV6a5QHbOLs1Ffj2qyxMCx3LgyOW0TfSGwARG1bByAPHEJ0DBI4EhmkzsduosLi
	 9E6eiG7fR899DrgOlWWMXVGz+feqhf4OLNnJi8uOoR6VgK9cWa1nfDbJADd58FIJDz
	 OCMMIQT1kIujA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rZrB2-000000007yd-1wrs;
	Tue, 13 Feb 2024 12:42:17 +0100
Date: Tue, 13 Feb 2024 12:42:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drm/msm: DisplayPort regressions in 6.8-rc1
Message-ID: <ZctVmLK4zTwcpW3A@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Since 6.8-rc1 the internal eDP display on the Lenovo ThinkPad X13s does
not always show up on boot.

The logs indicate problems with the runtime PM and eDP rework that went
into 6.8-rc1:

	[    6.006236] Console: switching to colour dummy device 80x25
	[    6.007542] [drm:dpu_kms_hw_init:1048] dpu hardware revision:0x80000000
	[    6.007872] [drm:drm_bridge_attach [drm]] *ERROR* failed to attach bridge /soc@0/phy@88eb000 to encoder TMDS-31: -16
	[    6.007934] [drm:dp_bridge_init [msm]] *ERROR* failed to attach panel bridge: -16
	[    6.007983] msm_dpu ae01000.display-controller: [drm:msm_dp_modeset_init [msm]] *ERROR* failed to create dp bridge: -16
	[    6.008030] [drm:_dpu_kms_initialize_displayport:588] [dpu error]modeset_init failed for DP, rc = -16
	[    6.008050] [drm:_dpu_kms_setup_displays:681] [dpu error]initialize_DP failed, rc = -16
	[    6.008068] [drm:dpu_kms_hw_init:1153] [dpu error]modeset init failed: -16
	[    6.008388] msm_dpu ae01000.display-controller: [drm:msm_drm_kms_init [msm]] *ERROR* kms hw init failed: -16
	
and this can also manifest itself as a NULL-pointer dereference:

	[    7.339447] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
	
	[    7.643705] pc : drm_bridge_attach+0x70/0x1a8 [drm]
	[    7.686415] lr : drm_aux_bridge_attach+0x24/0x38 [aux_bridge]
	
	[    7.769039] Call trace:
	[    7.771564]  drm_bridge_attach+0x70/0x1a8 [drm]
	[    7.776234]  drm_aux_bridge_attach+0x24/0x38 [aux_bridge]
	[    7.781782]  drm_bridge_attach+0x80/0x1a8 [drm]
	[    7.786454]  dp_bridge_init+0xa8/0x15c [msm]
	[    7.790856]  msm_dp_modeset_init+0x28/0xc4 [msm]
	[    7.795617]  _dpu_kms_drm_obj_init+0x19c/0x680 [msm]
	[    7.800731]  dpu_kms_hw_init+0x348/0x4c4 [msm]
	[    7.805306]  msm_drm_kms_init+0x84/0x324 [msm]
	[    7.809891]  msm_drm_bind+0x1d8/0x3a8 [msm]
	[    7.814196]  try_to_bring_up_aggregate_device+0x1f0/0x2f8
	[    7.819747]  __component_add+0xa4/0x18c
	[    7.823703]  component_add+0x14/0x20
	[    7.827389]  dp_display_probe+0x47c/0x568 [msm]
	[    7.832052]  platform_probe+0x68/0xd8

Users have also reported random crashes at boot since 6.8-rc1, and I've
been able to trigger hard crashes twice when testing an external display
(USB-C/DP), which may also be related to the DP regressions.

I've opened an issue here:

	https://gitlab.freedesktop.org/drm/msm/-/issues/51

but I also want Thorsten's help to track this so that it gets fixed
before 6.8 is released.

#regzbot introduced: v6.7..v6.8-rc1

The following series is likely the culprit:

	https://lore.kernel.org/all/1701472789-25951-1-git-send-email-quic_khsieh@quicinc.com/

Johan

