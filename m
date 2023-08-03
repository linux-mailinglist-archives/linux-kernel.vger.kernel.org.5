Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6B76E1EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjHCHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjHCHgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4D272A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85EF261C43
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8CEC433C8;
        Thu,  3 Aug 2023 07:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691048051;
        bh=M0/KnN63M+oG5LHRMhI/2AFUtVfFsD9k03JRjqSsC+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiWKqKNEx0rlUi0TYT1DzAMNNR74ylyO4JQRIT+fYrw5aFgXzaEbhwFmWpNp/xeBA
         ijXUQlrPLZ7udmp2wr54axnH4xbejIhvTDiX3alzUIg6lRy2G6gqAFHmQ/7E0L7XP9
         7NfG1xBcVfPrppm3vpGvmF2xwOne2NtMKaZBfDiH+y4e+EIj3CSOt/bbmOCu7BbIrA
         Pkoig5Bwth6iYxOoyeCaunQF9fNmkvRmQhZjUvv1q4Z0W6CrZshYCSH0LhgfhsTStf
         d56zuQ/TzgSEtH39vsWx5w3Qj+iYRw4p4wu4p4xFH0woVTmcOTVkG92m+qPrYc8+Ia
         IJmrjWnr4V2jQ==
Date:   Thu, 3 Aug 2023 03:33:59 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 3/3] riscv/atomic.h : Deduplicate arch_atomic.*
Message-ID: <ZMtYZ2jcgh5hePIe@gmail.com>
References: <20230803051401.710236-2-leobras@redhat.com>
 <20230803051401.710236-5-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803051401.710236-5-leobras@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:14:00AM -0300, Leonardo Bras wrote:
