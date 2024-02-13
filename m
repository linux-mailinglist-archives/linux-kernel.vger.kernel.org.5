Return-Path: <linux-kernel+bounces-64052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53285396D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3121D1F21A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3B604CE;
	Tue, 13 Feb 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAFheBoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247E604DC;
	Tue, 13 Feb 2024 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847543; cv=none; b=KnlmYKlYkgEoLO3sCHknN5PZoLBM6T95aDXiD/lr/BBUl5bBC4mAY37Ocnb9J5J4uowz9xwmAmiqFDpMhrgonFH/fSevYIlVqu82uPrjsx3/t9YONv5ZmU1nMfViofUIJTmVkxVCEUZa3ME2wJ+5RXdz83NaqH93p6mZpAxTrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847543; c=relaxed/simple;
	bh=HecSXPlQazpI+9KpIYoNGJ1ZcXO0NHDiFgEImC6uQ2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYSq6wPvYFsq8csxIU4a8qcsEeo5SbW3lX5tPCNNuaUyFP3QIqfTL1XxnrZmp+QzmvIQNVX2fUpgqqQnP8bYH+N/JyZosRwfhFMuGSqPsWcenGprULdO4naoTZUfWtDautA/dPk7POL6+I9nwQ9YuFGvcddPuV/EiKoRShSyi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAFheBoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE02C433C7;
	Tue, 13 Feb 2024 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847542;
	bh=HecSXPlQazpI+9KpIYoNGJ1ZcXO0NHDiFgEImC6uQ2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAFheBoj/bKBHs+d5nKtlNnbX/F+Igl4YMdrKR8fk3GLrIwe/Gep4mdlOLQUz5ElE
	 BJGSBW7He4mRVX5nKqjh+IFiWFde5QGSSReElAQuLLH67ge3eZ1c3aJVn1Wwdm6fxA
	 HIrfqCcOpG+i8iQJETlO2aGFr7KLJISHDBOWTPmkylUx71GR0BwUN9Q1OImHR+JOk5
	 lklOMu8Jrm8mAOnpXB6jcjmJOA3AmguWMUnWlgno6MpmqXHfNo4EJ2xggReAblqbSK
	 ATLJO5iyLtpv+j+caroAUgitrVfYoy6ZE8gBjazY1JdPtw2+DcDiUuHxCXKQx6S4en
	 1cYCYg+EA4QkQ==
Date: Tue, 13 Feb 2024 19:05:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andrey Melnikov <temnota.am@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlemoal@kernel.org,
	hdegoede@redhat.com
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
Message-ID: <Zcuvbzoo7/7c/F1q@x1-carbon>
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
 <7559d940-f191-4fe0-e147-17ffa6c1dfc4@gmail.com>
 <CA+PODjpOE=LGPi1G1ebvEwGeXAfpuZ+s_k4uMUwu3i6st9y--g@mail.gmail.com>
 <Zcukjucb4VEbKK9x@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcukjucb4VEbKK9x@x1-carbon>

On Tue, Feb 13, 2024 at 06:19:10PM +0100, Niklas Cassel wrote:
> On Thu, Feb 08, 2024 at 10:27:11AM +0300, Andrey Melnikov wrote:
> > > On 2/7/24 12:58 PM, Andrey Jr. Melnikov wrote:
> > >
> > > > The ASM1064 SATA host controller always reports wrongly,
> > > > that it has 24 ports. But in reality, it only has four ports.
> > > >
> > > > before:
> > > > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > > > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> > > > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> > > >
> > > > after:
> > > > ahci 0000:04:00.0: ASM1064 has only four ports
> > > > ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> > > > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > > > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
> > > > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> > > >
> > > >
> > > > Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> > > >
> > > > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > > > index da2e74fce2d9..ec30d8330d16 100644
> > > > --- a/drivers/ata/ahci.c
> > > > +++ b/drivers/ata/ahci.c
> > > > @@ -671,9 +671,14 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
> > > >  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
> > > >                                        struct ahci_host_priv *hpriv)
> > > >  {
> > > > -     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
> > > > -             dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> > > > -             hpriv->saved_port_map = 0x3f;
> > > > +     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> > > > +             if (pdev->device == 0x1166) {
> > >
> > >    Maybe *switch* instead?
> > 
> > Ok.
> 
> Hello Andrey,
> 
> do you intend to send out a v2 that uses a switch instead?
> 
> And perhaps take Damien's patch as patch 1/2
> (with Suggested-by: Damien ... of course),
> so that the before/after print in your commit message shows
> the override value.

On second thought, just go ahead and respin your patch using a switch,
as I don't think Damien's patch is fully correct.

He suggested to use hpriv->saved_port_map.

However, that will show the wrong result for platforms using
hpriv->mask_port_map.

As when hpriv->mask_port_map is used, saved_port_map is not set:
https://github.com/torvalds/linux/blob/v6.8-rc4/drivers/ata/libahci.c#L536-L548

However, the local variable "port_map" is updated for both
saved_port_map and mask_port_map cases.

And then at the end:
hpriv->port_map = port_map;
https://github.com/torvalds/linux/blob/v6.8-rc4/drivers/ata/libahci.c#L597

So I think we should print hpriv->port_map,
and not hpriv->saved_port_map.



However.. hpriv->port_map is already printed:
https://github.com/torvalds/linux/blob/v6.8-rc4/drivers/ata/libahci.c#L2617
in the "0x%x impl" print.

So
> before:
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode

> after:
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode

Actually prints the number of *implemented* ports.


I have to admit that this is a bit confusing.

Personally I would have preferred if we simply printed
"%u ports", hpriv->port_map,

and simply dropped the "0x%x impl" part of the print,
but I'm a bit worried that someone parses this print from user space,
but I guess we must be allowed to improve prints if they are confusing.

Damien, what do you think?


Kind regards,
Niklas

