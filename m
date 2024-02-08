Return-Path: <linux-kernel+bounces-58021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A684E051
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDA01F2E01F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823DA6F535;
	Thu,  8 Feb 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CslA+hOd"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD86E2B3;
	Thu,  8 Feb 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393888; cv=none; b=JirCvfdXc+U28Ur56qw8rbXMrxnSZj4r9tqmRfeEZCTaK1tG+igNFGe6X6GXAhwJiZRsRAZ4bKKFx/99DhLI84HagodGGVwPjahIXO3oUwPJfO242j9d6+86B1tslchVKCJWLFZQlybtufpbclrvF5i7+oNDm4BiXC1HjzKn5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393888; c=relaxed/simple;
	bh=hb449Ho5oQwZ/CAXVghNPHUSQ5nwpa3g/EF0X0oC1IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FC3qN6xLMHkIddfIj7iabrgwtLBBGD+dnrG+PRZMtNLJVtfCkw95lwxZBxRwZw/bd00bIsaL1Jpj1snqiVPbCXeY1pz777RSKSN5uJr0KFmHbz3Q78c/LAUIYNvhVXvP4OEBo+JnZCzLD3bkxK91NrLJqeZZenRtAG2rALx5L8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CslA+hOd; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3beab443a63so1210482b6e.3;
        Thu, 08 Feb 2024 04:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707393886; x=1707998686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dym7YOFYPe9uA2peOh1YfvXFFiPfyy6wB1LmCQQC+qU=;
        b=CslA+hOdIat9QMAGilvBFX/9x8uK+4Bo5a1x36RXb1Hq6s1cHzYLW6uyNV5Nf2YAbW
         HSj1uzaiN/l/moC41cghpX+v7YVJCkMI+s/SRGqaDgbOArhucHrk7c22NbRKPnPgyHDD
         DoWjeHeG8CqR3avnOTRTHE44RGBH7bGfnjmb0KnbJMgRNbUHcOVdyE/b9y3IJlcLvY3O
         b5KZ7g22Q/S9a8GySHdk7xRI+B6G8OuTxPcimLk2PbqkO/UUA19GfPNRpsJIhIQSgEeX
         XS9X47NZIAmicVxDLtnblu7i3cKHzhzHHSltHPTcwEcJKMw5Ei5YpR37h4ddQGr1tmpD
         YkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707393886; x=1707998686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dym7YOFYPe9uA2peOh1YfvXFFiPfyy6wB1LmCQQC+qU=;
        b=s8q8lUqphB63vb4a5KFWz9Ry8rQLM2qhcnsUD6deX2Zy8QzIIYbCilNvtxC9aRHCwo
         ZvkacOZEBatXZALjXlE6cIz/3P+vPevwXVXhrWvY2URyRqBI2f3RPR6GcagaVgunriZa
         cdZfjHBQjm5m0+5BfO5CEfyVEseqXoZ8v3Cbd6PyKskq8bOJBkKYHp+Apv4JJj7zi0tv
         WOIMO1OTK4e4IOwXZdTi4k4tJdEdIDG2XNbmeUzyANn00WONGzAA6ibFZhHd7Cw4XlXu
         N5ks2mM9ky/RZuJS7Pcvyp66fmoofeJxWSSR1nuG9d43z9yJ3EkhOcLap3cHDf2z1UcB
         VR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXecGkEv5aaUkZZsyA+AAKbUIhD8iroWrvUF2AbrlnH9jgJrO00A3lwRQqyVgnaUZcJrLImKor7vNIkbcTsEd0eZ4Ici7Oz+1X0cQm8FRQmGbPDJ3dbpzWq/ju8Tx0P/wbd9trUW9PQ
X-Gm-Message-State: AOJu0YyYw1MzNBqRMMVdKKrtoPvAx1o1vx3sEX28SufLDgc5ONY86EK9
	uijCHAnV5rwZ/pdPddKELdbEcospXeNbLIVFPMBNd5gi1kBlEjm6e//U8lJ6qKMySdWySFSR2t0
	wiyYA76K40dBfuZIrxkF+qllXJow=
X-Google-Smtp-Source: AGHT+IHKyES6KmPf+Rgk1Hlq0aKd3vvc9CupFSUiG4sdZLOyzU+Bk69uBF/abiXOyqFvgA+wfdcNErpgGBoGKW3e3sc=
X-Received: by 2002:a05:6808:f0d:b0:3bf:efd2:b852 with SMTP id
 m13-20020a0568080f0d00b003bfefd2b852mr3670560oiw.36.1707393886101; Thu, 08
 Feb 2024 04:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
 <7559d940-f191-4fe0-e147-17ffa6c1dfc4@gmail.com> <CA+PODjpOE=LGPi1G1ebvEwGeXAfpuZ+s_k4uMUwu3i6st9y--g@mail.gmail.com>
 <ZcSSzDI2qL3LSQvr@x1-carbon>
In-Reply-To: <ZcSSzDI2qL3LSQvr@x1-carbon>
From: Andrey Melnikov <temnota.am@gmail.com>
Date: Thu, 8 Feb 2024 15:04:33 +0300
Message-ID: <CA+PODjqTwko0+2cw227OpcLzP7DD3CouU26jQ=j-MirSHFEGEg@mail.gmail.com>
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
To: Niklas Cassel <cassel@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, Sergei Shtylyov <sergei.shtylyov@gmail.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, dlemoal@kernel.org, 
	hdegoede@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello.

> Hello Serge, Andrey,
>
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
> > Can someone explain to me - which method I should use here - override
> > portmap via hpriv->saved_port_map or mask it via hpriv->mask_port_map
> > ?
>
> Serge, you seem to be the last person to touch this in
> commit 88589772e80c ("ata: libahci: Discard redundant force_port_map
> parameter"), where you removed force_port_map, so you are already
> familiar with this code.
>
> From my quick look, it looks like mask_port_map is used to disable one or
> more ports from the port_map.
>
> But do you know if there is a reason why platforms that need to do that
> can't just change saved_port map directly?

Well, after deep dive into git history - initially, overriding
port_map introduced by commits
d799e083a80b220f3681d7790f11e77d1704022b (jmb361 workaround) and
cd70c26617f4686355263be4533ce8030242740e (marvel 6145 support), both
override port mapping, but in different ways - first set to 1, second
- apply masks. Logically - port_map = 1 and port_map &= 1 - are the
same.
Later, in commit 394d6e535f15c6f2d3c7fe2e228ee595acf0648c this two
hacks moved around, and setting port_map splitted into two ways - set
it directly via force_port_map (jmb361 workaround) and apply mask via
mask_port_map (marvel 6145 hack).
And now, we have two knobs which do the same! After that, commit
566d1827df2ef0cbe921d3d6946ac3007b1a6938 add checking AHCI version
(yet another SATA glitches workaround, user report [1] shows 8 port
and bitmask 0xff - 32 ports)  and this break updating saved_port_map
for AHCI >= 1.3. Later, commit
2fd0f46cb1b82587c7ae4a616d69057fb9bd0af7 fix saving port_map again,
and now overriding port_map completely splitted. saved_port_map is
really saved (and written back to HOST_PORTS_IMPL register on
saved_port map()) for all AHCI versions, mask_port_map is applied and
not updated saved_port_map.

1. https://lists.openwall.net/linux-kernel/2016/01/13/171

