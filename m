Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986D1802137
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjLCGJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjLCGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:09:04 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B31FE4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:08:29 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4648b191ce6so95992137.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 22:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583702; x=1702188502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7fevemxkHPKkn8De2PN0uPPbfcs4ANeofm/VTixKps=;
        b=L+5yy+gFluR+6N1HCbYSzYRDEsQ1ASoQEneK6FO/dQ90s7R1JgM2qWyBVsEe5B+d+N
         eEjvG4gx3zfxPlgiieUynGHukdHE8GxF5n7U1Ie6DVWAzYbcjjukZbgDw2syMHmyLWBH
         /D9JfGSrRq+/fA2oPT6S2NeHT55AhLwItR54amSWWgwwnKDxkWw0rE023algkAwKdvdS
         5X5YMIqjvp0j8FdXXunhL4f/tjZ3QTuSOvcEk8xsI/tuqpxAELaGYHIozFrNEeKDDUEO
         Ra+ONCEQvRalTK9YAd8ATfj/NYmN6FfykMeFeOgAzJTdIkNvrgO+g8yJ717cJRf+YlO2
         nw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583702; x=1702188502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7fevemxkHPKkn8De2PN0uPPbfcs4ANeofm/VTixKps=;
        b=igEkaQ2epGLwuZW8rrgg0KkeP7mDGa2uxkOPF8L99FSp1lfLf55BZ5KJDykWzAkHMd
         OFpi6Qr6FM2tp3+IpxtJtO6WZoFgf/IlaGagGMbYClk9SysYzl1pMPlzkE98LT6xc7xz
         qUSG0ZTJ7Hl7+nPtqRBK/DygqjCK2w76Y+EojeVTjsEsdiBdJv/D1mnODp38PpHI7WFz
         iIu2ztyXmaTQKpRF0SavFRwL9+s5I6z+jH3wIrB91Ib4Ur/IE0EG8bOjt80S0YOQvF1r
         CH6N/K02UfowEzAkExzOrwEa/5hQ7T87wGF/+FAo21z9zmzObPlwIlsK2QvVAXXVCRJA
         +P+g==
X-Gm-Message-State: AOJu0YxMvOkI51DfEirNWZUO1WUmFMUthGErVrbq9EPeue61/78jpWP4
        jTks5f0PPPVj9cnnoD+beaN3cex/4lFaWu4kMtA=
X-Google-Smtp-Source: AGHT+IHD6b/ENScKTpNLCErmigKxB8SjKB7WnwAYW+5SPyyWKG1QMEzG9OWFZqx/zwJ8pO/cybNdGbcvRJgof3+MWdk=
X-Received: by 2002:a05:6102:b0b:b0:464:77f1:f349 with SMTP id
 b11-20020a0561020b0b00b0046477f1f349mr1216372vst.23.1701583701624; Sat, 02
 Dec 2023 22:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20231031140741.79387-1-chengming.zhou@linux.dev> <20231031140741.79387-6-chengming.zhou@linux.dev>
In-Reply-To: <20231031140741.79387-6-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 3 Dec 2023 15:08:10 +0900
Message-ID: <CAB=+i9SuKDT61txyyr2Nrh_jXYc7vt5_GwQUYqCEPMvQiPdMJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/9] slub: Introduce freeze_slab()
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:09=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> We will have unfrozen slabs out of the node partial list later, so we
> need a freeze_slab() function to freeze the partial slab and get its
> freelist.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 1880b483350e..edf567971679 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3098,6 +3098,33 @@ static inline void *get_freelist(struct kmem_cache=
 *s, struct slab *slab)
>         return freelist;
>  }
>
> +/*
> + * Freeze the partial slab and return the pointer to the freelist.
> + */
> +static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
> +{
> +       struct slab new;
> +       unsigned long counters;
> +       void *freelist;
> +
> +       do {
> +               freelist =3D slab->freelist;
> +               counters =3D slab->counters;
> +
> +               new.counters =3D counters;
> +               VM_BUG_ON(new.frozen);
> +
> +               new.inuse =3D slab->objects;
> +               new.frozen =3D 1;
> +
> +       } while (!slab_update_freelist(s, slab,
> +               freelist, counters,
> +               NULL, new.counters,
> +               "freeze_slab"));
> +
> +       return freelist;
> +}
> +

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

>  /*
>   * Slow path. The lockless freelist is empty or we need to perform
>   * debugging duties.
> --
> 2.20.1
>
