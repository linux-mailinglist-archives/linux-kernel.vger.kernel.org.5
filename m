Return-Path: <linux-kernel+bounces-67138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD078566EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB811F2300E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8E13249C;
	Thu, 15 Feb 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSb2wHlf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8510613AF0;
	Thu, 15 Feb 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009691; cv=none; b=PVGPfL8ZhabEVNcGln61pbvZqc4vXVebNpsSX2B9hRBTWfuT9a+bmd8w1gQ1JGYkX09GWTrLbdyrmCUsVsSavTExKUIoSFnJKoTmppyWKSkpiIKjEgVLfHWva9IlQ+wgNv0f9ZtOyOBBYLYWfGrGZjpooekPjXtCdkcqR0fh75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009691; c=relaxed/simple;
	bh=nneF9xSwpmvvSrQTIwVRr6WPxaypX0oRVP9xZNFAWJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne6f2ldFqQTRwtWYEupiD6SDGD3WCaO98Cp4m+frlqckhLOK8erkIQAXGsCAQL3Zo3imlPIWdFoFfYgyqpS1drWau/AvMHjp1TvGzHUIqOimO7BbxCKJTl76cuZZlXGsY8g28kkMHmyG+TRniGkaYXGdn0Ylz+49ijTgXNzEsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSb2wHlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A993C433F1;
	Thu, 15 Feb 2024 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009690;
	bh=nneF9xSwpmvvSrQTIwVRr6WPxaypX0oRVP9xZNFAWJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSb2wHlfmhYR4fsXlhz3741dHPdDL6zxJdrHPh6h73dbvtLM55oPrb02X0JjrsUCU
	 kDr9JlBaYctKAZO3kqdlvn9WBX40Wy1R8DqOf/o1zeE5xtDXp7GQC6kT8RsBbG3orv
	 iOpnaet5A5gHM/RbQCeaTeCnt0V0h9/CxrsYTnDVX75zXYM/M9yjJxymK89zOwdJOo
	 K8I6LRBng85mFDVxq2Hdzr8zuVV3+BnX+jktiXCC3HpWUpgs0uJYwZQhu/pI8DA56T
	 F23qxPHJmwVeb4MpyfKH609w61gx+Sk6+fC3m5/ONrjgvi1WA906eO/ICz443ZEJCV
	 SUMBKbOggdGLg==
Date: Thu, 15 Feb 2024 09:08:07 -0600
From: Rob Herring <robh@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <maz@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of: OF_IRQ: select IRQ_DOMAIN instead of depending on
 it
Message-ID: <20240215150807.GA28377-robh@kernel.org>
References: <20240213225619.11726-1-rdunlap@infradead.org>
 <867cj75q52.wl-maz@kernel.org>
 <c6e55baf-4f0c-4342-971a-713ed55f5a51@app.fastmail.com>
 <8634tv57i2.wl-maz@kernel.org>
 <886629be-a492-4c8c-aa79-d13847cb228a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886629be-a492-4c8c-aa79-d13847cb228a@app.fastmail.com>

On Wed, Feb 14, 2024 at 06:22:53PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 14, 2024, at 17:35, Marc Zyngier wrote:
> > On Wed, 14 Feb 2024 16:06:06 +0000,
> > "Arnd Bergmann" <arnd@arndb.de> wrote:
> >> 
> >> On Wed, Feb 14, 2024, at 10:52, Marc Zyngier wrote:
> >> > On Tue, 13 Feb 2024 22:56:19 +0000, Randy Dunlap <rdunlap@infradead.org> wrote:
> >> >>
> >> >> diff -- a/drivers/of/Kconfig b/drivers/of/Kconfig
> >> >> --- a/drivers/of/Kconfig
> >> >> +++ b/drivers/of/Kconfig
> >> >> @@ -80,7 +80,8 @@ config OF_ADDRESS
> >> >>  
> >> >>  config OF_IRQ
> >> >>  	def_bool y
> >> >> -	depends on !SPARC && IRQ_DOMAIN
> >> >> +	depends on !SPARC
> >> >> +	select IRQ_DOMAIN
> >> > 
> >> >
> >> > This seems to be moving is the right direction.
> >> 
> >> Can we move the 'select IRQ_DOMAIN' under CONFIG_IRQCHIP
> >> then and remove the individual selects from the irqchip
> >> drivers? It looks like CONFIG_OF (other than sparc) now
> >> unconditionally enables OF_IRQ and IRQCHIP anyway.
> >
> > As long as it also works ACPI, it should be OK.
> 
> Out of the four architectures that have ACPI support (x86,
> arm64, loongarch, rv64), only x86 doesn't always select
> IRQ_DOMAIN already, and x86 selects it for almost all
> configs:
> 
> config X86_UP_APIC
>         bool "Local APIC support on uniprocessors" if !PCI_MSI
>         default PCI_MSI
>         depends on X86_32 && !SMP && !X86_32_NON_STANDARD
> 
> config X86_LOCAL_APIC
>         def_bool y
>         depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
>         select IRQ_DOMAIN_HIERARCHY
> 
> so it's only disabled here with
> 
> CONFIG_64BIT=n
> CONFIG_SMP=n
> CONFIG_X86_32_NON_STANDARD=n
> CONFIG_ACPI=y
> CONFIG_PCI=y (implied by ACPI)
> CONFIG_PCI_MSI=n
> 
> As far as I can tell, this specific configuration is
> currently able to save a little bit of kernel size
> by avoiding IRQ_DOMAIN, but we are probably better off
> enabling it here as well for consistency

+1

Also, looks like we have a couple of 'select OF_IRQ' that could be 
dropped.

Rob

