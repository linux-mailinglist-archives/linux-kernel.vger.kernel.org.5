Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B379B782867
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjHUL7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjHUL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:59:32 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AC90
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:59:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c4c7a83bcdso2009134fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692619170; x=1693223970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTg7Pfzlgj1crJFBBTiAr+4TTj7YL+SlhsKNIKDeb0c=;
        b=abr26lyW0+UkasnMMAQUwJFaYIOTMS/l++CwOOuUP9Z8F3vU0seHByEdRYji0yJ1iD
         /jwQl1Gljv+/m0aFPn8SRBQpdsjnTY5A9JLTv11EV6/ZdIYjxtKTo9+LTYtuVEIrKlXr
         44Ohq41ak3AzCGzy9sW1UR8Y6ZlLBhV1oYdYx0EAhrNyKfFZoWbXfA4swe9NiLDPqsi+
         gGT/gBj4N0Gi63iJS+Qwb9fzVMg617IeJi2YmbyyK79zQi+EZxm+GY5KCD26Ija7eFez
         KINRrHHoau6gXtuALsp9q9lqp+mnQnBJEcM7JnDX5RLC9zeEouvHaNbeFuDYZE3Pvune
         9tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619170; x=1693223970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTg7Pfzlgj1crJFBBTiAr+4TTj7YL+SlhsKNIKDeb0c=;
        b=ihYoKLgqWWeDI9BArLX2baFrSIW1lAevGDpzCKJWZYoQhvzmH+cHxwO0n7/AkZgNjR
         mWMQzepfOvj5/7PlTk6zgfI4vdVOz12W+oVtCbEWZn2hnZZfHF9XREI3ORxaeR/Bkl+m
         VizUIu4Td8QMqY4LtYjwUSmTYNJrJOMl2zRFa8NOJj+5KQPjBOgI9BZfYthV2xmzLy7Z
         Jj6CrzWcLERnvGiP7t+SjT41FOMYuUODfXwtpRgZG0i0BNjstMq9OF7ZjXuORVg64N0N
         w87mEnm+uv5vU54z8+XxCA5xaHXiGE4scg4loEbfMc3iz+R9/qQSBCZpprGobJ43hyhv
         lgsQ==
X-Gm-Message-State: AOJu0YyAMXmSG9unLCMsbqFvqPWqcFjVieKT/1lHLcuZ8bJ/kKhLvC8/
        frnYK4Yy20e/Z41IG42N7cSjqiAyqvb63Gd4oPG39A==
X-Google-Smtp-Source: AGHT+IFiiitBFVLXpwUe3sP/WkQ8fH+MysnM3V0IQlHVMFkm/mZANHhnDctsuY6avFLbAoPsi1ZYsvtkahKcKGv0qGM=
X-Received: by 2002:a05:6870:63a3:b0:1bb:c50d:7437 with SMTP id
 t35-20020a05687063a300b001bbc50d7437mr9170386oap.53.1692619170037; Mon, 21
 Aug 2023 04:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZN87UsqkWcFLDxea@swlinux02> <20230818132148.2237811-1-chengming.zhou@linux.dev>
In-Reply-To: <20230818132148.2237811-1-chengming.zhou@linux.dev>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Aug 2023 13:59:18 +0200
Message-ID: <CAKfTPtAwDtchtLBWNmwO2NWWf52Ra7BhdNnSLXQ6_bBwseWg0A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix cfs_rq_is_decayed() on !SMP
To:     chengming.zhou@linux.dev
Cc:     mingo@redhat.com, peterz@infradead.org, ycliang@andestech.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        zhouchengming@bytedance.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 at 15:22, <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> We don't need to maintain per-queue leaf_cfs_rq_list on !SMP, since
> it's used for cfs_rq load tracking & balance on SMP.
>
> But sched debug interface use it to print per-cfs_rq stats, which
> maybe better to change to use walk_tg_tree_from() instead.
>
> This patch just fix the !SMP version cfs_rq_is_decayed(), so the
> per-queue leaf_cfs_rq_list is also maintained correctly on !SMP,
> to fix the warning in assert_list_leaf_cfs_rq().
>
> Fixes: 0a00a354644e ("sched/fair: Delete useless condition in tg_unthrottle_up()")
> Reported-by: Leo Liang <ycliang@andestech.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..05e004515fde 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4654,7 +4654,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  {
> -       return true;
> +       return !(cfs_rq->nr_running);
>  }
>
>  #define UPDATE_TG      0x0
> --
> 2.41.0
>
