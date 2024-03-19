Return-Path: <linux-kernel+bounces-108121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C54880641
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5186283D25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504943BBF0;
	Tue, 19 Mar 2024 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TDY71+l7"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10E3BBE0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881398; cv=none; b=JNywhQTpx4rZ+0uEeDLrKnusUpKPCXrSfPJO3W5yrzJZ2mYjQ6n6/zUCDtEan0Hj9XoDhEqj08uJEvvbIfS61L9v+oVARDCb4pgY0ERG/QIcSmbaVrxzbDckyUZ/Ytfft22+fjMzJFckQT3JcQkIOAKD1WIY5SjJuADau9tOWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881398; c=relaxed/simple;
	bh=Z7LR4iuF5xe0JRhrBFTIJvdcbXLkygfhaGVBlRAGsdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0cl/CH8xpNUUDt5hedqZRTFgyFFPJniy3hc3HxIq9PnVKmVIN2gogRHX71PUU2cIwfRv5Ry1WnaVDFwNerwfKE+Wma3Yj+CH5E9ERHEZgTwg+zjnbWVBLXEgVx472szQ6x4ojTYey8MI4X5epqTQh+Ngbp1J+VXr0yIlJ9EZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDY71+l7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46f28f89baso8529066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710881395; x=1711486195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzFE/m5DbU9WjZnNo3vc0p2nL06oMgUw35m0zyhzHBs=;
        b=TDY71+l76J03xlvohIwCGgL9hDBNXOKk8Lj5DLNkl36LPEL6JIRa9yTHlstVkEnb6d
         0+/58Dec7qofMVPTKf9aBpUN51hRFRyB34K274taiw8pFHakKvjyjqfiyGPSFeDJhZAE
         x2x75VbGvcxVCdGQQoPyF2j1IDjZGL5INiSP2CbIT+ckcQRdyipAM63XZHFifb+DLiKn
         xSxfx1RIEKa8z+hfcaW0l09ni07/b1IvZN8r8xvm7FCjR6HehMiJ4n7lCthfFLVpWBqp
         RvN21vZF40Y/Ux5zR7drMaTabLTEXCaVfixyUncYtegtWS3o9sVlnR2aOYnwapbLaim9
         cQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881395; x=1711486195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzFE/m5DbU9WjZnNo3vc0p2nL06oMgUw35m0zyhzHBs=;
        b=p9Jp6Pochcjtrx4baotsJ/dFTbilUicJDhIED5fCSttRcvCB9edKN6Yygz08nokZqA
         ADVRgOP2b1uFYT6jN/pwhxD4PA7+X8ZyPG2pZLdaRz8Whu+xx1DM+DjVy5HA9e00jJkr
         W5Lw3N5QhWaLK3hkP636IFgDOHCvU+V+qVv1EktIpuMr87hmzQokgIIm3OIi7we1qy7m
         NaD7Eg3PScHxL3Ie4xJv1K5SSAfKp2VzG23e7IKZJPx9VMzCJ//TYKMs954v7b+Xr1gH
         fT0/8xnuXSwu7Ep9bcmRqJ6L9GuwkJ8FwWUFdSNmZLqp97YhoNKjYCNEg7wXOatzW2FB
         S46g==
X-Forwarded-Encrypted: i=1; AJvYcCXTCdKFg+K4uIR4MoI9DHbUnu6WkYCGFWis8xEkupXj5fwIefd7Lu3RLrRVz+HuzfDkGu2SeaVeDGZvbSajhUDCd3UAm17kv3EF9Dsh
X-Gm-Message-State: AOJu0YwJf5P95sFhQ4iXMusksvH3+yLDDVHajAxtj+pni/wmzq4SrNRt
	GwyzDGkhqGq1xph0g2W0fVAvK9Q5gzbW+xJhGA0qZbOR6FFQTNfp2DcXjTHtcIOlyl5L8FiBT5c
	MXtkhYwry++i6htbZwf0/+BcotmU036MBm8Lj
X-Google-Smtp-Source: AGHT+IGXWLGjCvtBBJPHB+AXDtlROX61sbxL8P5/tnul0XIuDk4mFOnYxI5vzoMwdg4uJMIF+QWddSjhyMAxLUf22Vc=
X-Received: by 2002:a17:906:709:b0:a46:984f:4a65 with SMTP id
 y9-20020a170906070900b00a46984f4a65mr562316ejb.19.1710881395015; Tue, 19 Mar
 2024 13:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311194346.2291333-1-yosryahmed@google.com>
 <CAJD7tkYy=e_qkpu64y57o1cWs7RN7PwWgPoFamJu1YDjj_s=kw@mail.gmail.com> <Zfn2Uql1Jg92CQeP@snowbird>
