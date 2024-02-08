Return-Path: <linux-kernel+bounces-57625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53884DB8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EA52881A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCFE692E6;
	Thu,  8 Feb 2024 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TekFmZBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56A2AD0F;
	Thu,  8 Feb 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381459; cv=none; b=H1FJwCI1jq1+fpcLFHV1oGoBrMTGudq9tLwUuGZO31RWMm16ijoe6RHfzDqneCc6WZzWWcwEF9FMaZmy+6vJhoA6daWZQUomT6hqnqIrAvoJ7D2qxjaVRVic5cwdqIFWl7dB6HUFdg7aR+7DhR4Pb1fBZQgXF9AG4EXNx+ScgA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381459; c=relaxed/simple;
	bh=b5gZnmEnZGLQKphN0ZRBk6/TZwqmzHAkM/DeYXqpe80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM3oAYTm8Uz3ZCzlsEW9BiUQ+fKsRPFbNNCbEfCCiyLmeB7A5SrV3fx8oC+NJrncHpAE8krm34+k244TDI1WdG43Zf0OAZm5eBbmTGIZ1lj2G5QbhKb9tr/R02+oWDg2P0NVlKHB9HmXUGX2lw+DJQPJmmZGrQeOKUaBEg+jkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TekFmZBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A8C43390;
	Thu,  8 Feb 2024 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381459;
	bh=b5gZnmEnZGLQKphN0ZRBk6/TZwqmzHAkM/DeYXqpe80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TekFmZBfEX0YmnErNWGdsnIhI0d13mC+i+IInYe8vsAzT0zR7Ox1Mxs3xM9CDeuYz
	 NCaIz5ZwBF59txD0H7ZZiQI8GP9LXzEgeSQobE46TxcK3FVlFfpl70UlCwVMkJeC0p
	 /x4zcPjlNaWZxJmIZxcJcG+aI7kqCFMJ87wsZ8J10Q4Zp1suDBrvjFQ/nvNhWKuKLk
	 XUwtSvVGlxc03I4S7JnXczFVJ0WKiz8MSqlKADrrK6/NpyyB8kupSGnP8wT5nBNcbT
	 JOMH8a4MmI6hM2k4FwvXb7VlzfUfM6krLNEzg6bZC/RUwfqLVCiV5bdoI8be7I+pQa
	 L9QPBZnMfypfw==
Date: Thu, 8 Feb 2024 09:37:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andrey Melnikov <temnota.am@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlemoal@kernel.org,
	hdegoede@redhat.com
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
Message-ID: <ZcSSzDI2qL3LSQvr@x1-carbon>
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
 <7559d940-f191-4fe0-e147-17ffa6c1dfc4@gmail.com>
 <CA+PODjpOE=LGPi1G1ebvEwGeXAfpuZ+s_k4uMUwu3i6st9y--g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PODjpOE=LGPi1G1ebvEwGeXAfpuZ+s_k4uMUwu3i6st9y--g@mail.gmail.com>

Hello Serge, Andrey,

On Thu, Feb 08, 2024 at 10:27:11AM +0300, Andrey Melnikov wrote:
> > On 2/7/24 12:58 PM, Andrey Jr. Melnikov wrote:
> >
> > > The ASM1064 SATA host controller always reports wrongly,
> > > that it has 24 ports. But in reality, it only has four ports.
> > >
> > > before:
> > > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> > > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> > >
> > > after:
> > > ahci 0000:04:00.0: ASM1064 has only four ports
> > > ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> > > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
> > > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> > >
> > >
> > > Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> > >
> > > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > > index da2e74fce2d9..ec30d8330d16 100644
> > > --- a/drivers/ata/ahci.c
> > > +++ b/drivers/ata/ahci.c
> > > @@ -671,9 +671,14 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
> > >  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
> > >                                        struct ahci_host_priv *hpriv)
> > >  {
> > > -     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
> > > -             dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> > > -             hpriv->saved_port_map = 0x3f;
> > > +     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> > > +             if (pdev->device == 0x1166) {
> >
> >    Maybe *switch* instead?
> 
> Ok.
> Can someone explain to me - which method I should use here - override
> portmap via hpriv->saved_port_map or mask it via hpriv->mask_port_map
> ?

Serge, you seem to be the last person to touch this in
commit 88589772e80c ("ata: libahci: Discard redundant force_port_map
parameter"), where you removed force_port_map, so you are already
familiar with this code.

From my quick look, it looks like mask_port_map is used to disable one or
more ports from the port_map.

But do you know if there is a reason why platforms that need to do that
can't just change saved_port map directly?


Kind regards,
Niklas

