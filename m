Return-Path: <linux-kernel+bounces-27172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383682EB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA50728254A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328D12B7D;
	Tue, 16 Jan 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zyxRF1/e"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AE12B66
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wsCbjUQ2hR0h4kZ3MX+VBUPxl0Ia2lfkvP41cApAIiI=; b=zyxRF1/eGlPVxACpktDZP2ZAZW
	GiVBzc8zSYgDavUz97u6dz/z/ayLLRZHaUNIb7oO87f/HKIGVvDfkF80cWotblbgSRdBsPdhDm1WH
	VkJfePn/OxLqEGHlbmV5KzotUIKd1IqXfgA4ROymqvlv/J7IYdnTG6GsFNO7Y8lc5+U/0KohWYgIc
	npwfkiGYaq77szrdBFaGjevD9V/mmCcApryqUqc0PfFPdSEeMkpzmKEL2e0Bc2JRC/NV7o11sL/9b
	fiYiv97W0eAgwgrtdTSkv1ZzHYGB1BmxVtidThQwYofSfIkNlz2W6xhPxaGWYvIft3PFS5et27HSh
	TyiBe4kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPfkZ-0003Ff-08;
	Tue, 16 Jan 2024 09:28:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPfkV-0003ll-0W; Tue, 16 Jan 2024 09:28:47 +0000
Date: Tue, 16 Jan 2024 09:28:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Valentin.Schneider@arm.com,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Matteo Carlini <Matteo.Carlini@arm.com>, akpm@linux-foundation.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZaZMTn62DI+2ygyb@shell.armlinux.org.uk>
References: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
 <ZaVRlHpAOoNIiRiY@shell.armlinux.org.uk>
 <f84f3e60-e71a-4ea4-8c9c-86fd915129a9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f84f3e60-e71a-4ea4-8c9c-86fd915129a9@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 16, 2024 at 03:10:26PM +0800, Kefeng Wang wrote:
> On 2024/1/15 23:39, Russell King (Oracle) wrote:
> > On Thu, Dec 14, 2023 at 04:05:56PM -0800, Christoph Lameter (Ampere) wrote:
> > > Index: linux/arch/arm64/Kconfig
> > > ===================================================================
> > > --- linux.orig/arch/arm64/Kconfig
> > > +++ linux/arch/arm64/Kconfig
> > > @@ -1407,7 +1407,21 @@ config SCHED_SMT
> > >    config NR_CPUS
> > >    	int "Maximum number of CPUs (2-4096)"
> > >    	range 2 4096
> > 
> > I think your mailer got to your patch and messed up the white space.
> > There are two spaces before each of these lines rather than the usual
> > one.
> > 
> > > -	default "256"
> > > +	default 512
> > > +
> > > +#
> > > +# Determines the placement of cpumasks.
> > > +#
> > > +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
> > > +# Useful for machines with lots of core because it avoids increasing
> > > +# the size of many of the data structures in the kernel.
> > > +#
> > > +# If this is off then the cpumasks have a static sizes and are
> > > +# embedded within data structures.
> > > +#
> > > +config CPUMASK_OFFSTACK
> > > +	def_bool y
> > > +	depends on NR_CPUS > 256
> > 
> > Should that be ">= 256" ?
> 
> Maybe just select CPUMASK_OFFSTACK if NR_CPUS >= 256,
> 
> 
> But could we just make CPUMASK_OFFSTACK configurable and let user/distro
> to enable it?
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5ddda7c2ed9b..4254be5aa843 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -535,7 +535,9 @@ config CHECK_SIGNATURE
>         bool
> 
>  config CPUMASK_OFFSTACK
> -       bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
> +       bool "Force CPU masks off stack"
> +       depends on SMP
> +       default n

Please. No.

There is no point in defining a default of n. The default default is n.
Therefore, specifying a default of n is utterly redundant as the option
will still default to n and just adds clutter to Kconfig files.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

