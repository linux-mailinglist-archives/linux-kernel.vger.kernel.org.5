Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A87C536C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjJKMR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjJKMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:17:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481B19B9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:17:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692779f583fso4849418b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697026628; x=1697631428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZZVqpdFFvvsTtGUfWSWk8kbvgYxHEIhPQBVUennje4=;
        b=bJsKKModK7fyQeL5AWJK2nGoI+XmfurRLYF+0HXB/ObfzmioQgZCj4+9/lSsoFkZVN
         ktOgCE4ETaXm5vMY38OS/ZMMc9ueEaa8YIPas6ZIjcCHlUSoOxtYd/T2fNExhUBd8tCR
         qOgZy4di+I5kzTWRcRg8dSgTSu5bMNJSsIrvha3NPgce1ndaqEnXzpJjaELrFW32tepo
         z29DuoJtV/h/33Pbwl66A0JvUr+aYGXclaFOdrXCU6kr+bb1RuobgKpVealAQhNxMdcp
         Gyxc9KbrgxcuxNgJlVVGDrJvbI36W0IxwEzLqWuMmMf/f7aVLUZgCGb6uxLE1oaq7HFt
         q23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026628; x=1697631428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZZVqpdFFvvsTtGUfWSWk8kbvgYxHEIhPQBVUennje4=;
        b=Hbpc2/FNeqBa+u1GjAQgS0WUb0ZGBOHNgxmW8nIt4KuFWLrYXblewOWQgtPZgay2nC
         58bQ4ONLhkyeGD14Vu6rU4BIXFL+pu2Si+OcT1uLpPI8M688c7AQg4uTHV7iyMmu/EV6
         XtM6Mf8+QHQhm5KV9EhWbz6gClyur7v2V6+uFkr8TkTsSWEkdygWSysfW5v4RCJEnMMa
         L83YToqagcZU8ItkPDUeZCiZ/Or9BN5frGbwH6eKfz0lSlA1Nq74M4PFvYXFuJzQapBa
         /XlGTCYbNKzpTEmRnljmEDyv3vk2oqNtCj1j4H0t74DJordjW3W6ARYmyAue+hnWXTqO
         nCvA==
X-Gm-Message-State: AOJu0YxcRPSyy0uoDp+2HcFfbYYIjOxANADxHfqeS0U63LeRrOKwtdqI
        q/0Cc9wgH9yqcWHtVqQX2bO1hcrApVYyFazH3eY=
X-Google-Smtp-Source: AGHT+IGuS8ZrP3WTmhWldo0gf4u9olT2cZSutj+xSn+FZaYFrfqxRfsvdZ3pHeUjljUY/kH253gv/EBVLeZQYeqXDHQ=
X-Received: by 2002:a05:6a20:4414:b0:159:cf93:9b50 with SMTP id
 ce20-20020a056a20441400b00159cf939b50mr24283177pzb.46.1697026627824; Wed, 11
 Oct 2023 05:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231011024842.3348767-1-longman@redhat.com>
In-Reply-To: <20231011024842.3348767-1-longman@redhat.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 11 Oct 2023 20:16:56 +0800
Message-ID: <CAJhGHyDc540v+45xNx4mtWF9O=3soxEh_p7eyGQGP48n+_o2Vg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:49=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
> Commit 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active=3D=3D1
> to be ordered") enabled implicit ordered attribute to be added to
> WQ_UNBOUND workqueues with max_active of 1. This prevented the changing
> of attributes to these workqueues leading to fix commit 0a94efb5acbb
> ("workqueue: implicit ordered attribute should be overridable").
>
> However, workqueue_apply_unbound_cpumask() was not updated at that time.
> So sysfs changes to wq_unbound_cpumask has no effect on WQ_UNBOUND
> workqueues with implicit ordered attribute. Since not all WQ_UNBOUND
> workqueues are visible on sysfs, we are not able to make all the
> necessary cpumask changes even if we iterates all the workqueue cpumasks
> in sysfs and changing them one by one.
>
> Fix this problem by applying the corresponding change made
> to apply_workqueue_attrs_locked() in the fix commit to
> workqueue_apply_unbound_cpumask().
>
> Fixes: 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active=3D=3D1 to =
be ordered")
> Signed-off-by: Waiman Long <longman@redhat.com>

Hello Waiman Long

Thanks for the fix.

> ---
>  kernel/workqueue.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index d141bd8eb2b7..19d403aa41b0 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5785,9 +5785,13 @@ static int workqueue_apply_unbound_cpumask(const c=
pumask_var_t unbound_cpumask)
>         list_for_each_entry(wq, &workqueues, list) {
>                 if (!(wq->flags & WQ_UNBOUND))
>                         continue;
> +
>                 /* creating multiple pwqs breaks ordering guarantee */
> -               if (wq->flags & __WQ_ORDERED)
> -                       continue;
> +               if (!list_empty(&wq->pwqs)) {

I don't remember why the same test is needed in 0a94efb5acbb.
And I can't figure it out now.

I think it needs some comments or to be removed.

Thanks
Lai
