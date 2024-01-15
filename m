Return-Path: <linux-kernel+bounces-26183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6782DC77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88344282769
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD8D1774F;
	Mon, 15 Jan 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XCQfBpQK"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5817743
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vca8iHXjvx6ztiPlpy6hQMT//Mi2gmGf4is7seIfbys=; b=XCQfBpQKZngHjvlBVESIc86brt
	vTkq4l1ip+CFF6LRkAeRRjtdSs/7zrkoDb+havr/JEUNz1IWft0tCbe4EXKR5ZoQu7VSs/zaxOcL3
	qwma/q46xM1fSlh4NVtO6iDvbPgiGDs7MavHEfrgYgFVvSS5cotGRSWZSxeuaL8KBtJtyg7TAN9+T
	xIjd2z+BI1NrTzNZGoIoI7/UsKNdojDw6bJfMfYrrC8TRPRUpqG/vFKRNeAZCKfclQnTP3N3P5skA
	qHi1ym2QciFsSK8seffAg7lg5I/7b7HapWBoZa4j3eNr6+ZvWvsLazUX6HVGA0kRAAbnUYWMOITe3
	8h9Vtp0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53076)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPP3I-0002Wd-2a;
	Mon, 15 Jan 2024 15:39:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPP3E-00033W-BK; Mon, 15 Jan 2024 15:39:00 +0000
Date: Mon, 15 Jan 2024 15:39:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
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
Message-ID: <ZaVRlHpAOoNIiRiY@shell.armlinux.org.uk>
References: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 04:05:56PM -0800, Christoph Lameter (Ampere) wrote:
> Index: linux/arch/arm64/Kconfig
> ===================================================================
> --- linux.orig/arch/arm64/Kconfig
> +++ linux/arch/arm64/Kconfig
> @@ -1407,7 +1407,21 @@ config SCHED_SMT
>   config NR_CPUS
>   	int "Maximum number of CPUs (2-4096)"
>   	range 2 4096

I think your mailer got to your patch and messed up the white space.
There are two spaces before each of these lines rather than the usual
one.

> -	default "256"
> +	default 512
> +
> +#
> +# Determines the placement of cpumasks.
> +#
> +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
> +# Useful for machines with lots of core because it avoids increasing
> +# the size of many of the data structures in the kernel.
> +#
> +# If this is off then the cpumasks have a static sizes and are
> +# embedded within data structures.
> +#
> +config CPUMASK_OFFSTACK
> +	def_bool y
> +	depends on NR_CPUS > 256

Should that be ">= 256" ?

> 
>   config HOTPLUG_CPU
>   	bool "Support for hot-pluggable CPUs"

Same here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

