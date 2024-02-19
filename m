Return-Path: <linux-kernel+bounces-71139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70CD85A136
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6621C219EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BCA28DD1;
	Mon, 19 Feb 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY6yXZr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA328DA5;
	Mon, 19 Feb 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339304; cv=none; b=DbFoN7zh+5feSMXvM9U83k3SZ8/xxUF9GFZAb7pTdLAHAJ4Mn0CRLDsqDlt4FmINJB5UPn3qt/2SnT6rKMKhWevob8gueQYqfVKxV56X7IMmAQK86IY+sDIXhoi3IpSJV9NKBa6zEuNBpI4jj13RKqOtI9ZouFIFmsG1p46AONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339304; c=relaxed/simple;
	bh=j0hZ7OP3iKPpfHm4XNFd9GklyucQI6Echl+Kr1PbKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0sFF5oPSj7Gmar+T+mGesT8RbSjcA8HYBfCFBW8YI3bz+JNtPV6V0S4GzX2Uu5Y+XWgtWPBpusX2BXwmQ/YIRaSm0Eud51V+BxVlCrR671jqtjBQ3s4BhVrSthbrdNcLoFbwkbaDF6A6uz/oWw5TFNWEkBPzaWN/g1TlDzcH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY6yXZr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ADCC433F1;
	Mon, 19 Feb 2024 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339303;
	bh=j0hZ7OP3iKPpfHm4XNFd9GklyucQI6Echl+Kr1PbKTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LY6yXZr3E2vzWkg1Hg9gmo5TqYcNayGq//e1aM6TDjTSjOYtKCjyL1lOKXFSFAeuF
	 V2WJ8OD/2ZPSq3wiOlRSM76qr71jZijdaRDQ/BijFj7wZnZ7sViiwSZ4bLlGNoD+ZV
	 WH4//y4qt8YHFZuPle48PQ0JIjlUyHbs3sqIxnQQwtNo6naYwYzLqwh0n+Ou9KxA9q
	 TLmwEhUoEEAKU+0VbbUZMfAjrQcLPHK05XkPWQ3IFQ3TazJb5UBMHb4crKm4a5q9n6
	 NqUbtMGE/2ohmNR3QBpUDSq7onI6kyNLMXQClsTIMiVx+CgsqLyenhRcpbnB8SmjCa
	 jPT7FURBb12Ew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rc15h-000000006eY-16Ya;
	Mon, 19 Feb 2024 11:41:41 +0100
Date: Mon, 19 Feb 2024 11:41:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Rob Clark <robdclark@gmail.com>,
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
Subject: drm/msm: Second DisplayPort regression in 6.8-rc1
Message-ID: <ZdMwZa98L23mu3u6@hovoldconsulting.com>
References: <ZctVmLK4zTwcpW3A@hovoldconsulting.com>
 <343710b1-f0f4-5c05-70e6-3c221cdc9580@quicinc.com>
 <ZczFhVjHIm55JTfO@hovoldconsulting.com>
 <ZdDNcrf4KpflGeYQ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdDNcrf4KpflGeYQ@hovoldconsulting.com>

On Sat, Feb 17, 2024 at 04:14:58PM +0100, Johan Hovold wrote:
> On Wed, Feb 14, 2024 at 02:52:06PM +0100, Johan Hovold wrote:
> > On Tue, Feb 13, 2024 at 10:00:13AM -0800, Abhinav Kumar wrote:

> Since Dmitry had trouble reproducing this issue I took a closer look at
> the DRM aux bridge series that Abhinav pointed and was able to track
> down the bridge regressions and come up with a reproducer. I just posted
> a series fixing this here:
> 
> 	https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/
> 
> As I mentioned in the cover letter, I am still seeing intermittent hard
> resets around the time that the DRM subsystem is initialising, which
> suggests that we may be dealing with two separate DRM regressions here
> however.
> 
> If the hard resets are triggered by something like unclocked hardware,
> perhaps that bit could this be related to the runtime PM rework?

