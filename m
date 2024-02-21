Return-Path: <linux-kernel+bounces-74287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE7985D219
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012391F27582
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25753BB36;
	Wed, 21 Feb 2024 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK6ijRXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40E3A269;
	Wed, 21 Feb 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502730; cv=none; b=TezZUO6M84Ep+HIMbQiskYsOHIQAFvVPYioL8I+CyGdD38mBSHwkQ8WqGIPW2w5kISTo4Z90ZUY+T98Z+/JsHNomn/461uUphCTmGvRfc/y4zJm8N3hkTTsICyt1f7QQGuBHAOwAsNpVmyYTT/i0Qt93tNfkLuh9iXWYkgdmKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502730; c=relaxed/simple;
	bh=Tpr/yec3AGC4Lc2eJDg1OjnAD9sBLP7h0jxhyqIYTUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvMCgaHuWbVU3OlQmOqJ3vYPDGHFhbaL5Whsickfh9y2a1dr3AVYl0t/HirioYTq3fv4nvcmKRRbJfwgcjfq45LHqCqMO/eYLLVL6koBBPb8ce/Wr4/pDIDeVQLSEIVfuA5jNrlRsNvzE0xNDFVco8oqP228BLNKcYNw1CYoGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK6ijRXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B0DC433C7;
	Wed, 21 Feb 2024 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708502729;
	bh=Tpr/yec3AGC4Lc2eJDg1OjnAD9sBLP7h0jxhyqIYTUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK6ijRXRympTy7Dlryxc1+ccz+sSc9s0V1MK9EzciMsOwCX31RlKWS1sIRNlLJZOl
	 nNXm/VKIPBSVHaaNT4XyAGeUwcPHOffWPNyCwwX0+nJCVmevA9E8CLAmGbhFpzDN5i
	 gNF1JoS+qJE4Du1iQMrDeb0MtjwdodkrHmvMa+4mVt5chON5GQBTtJVUNvDNQwEUCa
	 0HIEAJejS3pOB2BbCfmA/xZODMcpB6TjHBgD1ZtL4YmsLwENycTADaiN9TTZnwfMf+
	 zT2IK655ADuV66esW14ijM7EDLGHrRR4PSXMazD2xJGOMUn2JbiYJplEH9ruicueIK
	 +V/92rXlMN8Bw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rchbe-000000004Sj-2sC5;
	Wed, 21 Feb 2024 09:05:30 +0100
Date: Wed, 21 Feb 2024 09:05:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: drm/msm: Second DisplayPort regression in 6.8-rc1
Message-ID: <ZdWuygp4HuRVXvyl@hovoldconsulting.com>
References: <ZctVmLK4zTwcpW3A@hovoldconsulting.com>
 <343710b1-f0f4-5c05-70e6-3c221cdc9580@quicinc.com>
 <ZczFhVjHIm55JTfO@hovoldconsulting.com>
 <ZdDNcrf4KpflGeYQ@hovoldconsulting.com>
 <ZdMwZa98L23mu3u6@hovoldconsulting.com>
 <2df31f2d-8271-d966-158a-27c6e0581d72@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df31f2d-8271-d966-158a-27c6e0581d72@quicinc.com>

On Tue, Feb 20, 2024 at 01:19:54PM -0800, Abhinav Kumar wrote:
> On 2/19/2024 2:41 AM, Johan Hovold wrote:

> > It seems my initial suspicion that at least some of these regressions
> > were related to the runtime PM work was correct. The hard resets happens
> > when the DP controller is runtime suspended after being probed:

> > [   17.074925] bus: 'platform': __driver_probe_device: matched device aea0000.displayport-controller with driver msm-dp-display
> > [        Starting Network Time Synchronization...
> > [   17.112000] msm-dp-display aea0000.displayport-controller: dp_display_probe - populate aux bus
> > [   17.125208] msm-dp-display aea0000.displayport-controller: dp_pm_runtime_resume
> >           Starting Record System Boot/Shutdown in UTMP...
> >           Starting Virtual Console Setup...
> > [  OK  ] Finished Load/Save Screen Backlight Brightness of backlight:backlight.
> > [   17.197909] msm-dp-display aea0000.displayport-controller: dp_pm_runtime_suspend
> > [   17.198079] probe of aea0Format: Log Type - Time(microsec) - Message - Optional Info
> > Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> > S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.1-00470-MAKENA-1
> > S - IMAGE_VARIANT_STRING=SocMakenaWP
> > S - OEM_IMAGE_VERSION_STRING=crm-ubuntu92
> > 
> >    < machine is reset by hypervisor >
> > 
> > Presumably the reset happens when controller is being shut down while
> > still being used by the EFI framebuffer.
> 
> I am not sure if we can conclude like that. Even if we shut off the 
> controller when the framebuffer was still being fetched that should only 
> cause a blank screen and not a reset because we really don't trigger a 
> new register write / read while its fetching so as such there is no new 
> hardware access.

It specifically looks like the reset happens when shutting down the PHY,
that is, the call to dp_display_host_phy_exit(dp) in
dp_pm_runtime_suspend() never returns.

That seems like more than a coincidence to me.
 
> One thing I must accept is that there are two differences between 
> sc8280xp where we are hitting these resets and sc7180/sc7280 chromebooks 
> where we tested it more thoroughly without any such issues:
> 
> 1) with the chromebooks we have depthcharge and not the QC UEFI.
> 
> If we are suspecting a hand-off issue here, will it help if we try to 
> disable the display in EFI by using "fastboot oem select-display-panel 
> none" (assuming this is a fastboot enabled device) and see if you still 
> hit the reset issue?

No, we don't have fastboot.

But as I mentioned I still do see resets when I instrument the code to
not shut down the display, which could indicate more than one issue
here.

> 2) chromebooks used "internal_hpd" whereas the pmic_glink method used in 
> the sc8280xp.
> 
> I am still checking if there are any code paths in the eDP/DP driver 
> left exposed due to this difference with pm_runtime which can cause 
> this. I am wondering if some sort of drm tracing will help to narrow 
> down the reset point.
> 
> > In the cases where the machines survives boot, the controller is never
> > suspended.
> > 
> > When investigating this I've also seen intermittent:
> > 
> > 	[drm:dp_display_probe [msm]] *ERROR* device tree parsing failed
> 
> So this error I think is because in dp_parser_parse() ---> 
> dp_parser_ctrl_res(), we also have a devm_phy_get().
> 
> This can return -EDEFER if the phy driver has not yet probed.
> 
> I checked the other things inside dp_parser_parse(), others calls seem 
> to be purely DT parsing except this one. I think to avoid the confusion, 
> we should move devm_phy_get() outside of DT parsing into a separate call 
> or atleast add an error log inside devm_phy_get() failure below to 
> indicate that it deferred
> 
>          io->phy = devm_phy_get(&pdev->dev, "dp");
>          if (IS_ERR(io->phy))
>                  return PTR_ERR(io->phy);
> 
> If my hypothesis is correct on this, then this error log (even though 
> misleading) should be harmless for this issue because if we hit 
> DRM_ERROR("device tree parsing failed\n"); we will skip the 
> devm_pm_runtime_enable().

Yeah, this seems to be the case as boot appears to recover from this, so
this may indeed be a probe deferral.

Probe deferrals should not be logged as errors however, so the fix is
not to add another error message but rather to suppress the current one
(e.g. using dev_err_probe()).

> > Has anyone given some thought to how the framebuffer handover is
> > supposed to work? It seems we're currently just relying on luck with
> > timing.

Any comments to this? It seems we should not be shutting down (runtime
suspend) the display during boot as can currently happen.

Johan

