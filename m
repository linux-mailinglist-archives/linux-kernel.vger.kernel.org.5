Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8330075D69F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGUVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGUVeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:34:17 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8BA3A90;
        Fri, 21 Jul 2023 14:34:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ca9804dc6e4so3628786276.0;
        Fri, 21 Jul 2023 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689975253; x=1690580053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ww2Ir4UT9vxDO3gsmCYDrLzwmrTqayqlfs3UlkUjuw=;
        b=OPUj9OxU454FJm/G8SczfGd0mx1TOLwMInHURoJtRuBpA9gqTLQazUmOiyEjURWz9N
         ciz2mcxP4A+kCXpnnsDzqxmzKPShxwpmICIMNBEzpbg/k5xmEVfMDVl7Dl0cCtuLnSkJ
         D7oVpm3/52D1+Le9s+nUVPzPGRfeyzuQb9p/j59nYN8zTV+rh4eoMcpn5948yA5GXwYg
         y/kK1bVeo4C489Zdx95YBOAx0qt3b/6fhwJhxQM7XBiSSodMO6oX6znLjB/AUFStlAKY
         4pI2i62vdGpQQPZeYZe0DpGhNK8vNYUMSuGGirZzQ0oN8FlEtkxqpcAvNUkVenvX34jj
         QNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689975253; x=1690580053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ww2Ir4UT9vxDO3gsmCYDrLzwmrTqayqlfs3UlkUjuw=;
        b=hSBnQ53As2lXkN+ivNF+xpmpXv7kG2Cu3F8FIu05hRnPe5r24ZF2P7Qudi0j1y4h7g
         fRszm0WLD22zLwBvnrrovHUkM3LsSFw9M2+2eG3LEtfvw2DbxeTgZqa+1ITgnT6VaEV7
         /NaFPmX70KX5dihQAKzQ/jej//qZUf8a9UiDZKrgJs6DKtTUyF+GTbtCE11DI1D1Wl9n
         TWQT2l0oFk0cSY5pYWT4N7lMCH5sjuwFwB91DACdZDIwtD+j5W9sXNWyZ18tmz8XUV7Q
         TTdpoVTitpVte4SL3J2cBo3GihfDKThk2Wtyq7upTptzivjcP/mUgyVXvUoIrl5WM44Z
         76Tw==
X-Gm-Message-State: ABy/qLbqSSSCw4nirbbq6AHckksJgcpbR+PxXkQK1LIpCEIGEylHMx/8
        hA0ft7r03aZYhPRY0JrLW6n3JJa/RzJrPhZGLWU=
X-Google-Smtp-Source: APBJJlH9ZyZRlD9Qv0Td4wxXcf6aVx07IzZ7MVtvHVSjJrVkH+8myPIr6PdromOiF9dvg94W4jfb7Ze55+qm/5PzYGU=
X-Received: by 2002:a25:c58b:0:b0:d05:54a4:64ac with SMTP id
 v133-20020a25c58b000000b00d0554a464acmr1525614ybe.12.1689975253527; Fri, 21
 Jul 2023 14:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230720160729.39324-1-l3b2w1@gmail.com> <20230721162114.GA1321524-robh@kernel.org>
In-Reply-To: <20230721162114.GA1321524-robh@kernel.org>
From:   binglei wang <l3b2w1@gmail.com>
Date:   Sat, 22 Jul 2023 05:34:02 +0800
Message-ID: <CAJ3C4KwEgGaHaWv+W89fXNUQiHd+iu=JHe3v6V85mU7oGYCX1w@mail.gmail.com>
Subject: Re: [PATCH] cma: check for memory region overlapping
To:     Rob Herring <robh@kernel.org>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=85=AD 00:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jul 21, 2023 at 12:07:29AM +0800, Binglei Wang wrote:
> > From: Binglei Wang <l3b2w1@gmail.com>
> >
> > Cma memory region editted carelessly in dts may overlap
> > with kernel code/data memory region which is reserved by memblock
> > during the early phase of system memory initialization.
>
> Is your goal for the kernel to function with this careless editing or
> warn enough to fix the DT?
>
> What if other regions overlap with the kernel? Wouldn't we have the same
> problem?
>
> >
> > Without checking overlap and cma area setup done,
> > this region will be released to buddy system later.
> >
> > When memory usage under pressure, memory allocated from
> > this region will collide with kernel code which is read-only.
> > And the following writing to this region will trigger the panic
> > of writing to read-only memory.
> >

Dear Rob:
Thanks for your reply.

In the production environment, I encountered this issue in the 5.4 kernel.
The goal is just to warn enough to fix the DT.

> > So when rmem_cma_setup returns EBUSY, do not phys-free this region
> > to memblock or else we end up with free the kernel code memory
> > to buddy system.
> >
> > Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> > ---
> >  drivers/of/of_reserved_mem.c | 3 ---
> >  kernel/dma/contiguous.c      | 5 +++++
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.=
c
> > index 7ec94cfcb..d62cc76ef 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -338,9 +338,6 @@ void __init fdt_init_reserved_mem(void)
> >                                       rmem->name);
> >                               if (nomap)
> >                                       memblock_clear_nomap(rmem->base, =
rmem->size);
> > -                             else
> > -                                     memblock_phys_free(rmem->base,
> > -                                                        rmem->size);
>
> I don't understand this change. Seems like perhaps someone would want
> the free here?
>
> >                       } else {
> >                               phys_addr_t end =3D rmem->base + rmem->si=
ze - 1;
> >                               bool reusable =3D
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 6ea80ae42..a349f3e97 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_m=
em *rmem)
> >               return -EBUSY;
>
> Here we return EBUSY if we are using cmdline params. In that case, isn't
> freeing the DT CMA area the right thing to do?
>
>

yes, in some cases, freeing the DT CMA area is the right thing to do.
in another case, like the read-only panic,  freeing will cause problems.

Actually,  giving a warning message is already sufficient.
I should not overthink it, after all, it was caused by human factors.

When using command line,
I find cma_declare_contiguous_nid will check the overlap in the latest kern=
el.
But in the program flow of parsing dts, both the 5.4 kernel and the
latest version of the kernel lack this check.
That's the reason for this patch.

> >       }
> >
> > +     if (memblock_is_region_reserved(rmem->base, rmem->size)) {
> > +             pr_info("Reserved memory: overlap with exsiting one\n");
> > +             return -EBUSY;
> > +     }

Do you think a warning message is sufficient?

Best wishes
Binglei Wang.

> > +
> >       if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
> >           of_get_flat_dt_prop(node, "no-map", NULL))
> >               return -EINVAL;
> > --
> > 2.34.1
> >
