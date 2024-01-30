Return-Path: <linux-kernel+bounces-45024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 389FA842A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0991F24A64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BE1292E5;
	Tue, 30 Jan 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnXSeGa8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8661292D2;
	Tue, 30 Jan 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634785; cv=none; b=Zt6fw7GW2XALWEGEvVDHz/j3swtTH07IXF5qO5UGa12+t5IPprfG78N47kOJEBFcdSsy9ldbVCBBmIcu4pH5EIm2euzyavtCJnIPaqYnX2/lH782BgC9O8vKaK0WdP+gRbAGmZS4qDG9m2sv9S18Y0B2Fl6kau6XWEXR394gzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634785; c=relaxed/simple;
	bh=UkA0fUifhjkAamI3HED/L3EBo+j4suBV+QksQPDCgHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGeqNl5GU3/vS2PPKbjljKsRictpFmEKNnUkxdvkBKtRvQHR/QZDysbkE0L1YT3MehC3uuNhBVq6467Fit9pdYsmdHuwp/bs0SLA2R7QIhzmkauxaIGM5Ra2PHND8oKQHJKIv/VSd03txrVkzbpsDT3bC/jmFWPqDnpNcbu7VJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnXSeGa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBA5C433F1;
	Tue, 30 Jan 2024 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706634785;
	bh=UkA0fUifhjkAamI3HED/L3EBo+j4suBV+QksQPDCgHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnXSeGa8ToZx0xC9bOT94rMy47dNA99eMkVM1V9u5AXpCsxyskJW2rN8Co2/KsVHm
	 4A32ArbSZBFqQvHHL6pu+sKvUzFiKFbJEs0dM09v415WeGmbJu9XarfCM4l3onNHDW
	 gKQ0dn46fX8Hy1Fv0DY5HmefJSh+vMF6LVLBFN6g=
Date: Tue, 30 Jan 2024 09:13:04 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-fpga@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: fpga: dfl: fme: Return directly after a failed devm_kasprintf()
 call in fme_perf_pmu_register()
Message-ID: <2024013044-relay-jolt-35d0@gregkh>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <b7e2e9d1-5e3e-44b2-a4b7-327d334b776d@moroto.mountain>
 <e760bd1b-30bf-489f-b745-128d05397feb@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e760bd1b-30bf-489f-b745-128d05397feb@web.de>

On Tue, Jan 30, 2024 at 06:09:14PM +0100, Markus Elfring wrote:
> >> Thus return directly after a failed devm_kasprintf() call.
> >>
> >> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")
> >
> > This basically doesn't affect runtime because perf_pmu_register() checks
> > for NULL so no need for a Fixes tag.
> 
> I suggest to clarify this view a bit more also according to statements
> like the following.
> 
> 1. https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L11532
>    perf_pmu_register:
>    …
> 	pmu->name = name;
>    …
> 
> 2. https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L11472
>    pmu_dev_alloc:
>    …
> 	ret = dev_set_name(pmu->dev, "%s", pmu->name);
>    …
> 
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

thanks,

greg k-h's patch email bot

