Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEF7EE36C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbjKPO4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:56:30 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D151A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:56:27 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6707401e1edso4718736d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700146586; x=1700751386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzM0stGZCClmmzmredmePw1BMrI7dq9aY1ehb48KIQU=;
        b=FNLXCl1JfVrSP3wlr5c1EzCFRf4WU+SKRk5ziIleaUK4O05dpZtUZsJLwVwAI/76ZH
         JHZGLZRdv6Dbz2lSp9sb3b/cA/o8QkcyXWKsz2kQ2e+6LVd+vobUDAcOd5t0XcuXqIHl
         Fp1koZU/BZrbsvki7hCSZ7avhZooOTGOl0Nhnm2Xyc5E7K7LiuXZZJ/MyHcv6MNVqN4M
         Vg/Zsxqm7ou5hRnI8YOos7QUrCpBV/ICrSrICeFbj/+HhCDeNmT7RCqv5+4x7R7MgMUu
         P+lm3ysD0XGQiXYwq73x+6UR1DFOzQ52uDNhwPNmuXaMi1wY8AmrixwxvRwW7Kur73cP
         9kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146586; x=1700751386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzM0stGZCClmmzmredmePw1BMrI7dq9aY1ehb48KIQU=;
        b=RNJU0FaVgr90LJCi4re9O5LDwZwjAnv81UU0wFVDCEA/P9D/g9xRq5QKy18q0cypwY
         aKoPJmFUI/nFDIIaqIXNM6V1A2gxte+u/mnsP4elzYNZ6Wwh5jpDbMZ0L1miAS8MT4ji
         1LkMUs3vtoruEfbIHpIWBJI9SprOUnxHx6J60dnUYfUuf6cIng080UPn7QwhS8k3hrl4
         VFEXM2rUMsrgAzTokMPgZN/cT03shAKtnKO7t+62VfCdGVAv0bYUJUf13uuEZsM4wYQA
         WipKUQdRxD0LFgeSwJisaRgAlE2dBMA7hui1YF7CIF7RaZWAEjApFQ3Ffd01jem6mAY3
         QH2Q==
X-Gm-Message-State: AOJu0YxHdZ4ERipl7TuJWaOp0V8TMd3Mof85r1fPJkyEkJPWktOCwZp1
        KgJspfd0I1bEKgO0unUt0Q0kQ+IZjwWxnX13toJtcA==
X-Google-Smtp-Source: AGHT+IESlLCp03SBdqseDxgs7HGGaCnWUi82EdGIBUyYoFDdg/kV3Wtu7IaPSKUrNV12K+J0pCN37EM86rUdQP7PWi8=
X-Received: by 2002:a0c:bf02:0:b0:675:5925:7e08 with SMTP id
 m2-20020a0cbf02000000b0067559257e08mr8062067qvi.32.1700146586474; Thu, 16 Nov
 2023 06:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-14-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-14-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 15:55:45 +0100
Message-ID: <CAG_fn=WOfRvDw3r3zcZXWr8aa6MiEuKSa1etQrGVSJP+ic7=mg@mail.gmail.com>
Subject: Re: [PATCH 13/32] kmsan: Support SLAB_POISON
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> kmsan_slab_free() to poison the freed memory, and by preventing
> init_object() from unpoisoning new allocations.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  mm/kmsan/hooks.c | 2 +-
>  mm/slub.c        | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 7b5814412e9f..7a30274b893c 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -76,7 +76,7 @@ void kmsan_slab_free(struct kmem_cache *s, void *object=
)
>                 return;
>
>         /* RCU slabs could be legally used after free within the RCU peri=
od */
> -       if (unlikely(s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)))
> +       if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
>                 return;
>         /*
>          * If there's a constructor, freed memory must remain in the same=
 state
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..8d9aa4d7cb7e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1024,7 +1024,8 @@ static __printf(3, 4) void slab_err(struct kmem_cac=
he *s, struct slab *slab,
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
>
> -static void init_object(struct kmem_cache *s, void *object, u8 val)
> +__no_sanitize_memory static void

__no_sanitize_memory should be used with great care, because it drops
all instrumentation from the function, and any shadow writes will be
lost.
Won't it be better to add kmsan_poison() to init_object() if you want
it to stay uninitialized?
