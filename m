Return-Path: <linux-kernel+bounces-71421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF885A4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D5F1F2147A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4936B16;
	Mon, 19 Feb 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKU4rhLm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57136AE5;
	Mon, 19 Feb 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349924; cv=none; b=ABcn01yEdFgNqRcWU04gF8p2u+aPEiCORAdKJwQ8JD3Es9cZrfA++qL4XmmyRZhtRBli4G3GGiu2ZShDo5eqTRO9tRWppqsfVm6K/j9+rQPSSU5AWK9KIz9PEiS7rG0ZYoT7MPwp2BjkAPGYHYcpLG3cytjzdtszeAduW7iw4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349924; c=relaxed/simple;
	bh=2y/R2rNrQF5YNdRb1X6YdN4UDCwnv5pqvMcfcKpihWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6fCGpt4gOEwaC+tw1LLCvT9sdymmjt03/jiMQIoHjWaEAhKYp4ylEuR12PL0wGqbTsuUiGiC/Tz2ae3q3Sx9gREy6YB8Zl62xTSKIF7W42ShmHGCaIXrg0QO16gg2SPB7v2865S8MM4781vP68YQdYb6JKECYS/AGjlROe2ZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKU4rhLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E31C433F1;
	Mon, 19 Feb 2024 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708349924;
	bh=2y/R2rNrQF5YNdRb1X6YdN4UDCwnv5pqvMcfcKpihWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKU4rhLmXh2QGNfVOd1TLLlAWldlYF1g01lkeL+TNUl/NObJeGAgG8LAVZSK8Zt7l
	 ySPSnhqT2Gi2bZ5Kz09RVV3tGh8l9vffvkg9q29/Ypd5SQF4fw63Hx7eh3sZhT4Zfa
	 D6jeHwAt3rfOmYxtibweL82tniOlA9SX5g7Wtuxja01mcAzBbNATfB0mpLVp7IRw2u
	 s8nNCVyHiDp8qiomruTzVpmtl8nQJjLOy6HBxahTsCeydfzpL2F6c4sTkbsj5+qmGg
	 FtGX6AoSQRa4y+/hS/mnZvGo+91/BDSS5IEBoYAg0uAXgSWiLXszqzFpZyMt6eF5OF
	 /sHe0ELFLhLqw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rc3qz-000000002NA-15HX;
	Mon, 19 Feb 2024 14:38:41 +0100
Date: Mon, 19 Feb 2024 14:38:41 +0100
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
Subject: Re: drm/msm: Second DisplayPort regression in 6.8-rc1
Message-ID: <ZdNZ4TiJn9-yKT5_@hovoldconsulting.com>
References: <ZctVmLK4zTwcpW3A@hovoldconsulting.com>
 <343710b1-f0f4-5c05-70e6-3c221cdc9580@quicinc.com>
 <ZczFhVjHIm55JTfO@hovoldconsulting.com>
 <ZdDNcrf4KpflGeYQ@hovoldconsulting.com>
 <ZdMwZa98L23mu3u6@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdMwZa98L23mu3u6@hovoldconsulting.com>

On Mon, Feb 19, 2024 at 11:41:41AM +0100, Johan Hovold wrote:

> It seems my initial suspicion that at least some of these regressions
> were related to the runtime PM work was correct. The hard resets happens
> when the DP controller is runtime suspended after being probed:
 
> [   17.074925] bus: 'platform': __driver_probe_device: matched device aea0000.displayport-controller with driver msm-dp-display
> [   17.112000] msm-dp-display aea0000.displayport-controller: dp_display_probe - populate aux bus
> [   17.125208] msm-dp-display aea0000.displayport-controller: dp_pm_runtime_resume
> [   17.197909] msm-dp-display aea0000.displayport-controller: dp_pm_runtime_suspend
> [   17.198079] probe of aea0Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.1-00470-MAKENA-1
> S - IMAGE_VARIANT_STRING=SocMakenaWP
> S - OEM_IMAGE_VERSION_STRING=crm-ubuntu92
> 
>   < machine is reset by hypervisor >
> 
> Presumably the reset happens when controller is being shut down while
> still being used by the EFI framebuffer.
> 
> In the cases where the machines survives boot, the controller is never
> suspended.
> 
> When investigating this I've also seen intermittent:
> 
> 	[drm:dp_display_probe [msm]] *ERROR* device tree parsing failed

Note that there are further indications there may be more than one bug
here too.

I definitely see hard resets when dp_pm_runtime_suspend() is shutting
down the eDP PHY, but there are occasional resets also if I instrument
DP controller probe() to resume and then prevent the controller from
suspending until after a timeout (e.g. to be used as a temporary
workaround):

[   15.676495] bus: 'platform': __driver_probe_device: matched device aea0000.displayport-controller with driver msm-dp-display
[   15.769392] msm-dp-display aea0000.displayport-controller: dp_display_probe - populate aux bus
[   15.778808] msm-dp-display aea0000.displayport-controller: dp_display_probe - scheduling handover
[   15.789931] probe of aea0000.displayport-controller returned 0 after 91121 usecs
[   15.790460] bus: 'dp-aux': __driver_probe_device: matched device aux-aea0000.displayport-controller with driver panel-simple-dp-aux
Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.1-00470-MAKENA-1

I'll wait for the maintainers and authors of this code to comment, but
it seems the runtime PM work is broken in multiple ways.

Johan

