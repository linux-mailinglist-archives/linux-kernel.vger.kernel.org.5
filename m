Return-Path: <linux-kernel+bounces-63973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5385371C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717E31C24901
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE65FDCA;
	Tue, 13 Feb 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K85XESiv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64F5FBAB;
	Tue, 13 Feb 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844757; cv=none; b=dOZwZE8LNiTtSHEQr7aE2tfpkvaAx1LWUUj1Dk/0N/7odjwc7n2WKdGuwKPOcifn70mRmZwGFpe0ZM+bvnIM/GFxNVG67NvRWKyx6xlXegQDFFAnKjVXuiFuABk6f54gi1iqP255q2uOskj+Q6HQa1TwaC8qP6y23Wl0mATRo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844757; c=relaxed/simple;
	bh=R/B40q9CR1/8RE3F5SfXeRo7pDhszA/djBNLhnRhU8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlCcM5KxMx32AgOMIIY+K2RiFkafkz5MUA12v0okzgB7rxdh12L7dGT6Uh3UicLlwD4s+AWxUS4+urBdZodO783Frv7NuKR0SX740OC1+pdIUWnQt5QJRBq6cMycQF7Unc9QEfCZVdic4yt8sKTedLpITIQ9cgJksKQ0uQ+Vncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K85XESiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62108C433F1;
	Tue, 13 Feb 2024 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707844757;
	bh=R/B40q9CR1/8RE3F5SfXeRo7pDhszA/djBNLhnRhU8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K85XESiv7C47l3z1V3SZKplk1fWQ1VqiGUTwBuk2tMkNZtCI+MW9b5ugtQDEJ/lbG
	 GlYnDR0TFMcciYKYP6jMjrWxA93h84VzSAPzuFNwpr390Jdl3nmEwP6pdgX+y3MBj/
	 nEe6fNZG+47+io+ke0XKekodgRzxv6z4N41CFrSoM2MXVwbynu1wRLlx3tGNzNonpZ
	 Kj5bT/e+hY2iqoocVxojDP6m+wYT/hgvHx4FFGkbvNdEDOvnNMucxGor9XFIYR2o31
	 ewDTM5jmWLvCvPxEfs1tg8Pk5khAXJykFGi30mScSt/HHcooeNo+2ey8pTIgwivDIF
	 O19xRuLzqppvA==
Date: Tue, 13 Feb 2024 18:19:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andrey Melnikov <temnota.am@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlemoal@kernel.org,
	hdegoede@redhat.com
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
Message-ID: <Zcukjucb4VEbKK9x@x1-carbon>
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

Hello Andrey,

do you intend to send out a v2 that uses a switch instead?

And perhaps take Damien's patch as patch 1/2
(with Suggested-by: Damien ... of course),
so that the before/after print in your commit message shows
the override value.


Kind regards,
Niklas

