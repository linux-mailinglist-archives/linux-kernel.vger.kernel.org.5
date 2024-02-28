Return-Path: <linux-kernel+bounces-84734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC286AAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511E5B27C64
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A037141;
	Wed, 28 Feb 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec0qze6U"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597231A94
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111102; cv=none; b=KGFmgfRq6LJVc7VcF1ID564CbRATSZ57eg6o2Lwd/1Bc66pxONcv+h2vwNvpJGtslwg7h1yutLICuUsEPI58dWMkiqIZaGElbKNDuws5C1YadiJ1RT1rZoGNdyj7wk2Bhz9H1LkjcLPYVPS98r75gLa6sxE9VMqjSm6i45beQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111102; c=relaxed/simple;
	bh=SDCpujFx5m5R0akdtleqZP5cL0KU7Bh/tEDxQF2W9Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohUtQien8PAJxm4HmboPFnQlgMQaN0fbCYg/ArjlibDFCCKuKsfWnE6UHHmJTWxpObMwA8Sz8QBF4YXy/PfafIKtxySIZf2iN4MHobivgRa5oYZo9j3Hbl6fsmdhuRldLntGtkW8rh8z8vB3qNIakQ2GIziOLUWizCseF2waw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec0qze6U; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21e45ece781so3670116fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709111100; x=1709715900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lSdBPhRhYoA6tG059iv5wc9BFzvxS6RSQIxJahrV4s=;
        b=ec0qze6UKPfdkCjq3HUV01ZzVqdAuBsyLgM8TQ+abHnF9+9aPubgoviC2/bvyI5NBC
         RqeGO3u6dVE24u+mHPVnx4Ye4yGL3pC+5CmLJxvsbZqCJ+miH+zSFPG/TFE8gL3L8GeU
         sem2uXuLA35/92c6BicqSZm6BNrTX7jb9f4P9OKH1edtCTmwlr1nLwx9T4jNaTuhqZan
         bpiweGQY2TKE6rgzxy/XdT9QjY4APVW/DbMB1ZPksSLPPMgT4G5eo6JK3aGeXp6rqGyM
         0lDhzae+XAwlk+R9DPQOenKF94iZlFlMC9/cl7aWdHzlcb+pWwFlPxHZBvwqAUo4uA0E
         ZJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111100; x=1709715900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lSdBPhRhYoA6tG059iv5wc9BFzvxS6RSQIxJahrV4s=;
        b=bskMaYVBGPnZ/nkBq7pSm92mTFWp+ItGoK/AX0kiNZx1jRAUrPwEI3FsgeWJTLyLg1
         82qx4ted7DXYdvLbhsBcBW77T2zM3PhuM3YJpf6UkoMhVgIytJKz1/lwr8pNXexli9mV
         pfaMvNEvSdhO0516DfoGYq5WrodoCoXlo4qyouT6IfA02RsxN4SABTBEky3NRx3jORBZ
         qV0EZB641UlHbFQjTKB9PLfpLq2dKIQpdIFDW4WqxILkt/nqfJvCK9b0fpAA4PedPQIp
         rLr6vXPLjiKXFbOr8mqv/pCFBnhsHKFHUOt3aLKXkf2uP/w3oC8X2/50m8Kp62lHqKr5
         8v0g==
X-Forwarded-Encrypted: i=1; AJvYcCWXNAn9bkPtgnK94Fqj8M34g4U2wlInoc+51hZJ2Bj7eVUrzjbm92mQsaS771MeDLYm3rfeu70VOZgEsgVvOOvgSx+SPU7W8enIRHz1
X-Gm-Message-State: AOJu0Yz73oz0dMeWV7F3Rd8vM7od5HC9ggxet6vsI2QspXAUW+UqXeCE
	8YluiBHRC1k+3+kFHo7DYFw+gzOQpjEAtp+3bx0/HORDQE6D5aJ/bktNQGVyS1AvofzP5Tzfib3
	z8fq809vTLNlAGRuqVWe3LCPIGyc=
X-Google-Smtp-Source: AGHT+IFf7dpzGQRvPZ5WZgSU3qwbVKQxyt5TtlLk+bHEwPzaabBTrlvz5zd9+NUI/uvF1K5LMw6p41jl+9H9ds9y9x4=
X-Received: by 2002:a05:6870:ac0d:b0:21e:8853:5edb with SMTP id
 kw13-20020a056870ac0d00b0021e88535edbmr14894311oab.6.1709111100232; Wed, 28
 Feb 2024 01:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226082349.302363-1-yu.c.chen@intel.com>
