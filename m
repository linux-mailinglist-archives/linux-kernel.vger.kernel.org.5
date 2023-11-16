Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FEA7EE5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjKPRYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKPRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:24:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972381A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:24:07 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ce5b72e743so8895ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700155447; x=1700760247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxrwYPS2UXkYH5vJnr9A5YVDipfIzNaz0lzuX0Xmv0I=;
        b=irctMJkuQHl395qk1zZSnnb1uRrxAh1I2QfTBzgJHJRnlELvi545Jsv3n46PDJAvLN
         H6q1zJJfkQ/82FSzmMS+x9avgRyvoDDNL+ryPh03d7SpXvHrbtMttCMyPY6k2AlFoviK
         09XVrxHO0vX1QL5+tpehlJLb+mSYpWX1P4UuM56z7XhLbnTxtW0UZ9PLmQe8/Re130Vf
         n9rvaWjpOOw+TACvenRoh5B0FGSjw6L4acXbTUoV+rKPhhtij0N5KmYfzUaM2wpmkY+F
         c2Ersp2t1jD3GlAlR4FFMNtiAeF+NZchC4F1tpm2POWX4SFD1/Pbgic72Aw9lbXhgo+g
         KB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700155447; x=1700760247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxrwYPS2UXkYH5vJnr9A5YVDipfIzNaz0lzuX0Xmv0I=;
        b=c8PQQQQ0xrnErRYyCOXm2h73YNm3nQHBOdCuwlAAELnGXJVrrnyNW5nHEWmi85YejK
         +qThnQoXo/lwT3UoywMMkjwxBIKWhiKJAs5TEr0xKN70DkdwoIs+k372BkNOpAety7wb
         IE+zzXsUWNnSsvSX6mRhUpZ2cGKQpIO1EmepkPpgLNIUD1tGoAizM723PT6UWm74N28O
         mqblV8vqSvzQTvvJTqfS8KVrlTFwyCRUxZvTOx99HTmludQO7wogLQ8cRXru5rRwF86h
         tXeQesECLxkTsxQ7TQrb9po16lxQf2zLPOJm+CZn5bJfojewyWrTwOwCt9/lC0RPaV8Z
         tFRg==
X-Gm-Message-State: AOJu0YxWByb4rSdX5+z0iQlquTSxtr1GkDI7CCA2lPwG4o6J9q3FioGV
        qFJR8YCUaLyiB0fQz4CC9w97BSvu8i/RB+iGW5XFMQ==
X-Google-Smtp-Source: AGHT+IFr8rUGSROBx+KthnbMWFjb114D0XucdKv2i+7CAsyNBKWK/XLKLVYkxswJRzGDWuZeAfXfu5JQ88fyMqoyh6M=
X-Received: by 2002:a17:902:dace:b0:1cc:38c4:5448 with SMTP id
 q14-20020a170902dace00b001cc38c45448mr318339plx.22.1700155446770; Thu, 16 Nov
 2023 09:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20231116025109.3775055-1-roman.gushchin@linux.dev> <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz>
In-Reply-To: <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 16 Nov 2023 09:23:55 -0800
Message-ID: <CALvZod6_SWk8CUCW+9CToxEozfQZiCqW26anTQS7CdpRrPwzUA@mail.gmail.com>
Subject: Re: [PATCH] mm: kmem: properly initialize local objcg variable in current_obj_cgroup()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:04=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 11/16/23 03:51, Roman Gushchin wrote:
> > Actually the problem is caused by uninitialized local variable in
> > current_obj_cgroup(). If the root memory cgroup is set as an active
> > memory cgroup for a charging scope (as in the trace, where systemd
> > tries to create the first non-root cgroup, so the parent cgroup is
> > the root cgroup), the "for" loop is skipped and uninitialized objcg is
> > returned, causing a panic down the accounting stack.
> >
> > The fix is trivial: initialize the objcg variable to NULL
> > unconditionally before the "for" loop.
> >
> > Fixes: e86828e5446d ("mm: kmem: scoped objcg protection")
> > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1959
> > Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: stable@vger.kernel.org
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> We could also do this to make it less confusing?
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..a08bcec661b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3175,7 +3175,6 @@ __always_inline struct obj_cgroup *current_obj_cgro=
up(void)
>                 objcg =3D rcu_dereference_check(memcg->objcg, 1);
>                 if (likely(objcg))
>                         break;
> -               objcg =3D NULL;
>         }
>
>         return objcg;
>
>
> > ---
> >  mm/memcontrol.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 774bd6e21e27..b138501e6489 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3165,6 +3165,7 @@ __always_inline struct obj_cgroup *current_obj_cg=
roup(void)
> >       return NULL;
> >
> >  from_memcg:
> > +     objcg =3D NULL;
> >       for (; !mem_cgroup_is_root(memcg); memcg =3D parent_mem_cgroup(me=
mcg)) {
> >               /*
> >                * Memcg pointer is protected by scope (see set_active_me=
mcg())
>

For Roman's change and Vlastimil's cleanup:

Acked-by: Shakeel Butt <shakeelb@google.com>