It seems my initial suspicion that at least some of these regressions
were related to the runtime PM work was correct. The hard resets happens
when the DP controller is runtime suspended after being probed:

[   16.748475] bus: 'platform': __driver_probe_device: matched device ae00000.display-subsystem with driver msm-mdss
[   16.759444] msm-mdss ae00000.display-subsystem: Adding to iommu group 21
[   16.795226] bus: 'platform': __driver_probe_device: matched device ae01000.display-controller with driver msm_dpu
[   16.807542] probe of ae01000.display-controller returned -517 after 3 usecs
[   16.821552] bus: 'platform': __driver_probe_device: matched device ae90000.displayport-controller with driver msm-dp-display
[   16.837749] probe of ae90000.displayport-controller returned -517 after 1 usecs
[  OK  ] Listening on Load/Save RF Kill Swit[   16.854659] bus: 'platform': __dch Status /dev/rfkill Watch.
[   16.868458] probe of ae98000.displayport-controller returned -517 after 2 usecs
[   16.880012] bus: 'platform': __driver_probe_device: matched device aea0000.displayport-controller with driver msm-dp-display
[   16.891856] probe of aea0000.displayport-controller returned -517 after 2 usecs
[   16.903825] probe of ae00000.display-subsystem returned 0 after 144497 usecs
[   16.911636] bus: 'platform': __driver_probe_device: matched device ae01000.display-controller with driver msm_dpu
[   16.942092] probe of ae01000.display-controller returned 0 after 19593 usecs
         Starting Load/Save Screen Backligh…rightness[   16.959146] bus: 'platform': _ of backlight:backlight...
[   16.995355] msm-dp-display ae90000.displayport-controller: dp_display_probe - probe tail
[   17.004032] probe of ae90000.displayport-controller returned 0 after 30225 usecs
[   17.012308] bus: 'platform': __driver_probe_device: matched device ae98000.displayport-controller with driver msm-dp-display
[   17.050193] msm-dp-display ae98000.displayport-controller: dp_display_probe - probe tail
         Starting Network Name Resolution...
[   17.058925] probe of ae98000.displayport-controller returned 0 after 34774 usecs
[   17.074925] bus: 'platform': __driver_probe_device: matched device aea0000.displayport-controller with driver msm-dp-display
[        Starting Network Time Synchronization...
[   17.112000] msm-dp-display aea0000.displayport-controller: dp_display_probe - populate aux bus
[   17.125208] msm-dp-display aea0000.displayport-controller: dp_pm_runtime_resume
         Starting Record System Boot/Shutdown in UTMP...
         Starting Virtual Console Setup...
[  OK  ] Finished Load/Save Screen Backlight Brightness of backlight:backlight.
[   17.197909] msm-dp-display aea0000.displayport-controller: dp_pm_runtime_suspend
[   17.198079] probe of aea0Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.1-00470-MAKENA-1
S - IMAGE_VARIANT_STRING=SocMakenaWP
S - OEM_IMAGE_VERSION_STRING=crm-ubuntu92

  < machine is reset by hypervisor >

Presumably the reset happens when controller is being shut down while
still being used by the EFI framebuffer.

In the cases where the machines survives boot, the controller is never
suspended.

When investigating this I've also seen intermittent:

	[drm:dp_display_probe [msm]] *ERROR* device tree parsing failed

which also appears to be related to the runtime PM rework:

	https://lore.kernel.org/lkml/1701472789-25951-1-git-send-email-quic_khsieh@quicinc.com/

I believe this is enough evidence to conclude that this second
regression is introduced by commit 5814b8bf086a ("drm/msm/dp:
incorporate pm_runtime framework into DP driver"):

#regzbot introduced: 5814b8bf086a

Has anyone given some thought to how the framebuffer handover is
supposed to work? It seems we're currently just relying on luck with
timing.

Johan