In-Reply-To: <Zfn2Uql1Jg92CQeP@snowbird>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Mar 2024 13:49:17 -0700
Message-ID: <CAJD7tkYRnCkP39gOHtfpxTpz_ntx47dz48pFes9dHunnmy7Xtw@mail.gmail.com>
Subject: Re: [PATCH] percpu: clean up all mappings when pcpu_map_pages() fails
To: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 1:32=E2=80=AFPM Dennis Zhou <dennis@kernel.org> wro=
te:
>
> Hi Yosry,
>
> On Tue, Mar 19, 2024 at 01:08:26PM -0700, Yosry Ahmed wrote:
> > On Mon, Mar 11, 2024 at 12:43=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
com> wrote:
> > >
> > > In pcpu_map_pages(), if __pcpu_map_pages() fails on a CPU, we call
> > > __pcpu_unmap_pages() to clean up mappings on all CPUs where mappings
> > > were created, but not on the CPU where __pcpu_map_pages() fails.
> > >
> > > __pcpu_map_pages() and __pcpu_unmap_pages() are wrappers around
> > > vmap_pages_range_noflush() and vunmap_range_noflush(). All other call=
ers
> > > of vmap_pages_range_noflush() call vunmap_range_noflush() when mappin=
g
> > > fails, except pcpu_map_pages(). The reason could be that partial
> > > mappings may be left behind from a failed mapping attempt.
> > >
> > > Call __pcpu_unmap_pages() for the failed CPU as well in
> > > pcpu_map_pages().
> > >
> > > This was found by code inspection, no failures or bugs were observed.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Any thoughts about this change? Should I resend next week after the
> > merge window?
> >
>
> Sorry for the delay.
>
> I'm looking at the code from mm/kmsan/hooks.c kmsan_ioremap_page_range().
> It seems like __vunmap_range_noflush() is called on error for
> successfully mapped pages similar to how it's being done in percpu-vm.c.

You  picked an unconventional example to compare against :)

>
> I haven't read in depth the expectations of vmap_pages_range_noflush()
> but on first glance it doesn't seem like percpu is operating out of the
> ordinary?

I was looking at vm_map_ram(), vmap(), and __vmalloc_area_node(). They
all call vmap_pages_range()-> vmap_pages_range_noflush().

When vmap_pages_range() fails:
- vm_map_ram() calls
vm_unmap_ram()->free_unmap_vmap_area()->vunmap_range_noflush().
- vmap() calls vunmap()->remove_vm_area()->free_unmap_vmap_area()->
vunmap_range_noflush().
- __vmalloc_area_node() calls
vfree()->remove_vm_area()->free_unmap_vmap_area()->
vunmap_range_noflush().

I think it is needed to clean up any leftover partial mappings. I am
not sure about the kmsan example though.

Adding vmalloc reviewers here as well here.
>
> Thanks,
> Dennis
>
> > > ---
> > >
> > > Perhaps the reason __pcpu_unmap_pages() is not currently being called
> > > for the failed CPU is that the size and alignment requirements make s=
ure
> > > we never leave any partial mappings behind? I have no idea. Nonethele=
ss,
> > > I think we want this change as that could be fragile, and is
> > > inconsistent with other callers.
> > >
> > > ---
> > >  mm/percpu-vm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > > index 2054c9213c433..cd69caf6aa8d8 100644
> > > --- a/mm/percpu-vm.c
> > > +++ b/mm/percpu-vm.c
> > > @@ -231,10 +231,10 @@ static int pcpu_map_pages(struct pcpu_chunk *ch=
unk,
> > >         return 0;
> > >  err:
> > >         for_each_possible_cpu(tcpu) {
> > > -               if (tcpu =3D=3D cpu)
> > > -                       break;
> > >                 __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_=
start),
> > >                                    page_end - page_start);
> > > +               if (tcpu =3D=3D cpu)
> > > +                       break;
> > >         }
> > >         pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
> > >         return err;
> > > --
> > > 2.44.0.278.ge034bb2e1d-goog
> > >

