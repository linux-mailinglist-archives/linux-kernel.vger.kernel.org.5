Return-Path: <linux-kernel+bounces-128519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C3895BED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C991C20C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8AC15B540;
	Tue,  2 Apr 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQCHQU5E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E615AAAA;
	Tue,  2 Apr 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083717; cv=none; b=XxgA6SKsQK5Hlb33Kqh2wFAuXsnBPm7HqcvDwET/bPmFdrX+TKCxplh0OsHcBWe0RXm+/cZQl4y9kiLkTSe4Aqv49r+addjZPcJ8muS4RBhCA3UW0OnyQ6D2VAwACMsGCA1gEdlJ09niHlGty/9+poXHElULALgEDWQeocKRfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083717; c=relaxed/simple;
	bh=mKrjhnY8pVcgEHLKKw5VsWYAh/llZ4ifRJMaYVxScms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aupp2iWQMGecgoHCfcdqHNVpTwUemee8ev+05TQfdxoX/g/vEuy5Z+NTgQlo9dQnFn9THckWCHDQsptUZJXF7NNNRj+2ESMdcJ+LvMzNc1al12mcqNZtWUuuO5DBPh4RzMiARbmoQY1MIzlvUmK9VzplUIwxe1xtDbuIhlleG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQCHQU5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4794BC433C7;
	Tue,  2 Apr 2024 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712083716;
	bh=mKrjhnY8pVcgEHLKKw5VsWYAh/llZ4ifRJMaYVxScms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQCHQU5EecHUloNS1mzyuT76vUsvoHOW8HJUKnliuoM2IRbghFV20xjh4JSmnZDrU
	 NHAeHggejGhmARM1CeO6eIn+Q0ashBEccumjvC4KtesoTAdt536j68NaubLwBuW35X
	 gxiHQrFtU/PP+NDvhD586PfmvLOc71bnlJAS0tyUNJLNeM3b1a+QHafG1uct3qGgeC
	 AyNDZC6eQFBWQp1O6JTvsuirt08Vr+DJVTdGWslII5OpB62srTUFC/Ue3+05JODGGN
	 ZUHs25oM4sZh/+3h6s/X5hTbcIxmQS57QGOfzkCwBZQejF4KROYn9No29ubTZKj2y1
	 RQtdbK0MDFkig==
Date: Tue, 2 Apr 2024 21:48:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402184832.GO11187@unreal>
References: <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>

On Tue, Apr 02, 2024 at 05:32:44PM +0100, Edward Cree wrote:
> On 26/03/2024 14:57, David Ahern wrote:
> > The proposal is an attempt at a common interface and common tooling to a
> > degree but independent of any specific subsystem of which many are
> > supported by the device.
> 
> [ Let me prefix this by noting that I'm speaking personally here, and
>   not representing the position of my employer. ]

<...>

>  you're getting maintainer pushback.

May I suggest you to take a short break, collect names of people who
participated in this discussion and check in git history/MAINTAINERS
file their contribution to the linux kernel?

After you do that, try to ask yourself if your response is still appropriate.

Thanks.

> 
> Do we need to go all the way back to operating systems 101 and point out
>  that one of the fundamental jobs of a kernel is to *abstract* the
>  hardware, and provide *services* to userspace rather than mere devices?
> 
> Frankly, this whole thread reads to me like certain vendors whining that
>  they weren't expecting to have to get their new features *reviewed* by
>  upstream — possibly they thought devlink params would just get rubber-
>  stamped — and now they're finding that the kernel's quality standards
>  still apply.
> Complaining that devlink params "don't scale" is disingenuous.  Patches
>  aren't languishing for want of reviewer resources; it's just that it
>  takes *submitter* time and effort to bring them up to the quality level
>  that's required, and occasionally the vendor has to (shock! horror!)
>  tell the world what one of their magic knobs actually *does*.
> 
> If all the configuration of these Complex Devices™ goes through fwctl
>  backdoors, where exactly is anyone going to discover the commonalities
>  to underlie the generic interfaces of the next generation?  What would
>  configuring plain vanilla netdevs be like today if, instead of a set of
>  well-defined cross-vendor APIs, ethtool (say) had been a mechanism to
>  write arbitrary values to hardware registers on the NIC?
> These commonalities are key to allowing a product category to mature.  I
>  realise vendors in many cases don't want that to happen, because mature
>  products are largely commoditised and thus don't command huge margins;
>  but Linux isn't here to serve vendors' interests at the expense of
>  users.
> 
> On 23/03/2024 01:27, Saeed Mahameed wrote:
> > It is obvious to everyone that in the AI era, everyone needs
> > customization
> 
> It's always possible to argue that the New Thing is qualitatively
>  different from anything that went before, that these "multibillion
>  gate devices" need to be able to break the rules.
> But the truth is, you aren't that special.
> 
> -e

