Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC837F7909
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjKXQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKXQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:32:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22001BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lRSiH2QNyct0O1zK7Llfv4fzLag68+OyvxcKpYofq0w=; b=BbYbQT1LLbBcLhrp53tdnZgluP
        zbNLnSXvIclXvHBaG5ExEIV/u4nbkydq0lE70BMjBjlIDn/zqhZB3x5G9ODHyt8jcWdSj2KrI0Czz
        sFkKeyYQpmoF7ryksGfmWLRKC5hr2Dd/ZInEp9zriaiHBgfu+fsFLKFkyDBSopKQKMblsIFzCGe6n
        Hd+zeZ5iAYYwB3bIfFQzrlx+I/0D356XXIgzftK2W8zprTjrq0xGD5iR91DGCjhvnv57HMUc39oGY
        ciAFdsX7LVJLtN+fN0zE2VtlHyhLng8tWWsdl4mD9AxIWuc1MrUWsRVJnkzq5NGfxF4YRNPZfwbjl
        TIoYX5lw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r6Z6L-00Dwsr-2g;
        Fri, 24 Nov 2023 16:32:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 854253002BE; Fri, 24 Nov 2023 17:32:20 +0100 (CET)
Date:   Fri, 24 Nov 2023 17:32:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     mark.rutland@arm.com, keescook@chromium.org, paulmck@kernel.org,
        ubizjak@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] locking/atomic: Add acquire and release fence for
 atomic(64)_read(set)
Message-ID: <20231124163220.GU3818@noisy.programming.kicks-ass.net>
References: <20231124162508.3331357-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124162508.3331357-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:25:08AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The definitions of atomic(64)_read(set) are relax version, so
> add acquire and release fence for them.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---

You lost the script change?

>  include/linux/atomic/atomic-arch-fallback.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 18f5744dfb5d..9775900eeefd 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -460,7 +460,10 @@ raw_atomic_read_acquire(const atomic_t *v)
>  #if defined(arch_atomic_read_acquire)
>  	return arch_atomic_read_acquire(v);
>  #elif defined(arch_atomic_read)
> -	return arch_atomic_read(v);
> +	int ret;
> +	ret = arch_atomic_read(v);
> +	__atomic_acquire_fence();
> +	return ret;
>  #else
>  	int ret;
>  
> @@ -509,6 +512,7 @@ raw_atomic_set_release(atomic_t *v, int i)
>  #if defined(arch_atomic_set_release)
>  	arch_atomic_set_release(v, i);
>  #elif defined(arch_atomic_set)
> +	__atomic_release_fence();
>  	arch_atomic_set(v, i);
>  #else
>  	if (__native_word(atomic_t)) {
> @@ -2576,7 +2580,10 @@ raw_atomic64_read_acquire(const atomic64_t *v)
>  #if defined(arch_atomic64_read_acquire)
>  	return arch_atomic64_read_acquire(v);
>  #elif defined(arch_atomic64_read)
> -	return arch_atomic64_read(v);
> +	s64 ret;
> +	ret = arch_atomic64_read(v);
> +	__atomic_acquire_fence();
> +	return ret;
>  #else
>  	s64 ret;
>  
> @@ -2625,6 +2632,7 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
>  #if defined(arch_atomic64_set_release)
>  	arch_atomic64_set_release(v, i);
>  #elif defined(arch_atomic64_set)
> +	__atomic_release_fence();
>  	arch_atomic64_set(v, i);
>  #else
>  	if (__native_word(atomic64_t)) {
> @@ -4657,4 +4665,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
> +// 3135f55051cf62b76664e528bf04337c44a14e72
> -- 
> 2.36.1
> 
