Return-Path: <linux-kernel+bounces-131968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640D898E0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD10F1F2BA04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DA1332A1;
	Thu,  4 Apr 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pha4B60D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82451327FD;
	Thu,  4 Apr 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255745; cv=none; b=ba0t0QesFw4oIaeVLWXjAs2+RG4GuXPIxDFrIZ/xVAwBklQ6DrrpO4SGGASbPc0o+cC/JtRHHkRgsqpMuaLO56gWl4mBKAgNRFiAE8nnGG9sar1l6QYXKlWXMBOcxVX/iFPGnFeohyajwmmtDMpxvi22P1lcQiwE2g1ciPldK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255745; c=relaxed/simple;
	bh=D5doStes5LbDvIj5OW/qOmZxpIoPwQ/5pyTQVs/kqTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJiEEbbJsLGyr5YFblxTy9LNFCAs0Jacf5rKIeZggTOPOvoi19gPgc8l/Q38fGoJlIIOGqHe6mVxD4HevSvSOCQYUcVhjIWdKlUWgJw+lEhn/tp8w8qzVNmXEzTC7frIckCtHEfUJ0mFqAPbXsEnDCY2MD1db79pEgNnDpTZxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pha4B60D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67903C433F1;
	Thu,  4 Apr 2024 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712255745;
	bh=D5doStes5LbDvIj5OW/qOmZxpIoPwQ/5pyTQVs/kqTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pha4B60D0m27PsZaGvvJLi2KhZWTl0mLjUrg4k2TtT/UyLw2H53c9501PX5z6j5wk
	 oy5zZGtvA/zBA4X2vNT4IgJ2Tbm6CHxx5WzI6JMswDGbzrz2YweJL3sQ+KXBcpQF1p
	 nxH+jEemSF7NLsK+WWKVpgVWgRmBD1xDQX3Oembysvf7B4BraO1jPGQAS/phWXS+Yh
	 JuJapJYAIWp7hFI0qjiPMiXh/6j9iCqFg/4licHVkXc9193Ul1dHNV/7Z5Q7VPQeuH
	 H2ByAxUDkjBeJZb7jHlElBs1WFB1NIb+Pqh0SR6bLxXJ1p5+I5jLZW4tEY6kBNkvte
	 XpA6lkalRzmeQ==
Date: Thu, 4 Apr 2024 21:35:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20240404183540.GX11187@unreal>
References: <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org>
 <20240404122338.GI1723999@nvidia.com>
 <20240404074850.19ecd52e@kernel.org>
 <20240404174728.GL1723999@nvidia.com>
 <d0b11055-1804-515b-7916-cb83a6274955@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b11055-1804-515b-7916-cb83a6274955@gmail.com>

On Thu, Apr 04, 2024 at 07:06:53PM +0100, Edward Cree wrote:
> #include <disclaimer.h>
> 
> On 04/04/2024 18:47, Jason Gunthorpe wrote:
> > The configurables exist as they are
> > and need to be supported, in one way or another, by the kernel.
> 
> Why?  What does the kernel get out of it?
> 
> Maybe *you* need them to be supported, but maybe you should have
>  thought of that earlier in the design process.  ("A failure on
>  your part to foresee the eminently foreseeable does not
>  constitute an emergency on mine.")
> If we let folks bypass our standards with a _fait accompli_, we
>  don't really have standards in the first place.

Sorry, who are "we" and what are "our standards"?

And, please, please reread the thread, it is not about devlink at all.

Thanks