In-Reply-To: <20240226082349.302363-1-yu.c.chen@intel.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 28 Feb 2024 17:04:49 +0800
Message-ID: <CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xbx94w@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, Tim Chen <tim.c.chen@intel.com>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, 
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu

On Mon, Feb 26, 2024 at 4:26=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> There is occasional report from lkp that the kernel hits the NULL pointer
> exception:
>
> [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 000=
0002c
> [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> [  512.082337][ T8305] *pde =3D 00000000
> [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        =
W
> [  512.086203][ T8305] EIP: set_next_entity (fair.c:?)
>
> This is caused by NULL candidate returned by pick_eevdf() as Abel analyze=
d.
> After
> commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> the NULL candidate would trigger the NULL pointer exception. While before
> this commit, there would be warning.
>
> This NULL entity issue was always there before above commit. With debug
> patch to print the cfs_rq and all the entities in the tree, we have the
> information when the issue was reproduced:
>
> [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 min=
_vruntime:763383370431
> [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:184358520135=
62231446
>                         min_vruntime:18437121115753667698 vruntime:184358=
52013561943404, load:629
> [  514.536772][ T8390] Traverse rb-tree from left to right
> [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:=
763383370431 vruntime:763383370431 non-eligible
> [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:=
763760947228 vruntime:763760947228 non-eligible
> [  514.538539][ T8390] Traverse rb-tree from topdown
> [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vr=
untime:763383370431 vruntime:763383370431 non-eligible
> [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vr=
untime:763760947228 vruntime:763760947228 non-eligible
> [  514.540340][ T8390] Found best:0x0
> [  514.540613][ T8390] BUG: kernel NULL pointer dereference, address: 000=
00074
>
> We can see that non of the entities in the tree are eligible, neither is
> the current entity on this cfs_rq. As a result, curr is set to NULL:
> if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>         curr =3D NULL;
>
> and the best is set to NULL, which caused the problem:
> if (!best || (curr && entity_before(curr, best)))
>         best =3D curr;
>
> The cause is that, the curr is eligible, but vruntime_eligible()
> returns false. And the false negative is due to the following
> code in vruntime_eligible():
>
> return avg >=3D (s64)(vruntime - cfs_rq->min_vruntime) * load;
>
> According to the log, vruntime is 18435852013561943404, the
> cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 =3D 2677,
> thus:
> s64 delta =3D (s64)(18435852013561943404 - 763383370431) =3D -10892823530=
978643
>     delta * 2677 =3D 7733399554989275921
> that is to say, the multiply result overflow the s64, which turns the
> negative value into a positive value, thus eligible check fails.
>
> So where is this insane huge vruntime 18435852013561943404 coming from?
> My guess is that, it is because the initial value of cfs_rq->min_vruntime
> is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this cas=
e)
> seldom scheduled in, its vruntime might not move forward too much and
> remain its original value by previous place_entity().

Could you please test the follow patch:

https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com/

Because the se->vruntime would be changed in place_entity() and
reweight_eevdf(),
however, now the vlag may exceed eevdf's limit in some scenarios, it may ca=
use
the vrunitme's error.

>
> The proper fix should deal with the overflow of entity_key() * load, but
> I don't have much clue on that, so propose this conservative method to
> restore the previous behavior before the mentioned commit.
>
> Fixes: 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@in=
tel.com/
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..fb9202f464e2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -880,7 +880,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq =
*cfs_rq)
>         struct rb_node *node =3D cfs_rq->tasks_timeline.rb_root.rb_node;
>         struct sched_entity *se =3D __pick_first_entity(cfs_rq);
>         struct sched_entity *curr =3D cfs_rq->curr;
> -       struct sched_entity *best =3D NULL;
> +       struct sched_entity *best =3D NULL, *leftmost;
>
>         /*
>          * We can safely skip eligibility check if there is only one enti=
ty
> @@ -905,6 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq =
*cfs_rq)
>                 goto found;
>         }
>
> +       leftmost =3D se;
> +

Maybe judging which of the deadlines of curr and se is smaller is better?

>         /* Heap search for the EEVD entity */
>         while (node) {
>                 struct rb_node *left =3D node->rb_left;
> @@ -937,6 +939,15 @@ static struct sched_entity *pick_eevdf(struct cfs_rq=
 *cfs_rq)
>         if (!best || (curr && entity_before(curr, best)))
>                 best =3D curr;
>
> +       /*
> +        * entity_eligible() could bring false negative due to
> +        * multiply overflow, which reports no eligible entity.
> +        * Return leftmost entity as a backup(it is guaranteed
> +        * the tree is not NULL.
> +        */
> +       if (!best)
> +               best =3D leftmost;
> +
>         return best;
>  }
>
> --
> 2.25.1
>
>

BR
--
xuewen

