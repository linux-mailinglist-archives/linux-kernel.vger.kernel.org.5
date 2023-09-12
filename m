Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B5279D2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjILNsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjILNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:48:40 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDDD10CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:48:36 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44e84fbaab9so2319178137.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526516; x=1695131316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcT6oclXMuSPn3QBAyqNrtWmxEZ6No3EZHJZPbcbszw=;
        b=BMjZYgO2ntnJOVJKtDIheo/h2VAJ/qD83d2K3Nz57dPLyq9Hs7YPK2qsXxIZ0MUcW9
         IaoT8WMAHKWsjaDOBg/e0qbKi6OE3do+iZJJay8MGyZnSpu3bppxmWgFE5s+wLnRYGG4
         86vnCWHN+eoV5ry/3l+xUJgu+flNcXEc6vvtkDcSI0UYHAHccU6cZJ0bhgofHsCTGQd4
         GEVe1yMjTE+Y3N/d1PAdKydLdB/5O8lQqscY1Z/slawMGmdRnPggtKPpHnSjrMoZTXsq
         3a0tPeYx5nLlX/lPdou+gidpAexqKfaoT0Reczev3O0oQ6Ex+ZBYga8nkqeMcGoZZ0Xa
         NmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526516; x=1695131316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcT6oclXMuSPn3QBAyqNrtWmxEZ6No3EZHJZPbcbszw=;
        b=EG/rEbRBqrR58aKT2MTKy1GDGrI2qATHL4q2N94plnPfE4kFQay/a7H5ISIfkbTd96
         X9whuJ3qPlDDNFyNolCBsNDgdEekVbmZGZb/2olSsul2WNwoVzvG687gw4tHSa4o/UP6
         N+ly9Ebas6y7igXY9GPvS2lvzO47gFhF/WCbbjHlr4xmpbbimh5CJd5ZCLibGVemR4HA
         Y0H+cjYpSjkcyNnhf2sCZxYUCG+Ljmg1EVtxt/1CAS4g5HNuzUfTFybwzTMcN7d/4MP2
         1tnEUEpxQg1iYnWg8Jpz/riHyxTDu+LO9+JHinVIhJDF376uUomunyoV0d4ffynMlLKY
         6A7w==
X-Gm-Message-State: AOJu0YyNAg+78wlw/nYSosgySLqDtpUR4gpc003RxO1uOJyarcfGNhDe
        aSva0fPfcRVoWW/U46EMootFb+/80gPf0Ai0LKk=
X-Google-Smtp-Source: AGHT+IHeKZLFaE3ntl/c9r+ENEgyO4BNrBL5FfBrgal0n2Cv3vUWEWPGT/2Cfn4RKJ9Fu22o2xvo7lZ6DifjtmzNiFg=
X-Received: by 2002:a05:6102:3f89:b0:44d:538e:c6ce with SMTP id
 o9-20020a0561023f8900b0044d538ec6cemr7649123vsv.25.1694526515566; Tue, 12 Sep
 2023 06:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230905141348.32946-1-feng.tang@intel.com> <20230905141348.32946-4-feng.tang@intel.com>
In-Reply-To: <20230905141348.32946-4-feng.tang@intel.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 12 Sep 2023 13:48:23 +0900
Message-ID: <CAB=+i9RWVvUb5LyoTpzZ0XXWoSNxbKJuA6fynvOd4U+P5q+uaA@mail.gmail.com>
Subject: Re: [RFC Patch 3/3] mm/slub: setup maxim per-node partial according
 to cpu numbers
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 11:07=E2=80=AFPM Feng Tang <feng.tang@intel.com> wro=
te:
>
> Currently most of the slab's min_partial is set to 5 (as MIN_PARTIAL
> is 5). This is fine for older or small systesms, and could be too
> small for a large system with hundreds of CPUs, when per-node
> 'list_lock' is contended for allocating from and freeing to per-node
> partial list.
>
> So enlarge it based on the CPU numbers per node.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  include/linux/nodemask.h | 1 +
>  mm/slub.c                | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 8d07116caaf1..6e22caab186d 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -530,6 +530,7 @@ static inline int node_random(const nodemask_t *maskp=
)
>
>  #define num_online_nodes()     num_node_state(N_ONLINE)
>  #define num_possible_nodes()   num_node_state(N_POSSIBLE)
> +#define num_cpu_nodes()                num_node_state(N_CPU)
>  #define node_online(node)      node_state((node), N_ONLINE)
>  #define node_possible(node)    node_state((node), N_POSSIBLE)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 09ae1ed642b7..984e012d7bbc 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4533,6 +4533,7 @@ static int calculate_sizes(struct kmem_cache *s)
>
>  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  {
> +       unsigned long min_partial;
>         s->flags =3D kmem_cache_flags(s->size, flags, s->name);
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>         s->random =3D get_random_long();
> @@ -4564,8 +4565,12 @@ static int kmem_cache_open(struct kmem_cache *s, s=
lab_flags_t flags)
>          * The larger the object size is, the more slabs we want on the p=
artial
>          * list to avoid pounding the page allocator excessively.
>          */
> -       s->min_partial =3D min_t(unsigned long, MAX_PARTIAL, ilog2(s->siz=
e) / 2);
> -       s->min_partial =3D max_t(unsigned long, MIN_PARTIAL, s->min_parti=
al);
> +
> +       min_partial =3D rounddown_pow_of_two(num_cpus() / num_cpu_nodes()=
);
> +       min_partial =3D max_t(unsigned long, MIN_PARTIAL, min_partial);
> +
> +       s->min_partial =3D min_t(unsigned long, min_partial * 2, ilog2(s-=
>size) / 2);
> +       s->min_partial =3D max_t(unsigned long, min_partial, s->min_parti=
al);

Hello Feng,

How much memory is consumed by this change on your machine?

I won't argue that it would be huge for large machines but it
increases the minimum value for every
cache (even for those that are not contended) and there is no way to
reclaim this.

Maybe a way to reclaim a full slab on memory pressure (on buddy side)
wouldn't hurt?

>         set_cpu_partial(s);
>
> --
> 2.27.0
>
