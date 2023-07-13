Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9718752B58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjGMUH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjGMUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:07:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC940E5C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:07:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7589b187so2021300e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689278872; x=1691870872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmyD6UuJlO+HcBnFreMiVGyFDB5o50ZGx/l9nM/sihU=;
        b=NeguS5X02pGP4ffeEjjxlNq0me/Gt5VNr/nMw/uHEZ/m18dK11kY/FVwzOqaK/Yqd8
         QRD+Z/yPsiH+w9NTmGDI7xUmg6xdjgLLrowYVt3izlXLx0BQdYz+ldywX+/6tGSU5tOr
         RCqfxQEZgtDsVqfJ2osostwY4wQUXGPGIqgsIGNBkVeZP6PAsLT8RdL6NlHUNvU+FbfJ
         MPdfLcj/KoO2gPZFUbZXDMCH4Je2JiCB9ICff1xRkADbci2rhrsKJOYxcNfzNpI+bRnI
         xx+QfrRxzXHmuFeqPN0lWADO/1o9DJiUTpsSO3RwdJgtqPnCVbGY+/8kDn14l50EU/+9
         MCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689278872; x=1691870872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmyD6UuJlO+HcBnFreMiVGyFDB5o50ZGx/l9nM/sihU=;
        b=l75noHGFmnKUBBBLYnudNYqiwn8VUnDa10OlCWPvOPQml1my7y7a7RAh8yKRm8PEBa
         SBb5p/mVDjKk+ofNQZpkKGTRiXUP/Mke+SMi8neVTRPL5B7pSG/HecIaQv5r+lHVGcCc
         rt42t5kiIYm6FmvGVTid5MBjANxzVq4ZMSfs/QxvFBfw5Ia7YUYHWOiLHdaMnWf6+ufs
         o9l1mxdjmwQi9kqJdsGHLYGABaCVeF75jTdQ3DZnVZmxM/b184SnGdoPXpPybymPWF2m
         fUIhjCXciRyE7rRQhZczOWV5/8g6+oxPhMdC3P13rr8N3PDdUnA425H8BIBEbC8t3LEW
         CiKQ==
X-Gm-Message-State: ABy/qLaAgflDcslFizuuLjEpLaqkvdLzsad6EZ8DL67g6U0Cj+AYojTR
        bn36wIzCklU7cNSlDwa7WQFYBburF9wWUc9F903DJJo2v0BxWL9g
X-Google-Smtp-Source: APBJJlGNalpJ/skfhn8F06OotfKQQWeVngDgh58gRYDIDKhLspBsOL2+/fmBtlqTSy5WfuUWVzuvCvnbop0wCZZ97eM=
X-Received: by 2002:a05:6512:3b7:b0:4fb:8987:734e with SMTP id
 v23-20020a05651203b700b004fb8987734emr1728293lfp.68.1689278871467; Thu, 13
 Jul 2023 13:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230516122202.954313-1-alex@shruggie.ro>
In-Reply-To: <20230516122202.954313-1-alex@shruggie.ro>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Thu, 13 Jul 2023 23:07:40 +0300
Message-ID: <CAH3L5QoBqSOBHhoxSrYw6U34gqTPEhi_RB_Cve-YmBzYj3LXAQ@mail.gmail.com>
Subject: Re: [PATCH][V2] sched/rt: Print curr when RT throttling activated
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tian.xianting@h3c.com,
        steffen.aschbacher@stihl.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 3:22=E2=80=AFPM Alexandru Ardelean <alex@shruggie.r=
o> wrote:
>
> From: Xianting Tian <tian.xianting@h3c.com>
>
> We may meet the issue, that one RT thread occupied the cpu by 950ms/1s,
> The RT thread maybe is a business thread or other unknown thread.
>
> Currently, it only outputs the print "sched: RT throttling activated"
> when RT throttling happen. It is hard to know what is the RT thread,
> For further analysis, we need add more prints.
>
> This patch is to print current RT task when RT throttling activated,
> It help us to know what is the RT thread in the first time.
>

Adding Greg on this patch, since it 's been a while.
And also: ping :)

> Tested-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>
> Initial patch submission:
>   https://lore.kernel.org/all/f3265adc26d4416dacf157f61fa60ad6@h3c.com/T/
>
> We've been having some issues of our own with some applications + some RT
> configuration =3D=3D some threads endded up taking too much CPU time.
> This patch came in quite in handy to see in logs which thread is more
> problematic.
>
> We've applied this patch onto a 5.10.116 tree. It did need a bit of
> re-applying since some context has changed since the initial version (hen=
ce
> the V2 tag).
> Since 5.10.116 (where we used it), it applied nicely to the latest/curren=
t
> linux-next tree (hence the Tested-by tag).
>
> It would be nice to apply this to the mainline kernel and have this handy=
.
>
>  kernel/sched/rt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 00e0e5074115..44b161e42733 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -995,7 +995,7 @@ static inline int rt_se_prio(struct sched_rt_entity *=
rt_se)
>         return rt_task_of(rt_se)->prio;
>  }
>
> -static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
> +static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, struct task_st=
ruct *curr)
>  {
>         u64 runtime =3D sched_rt_runtime(rt_rq);
>
> @@ -1019,7 +1019,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *=
rt_rq)
>                  */
>                 if (likely(rt_b->rt_runtime)) {
>                         rt_rq->rt_throttled =3D 1;
> -                       printk_deferred_once("sched: RT throttling activa=
ted\n");
> +                       printk_deferred_once("sched: RT throttling activa=
ted (curr: pid %d, comm %s)\n",
> +                                               curr->pid, curr->comm);
>                 } else {
>                         /*
>                          * In case we did anyway, make it go away,
> @@ -1074,7 +1075,7 @@ static void update_curr_rt(struct rq *rq)
>                 if (sched_rt_runtime(rt_rq) !=3D RUNTIME_INF) {
>                         raw_spin_lock(&rt_rq->rt_runtime_lock);
>                         rt_rq->rt_time +=3D delta_exec;
> -                       exceeded =3D sched_rt_runtime_exceeded(rt_rq);
> +                       exceeded =3D sched_rt_runtime_exceeded(rt_rq, cur=
r);
>                         if (exceeded)
>                                 resched_curr(rq);
>                         raw_spin_unlock(&rt_rq->rt_runtime_lock);
> --
> 2.40.1
>
