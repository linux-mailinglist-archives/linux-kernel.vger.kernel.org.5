Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C447BCDEB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbjJHK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbjJHK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:58:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32473BA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7pI/ahoeLwQta1iBDvRGZESmSgf9li60JTBecFWXMxk=; b=jgzOlfO4cO3bnYQRy5enV0Nj+e
        WPnanc4s50xLJds4z9pWdVpVuHwzAi2FgJDtp+//bEdUaORyFosJt47wlODgy+0CuIaTOSTt6x2Yn
        +1UIClin7Q1J60m7IXGWfkRpwjbJyeu1AIDFDmIMI113MYYPPVAd+tbWbIqPKbK684eea3iYVCHEk
        ItEV6Vp3Jve5dKHvIy1ECq8i3hXXD23uCs/SeHMTd0mhhDzIPUkTD14hysoPCgQ+83kTxhc9LihmK
        5OyBieTKMQxbDDh+7tCol/hdvB7QbuGyWf1DHOoNH+l9cNrPbE87GswoduqxnvBPtX+ZWJOVy7OQM
        Gx8QAn6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpRU0-00EeBZ-28;
        Sun, 08 Oct 2023 10:58:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7986300687; Sun,  8 Oct 2023 12:58:01 +0200 (CEST)
Date:   Sun, 8 Oct 2023 12:58:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "brookxu.cn" <brookxu.cn@gmail.com>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
Message-ID: <20231008105801.GC6320@noisy.programming.kicks-ass.net>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 06:49:37PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> Since in some scenarios we still want to get the task delayacct
> through taskstats, so commit <0cd7c741f01de> introduces a sysctl to

This is not the canonical way to reference a commit.

> enable it dynamically. However, since task->delays is allocated
> during fork(), task->delays will not be reallocated when delayacct
> is enabled later. This will make we cannot get the delayacct of old
> tasks, but the new tasks cans. This can easily lead to confusion.
> Therefore, try to workaround this issue by convert task->delays to
> an object.

And grow task_struct for no reason? I think not.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..5cc78184a31f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -37,6 +37,7 @@
>  #include <linux/kcsan.h>
>  #include <linux/rv.h>
>  #include <linux/livepatch_sched.h>
> +#include <linux/delayacct.h>
>  #include <asm/kmap_size.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
> @@ -1331,7 +1332,7 @@ struct task_struct {
>  	struct page_frag		task_frag;
>  
>  #ifdef CONFIG_TASK_DELAY_ACCT
> -	struct task_delay_info		*delays;
> +	struct task_delay_info		delays;
>  #endif

Yeah, no.
