Return-Path: <linux-kernel+bounces-72518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0885B4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBBA1F21FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518195C60F;
	Tue, 20 Feb 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWAqPqIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936BD5C5EF;
	Tue, 20 Feb 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416841; cv=none; b=EPAY9VqBMMDxgmCB4UDWe+XeIGtDsdtBSV3LRNelDvgn3qsZE4FZmskpCCL816KXtgaCkrQ0tLhz4FFVmvp6o6X3AWya3CEyHU0NcRbjAmSSI0LWYRGh2nE0Zgs8pegLNLIxneyK/M1oD2XWynv4e1BEdJbn6NxDIHypXYYKL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416841; c=relaxed/simple;
	bh=KMaiaCUm3bZGBK7I5/F1KQ3UkBMCQjLFXyGs6MrrrZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJlQB1BKx7r/koL3EYIcHCVLDmIPD8LUal7REtOnsG2zKEKfbmtm7JQIl7sNODMelrVcz3P0p1Vs07GIkfYkcIQpq8uh77D669mcVfeRGZCjharORM6qhFjubTxNv6HHKKQ+Bzq+POJMmfiygCu0Fp60/8IbC8mFVwN0iWTLFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWAqPqIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A99C433F1;
	Tue, 20 Feb 2024 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708416841;
	bh=KMaiaCUm3bZGBK7I5/F1KQ3UkBMCQjLFXyGs6MrrrZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWAqPqIFYAZcp/X5cbUN4fXO8zQJX/f6D4UJtzxFT6y6m5gyG3oKuoyLyKCf6r6Np
	 bHxHY+ewlI5Loa2rf5avoXxV7CrD6+ALSzIiHSWDVhHYjfzr8O7AlZOYCQ+5MF7fqv
	 5avMiRaq3S3N4IBGWssZdSlZbpiZED8r8rwXL3dA/xuPMaO3XXoym7jDw5qlYD75+r
	 qTCuA0UYbEVEQ/dDDyvoTExr1WLTNadhOWBz6MI+2wm5we1NzvkYcklutzMXfXStn5
	 qRtBEHp4ZmitTxwcP/I3jc0w5avu3ifpbqNlHzrJDtbU055PBcjgSF0W1JJZxS9Vnc
	 7ap2cwluTBrzw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcLGJ-000000002QZ-0PDo;
	Tue, 20 Feb 2024 09:13:59 +0100
Date: Tue, 20 Feb 2024 09:13:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Wire up tlb ops
Message-ID: <ZdRfR3xqYIYNISbL@hovoldconsulting.com>
References: <20240213172340.228314-1-robdclark@gmail.com>
 <Zc2-qVd0gtErdbKe@hovoldconsulting.com>
 <CAF6AEGsPojmqDgMZWrEAm_CoWGZ05euc0jzD5+9aX0cXQha_ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGsPojmqDgMZWrEAm_CoWGZ05euc0jzD5+9aX0cXQha_ew@mail.gmail.com>

On Thu, Feb 15, 2024 at 07:28:53AM -0800, Rob Clark wrote:
> On Wed, Feb 14, 2024 at 11:34 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Feb 13, 2024 at 09:23:40AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > The brute force iommu_flush_iotlb_all() was good enough for unmap, but
> > > in some cases a map operation could require removing a table pte entry
> > > to replace with a block entry.  This also requires tlb invalidation.
> > > Missing this was resulting an obscure iova fault on what should be a
> > > valid buffer address.
> > >
> > > Thanks to Robin Murphy for helping me understand the cause of the fault.
> > >
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")
> >
> > Sounds like you're missing a
> >
> > Cc: stable@vger.kernel.org
> >
> > here? Or is there some reason not to backport this fix (to 5.9 and later
> > kernels)?
> 
> No reason, I just expected the Fixes tag was sufficient

No, you should still mark patches intended for stable with an explicit
CC-stable tag (as per the documentation).

The fact that Sasha and his AI tries to catch fixes which the author and
maintainer failed to tag as a fallback should not be relied upon. It
also makes it harder for the stable team and others to determine what
the intention with a fix was.

Johan