> Some functions use mostly the same asm for 32-bit and 64-bit versions.
> 
> Make a macro that is generic enough and avoid code duplication.
> 
> (This did not cause any change in generated asm)
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/atomic.h | 164 +++++++++++++++-----------------
>  1 file changed, 76 insertions(+), 88 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index f5dfef6c2153..80cca7ac16fd 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>  
> +#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u, sfx)	\
> +({									\
> +	__asm__ __volatile__ (						\
> +		"0:	lr." sfx "     %[p],  %[c]\n"			\
> +		"	beq	       %[p],  %[u], 1f\n"		\
> +		"	add            %[rc], %[p], %[a]\n"		\
> +		"	sc." sfx ".rl  %[rc], %[rc], %[c]\n"		\
> +		"	bnez           %[rc], 0b\n"			\
> +		"	fence          rw, rw\n"			\
> +		"1:\n"							\
> +		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
> +		: [a]"r" (_a), [u]"r" (_u)				\
> +		: "memory");						\
> +})
> +
>  /* This is required to provide a full barrier on success. */
>  static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {
>         int prev, rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.w     %[p],  %[c]\n"
> -		"	beq      %[p],  %[u], 1f\n"
> -		"	add      %[rc], %[p], %[a]\n"
> -		"	sc.w.rl  %[rc], %[rc], %[c]\n"
> -		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		: [a]"r" (a), [u]"r" (u)
> -		: "memory");
> +	_arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "w");
> +
>  	return prev;
>  }
>  #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> @@ -222,77 +228,86 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
>         s64 prev;
>         long rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.d     %[p],  %[c]\n"
> -		"	beq      %[p],  %[u], 1f\n"
> -		"	add      %[rc], %[p], %[a]\n"
> -		"	sc.d.rl  %[rc], %[rc], %[c]\n"
> -		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		: [a]"r" (a), [u]"r" (u)
> -		: "memory");
> +	_arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "d");
> +
>  	return prev;
>  }
>  #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
>  #endif
>  
> +#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)	\
> +({									\
> +	__asm__ __volatile__ (						\
> +		"0:	lr." sfx "      %[p],  %[c]\n"			\
> +		"	bltz            %[p],  1f\n"			\
> +		"	addi            %[rc], %[p], 1\n"		\
> +		"	sc." sfx ".rl   %[rc], %[rc], %[c]\n"		\
> +		"	bnez            %[rc], 0b\n"			\
> +		"	fence           rw, rw\n"			\
> +		"1:\n"							\
> +		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
> +		:							\
> +		: "memory");						\
> +})
> +
>  static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
>  {
>  	int prev, rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.w      %[p],  %[c]\n"
> -		"	bltz      %[p],  1f\n"
> -		"	addi      %[rc], %[p], 1\n"
> -		"	sc.w.rl   %[rc], %[rc], %[c]\n"
> -		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		:
> -		: "memory");
> +	_arch_atomic_inc_unless_negative(prev, rc, v->counter, "w");
> +
>  	return !(prev < 0);
>  }
>  
>  #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
>  
> +#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)	\
> +({									\
> +	__asm__ __volatile__ (						\
> +		"0:	lr." sfx "      %[p],  %[c]\n"			\
> +		"	bgtz            %[p],  1f\n"			\
> +		"	addi            %[rc], %[p], -1\n"		\
> +		"	sc." sfx ".rl   %[rc], %[rc], %[c]\n"		\
> +		"	bnez            %[rc], 0b\n"			\
> +		"	fence           rw, rw\n"			\
> +		"1:\n"							\
> +		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
> +		:							\
> +		: "memory");						\
> +})
> +
>  static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
>  {
>  	int prev, rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.w      %[p],  %[c]\n"
> -		"	bgtz      %[p],  1f\n"
> -		"	addi      %[rc], %[p], -1\n"
> -		"	sc.w.rl   %[rc], %[rc], %[c]\n"
> -		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		:
> -		: "memory");
> +	_arch_atomic_dec_unless_positive(prev, rc, v->counter, "w");
> +
>  	return !(prev > 0);
>  }
>  
>  #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
>  
> +#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)		\
> +({									\
> +	__asm__ __volatile__ (						\
> +		"0:	lr." sfx "     %[p],  %[c]\n"			\
> +		"	addi           %[rc], %[p], -1\n"		\
> +		"	bltz           %[rc], 1f\n"			\
> +		"	sc." sfx ".rl  %[rc], %[rc], %[c]\n"		\
> +		"	bnez           %[rc], 0b\n"			\
> +		"	fence          rw, rw\n"			\
> +		"1:\n"							\
> +		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
> +		:							\
> +		: "memory");						\
> +})
> +
>  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
>  {
>         int prev, rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.w     %[p],  %[c]\n"
> -		"	addi     %[rc], %[p], -1\n"
> -		"	bltz     %[rc], 1f\n"
> -		"	sc.w.rl  %[rc], %[rc], %[c]\n"
> -		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		:
> -		: "memory");
> +	_arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
> +
>  	return prev - 1;
>  }
>  
> @@ -304,17 +319,8 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
>  	s64 prev;
>  	long rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.d      %[p],  %[c]\n"
> -		"	bltz      %[p],  1f\n"
> -		"	addi      %[rc], %[p], 1\n"
> -		"	sc.d.rl   %[rc], %[rc], %[c]\n"
> -		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		:
> -		: "memory");
> +	_arch_atomic_inc_unless_negative(prev, rc, v->counter, "d");
> +
>  	return !(prev < 0);
>  }
>  
> @@ -325,17 +331,8 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
>  	s64 prev;
>  	long rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.d      %[p],  %[c]\n"
> -		"	bgtz      %[p],  1f\n"
> -		"	addi      %[rc], %[p], -1\n"
> -		"	sc.d.rl   %[rc], %[rc], %[c]\n"
> -		"	bnez      %[rc], 0b\n"
> -		"	fence     rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		:
> -		: "memory");
> +	_arch_atomic_dec_unless_positive(prev, rc, v->counter, "d");
> +
>  	return !(prev > 0);
>  }
>  
> @@ -346,17 +343,8 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
>         s64 prev;
>         long rc;
>  
> -	__asm__ __volatile__ (
> -		"0:	lr.d     %[p],  %[c]\n"
> -		"	addi      %[rc], %[p], -1\n"
> -		"	bltz     %[rc], 1f\n"
> -		"	sc.d.rl  %[rc], %[rc], %[c]\n"
> -		"	bnez     %[rc], 0b\n"
> -		"	fence    rw, rw\n"
> -		"1:\n"
> -		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> -		:
> -		: "memory");
> +	_arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
> +
>  	return prev - 1;
>  }
I have no problem with this optimization.

Reviewed-by: Guo Ren <guoren@kernel.org> 

>  
> -- 
> 2.41.0
> 
