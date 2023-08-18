Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110E0780BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376855AbjHRMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376876AbjHRMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:25:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E4103
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:25:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-688731c6331so680297b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692361515; x=1692966315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rQ85OeCDX21R8DuR1sbbC2fOF//3QjsHpvW0X/iXrOY=;
        b=U/nyOu4ZptNvLvXi2x/m+ILjuI0nALdi3p30wTD43SwnkxlJQWhwCfI6bt1msDGdzg
         JBCROdnuo3dmhw3ZzS12Yy50Ujii4cAChIK88RBe7pfc/qKmlYpe4HRS2PiB+vNbaQ+6
         RRjsSKnAP1Va/MI/OWMvIEf/FqA0m8OfvkHXM8FKBB1aZE4GrOCVhU2gYvpULIbIjV4k
         FLolls8Hr2pW8XXGAayNQBgs/G9WTJWHmvv9lV2TWAhOw6zut56Aw6D/c94PROJtLg2k
         +sm1yaw9j8gpRJaWw3xKnG7ya5mg6ynVmKPhypxkaGgySOpXIsxPtpru8u4MMs73IJrA
         Udxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692361515; x=1692966315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQ85OeCDX21R8DuR1sbbC2fOF//3QjsHpvW0X/iXrOY=;
        b=dH8hKiburie9+2EHTfSXhaoNgSxwLGDKES2+QLn4FkAyNqwz9KdC+BcPG0bGVjD7L9
         A3R4HOF24p8vuXhmydctiKoBtgqoOC2GumJm1y5tQJ/x5z/B9zgVdI/27QgExCH1PN48
         SDTEWGJQ1LzT4caLGK+vyAM5s0/GVlmegrH7nYtMDL1IH8AYN0b3WCmJ8hHgmBv4b6W9
         JzPfvlssiHtNUfkQMDJv12/8UqdKwdBGBFRE/6SvwP1vbot4lG4WLjkkCEHfJrq+I8f9
         GGA9YEJohxBQIeQzc4HiQJvKVQaT81W+w7Jmj00pyuCOXj4+kHSx9ghtqU5NDw2sDAIz
         bBqA==
X-Gm-Message-State: AOJu0YwTw5X+a7o3ox83oDWWV9EtloqxGsLBo7OxBk77Na4bEmYwMxQ0
        0EYZ/+w7o1y7ox+x7CkhKBljSybs0ZOAJ9mtymuNuQ==
X-Google-Smtp-Source: AGHT+IGjlx0JXcJm4vzuRRl6t/1XlPMX2rDZpE1q4KHdIe+6fDyvQ6X7Njxz558VwfjUqRXvi1TT897JuYppz1caAwo=
X-Received: by 2002:a05:6a00:1952:b0:671:4b06:4ea7 with SMTP id
 s18-20020a056a00195200b006714b064ea7mr2504003pfk.15.1692361515120; Fri, 18
 Aug 2023 05:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <ZN87UsqkWcFLDxea@swlinux02> <20230818113537.2231129-1-chengming.zhou@linux.dev>
In-Reply-To: <20230818113537.2231129-1-chengming.zhou@linux.dev>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Aug 2023 14:25:03 +0200
Message-ID: <CAKfTPtAX4_yspgx3Fm88+2OVFobutJqxJKBARo3o9cRdVU1XYw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix cfs_rq_is_decayed() on !SMP
To:     chengming.zhou@linux.dev
Cc:     mingo@redhat.com, peterz@infradead.org, ycliang@andestech.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        zhouchengming@bytedance.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 at 13:37, <chengming.zhou@linux.dev> wrote:
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
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..00ef7e86a95b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4654,6 +4654,8 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  {
> +       if (cfs_rq->load.weight)
> +               return false;
>         return true;

Why not :

return !(cfs_rq->nr_running);

The above seems easier to understand although I agree that both do the
same thing at the end

>  }
>
> --
> 2.41.0
>
