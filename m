Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF675E29E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGWOZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWOZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:25:20 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C2E52;
        Sun, 23 Jul 2023 07:25:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63cf8754d95so1333126d6.1;
        Sun, 23 Jul 2023 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690122318; x=1690727118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iurTWtSaLbMm2NTaCeWSk9J+CNX1LHp4kCy9cz265zM=;
        b=OJzM0aOgl5X2s79S9cqo/Jp5SxdniNYeEBRIFE9N8/wAJ5coWbZqVymcoDkIv2N7Sd
         5udGtKHGYzUYC0+EjE8xoA1kmukN6zdokBTs8DIeKaWZhEWYExA+uXZAkjkbDp0I0xMK
         59PCPWHmutLiFrWJ6A+r02pDtiWFfZjH6OGSqT6h5a1v/+9qPXR1EocqOJkePtIG5wze
         TpUISQlR/Eqshuw6cjw9WZFvGuL8bgsu5K0C88Fic2MmvWnjPvWfMUbCd8Mh9KpVTcri
         p6nV/OYEMk8QHL0d0pmB30VyAimAZZ7QEcYRC5gJNL2Jij1EDGchbtGaf6oQvdNJSTe4
         Veig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690122318; x=1690727118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iurTWtSaLbMm2NTaCeWSk9J+CNX1LHp4kCy9cz265zM=;
        b=aMHaIyVhG58kHYUvQ7mRVGp5RbyvQCgq+4aCs7EUOFaXTZmjhny4sxzjAwW5cMVTFc
         8ddt0MuzV76EpQNvOz8XrP/2WqFFEPLjcxcgCofnIsmvNtOkwQ4vNj9qd1ifIbmYvHAx
         a6Tn3JTr6/hFfRvo7RuUWiR5gf45WzAYFxJp5j7X3gZkSuhQ1ZowBIYxWBUBfhKdw3N6
         Kr1MG53SBH2IzY1J2uQCH9/G5SQSJWnHhs3AdybCvsB8jHFXNDZ5f1UHUoDGQnGo4KeQ
         F+M5uSCMct/m3HFBYFbQeBlsHZAhwQx01QOX2MWGw4BBu1jz4a8QJrVEb/ROrXEiMja0
         7fog==
X-Gm-Message-State: ABy/qLanydciPckj1/ESimnUG2lk50/FuG8yq3O9YhjDaN7Smo9OElWh
        g/gqC4vdbQ0ORH+IyA3lDEgds6E6UYCeug2s8ss=
X-Google-Smtp-Source: APBJJlFAhZc7xp7oSLlufv1DynxmluLdZ7Szb4Oy3ygsFLrE2h5tV50ecD7UBlimeM7qLTVH8ArrenD7EC7a+1z7MTo=
X-Received: by 2002:a05:6214:5a02:b0:623:86a9:7696 with SMTP id
 lu2-20020a0562145a0200b0062386a97696mr4103260qvb.5.1690122318566; Sun, 23 Jul
 2023 07:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230722074753.568696-1-arnd@kernel.org>
In-Reply-To: <20230722074753.568696-1-arnd@kernel.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 23 Jul 2023 22:24:42 +0800
Message-ID: <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
Subject: Re: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 3:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Splitting these out into separate helper functions means that we
> actually pass an uninitialized variable into another function call
> if dec_active() happens to not be inlined, and CONFIG_PREEMPT_RT
> is disabled:

Do you mean that the compiler can remove the flags automatically when
dec_active() is inlined, but can't remove it automatically when
dec_active() is not inlined ?
If so, why can't we improve the compiler ?

If we have to change the kernel, what about the change below?

index 51d6389..17191ee 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -165,15 +165,17 @@ static struct mem_cgroup *get_memcg(const struct
bpf_mem_cache *c)
 #endif
 }

-static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
+static unsigned long inc_active(struct bpf_mem_cache *c)
 {
+       unsigned long flags =3D 0;
+
        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                /* In RT irq_work runs in per-cpu kthread, so disable
                 * interrupts to avoid preemption and interrupts and
                 * reduce the chance of bpf prog executing on this cpu
                 * when active counter is busy.
                 */
-               local_irq_save(*flags);
+               local_irq_save(flags);
        /* alloc_bulk runs from irq_work which will not preempt a bpf
         * program that does unit_alloc/unit_free since IRQs are
         * disabled there. There is no race to increment 'active'
@@ -181,6 +183,7 @@ static void inc_active(struct bpf_mem_cache *c,
unsigned long *flags)
         * bpf prog preempted this loop.
         */
        WARN_ON_ONCE(local_inc_return(&c->active) !=3D 1);
+       return flags;
 }


>
> kernel/bpf/memalloc.c: In function 'add_obj_to_free_list':
> kernel/bpf/memalloc.c:200:9: error: 'flags' is used uninitialized [-Werro=
r=3Duninitialized]
>   200 |         dec_active(c, flags);
>
> Mark the two functions as __always_inline so gcc can see through
> this regardless of optimizations and other options that may
> prevent it otherwise.
>
> Fixes: 18e027b1c7c6d ("bpf: Factor out inc/dec of active flag into helper=
s.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/bpf/memalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 51d6389e5152e..23906325298da 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -165,7 +165,7 @@ static struct mem_cgroup *get_memcg(const struct bpf_=
mem_cache *c)
>  #endif
>  }
>
> -static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
> +static __always_inline void inc_active(struct bpf_mem_cache *c, unsigned=
 long *flags)
>  {
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 /* In RT irq_work runs in per-cpu kthread, so disable
> @@ -183,7 +183,7 @@ static void inc_active(struct bpf_mem_cache *c, unsig=
ned long *flags)
>         WARN_ON_ONCE(local_inc_return(&c->active) !=3D 1);
>  }
>
> -static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
> +static __always_inline void dec_active(struct bpf_mem_cache *c, unsigned=
 long flags)
>  {
>         local_dec(&c->active);
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> --
> 2.39.2
>
>


--=20
Regards
Yafang
