Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26C778C89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjHKK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjHKK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7576268C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691751507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoyXRTUZSWu0ttjcwGJ+MhkUvJX5qcOZJQvXWnNz76U=;
        b=EjaMPBcORX2vmtTLmTpyCBPlM2aZ8shYO4eNfJcdB5nwz1IfvECqda6qFLtm3kj4/Qik9z
        RataDZ27ge9qk0jkdoJAtHU0JjpsUj4XbRl69LErz1DGOA/KDg54JFAh1H0a5CGvgMQTgq
        iLoSPGsjoxiykwrFX6OYbHKCfUl6dj8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33--GytRdlTPYSHIbmU3k406A-1; Fri, 11 Aug 2023 06:58:26 -0400
X-MC-Unique: -GytRdlTPYSHIbmU3k406A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9d0b3a572so20249171fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691751504; x=1692356304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoyXRTUZSWu0ttjcwGJ+MhkUvJX5qcOZJQvXWnNz76U=;
        b=c3SW+yX93Ffd/AmfIvnyk66f0dT/1LaWCja1EX7aAgjzmV4sV1x4yLE7+p57DrzYeP
         7dpUUN0BVxlRJ1lCH1THj53F4ilkeASMyaYO9gKLuQ94t+ppVppaE5dNTn6vxel4tiS7
         XYH+d+OjYHSb0fDfWtcDb8a7W0I8gDGZPnDMlEPX6M20cbHP2TRG+zvrQA6iXw5A4DIi
         6SFY1p/WL+g+msK0fmp6ei3gL126s+e3PeynSpdgkE75UCJ5Eh8z72IERTL/KlkIWaMm
         c1w/zGuvB3zCaFZyfKnVZiqpPIt6yz3rc0jXN7RSenFBiRuRrvdAtdiH6g2vW/LxN6SR
         584Q==
X-Gm-Message-State: AOJu0YxVOyTjWTo0TVAGV6kndaCeZmwNkI+uAfcVWEivb/12FS7EKOF+
        llcWB3AXDsu8UDzyFnNH1ZUhvK7TeReuzNvuSOo60+03oGDTwMEyGQWibaqzL+/8/a8+kp78DRS
        C3TER+RTNyRbju+EAmNVZTA7hSYpDa2G9Yywnkwqq
X-Received: by 2002:ac2:4883:0:b0:4fe:df7:bcf5 with SMTP id x3-20020ac24883000000b004fe0df7bcf5mr1028204lfc.8.1691751504538;
        Fri, 11 Aug 2023 03:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqDCR+c+QPLCQg4ciXrFBP4JSxKxuft5Xecs2/1nJjqITeCH5e2d/3qYZ2HP8iYniHecbQJLRluxEMS7NvXLk=
X-Received: by 2002:ac2:4883:0:b0:4fe:df7:bcf5 with SMTP id
 x3-20020ac24883000000b004fe0df7bcf5mr1028193lfc.8.1691751504208; Fri, 11 Aug
 2023 03:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230810021640.252033-1-ming.lei@redhat.com>
In-Reply-To: <20230810021640.252033-1-ming.lei@redhat.com>
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Fri, 11 Aug 2023 18:59:25 +0800
Message-ID: <CAGS2=Ypt3U6AiR77B-WDUMB5atGt9YsuQoEn+PgZVmcH0n8tXg@mail.gmail.com>
Subject: Re: [PATCH] lib/group_cpus.c: avoid to acquire cpu hotplug lock in group_cpus_evenly
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,
I don't find any IO block after apply the patch.

Tested-by: Guangwu Zhang <guazhang@redhat.com>

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8810=E6=97=A5=
=E5=91=A8=E5=9B=9B 10:22=E5=86=99=E9=81=93=EF=BC=9A
>
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
>
> Then dead lock is caused:
>
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
>
> 2) error handler is waiting for CPU hotplug lock
>
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
>
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly()=
,
> in which two stage spreads are taken: 1) the 1st stage is over all presen=
t
> CPUs; 2) the end stage is over all other CPUs.
>
> Turns out the two stage spread just needs consistent 'cpu_present_mask', =
and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.
>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-block@lists.infradead.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/group_cpus.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index aa3f6815bb12..15006e79196f 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -348,6 +348,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s)
>  {
>         unsigned int curgrp =3D 0, nr_present =3D 0, nr_others =3D 0;
>         cpumask_var_t *node_to_cpumask;
> +       cpumask_var_t local_cpu_present_mask;
>         cpumask_var_t nmsk, npresmsk;
>         int ret =3D -ENOMEM;
>         struct cpumask *masks =3D NULL;
> @@ -355,6 +356,16 @@ struct cpumask *group_cpus_evenly(unsigned int numgr=
ps)
>         if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>                 return NULL;
>
> +       if (!zalloc_cpumask_var(&local_cpu_present_mask, GFP_KERNEL))
> +               goto fail_local_pres_mask;
> +
> +       /*
> +        * Make a local cache of 'cpu_present_mask', so the two stages
> +        * spread can observe consistent 'cpu_present_mask' without holdi=
ng
> +        * cpu hotplug lock.
> +        */
> +       cpumask_copy(local_cpu_present_mask, cpu_present_mask);
> +
>         if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
>                 goto fail_nmsk;
>
> @@ -366,13 +377,11 @@ struct cpumask *group_cpus_evenly(unsigned int numg=
rps)
>         if (!masks)
>                 goto fail_node_to_cpumask;
>
> -       /* Stabilize the cpumasks */
> -       cpus_read_lock();
>         build_node_to_cpumask(node_to_cpumask);
>
>         /* grouping present CPUs first */
>         ret =3D __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -                                 cpu_present_mask, nmsk, masks);
> +                                 local_cpu_present_mask, nmsk, masks);
>         if (ret < 0)
>                 goto fail_build_affinity;
>         nr_present =3D ret;
> @@ -387,15 +396,13 @@ struct cpumask *group_cpus_evenly(unsigned int numg=
rps)
>                 curgrp =3D 0;
>         else
>                 curgrp =3D nr_present;
> -       cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> +       cpumask_andnot(npresmsk, cpu_possible_mask, local_cpu_present_mas=
k);
>         ret =3D __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
>                                   npresmsk, nmsk, masks);
>         if (ret >=3D 0)
>                 nr_others =3D ret;
>
>   fail_build_affinity:
> -       cpus_read_unlock();
> -
>         if (ret >=3D 0)
>                 WARN_ON(nr_present + nr_others < numgrps);
>
> @@ -406,6 +413,9 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s)
>         free_cpumask_var(npresmsk);
>
>   fail_nmsk:
> +       free_cpumask_var(local_cpu_present_mask);
> +
> + fail_local_pres_mask:
>         free_cpumask_var(nmsk);
>         if (ret < 0) {
>                 kfree(masks);
> --
> 2.40.1
>


--=20
Guangwu Zhang
Thanks

