Return-Path: <linux-kernel+bounces-1264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ABB814C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA71C2398A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF73BB53;
	Fri, 15 Dec 2023 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kaIDu23v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437F3BB35
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6473EC433C7;
	Fri, 15 Dec 2023 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702656640;
	bh=sPDbMX45qE3aG47Wc5EgbyBMNnm7PcXQ2gS1xKj3cyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaIDu23vT5XDbOfdWU8bkKYWls9TpTfpUFKVLg2zKzTOOJGdfyr8B0vjkM7s3Spq5
	 rI2ShCctUh7k+CPs91koVeG2riysP3SvEo4ZdR9QYofgrBCFfO+3+F48xNPHm4/cRy
	 OaJBx4blXfQiSfUrgQMrV70xTOrBP9YQs0Rw0U7M=
Date: Fri, 15 Dec 2023 17:10:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cdx: Enable COMPILE_TEST
Message-ID: <2023121509-snuggle-lagged-1365@gregkh>
References: <20231207163128.2707993-1-robh@kernel.org>
 <2023121551-uncommon-negation-fdda@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121551-uncommon-negation-fdda@gregkh>

On Fri, Dec 15, 2023 at 05:09:15PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 07, 2023 at 10:31:26AM -0600, Rob Herring wrote:
> > There is no reason CDX needs to depend on ARM64 other than limiting
> > visibility. So let's also enable building with COMPILE_TEST.
> > 
> > The CONFIG_OF dependency is redundant as ARM64 always enables it and all
> > the DT functions have empty stubs.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/cdx/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> > index a08958485e31..7cdb7c414453 100644
> > --- a/drivers/cdx/Kconfig
> > +++ b/drivers/cdx/Kconfig
> > @@ -7,7 +7,7 @@
> >  
> >  config CDX_BUS
> >  	bool "CDX Bus driver"
> > -	depends on OF && ARM64
> > +	depends on ARM64 || COMPILE_TEST
> 
> Ok, good start, now we need to turn this into a module, what's keeping
> it from being able to be built as a tristate?

To answer my own question, the following errors:

ERROR: modpost: missing MODULE_LICENSE() in drivers/cdx/cdx.o
ERROR: modpost: "iommu_device_unuse_default_domain" [drivers/cdx/cdx.ko] undefined!
ERROR: modpost: "iommu_device_use_default_domain" [drivers/cdx/cdx.ko] undefined!

Would be great for someone to fix this up...

thanks,

greg k-h

