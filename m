Return-Path: <linux-kernel+bounces-58255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7417584E38B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50CBB229FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05C7B3C7;
	Thu,  8 Feb 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZdXZqn5"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91606BB36
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404269; cv=none; b=UYDSxsspKgnf9g7PFB4ecyzRY24S+M5Mh1QfQ73jOcfSDEq+aA+tweiroS7RqmnYHJQJL/k21hrlNo7xYx3ZeGWECeoUzZ7cYizY7y4740/cavb63A9JAKjHoI9ye46QxO4mW638QwFmEYYJwbMP0nZTwdC9RNptQEMxFZWFwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404269; c=relaxed/simple;
	bh=hH7V+z/hkc0o3nHSLBAVIPKUSNR0BqQ6uPNJD/UTNDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVXSuXjz4BJmGbmcAB+e+XHP2ifTFHvOvbVQyacDkE1os4FkiU79Uxv1VDNIif80j+GWB7+dX0yO0iWIj0I+xLINQUPFLMzXUopZ/XziyXZv+FOLA4zcPSnCsnlx0Uj4THKUD67PUPMU5wPLLsDEegVIEMlEeiL3WfvUak8eEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZdXZqn5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-604819d544cso20464577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707404267; x=1708009067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zopLlrXDFqXb0fsa403Kdv4YZb4TULp/KAiF9gHcjgo=;
        b=XZdXZqn5n1t/M432JA7+NTNJYk58/6A5CnUFDcokx27Pvcu5HwFeKrGfSRB8arPbcp
         HqBNLwF1DYJjhC3/xPCysFOZLMq2UHJkVizm1gqzv5YH8epT8rc6kMBgXElp+x7r48rr
         aWIGEk+tY9ykSJEwBUE+gvCTOge6tRoNXzTKfYZsAk3RpAr+1eX830RNvHq+yr7F9dce
         vVa2Kogp3+d/M2AIjoeMXdnPZUsKvR0XsAEOQS5ev2ajCfbcMawEI/YwzcLnf6X8bHWX
         w3Th6uP+aINpRby/1hkV5+HMHyboM1jaB9ojNRvXVZDV6J86ds7G3UXj5UOZKuHy8VdQ
         V95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404267; x=1708009067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zopLlrXDFqXb0fsa403Kdv4YZb4TULp/KAiF9gHcjgo=;
        b=pxMviaai4udu6rxIg7giXNO0hvQU5yLj1MXFlVYO5TWfjNB2DHgpScwQTJ7X6/e2rl
         r3fVH4/AmrI2LDYTck0n+Goy+1ZunBqDvN0AeEIP2qxXD5mRH9afA0q80LSsk75OLXTx
         ctxwywvlu9d42omcezIBfyGDYL8vGsbkC2BR0OZQw6ohWE3cU67mQ2YeTtXgfikn/bsU
         mG/vLfJIRRPZ6fz5N/80Q8qfsUGV/ngjLalW2Oq3sl/PDMqnZCl5jWQ5RbA6m0xeEDHp
         zZnK2G1f+VW+hKY8J83bGeu5OCdCzDkVrjN5T87cXYrruVHvIQjaqawdy1rU6Y6/1kfd
         o1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWaL7TupXwkJlj78j2/ZFU1nBv6R6077GQSb4yAf10l8MdIgqNW/kW5gAXoQLBwaputRh2zJSIF6w5pUTESvy38cAy4GL6EETiz2osJ
X-Gm-Message-State: AOJu0Yzba3+CINC9+MiAw/BeMCDzyqKTrSNrIUuokuMJkh5hDA0yaf8u
	m6O746+uf9gY3pczn9n3yVWMnc2m2jcMhxywoI6PWGx1RZUHtWq26niLYrzyZZ4GhLBYwkbC4RH
	YNneosYdz4zcz8ntQOuJ5ewv5XwtuwCxdqgqF
X-Google-Smtp-Source: AGHT+IGrPduEnxofD7OsjMeh2aFvSXFirpwFFu4mUL42iR68ByNnAUEsUvjhMEaNQwNYyPv1xuLzyiMtMEhEE7h6zPM=
X-Received: by 2002:a05:690c:6:b0:5ff:9662:11c8 with SMTP id
 bc6-20020a05690c000600b005ff966211c8mr11396195ywb.43.1707404266501; Thu, 08
 Feb 2024 06:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205072312.2342188-1-howardyen@google.com>
 <ZcDPn5eLvMwpb7N1@smile.fi.intel.com> <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
 <CAJDAHvYYUcn2HL1QTSG-KA0QcuAOotk5hY4cpuasOu_H=X-V0A@mail.gmail.com> <ZcSzW1kFZIZ_f759@smile.fi.intel.com>
