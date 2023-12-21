Return-Path: <linux-kernel+bounces-7976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF481AFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2981F22A44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B615ADF;
	Thu, 21 Dec 2023 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrsOSS6O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9C156DA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC591C433C8;
	Thu, 21 Dec 2023 08:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703146052;
	bh=Mj6bwpLgKCMRAIM7uI/538+bBUU8/byG9V0NRZN50Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrsOSS6OEFI2QV4od2rUU31B2tzoPP+upoNHYQOVHtBT3DsIiAM4yHVYyLSYO16vn
	 cpaYFBrwjTnmqMfMsEtCi+z0bN0Bwk2brPErUcrvlYIDmk8Z7vL8Ep3ou/X4REGTO0
	 rOY9ABN6Tn4M5n56aGxJc6JcmOZRePs5eFLMSWNQ=
Date: Thu, 21 Dec 2023 09:07:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
Cc: "Gupta, Nipun" <Nipun.Gupta@amd.com>,
	"Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] cdx: Enable COMPILE_TEST
Message-ID: <2023122142-huff-closure-d5d4@gregkh>
References: <20231207163128.2707993-1-robh@kernel.org>
 <2023121551-uncommon-negation-fdda@gregkh>
 <2023121509-snuggle-lagged-1365@gregkh>
 <DM4PR12MB77656006A8A6EB5DE6A468038F95A@DM4PR12MB7765.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB77656006A8A6EB5DE6A468038F95A@DM4PR12MB7765.namprd12.prod.outlook.com>

On Thu, Dec 21, 2023 at 06:42:29AM +0000, Gangurde, Abhijit wrote:
> > > On Thu, Dec 07, 2023 at 10:31:26AM -0600, Rob Herring wrote:
> > > > There is no reason CDX needs to depend on ARM64 other than limiting
> > > > visibility. So let's also enable building with COMPILE_TEST.
> > > >
> > > > The CONFIG_OF dependency is redundant as ARM64 always enables it and
> > all
> > > > the DT functions have empty stubs.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  drivers/cdx/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> > > > index a08958485e31..7cdb7c414453 100644
> > > > --- a/drivers/cdx/Kconfig
> > > > +++ b/drivers/cdx/Kconfig
> > > > @@ -7,7 +7,7 @@
> > > >
> > > >  config CDX_BUS
> > > >  	bool "CDX Bus driver"
> > > > -	depends on OF && ARM64
> > > > +	depends on ARM64 || COMPILE_TEST
> > >
> > > Ok, good start, now we need to turn this into a module, what's keeping
> > > it from being able to be built as a tristate?
> > 
> > To answer my own question, the following errors:
> > 
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/cdx/cdx.o
> > ERROR: modpost: "iommu_device_unuse_default_domain"
> > [drivers/cdx/cdx.ko] undefined!
> > ERROR: modpost: "iommu_device_use_default_domain" [drivers/cdx/cdx.ko]
> > undefined!
> > 
> > Would be great for someone to fix this up...
> 
> I did look at this code. There are 2 issues here for it to be a module.
> 1. There are many symbols in iommu, msi and other module which are not exported.
> Most of other busses like amba, fslmc, pci are bool only.

I only see 2 symbols here, what other ones do you see?

> 2. As of now, iommu has static list on bus types (static struct bus_type * const iommu_buses[])
>  which is initializes the notifier at init time. So, if we change cdx bus to be a module
> cdx devices would miss these mappings.

That static bus list needs to be fixed up eventually anyway as we are
moving all bus structures to read-only-memory.  So it's on my todo
list...

Anyway, for now this is ok, but ideally if possible, and if you all want
more build testing, it should be made a module.

thanks,

greg k-h

