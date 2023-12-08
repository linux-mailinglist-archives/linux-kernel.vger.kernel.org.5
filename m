Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C698809707
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjLHARV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbjLHAQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:16:59 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083EF30F3;
        Thu,  7 Dec 2023 16:16:32 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c66418decaso1123416a12.3;
        Thu, 07 Dec 2023 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994592; x=1702599392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYaCvNQnFX8gSshhD0U4TjEw0tlZoDuU2wJUbPArFf8=;
        b=WIh5cGTz09wSE4+SUXHkBH+VTwBndYOxGzkeozcvyKdfK/K3Fsu0armv9KwvSU+vYW
         Uk7gEKBCTVZVBqnDIFp72D4fB1eBzO6FfQa2N+2AUMNai86Wogqznr/AkKTqgqe5wmwI
         Wqj4VIjlNyCz5uVP+USRejBrsW75pY4YVNNEM7DPOnx7LhFGBMg/UFf3+FBc8cUzgtRU
         as7lglpHrB7/0l/ehUbCYm5ibcQLtBzTpPCQNx6y79yV5Cz0LuN10CQamYsD0vYGqJiY
         3mLp58cVQ2QnhWC2ZeGSNwb+g+S3lmYmgC7Jy70JjTMdhGiF6iD+50bEG9e7GuUZTKPG
         Bwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994592; x=1702599392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYaCvNQnFX8gSshhD0U4TjEw0tlZoDuU2wJUbPArFf8=;
        b=w6XjlQtxBkiQZhKs1cunCI1AKhoGNv2mACktOFhN/quAb/g9eXpuvKHDkzyKH+39u7
         4qa1rKlJGEsQ9Hd0101F3kERG+5J5msZgS++Wmls+If1l2z2tiGjP78ry9bKkEhLjFoj
         1pdLi1UL24QtuN6b+ZU/upMt1agy25PCkj1acaCAugp6CbS3tTYg2i9NlQLfCgIn4Uik
         UggcBAL1HIi7zwAyBWTBmMKGWnpk3uOQ8qBPDQ2FFFCC5pIB5/T74MNB0mkhO3hw5gto
         /zE5u+cPhYkNd1/ayxPfbThxCi5ZFJnWdYLTpqrQhX5JsU+e1mSvurBL3rfRGX2vn2ac
         1UuQ==
X-Gm-Message-State: AOJu0Yx9pLpVC7DqHUqob5eCwQ44Sj4oX/VYdSrhjLAS+MlPzGOlHHyv
        HZI47Zw4wXGpJUjl3jp4Ar0=
X-Google-Smtp-Source: AGHT+IFy9HbQWTNcyN32kK0LC8FOvXZMYftP3rKNMYn/O6vKj3WIQqEzLjU+hOsNMtxdAsDBVSv4eA==
X-Received: by 2002:a17:903:191:b0:1d0:a53e:263a with SMTP id z17-20020a170903019100b001d0a53e263amr3271941plg.109.1701994592059;
        Thu, 07 Dec 2023 16:16:32 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id ba1-20020a170902720100b001d09c539c95sm403131plb.90.2023.12.07.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:16:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 7 Dec 2023 14:16:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Changwoo Min <multics69@gmail.com>
Cc:     kernel-dev@igalia.com, andrea.righi@canonical.com,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brho@google.com, bristot@redhat.com, bsegall@google.com,
        changwoo@igalia.com, daniel@iogearbox.net, derkling@google.com,
        dietmar.eggemann@arm.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, dvernet@meta.com, haoluo@google.com,
        himadrics@inria.fr, joshdon@google.com, juri.lelli@redhat.com,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, memxor@gmail.com, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        riel@surriel.com, rostedt@goodmis.org,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Subject: Re: [PATCH] scx: set p->scx.ops_state using atomic_long_set_release
Message-ID: <ZXJgXqQlHc1mgd1m@slm.duckdns.org>
References: <20231111024835.2164816-13-tj@kernel.org>
 <20231207020459.117365-1-changwoo@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207020459.117365-1-changwoo@igalia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 07, 2023 at 11:04:59AM +0900, Changwoo Min wrote:
> p->scx.ops_state should be updated using the release semantics,
> atomic_long_set_release(), because it is read using
> atomic_long_read_acquire() at ops_dequeue() and wait_ops_state().
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 53ee906aa2b6..3a40ca2007b6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -881,7 +881,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
>  
>  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> -	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> +	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);

atomic_long_load_acquire() are used when waiting the transitions out of
QUEUEING and DISPATCHING states. ie. the interlocking between writer and
reader is necessary only when transitioning out of those states. In the
above, @p is going into QUEUEING and release/acquire isn't necessary.
Selectively using them is kinda subtle but it's less confusing to keep it
that way, I think.

Thanks.

-- 
tejun
