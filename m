Return-Path: <linux-kernel+bounces-69933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C13859071
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43873284511
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E47C6CA;
	Sat, 17 Feb 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE7HsySo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208069D3A;
	Sat, 17 Feb 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182899; cv=none; b=uEf5iz4n5y7iCAp351uv3j937AaV/2w9VVe2Ejv/6w77FKM18422msLmPgcnbXxrr+/OdXu2kZG1wdBO1DDDyzwVguaUXk7ywL4zx6vMXqN2oqmt2WMNrInhRPIxpKbf7YhmCw3CU8Zp0s9bUDm64+heYnOzcEvc0OD2ZfFOkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182899; c=relaxed/simple;
	bh=TLjN2HulsLngOJVgAuYf4Pn7GqZqS3+GGjKKcBZ0KkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx0MJapr8LikmlWF1q4/Ii20oUVGyVWNMzOhekuj5THVrNfVyEsUHqjZhE7d0ezOgbHe/6HnDglsnj3pIMwsCu4abtRbUg/qu/2sjnVdxXP9MC6H05bcj/8PmuTJQlpYyi6qSODPS/O3kIoUNzmQO6pebex9+Wmhl+eh+8HxEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE7HsySo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E663C433F1;
	Sat, 17 Feb 2024 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182898;
	bh=TLjN2HulsLngOJVgAuYf4Pn7GqZqS3+GGjKKcBZ0KkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nE7HsySov90y/vHtMCfJXd23d7y6KBAtm1F4lITB4vg8MBRjnFV0snYu57pS04AHo
	 /4GtJZiH7KWwW1kKACjE3hCQSRcfwb9zXVHDpI9D753TxbzIaK4lhFJEtHxBG9n5Cs
	 zc5SamBHZXw6g1u5F2JyYpiKNIpsG/XcMtmnzbbiaXsAvHrHx1xsXxqGhXmv+soR+O
	 DNBUfMQUqod4rzw4eInf23Mt96swC3oHpbUFe0NtdiEwXmXh0vKjPofCQQYpgqhI33
	 lmJj0Mc8dg1t7sOVpEAJzbgnyeeIJ1dL8sGY9i04DZT1pGS/3sw8gjbjI7tLYyIGVx
	 6b//0l8cHdAsQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rbMP4-000000001bL-1zG3;
	Sat, 17 Feb 2024 16:14:58 +0100
Date: Sat, 17 Feb 2024 16:14:58 +0100
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
Subject: Re: drm/msm: DisplayPort regressions in 6.8-rc1
Message-ID: <ZdDNcrf4KpflGeYQ@hovoldconsulting.com>
References: <ZctVmLK4zTwcpW3A@hovoldconsulting.com>
 <343710b1-f0f4-5c05-70e6-3c221cdc9580@quicinc.com>
 <ZczFhVjHIm55JTfO@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZczFhVjHIm55JTfO@hovoldconsulting.com>

On Wed, Feb 14, 2024 at 02:52:06PM +0100, Johan Hovold wrote:
> On Tue, Feb 13, 2024 at 10:00:13AM -0800, Abhinav Kumar wrote:
> 
> > I do agree that pm runtime eDP driver got merged that time but I think 
> > the issue is either a combination of that along with DRM aux bridge 
> > https://patchwork.freedesktop.org/series/122584/ OR just the latter as 
> > even that went in around the same time.
> 
> Yes, indeed there was a lot of changes that went into the MSM drm driver
> in 6.8-rc1 and since I have not tried to debug this myself I can't say
> for sure which change or changes that triggered this regression (or
> possibly regressions).
> 
> The fact that the USB-C/DP PHY appears to be involved
> (/soc@0/phy@88eb000) could indeed point to the series you mentioned.
> 
> > Thats why perhaps this issue was not seen with the chromebooks we tested 
> > on as they do not use pmic_glink (aux bridge).
> > 
> > So we will need to debug this on sc8280xp specifically or an equivalent 
> > device which uses aux bridge.
> 
> I've hit the NULL-pointer deference three times now in the last few days
> on the sc8280xp CRD. But since it doesn't trigger on every boot it seems
> you need to go back to the series that could potentially have caused
> this regression and review them again. There's clearly something quite
> broken here.

Since Dmitry had trouble reproducing this issue I took a closer look at
the DRM aux bridge series that Abhinav pointed and was able to track
down the bridge regressions and come up with a reproducer. I just posted
a series fixing this here:

	https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/

As I mentioned in the cover letter, I am still seeing intermittent hard
resets around the time that the DRM subsystem is initialising, which
suggests that we may be dealing with two separate DRM regressions here
however.

If the hard resets are triggered by something like unclocked hardware,
perhaps that bit could this be related to the runtime PM rework?

Johan

