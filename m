Return-Path: <linux-kernel+bounces-117725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45DD88B55E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C299C60CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742CB29CE7;
	Mon, 25 Mar 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLzT+WEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80819460;
	Mon, 25 Mar 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391833; cv=none; b=SozFsytfoCRZHzDfljpnpvKKk6DzRWnJZy1mKIMtQ83kwYCpiNhQhaPYlNtUrhKvuqna5t6PK1yRY2upe1JzIFp8Kmj5g6qkpPEwVHAf1uEHuWv/SOE61AOmU7HSPLRiTiox96xcRtYWmiR4GQCVPaViIPaR9/MX1wHHp6J1q1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391833; c=relaxed/simple;
	bh=ozLed1RgSofEW/JhzPbh4DFYa4pZ4WP0p3K+tacDuL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PypFyY3PtOqODSdITABIthncOYPQOtRmwsRoeZ9fLAD+kWPwKxJAq0+OQhdcwttZCdNm2OODCsbK3qMXHXIjvxnV3L9viniK4AP0TrggcAnJPaafyVGQrknC3QDrM75e/ZOU/jMKcUisVNeK86LhMOVW4KYYJRC1Oa7llPSXM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLzT+WEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EFEC433F1;
	Mon, 25 Mar 2024 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711391833;
	bh=ozLed1RgSofEW/JhzPbh4DFYa4pZ4WP0p3K+tacDuL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLzT+WEgcFPrHqlwu8yvATEVwVaCuzHiW2benJYKJGo+cuEwq0Ralk2U6j87c8HYi
	 1i0hVGHlBbV9Qw9OhV8bop+B5MI5+Bt59k1PD8wSS0WHysuKTaulfTZnU51IXcOz1S
	 32+uNpXoVf8BQGmYU36Yjy2crV2COr/auNTvgQJk=
Date: Mon, 25 Mar 2024 19:37:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Saravana Kannan <saravanak@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] driver core: Introduce device_link_wait_removal()
Message-ID: <2024032548-rope-improper-4f67@gregkh>
References: <20240325152140.198219-1-herve.codina@bootlin.com>
 <20240325152140.198219-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325152140.198219-2-herve.codina@bootlin.com>

On Mon, Mar 25, 2024 at 04:21:25PM +0100, Herve Codina wrote:
> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
> 
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
> 
> For instance, in the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
> 
> During the step 1, devices are released and related devlinks are removed
> (jobs pushed in the workqueue).
> During the step 2, OF nodes are destroyed but, without any
> synchronisation with devlink removal jobs, of_overlay_remove() can raise
> warnings related to missing of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2
> 
> Indeed, the missing of_node_put() call is going to be done, too late,
> from the workqueue job execution.
> 
> Introduce device_link_wait_removal() to offer a way to synchronize
> operations waiting for the end of devlink removals (i.e. end of
> workqueue jobs).
> Also, as a flushing operation is done on the workqueue, the workqueue
> used is moved from a system-wide workqueue to a local one.
> 
> Cc: stable@vger.kernel.org

Why is this for stable?  You are just adding a new api, no one is using
it.

Or if they are, you didn't send me that patch...

greg k-h

