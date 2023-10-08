Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD37BCDE8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbjJHK4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbjJHK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:56:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEF2AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bGUP9QtcJkJxOjkvklPRJzMVTLBU5GEL0fYQ0T8DzuY=; b=sUEIDuzWk6CjhHzlf4vt+f1U1E
        ls6flOjftAlWIyXR/weSDUz9/JP0SFLnZPrFv3pOB0f5NFfO7NyzNLYM0g8ImcyZ24D38v0Wyphgi
        sri3xf3jh1WnVoKfhDEtbgJb197GRGs90vxeDEjjOAZpbxpaFxb/AVKUousXTEwN/uCvM3c3Y+cXh
        9UqS0YH/RBVlfST+UCzDSfi/Qc7n2pgb+q+OGfAK391w0n0zs5/N3qCRPjhaEfT7xDbYlcpYzohJ5
        p5JnbYur4WTstrq7ecOaB3gweZ99aWB5+skAdQBoltzB8U1+te1WZTR1Crt0Ei9NzvrP6vOhz0WC9
        cAa7Q3ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpRSV-009OTR-T2; Sun, 08 Oct 2023 10:56:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A9E1300687; Sun,  8 Oct 2023 12:56:27 +0200 (CEST)
Date:   Sun, 8 Oct 2023 12:56:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "brookxu.cn" <brookxu.cn@gmail.com>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] delayacct: introduce delayacct_enabled() to simplify
 implement
Message-ID: <20231008105627.GB6320@noisy.programming.kicks-ass.net>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <8e5d6ed7d70ff7187a33130231783ed2c1d70841.1696761522.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5d6ed7d70ff7187a33130231783ed2c1d70841.1696761522.git.chunguang.xu@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 06:49:36PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> Introduce delayacct_enabled() to simplify the code and make it
> more concise.
> 
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> ---
>  include/linux/delayacct.h | 74 +++++++++++----------------------------
>  kernel/delayacct.c        |  2 +-
>  2 files changed, 21 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
> index 6639f48dac36..660e534ce7c4 100644
> --- a/include/linux/delayacct.h
> +++ b/include/linux/delayacct.h
> @@ -94,137 +94,103 @@ static inline void delayacct_tsk_init(struct task_struct *tsk)
>  		__delayacct_tsk_init(tsk);
>  }
>  
> +static inline bool delayacct_enabled(void)
> +{
> +	return static_branch_unlikely(&delayacct_key);
> +}
> +
>  /* Free tsk->delays. Called from bad fork and __put_task_struct
>   * where there's no risk of tsk->delays being accessed elsewhere
>   */
>  static inline void delayacct_tsk_free(struct task_struct *tsk)
>  {
> -	if (tsk->delays)
> +	if (delayacct_enabled())

This isn't an equivalent change and your Changelog does not clarify.
