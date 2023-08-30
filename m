Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AE78DE74
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbjH3TC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbjH3JTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:19:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8B19A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:19:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so723787166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693387165; x=1693991965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN/Y4Au6Fot9Yqx1buRLtecwemR+yU1iAj0aDwfTk5E=;
        b=pbS5XW9BMq19I7Sv2BOzugfmtxKo9qyX+hTiCo0OkTNV5TqOOEl98LnX9+IvVItnYh
         uUMX7MhbIahtNLsyCSSZEZRzTDoxoHQn0EkzMl4snxIcaCqKczmssHRMEjTpSc59MQyl
         TE8PPdJulMSEgCvV8njOOqZiKyNU2GOyIqoAHohkVvYpzWm89oxMn98jWmMZfZ9AwSqy
         09l+ewtEmsNwQJiOccW65KIGcv/QsZw7s6VS99E+LdK9Kqft3OKVFG3xgSL5cyzJcyRv
         H1zJq3ck9xdbjsGI+AJbePl23cLBAYT1Rkd12UmtGVzQK8nLMTZyrCtRxqsZdH5+3uCs
         lb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693387165; x=1693991965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN/Y4Au6Fot9Yqx1buRLtecwemR+yU1iAj0aDwfTk5E=;
        b=WaK64EZ3qaQdFhuuuKD2Ke0VWWiBeU9N0KdUNq3HykaNllh+usM2mdNujQFx3LGUsv
         YytdCGBjA5CBmgxTTwcfTzzU16hCICpBCEKeVQ9ds5dFoamFiIomPhg+NNxECR6epx7n
         mec+YfNeOfipJif2NZHXHpDDqntaQcgQ/mNzjIqIi69jCw0bKiwx1BmpC96jAS++7ALp
         TFzQA6i+G9v65eqH9r4lSC3n2ey0h6lDxk7ZgkB5KmLeCSOtD/lJpn0q0uza7HcZ/G3O
         MbvFj74bmunicbE/WFbO7HI/gmaRrQHwPk3n12ihbDuwJupyF2IShE3bYOk/YF7TEFOU
         1cUw==
X-Gm-Message-State: AOJu0YwEBb6z1SU2bLRpCn6Ydgx/MwErTqFxdC9849AvslDpdOdHoWMI
        g10lTLGUMqsyE6jc0jAVxRWYI89OEF6h83YVT34=
X-Google-Smtp-Source: AGHT+IEVdHNedfLDWiyn/wLDgMe1D0HrwEXn/m91v58Z3MMrzjgBYi9a8xZ+AMrPVF47vwZAR/uRNSa6/nblWYS+Fcc=
X-Received: by 2002:a17:906:9517:b0:9a5:da6c:6539 with SMTP id
 u23-20020a170906951700b009a5da6c6539mr1287122ejx.75.1693387165246; Wed, 30
 Aug 2023 02:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230809062716.62123-1-nrf233@gmail.com>
In-Reply-To: <20230809062716.62123-1-nrf233@gmail.com>
From:   =?UTF-8?B?54mb6Iul6aOe?= <nrf233@gmail.com>
Date:   Wed, 30 Aug 2023 17:19:14 +0800
Message-ID: <CALJBpEcTPYFUmkkSKKS5WkFG0ekDHB-ZUeJacTGXZVOjP7yCzg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix burst unit mismatch error for cgroup v2 cfsb.
To:     peterz@infradead.org
Cc:     coonwel@gmail.com, qiang.zhang1211@gmail.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc:  linux-kernel@vger.kernel.org


NiuRuofei <nrf233@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=B8=89 14:27=E5=86=99=E9=81=93=EF=BC=9A
>
> The burstable CFS controller is introduced:
> Link: https://lore.kernel.org/lkml/20210316044931.39733-2-changhuaixin@li=
nux.alibaba.com/
>
> The original patch directly used the 'cpu.max' interface file, and it han=
dles the unit conversion
> when cpu_period_quota_parse() function called(something like this, *burst=
p *=3D NSEC_PER_USEC;), it works fine.
>
> However, in the official version,  the single "cpu.max" file was split in=
to 'cpu.max' and 'cpu.max.burst' interface files,
> and we don't parse 'burst' in cpu_period_quota_parse() function anymore. =
Instead, we call tg_get_cfs_burst() to get burst value,
> which return burst_time in microseconds. This could result in a unit mism=
atch bug.
>
> We can easily reproduce this bug using the following steps:
>         bash:/sys/fs/cgroup/mycgroup$ echo 25000 | sudo tee cpu.max.burst
>         25000
>         bash:/sys/fs/cgroup/mycgroup$ echo 50000 100000 | sudo tee cpu.ma=
x
>         50000 100000
>         bash:/sys/fs/cgroup/mycgroup$ cat cpu.max.burst
>         25
>
> Signed-off-by: NiuRuofei <nrf233@gmail.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c52c2eba7c73..e635598486a9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11380,7 +11380,7 @@ static ssize_t cpu_max_write(struct kernfs_open_f=
ile *of,
>  {
>         struct task_group *tg =3D css_tg(of_css(of));
>         u64 period =3D tg_get_cfs_period(tg);
> -       u64 burst =3D tg_get_cfs_burst(tg);
> +       u64 burst =3D tg_get_cfs_burst(tg) * NSEC_PER_USEC;
>         u64 quota;
>         int ret;
>
> --
> 2.30.1 (Apple Git-130)
>
