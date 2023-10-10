Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AB17C03AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbjJJSpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjJJSpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:45:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5CA7;
        Tue, 10 Oct 2023 11:45:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c60f1a2652so1266955ad.0;
        Tue, 10 Oct 2023 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696963546; x=1697568346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuwTA6W5clzCXb2ldm/5D+a5y7dBMzbzp8ouplsoM60=;
        b=DwI9KoqqN3mi0rruvgXgA2d4cKx0Q8qhL4LPEreZJkFAyhcqF83/IHKCd8XbjWw45y
         e8LYjw/zUPI/WuTeYd3qQhiuS1/OWQEboZkp9L2VuEx9jWAGM9yxdPqA9XqSp8cFBXaL
         AhA960fCN6G/eb4pZE8L3pN8C9J9Gmf8+i7iSJwUedXlMvrCwyU2UyxEtFCp0dsKF09N
         ZVMZgnXxn13TncmnfmVldpcxNFp3Kju9w04GRe9Gl74FjLgf3TYVw+qKZ8xslpG7KZq7
         +8QzdVQ+j6CM5Jb29ZfXA6sjIHkhFIG6/sHjyVOG39YI9pVsuMnERAWA27wV0KyF0+C/
         XzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963546; x=1697568346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuwTA6W5clzCXb2ldm/5D+a5y7dBMzbzp8ouplsoM60=;
        b=eYbP6JLh5Rm6vR+2zh1NUyc2ShvjkUTQ5xQmjVcIaDSM8zzl41yHzhG+vilUAToeIM
         cDS5BcOH6/+P1spux0jbIM4kTQOxXqsgZ5FCKcqorRZ3WjsdaE3Xfhj29esbF2BhNX2v
         CWJHkCgIrHS6+zDT/b+Sp+3Hzd1c6TKTdROuPzOuk2wiwTtjfBaV8nJ6WsSz0buI8Vo1
         fQ4HClDC8gmkWbaeoCJ5iUNIqGoc7VEPvpfEibFpPlaJXcQyf2815fE0yWRHxAhHUIVw
         4kDkoNMkwwVqbNU178w4CKe9OR2CDzAi4aMkJcGpRNuJTeR8krYiByIiW75rubhE2AQF
         naTw==
X-Gm-Message-State: AOJu0YwHpfPFGAXr/jNxYePCZrV6eEeFINgIDQM9Wj6PiPhk/HDJbDHQ
        tdBOrDtXwM7JRQsYq/t1/mk=
X-Google-Smtp-Source: AGHT+IHvXKvU9F6Gai1mrgeIR2jAjGfYSMywkjz/pPs6R/Fi58V5tSHmk2NjWWcmvKH5jy6ulkGtbg==
X-Received: by 2002:a17:902:a412:b0:1c3:e5bf:a9fe with SMTP id p18-20020a170902a41200b001c3e5bfa9femr18310492plq.30.1696963545736;
        Tue, 10 Oct 2023 11:45:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709028d8a00b001c6189ce950sm771701plo.188.2023.10.10.11.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:45:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Oct 2023 08:45:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] blk-mq: add module parameter to not run block kworker on
 isolated CPUs
Message-ID: <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
References: <20231010142216.1114752-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010142216.1114752-1-ming.lei@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Frederic)

On Tue, Oct 10, 2023 at 10:22:16PM +0800, Ming Lei wrote:
> Kernel parameter of `isolcpus=` is used for isolating CPUs for specific
> task, and user often won't want block IO to disturb these CPUs, also long
> IO latency may be caused if blk-mq kworker is scheduled on these isolated
> CPUs.
> 
> Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> the responsibility should be on wq user.
> 
> Add one block layer parameter for not running block kworker on isolated
> CPUs.
> 
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ec922c6bccbe..c53b5b522053 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -29,6 +29,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/part_stat.h>
> +#include <linux/sched/isolation.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -42,6 +43,13 @@
>  #include "blk-rq-qos.h"
>  #include "blk-ioprio.h"
>  
> +static bool respect_cpu_isolation;
> +module_param(respect_cpu_isolation, bool, 0444);
> +MODULE_PARM_DESC(respect_cpu_isolation,
> +		"Don't schedule blk-mq worker on isolated CPUs passed in "
> +		"isolcpus= or nohz_full=. User need to guarantee to not run "
> +		"block IO on isolated CPUs (default: false)");

Any chance we can centralize these? It's no fun to try to hunt down module
params to opt in different subsystems and the housekeeping interface does
have some provisions for selecting different parts. I'd much prefer to see
these settings to be collected into a central place.

Thanks.

-- 
tejun
