Return-Path: <linux-kernel+bounces-49193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3184670A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8AEB23BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4DF9C6;
	Fri,  2 Feb 2024 04:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gk7H7qJm"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B413F4F6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848875; cv=none; b=pFLtp11AwTeBhEsiUcar7yc4iB1fv4Of4W7jwVR0u9LyTD5ThUp4926nk783uMNKqa1j9UmtxVZirI2ptyrP1zJJFXVe3y7JvkHTvVaHJ5P7HqZbtpdgyQ4KXA3P4XX+Laaodlf7G8ULjLwWaNFEYIOggrNdiHu/AmMrBAWxSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848875; c=relaxed/simple;
	bh=tcEH8y9ILQRfJEiztnFPBtbL/SdrVqxuQ6BXuMiY/J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtM3HmWEk3FUYd2Xqo/VDSlbd5eafUrnm9opNpcGiO1B0UNCSs1VZKPa2AoLa9C4kVllVWM0tCQeYHTt8aAl3uNUvCaBz28RwKFtWZo4uHCXPxs6r1bgOExT+wuhvlJcPCHPJ1F2OWJYSTRcXVeZUkGXnADQqPiOVCXJp81EL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gk7H7qJm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1645576276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 20:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706848871; x=1707453671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR2/y2vEPhv8eBcksIZP96OOa1fhQ1JeijHES+W35BI=;
        b=gk7H7qJmWRxTONWlFZAJzlQt8r34Dwj0rA5axTYjyfswVxrTXK3t/vTla0eSJNE7oe
         kmxW+A30ZJWLmH4bNZr3rRg4gAfmbChbyPVUPWrQr/SSnXA1f0/oBq/sxBQlvq4iWPGo
         KkdTsHvsNuJlyi3ZDGMXNU/Nw9J6dfkk+364IRxdlY5B2Voko9WNCDKug4lACjHca+ph
         rU3U3rs80yaiFzCVRB90djYY6gZetIyqLGkOSb8GVKlU/XaP4U9PfpYVSvUwWW1dtrzB
         2uH+1PrG0VnJqW54G5BAJtJ2SfHDT1fyTqIR9qLeMsuWdkGFB7DFL4rLFlRkoeVJvFjH
         uajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706848871; x=1707453671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR2/y2vEPhv8eBcksIZP96OOa1fhQ1JeijHES+W35BI=;
        b=I9xVAC8rt6LvsN4j3BMPrL6KHgZtekJ+g4BtrDZaA60ax169fxL72CNUsKFYn7gBEE
         rTnExYKweEnAhKl55+fCEqrxVuMvReL7iizotzeg2vPQ0OxBRGoj0OqDNlAZZgNagFPN
         NJ1l/eYgywslXST/nDK968CEYNGURqyigoAjdZG9Uzwk8SmBCDv6DDz/f1kLddz1R3N9
         MhH2Q1Lw/vbNBxp+U4XQXeZi9uwlli2JZVcLrT5337jL9yISWCNofUM3boGngWD2IHut
         sAGsLel5jGJPbDMKPZaiZldbuXXjCBgzKkqw4T4fxtM1dOkjULSQ3fgHi9ZxvI7Fj7a9
         92Mw==
X-Gm-Message-State: AOJu0YyUyJdAF5wwXWK8hAJpvKR50FjJswqrJgs+inwUD6dj0kGIZtrK
	FE/A+kAP+4nCz2XLRJaD7yuiD18TBKeYjDlDWB+aLxfbg0heyU1VIyP8AI4ZChriXeGtReJM5lt
	gzFPBB5RGWOmndydwaLbML4n5883rzseK7jYU
X-Google-Smtp-Source: AGHT+IEeBKezZDIqBQF7eHwuYqAvCJ8nw+dAXcKn3tJnFoqaYeczMg4ET2n7H9b6PoIbYlxV8PzaiVJxGLGJ2vWoXDo=
X-Received: by 2002:a25:9701:0:b0:dc6:bb86:ea11 with SMTP id
 d1-20020a259701000000b00dc6bb86ea11mr4583776ybo.19.1706848871267; Thu, 01 Feb
 2024 20:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201093515.849873-1-howardyen@google.com> <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
 <2024020156-reshuffle-salvaging-8161@gregkh>
In-Reply-To: <2024020156-reshuffle-salvaging-8161@gregkh>
From: Howard Yen <howardyen@google.com>
Date: Fri, 2 Feb 2024 12:40:59 +0800
Message-ID: <CAJDAHvZ=XVZ-Ea1LVqfTnDXJ+J=PLbZNCZkuSpvdOtEsreguWw@mail.gmail.com>
Subject: Re: [PATCH] dma-coherent: add support for multi coherent rmems per dev
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, m.szyprowski@samsung.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 01, 2024 at 10:45:30AM +0000, Robin Murphy wrote:
> > On 2024-02-01 9:35 am, Howard Yen wrote:
> > > Add support for multiple coherent rmems per device. This patch addes
> > > dma_mem_list to device structure to store multiple rmems.
> > >
> > > These multiple rmems can be assigned to the device one by one by
> > > of_reserved_mem_device_init_by_idx() with the memory-region
> > > declaration in device tree as below and store the rmem to the dma_mem=
_list.
> > >
> > >     device1@0 {
> > >             ...
> > >             memory-region =3D <&reserved_mem0>, <&reserved_mem1>;
> > >             ...
> > >     };
> > >
> > > When driver tries to allocate memory from the rmems, looks for the fi=
rst
> > > available rmem and allocates the memory from this rmem.
> > >
> > > Then if driver removed, of_reserved_mem_device_release() needs to be
> > > invoked to release all the rmems assigned to the device.
> > >
> > > Signed-off-by: Howard Yen <howardyen@google.com>
> > > ---
> > >   include/linux/device.h |  1 +
> > >   kernel/dma/coherent.c  | 66 +++++++++++++++++++++++++++++++++++----=
---
> > >   2 files changed, 56 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 97c4b046c09d..c8682ee507cf 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -751,6 +751,7 @@ struct device {
> > >   #ifdef CONFIG_DMA_DECLARE_COHERENT
> > >     struct dma_coherent_mem *dma_mem; /* internal for coherent mem
> > >                                          override */
> > > +   struct list_head        dma_mem_list;
> >
> > I'm not necessarily against the idea, but only if it's implemented sens=
ibly.
> > If we're going to have a list of these it should *replace* the existing
> > pointer, not do this weird thing with both.
>
> Agreed, it should be one pointer max for this structure for this type of
> thing.  Why not move it into the dma_coherent_mem structure?
>
> thanks,
>
> greg k-h

I'm considering to modify the change to

1. Move it into the dma_coherent_mem structure, like

     HEAD
mem0->node

This case, if I check list_empty(mem0->node), it would give me the
list is empty, but actually there is one rmem.

2. Replace the pointer to a list_head.

    HEAD
dma_mems ---> mem0->node

This case, if I check list_empty(dma_mems), it would give me the list
is non-empty, it matches the actual status.

So, the 2nd looks reasonable, I'm going to upload a v2 patch with the
2nd approach, does that make sense?

--=20
Regards,

Howard

