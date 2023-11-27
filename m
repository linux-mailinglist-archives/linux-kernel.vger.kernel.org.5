Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF97F9F21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjK0L40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjK0L4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:56:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59BAD8F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:56:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1E1A2F4;
        Mon, 27 Nov 2023 03:57:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.171])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C77AF3F73F;
        Mon, 27 Nov 2023 03:56:28 -0800 (PST)
Date:   Mon, 27 Nov 2023 11:56:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     peterz@infradead.org, keescook@chromium.org, paulmck@kernel.org,
        ubizjak@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3] locking/atomic: scripts: Exclude
 arch_atomic(64)_read(set) mappings
Message-ID: <ZWSD6v1d9wwOxOYd@FVFF77S0Q05N>
References: <20231126013921.103133-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126013921.103133-1-guoren@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 08:39:21PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The definitions of atomic(64)_read(set) are relax version, and using
> them for acquire and release is incorrect, so exclude these mappings.

This was fixed by commit:

  6d2779ecaeb56f92 ("locking/atomic: scripts: fix fallback ifdeffery")

That commit was in v6.6-rc3, and has been backported to stable kernels.

I think you're using an old kernel as a base.

Thanks,
Mark.

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
> Changelog:
> v3:
>  - Minimize modification on atomic(64)_read(set)
> 
> v2:
>  - Use gen-atomic-fallback.sh instead of header modification
> ---
>  include/linux/atomic/atomic-arch-fallback.h | 10 +---------
>  scripts/atomic/gen-atomic-fallback.sh       |  3 ++-
>  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 18f5744dfb5d..b83ef19da13d 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -459,8 +459,6 @@ raw_atomic_read_acquire(const atomic_t *v)
>  {
>  #if defined(arch_atomic_read_acquire)
>  	return arch_atomic_read_acquire(v);
> -#elif defined(arch_atomic_read)
> -	return arch_atomic_read(v);
>  #else
>  	int ret;
>  
> @@ -508,8 +506,6 @@ raw_atomic_set_release(atomic_t *v, int i)
>  {
>  #if defined(arch_atomic_set_release)
>  	arch_atomic_set_release(v, i);
> -#elif defined(arch_atomic_set)
> -	arch_atomic_set(v, i);
>  #else
>  	if (__native_word(atomic_t)) {
>  		smp_store_release(&(v)->counter, i);
> @@ -2575,8 +2571,6 @@ raw_atomic64_read_acquire(const atomic64_t *v)
>  {
>  #if defined(arch_atomic64_read_acquire)
>  	return arch_atomic64_read_acquire(v);
> -#elif defined(arch_atomic64_read)
> -	return arch_atomic64_read(v);
>  #else
>  	s64 ret;
>  
> @@ -2624,8 +2618,6 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
>  {
>  #if defined(arch_atomic64_set_release)
>  	arch_atomic64_set_release(v, i);
> -#elif defined(arch_atomic64_set)
> -	arch_atomic64_set(v, i);
>  #else
>  	if (__native_word(atomic64_t)) {
>  		smp_store_release(&(v)->counter, i);
> @@ -4657,4 +4649,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
> +// 2fdd6702823fa842f9cea57a002e6e4476ae780c
> diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
> index c0c8a85d7c81..282a1d3c41d4 100755
> --- a/scripts/atomic/gen-atomic-fallback.sh
> +++ b/scripts/atomic/gen-atomic-fallback.sh
> @@ -102,7 +102,8 @@ gen_proto_order_variant()
>  	fi
>  
>  	# Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FULL ops
> -	if [ ! -z "${order}" ]; then
> +	# Exclude arch_atomic(64)_read(set) mappings because these are not FULL ops.
> +	if [ ! -z "${order}" ] && [ "${name}" != "read" ] && [ "${name}" != "set" ]; then
>  		printf "#elif defined(arch_${basename})\n"
>  		printf "\t${retstmt}arch_${basename}(${args});\n"
>  	fi
> -- 
> 2.36.1
> 