In-Reply-To: <ZcSzW1kFZIZ_f759@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Thu, 8 Feb 2024 22:57:34 +0800
Message-ID: <CAJDAHvaYqq+PFTQRejcbUbyX6zHw5wygF+dRh9HNbJ83fmZacA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-coherent: add support for multi coherent rmems per dev
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 08, 2024 at 03:53:37PM +0800, Howard Yen wrote:
> > On Tue, Feb 6, 2024 at 11:43=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 05, 2024 at 02:08:00PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Feb 05, 2024 at 07:23:00AM +0000, Howard Yen wrote:
>
> ...
>
> > > > > @@ -18,15 +18,9 @@ struct dma_coherent_mem {
> > > > >     unsigned long   *bitmap;
> > > > >     spinlock_t      spinlock;
> > > > >     bool            use_dev_dma_pfn_offset;
> > > > > +   struct list_head        node;
> > > >
> > > > Have you run `pahole`? Here I see wasted bytes for nothing.
> > >
> > > On top of that one may make container_of() to be no-op, by placing th=
is member
> > > to be the first one. But, double check this with bloat-o-meter (that =
it indeed
> > > does better code generation) and on the other hand check if the curre=
nt first
> > > member is not performance critical and having additional pointer arit=
hmetics is
> > > okay.
> > >
> > > > >  };
> >
> > I'm trying to re-org the members as below
> >
> > from =3D=3D=3D>
> >
> > struct dma_coherent_mem {
> > void *                     virt_base;            /*     0     8 */
> > dma_addr_t                 device_base;          /*     8     8 */
> > unsigned long              pfn_base;             /*    16     8 */
> > int                        size;                 /*    24     4 */
> >
> > /* XXX 4 bytes hole, try to pack */
> >
> > unsigned long *            bitmap;               /*    32     8 */
> > spinlock_t                 spinlock;             /*    40     4 */
> > bool                       use_dev_dma_pfn_offset; /*    44     1 */
> >
> > /* XXX 3 bytes hole, try to pack */
> >
> > struct list_head           node;                 /*    48    16 */
> >
> > /* size: 64, cachelines: 1, members: 8 */
> > /* sum members: 57, holes: 2, sum holes: 7 */
> > };
> >
> >
> > to =3D=3D=3D>
> >
> > struct dma_coherent_mem {
> > struct list_head           node;                 /*     0    16 */
> > void *                     virt_base;            /*    16     8 */
> > dma_addr_t                 device_base;          /*    24     8 */
> > unsigned long              pfn_base;             /*    32     8 */
> > int                        size;                 /*    40     4 */
> > spinlock_t                 spinlock;             /*    44     4 */
> > unsigned long *            bitmap;               /*    48     8 */
> > bool                       use_dev_dma_pfn_offset; /*    56     1 */
> >
> > /* size: 64, cachelines: 1, members: 8 */
> > /* padding: 7 */
>
> Which seems better that above, right?
>
> > };
> >
> > Looks like there is about 7 bytes padding at the end of the structure.
> > Should I add __attribute__((__packed__)) to not add the padding?
>
> No, __packed is about alignment, may give you much worse code generation.
> With list_head member first you might get better code from the original,
> check it with bloat-o-meter.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

From the check result with bloat-o-meter, there is about 3.38%
reduction totally from the
original version. Thanks for the suggestion!

add/remove: 0/0 grow/shrink: 0/7 up/down: 0/-60 (-60)
Function                                     old     new   delta
rmem_dma_device_release                      104     100      -4
dma_release_from_dev_coherent                184     180      -4
dma_release_coherent_memory                  144     140      -4
dma_mmap_from_dev_coherent                   228     224      -4
dma_init_coherent_memory                     292     284      -8
rmem_dma_device_init                         168     152     -16
dma_declare_coherent_memory                  184     164     -20
Total: Before=3D1776, After=3D1716, chg -3.38%
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Data                                         old     new   delta
Total: Before=3D0, After=3D0, chg +0.00%
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
RO Data                                      old     new   delta
Total: Before=3D216, After=3D216, chg +0.00%

For the dev check, in the previous comment, they're in the static
function and are assigned
to ops function pointers, I think the check is required because they
might be invoked from
others.

I'll submit v3 with the members reorg, the return variable naming
changes and if (!dev) return; .


--=20
Regards,

Howard

