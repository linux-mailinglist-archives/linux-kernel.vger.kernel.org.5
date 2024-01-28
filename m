Return-Path: <linux-kernel+bounces-41588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D3983F4F9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E0BB21EE4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E711DFC6;
	Sun, 28 Jan 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="f5LNqP6m"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF11EB23;
	Sun, 28 Jan 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706437799; cv=none; b=EZp/1cRZ8PkraJrgndb3/iNqDofcBF57TyZi+4DLauS7gsETprNI6YM9K4zHtJqYmhbmQFB1oZpcCNY92DGCpAAAYcRNHxVXzUi4I16GnvQMFoQf/0yFkaes1r4v/W02D0G4DTmPG0h/mfksInWbPkEhKL1H3Nsqv9Yx6DtXHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706437799; c=relaxed/simple;
	bh=5rF8LoO+tyQ83knbEjawZi7tXkhPE9yqcUuV6GRhvZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cblTGd0kWU8Gk8NbmoU8D+8KcR6EGX8/HXEaTK+/fViOE9Uf1wceV5I8mdk45YPOpp3zsCc9mwOjGOxZonGK5tYByNqha5eO2F4rB4UPCwDNDjcTjZ+5bzQdgK+YdJzksqLRS81yw8hctW3sRDVZc9HK46NehQWr2b+n0jZiCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=f5LNqP6m; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706437785; x=1707042585; i=erick.archer@gmx.com;
	bh=5rF8LoO+tyQ83knbEjawZi7tXkhPE9yqcUuV6GRhvZY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=f5LNqP6mmxF9MfqjweX5YmzCesuLn7rawarp/tHROWZdBgS5wxQlScV5+Tp/kxDa
	 Dphkd0ecmogABQqACYLrejBlRNL9WcdrLg02Mr0rj4W7GHgsVKzO7k84TdK/0oq2L
	 1wxvqKRXlymwZsuv689TSVF5bNuHSUdEDFjtdk1B0MYoVH1IMnOw8zuCWOJjVsamZ
	 BFbpPBggCDkGs8jOXIFA6r38mwzt+NCWV6vi4zcNwqB33R8bR7fXfdi51H/Bov+GH
	 3sV+bURw771/Y3UOCzLxyqn5/njXzMEtyNncfQZaHgUYETHF6jXLbEIGhuvtp5rRN
	 IXxAoj0kxndnww+W4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from titan ([79.157.194.183]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bfq-1qzy583tTq-01807N; Sun, 28
 Jan 2024 11:29:45 +0100
Date: Sun, 28 Jan 2024 11:29:33 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Message-ID: <20240128102933.GA2800@titan>
References: <20240120152518.13006-1-erick.archer@gmx.com>
 <43614a09-d520-4111-873a-b352bd93ea07@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43614a09-d520-4111-873a-b352bd93ea07@moroto.mountain>
X-Provags-ID: V03:K1:ZdbxvZ0Mn/OkNmxnpyI6tcO9iODEyBjoc6VyPzhHpVtBsH0+gWL
 poErAPG+L3g1f8DvFqBDN2C34AT4y/5so3j0v5hP7DxYI06IqzdnsfMFRShvwNkUTOJa0iC
 hBBXf/WIB9/ViwDVwNwymW5trSxc8B3W/Rn7ikuxSE2hIrafzDdwyaFS1/MrKTMzeeTyrWi
 E4CiV7w+uG0U83JwT6xZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q3/bpQWk/cw=;zveX/XHwfQYoL9WZ3UioPfEM/Tp
 xxGX7AUHZW34Nn5+GSKI2ZfBTKf2YuizqDv6nVRiXN2GNmGtHWWkS/gP1ir4rdJjBVwdFOpBn
 2f2k4dODbfk1Fo9nZZ8ieql2sT8R6UDeAM0y4uio8l7y50ozF+u+PHHn86s/SD60LBra8e451
 mEWXLXg5TIjLmegrad/WA3GHwhRfE7YbVc+JBOGWUV/owimFMKhG+Jo6VHhVwPomewB/VFxfG
 kS4BKioeuOu04B7Ohv0Ucoa7GZqrQSGsUR0zEIaRKiZkJ706SNc5GcjTVNvBcdX8F7gcVXXTZ
 VwkxMx5nwq0t0fpz7i2zB0GGKh8/7kF/6Xtb9SGdypQFaNQgE+ohqzw7XlcUQIBTi25hcI4NA
 xms4Owvs0ygrwcmyE05+w88S1JJzo7bTTtYbrtyP7GYPNEsP/qKXNM+eozJI5j+dOM0q0671I
 Ju6+25h/rPgb8CKzmIEphJ5C/z5SgrjNLmHCxxJ0ZLlbRMwh4q7N6dizJ/TJlPNITz6JB5krO
 lYqeztCIwqFCNeEUCTbE5zOs/RDalgvuJpXrEkNsrZfH/dR/Z0BxFFduYOOWqVH0yMWSmK/K6
 ddWdfn9r43HsUCw2+GciMObPVdFZyvVJy+ps3XtCQYJ1MWx4xt4wOMl3MeHNB+cTqt3LP1vNj
 OkPcFnreI49ZxTHpF1nvI0/R9VnAUdmVyv4vPkWfshXREI2x3FdAe4vydVTrkDHShvgGso8SD
 pESWEy0MmV4M92JHnwcZZyQQ3FLBe6LKeQ3hXim/a2aUP4uowCQEi0YLSWssngQMl30abNzLH
 4+Ov52ORPtWYqtdpuO6n5zib60YwE1uebRMQfYU/8PD1yDHCXSsivloxaArNfaGFj856Lqs3t
 9O4lbzPWHDSm0GNFTeMC9Hi6OIxMg9x0pqXjSexC5e2eci+0xwac3kBHhstBY7+UHEXuOdSbO
 bw368zUr7Vc17rT6x2+0vQ0lTY4=
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, Jan 22, 2024 at 10:15:20AM +0300, Dan Carpenter wrote:
> This code does not have an integer overflow, but it might have a
> different memory corruption bug.

I don't see this possible memory corruption bug. More info below.

> On Sat, Jan 20, 2024 at 04:25:18PM +0100, Erick Archer wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or simila=
r)
> > function arguments due to the risk of them overflowing. This could lea=
d
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> >
> > So, use the purpose specific kcalloc() function instead of the argumen=
t
> > count * size in the kzalloc() function.
> >
>
> This one is more complicated to analyze.  I have built a Smatch cross
> function database so it's easy for me and I will help you.
>
> $ smbd.py where mhi_ep_cntrl event_rings
> drivers/pci/endpoint/functions/pci-epf-mhi.c | pci_epf_mhi_probe        =
      | (struct mhi_ep_cntrl)->event_rings | 0
