Return-Path: <linux-kernel+bounces-83321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B6B8692EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9271B260E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E7313B2BA;
	Tue, 27 Feb 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+KKGwdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C672F2D;
	Tue, 27 Feb 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040825; cv=none; b=CoubUdz888BYkfXe4dv47JsfrM+xeP2Da6PIZAX+v/s8tq7c/bSs3a4oA3NkMt3NUI6RYU0rn1iRXlVwF6gxcRrRwAkWuNFBLiaQ8andDOBnJro47vtCwuAItLvhb/FsYZ1YJtGHpJDxwsvc+9Ncu9OcOAceFJpuZPd0T2g/Ogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040825; c=relaxed/simple;
	bh=N4hJ3rbmGb3aGfm5/rEMCgX5Pes2gJRcb4blBbA46Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IK4CYmkINV15FDOcVl6fB4aP08hJKCBoTCgrcI2eE0Y7NtlPygR4yv1eYR6hgKTqdnRBfaE+0gVyJthYPHX7OnlHakqi+DiHn2SqaAkjihM526ZCRwUWICxhmKlpplpRuZoxyhZlvk+wDxhhgJTffogbSGkX1udUrHJGtbA7c2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+KKGwdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62612C433F1;
	Tue, 27 Feb 2024 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709040825;
	bh=N4hJ3rbmGb3aGfm5/rEMCgX5Pes2gJRcb4blBbA46Mc=;
	h=Date:From:To:Cc:Subject:From;
	b=j+KKGwdYVHf4Tps9pQpbbdwOVyN1f5D00T5l2uPn0z+U9Z71vnoyhCH8hccVsAPRn
	 B4CWq8Fi8VISDe+Tw9/VF0x1XBM4QjhYB/kAsoXEqHCxxPkOQPr3thYXhZ5+lF85YC
	 Gh1LEOPgBmK5u7QTsgaShhK2d+kWWU8wiPfIsuw51hwsdsmca03112rf89TcL7ixId
	 oE/vXOZ2B0MjrHC5g8BZEPovxvkFrzioBSOB0uJWL6z1Eeri9s0MuohrwAKDDsAJGG
	 ZC26uynk0qS79KXi+o4U+u4mBddkaKQbYwiHtPKIHGiyyoDiVQ0rBk+COt0IRLypSs
	 JwHL1kvqbFXzQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rexae-000000000VL-23Zy;
	Tue, 27 Feb 2024 14:33:48 +0100
Date: Tue, 27 Feb 2024 14:33:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drm/msm: DisplayPort hard-reset on hotplug regression in 6.8-rc1
Message-ID: <Zd3kvD02Qvsh2Sid@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Since 6.8-rc1 I have seen (and received reports) of hard resets of the
Lenovo ThinkPad X13s after connecting and disconnecting an external
display.

I have triggered this on a simple disconnect while in a VT console, but
also when stopping Xorg after having repeatedly connected and
disconnected an external display and tried to enable it using xrandr.

In the former case, the last (custom debug) messages printed over an SSH
session were once:

    [  948.416358] usb 5-1: USB disconnect, device number 3
    [  948.443496] msm_dpu ae01000.display-controller: msm_fbdev_client_hotplug
    [  948.443723] msm-dp-display ae98000.displayport-controller: dp_power_clk_enable - type = 1, enable = 0
    [  948.443872] msm-dp-display ae98000.displayport-controller: dp_ctrl_phy_exit
    [  948.445117] msm-dp-display ae98000.displayport-controller: dp_ctrl_phy_exit - done
    
and then the hypervisor resets the machine.

Hotplug in Xorg seems to work worse than it did with 6.7, which also had
some issues. Connecting a display once seems to work fine, but trying to
re-enable a reconnected display using xrandr sometimes does not work at
all, while with 6.7 it usually worked on the second xrandr execution.

xrandr reports the reconnected display as disconnected:

    Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 5120 x 4096
    eDP-1 connected primary 1920x1200+0+0 (normal left inverted right x axis y axis) 286mm x 178mm
       1920x1200     60.03*+
       1600x1200     60.00  
    DP-1 disconnected (normal left inverted right x axis y axis)
    DP-2 disconnected 1920x1200+0+0 (normal left inverted right x axis y axis) 0mm x 0mm
      1920x1200 (0x40c) 154.000MHz +HSync -VSync
            h: width  1920 start 1968 end 2000 total 2080 skew    0 clock  74.04KHz
            v: height 1200 start 1203 end 1209 total 1235           clock  59.95Hz

Running 'xrandr --output DP-2 --auto' 2-3 times makes xrandr report the
display as connected, but the display is still blank (unlike with 6.7).

A few times after having exercised hotplug this way, the machine hard
resets when Xorg is later stopped. Once I saw the following log messages
on an SSH session but they may not have been printed directly before
the hard reset:

    [  214.555781] [drm:dpu_encoder_phys_vid_wait_for_commit_done:492] [dpu error]vblank timeout
    [  214.555843] [drm:dpu_kms_wait_for_commit_done:483] [dpu error]wait for commit done returned -110

Note that this appears to be unrelated to the recently fixed Qualcomm
power domain driver bug which can trigger similar resets when
initialising the display subsystem on boot. Specifically, I have
triggered the hotplug resets described above also with the fix applied.
[1]

Reverting commit e467e0bde881 ("drm/msm/dp: use drm_bridge_hpd_notify()
to report HPD status changes") which fixes the related VT console
regression does not seem to make any difference. [2]

Daniel Thompson reports that reverting the whole runtime PM series
appears to make the hard resets he has seen with DisplayPort hotplug go
away however:

	https://lore.kernel.org/lkml/1701472789-25951-1-git-send-email-quic_khsieh@quicinc.com/

So for now, let's assume that these regressions were also introduced (or
triggered) by commit 5814b8bf086a ("drm/msm/dp: incorporate pm_runtime
framework into DP driver").

Johan


[1] https://lore.kernel.org/lkml/20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com/
[2] https://lore.kernel.org/lkml/Zd3YPGmrprxv-N-O@hovoldconsulting.com/


#regzbot introduced: 5814b8bf086a