> drivers/bus/mhi/ep/main.c      | mhi_ep_irq                     | (struc=
t mhi_ep_cntrl)->event_rings | min-max
> drivers/bus/mhi/ep/mmio.c      | mhi_ep_mmio_init               | (struc=
t mhi_ep_cntrl)->event_rings | 0-255
> drivers/bus/mhi/ep/mmio.c      | mhi_ep_mmio_update_ner         | (struc=
t mhi_ep_cntrl)->event_rings | 0-255
>
> The other way to figure this stuff out would be to do:
>
> $ grep -Rn "event_rings =3D " drivers/bus/mhi/ep/
> drivers/bus/mhi/ep/mmio.c:260:  mhi_cntrl->event_rings =3D FIELD_GET(MHI=
CFG_NER_MASK, regval);
> drivers/bus/mhi/ep/mmio.c:261:  mhi_cntrl->hw_event_rings =3D FIELD_GET(=
MHICFG_NHWER_MASK, regval);
> drivers/bus/mhi/ep/mmio.c:271:  mhi_cntrl->event_rings =3D FIELD_GET(MHI=
CFG_NER_MASK, regval);
> drivers/bus/mhi/ep/mmio.c:272:  mhi_cntrl->hw_event_rings =3D FIELD_GET(=
MHICFG_NHWER_MASK, regval);
>
> That means that this multiplication can never overflow so the patch
> has no effect on runtime.  The patch is still useful because we don't
> want every single person to have to do this analysis.  The kcalloc()
> function is just safer and more obviously correct.

Ok, I will send a v2 patch with more info in the commit message.

> It's a bit concerning that ->event_rings is set multiple times, but only
> allocated one time.  It's either unnecessary or there is a potential
> memory corruption bug.  If it's really necessary then there should be a
> check that the new size is <=3D the size of the original buffer that we
> allocated.

The ->event_rings is set twice. In the mhi_ep_mmio_init function and in
the mhi_ep_mmio_update_ner function.

void mhi_ep_mmio_init(struct mhi_ep_cntrl *mhi_cntrl)
{
	[...]
	mhi_cntrl->event_rings =3D FIELD_GET(MHICFG_NER_MASK, regval);
	[...]
}

void mhi_ep_mmio_update_ner(struct mhi_ep_cntrl *mhi_cntrl)
{
	[...]
	mhi_cntrl->event_rings =3D FIELD_GET(MHICFG_NER_MASK, regval);
	[...]
}

But ->event_rings does not need to be allocated because the type is a u32.

struct mhi_ep_cntrl {
	[...]
	u32 event_rings;
	[...]
};

So, I don't know what you are trying to explain to me. I'm sorry.

> I work in static analysis and I understand the struggle of trying to
> understand code to see if static checker warnings are a real bug or not.
> I'm not going to insist that you figure everything out, but I am asking
> that you at least try.  If after spending ten minutes reading the code
> you can't figure it out, then it's fine to write something like, "I
> don't know whether this multiply can really overflow or not, but let's
> make it safer by using kcalloc()."  You can put that sort of "I don't
> know information" under the --- cut off line inf you want.

Thanks a lot for the advices.

Regards,
Erick

> regards,
> dan carpenter

