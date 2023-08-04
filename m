Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CCA770584
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjHDQDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjHDQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9A4C25;
        Fri,  4 Aug 2023 09:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 991C26209B;
        Fri,  4 Aug 2023 16:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F54C433B7;
        Fri,  4 Aug 2023 16:03:10 +0000 (UTC)
Date:   Fri, 4 Aug 2023 12:03:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 2/3] list_debug: Introduce inline wrappers for debug
 checks
Message-ID: <20230804120308.253c5521@gandalf.local.home>
In-Reply-To: <20230804090621.400-2-elver@google.com>
References: <20230804090621.400-1-elver@google.com>
        <20230804090621.400-2-elver@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Aug 2023 11:02:57 +0200
Marco Elver <elver@google.com> wrote:

> Turn the list debug checking functions __list_*_valid() into inline
> functions that wrap the out-of-line functions. Care is taken to ensure
> the inline wrappers are always inlined, so that additional compiler
> instrumentation (such as sanitizers) does not result in redundant
> outlining.
> 
> This change is preparation for performing checks in the inline wrappers.
> 
> No functional change intended.

I think the entire underscoring functions calling more underscoring
functions in the kernel is an abomination. Yes, there's lots of precedence
to this craziness, but let's not extend it.

Can we give actual real names to why the function is "special" besides that
it now has another underscore added to it?

I've been guilty of this madness myself, but I have learned the errors of
my ways, and have been avoiding doing so in any new code I write.

-- Steve


> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/list_debug.c |  6 +++---
>  include/linux/list.h                 | 15 +++++++++++++--
>  lib/list_debug.c                     | 11 +++++------
>  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/list_debug.c b/arch/arm64/kvm/hyp/nvhe/list_debug.c
> index d68abd7ea124..589284496ac5 100644
> --- a/arch/arm64/kvm/hyp/nvhe/list_debug.c
> +++ b/arch/arm64/kvm/hyp/nvhe/list_debug.c
> @@ -26,8 +26,8 @@ static inline __must_check bool nvhe_check_data_corruption(bool v)
>  
>  /* The predicates checked here are taken from lib/list_debug.c. */
>  
> -bool __list_add_valid(struct list_head *new, struct list_head *prev,
> -		      struct list_head *next)
> +bool ___list_add_valid(struct list_head *new, struct list_head *prev,
> +		       struct list_head *next)
>  {
>  	if (NVHE_CHECK_DATA_CORRUPTION(next->prev != prev) ||
>  	    NVHE_CHECK_DATA_CORRUPTION(prev->next != next) ||
> @@ -37,7 +37,7 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
>  	return true;
>  }
>  
> -bool __list_del_entry_valid(struct list_head *entry)
> +bool ___list_del_entry_valid(struct list_head *entry)
>  {
>  	struct list_head *prev, *next;
>  
> diff --git a/include/linux/list.h b/include/linux/list.h
> index f10344dbad4d..e0b2cf904409 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -39,10 +39,21 @@ static inline void INIT_LIST_HEAD(struct list_head *list)
>  }
>  
>  #ifdef CONFIG_DEBUG_LIST
> -extern bool __list_add_valid(struct list_head *new,
> +extern bool ___list_add_valid(struct list_head *new,
>  			      struct list_head *prev,
>  			      struct list_head *next);
> -extern bool __list_del_entry_valid(struct list_head *entry);
> +static __always_inline bool __list_add_valid(struct list_head *new,
> +					     struct list_head *prev,
> +					     struct list_head *next)
> +{
> +	return ___list_add_valid(new, prev, next);
> +}
> +
> +extern bool ___list_del_entry_valid(struct list_head *entry);
> +static __always_inline bool __list_del_entry_valid(struct list_head *entry)
> +{
> +	return ___list_del_entry_valid(entry);
> +}
>  #else
>  static inline bool __list_add_valid(struct list_head *new,
>  				struct list_head *prev,
> diff --git a/lib/list_debug.c b/lib/list_debug.c
> index d98d43f80958..fd69009cc696 100644
> --- a/lib/list_debug.c
> +++ b/lib/list_debug.c
> @@ -17,8 +17,8 @@
>   * attempt).
>   */
>  
> -bool __list_add_valid(struct list_head *new, struct list_head *prev,
> -		      struct list_head *next)
> +bool ___list_add_valid(struct list_head *new, struct list_head *prev,
> +		       struct list_head *next)
>  {
>  	if (CHECK_DATA_CORRUPTION(prev == NULL,
>  			"list_add corruption. prev is NULL.\n") ||
> @@ -37,9 +37,9 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
>  
>  	return true;
>  }
> -EXPORT_SYMBOL(__list_add_valid);
> +EXPORT_SYMBOL(___list_add_valid);
>  
> -bool __list_del_entry_valid(struct list_head *entry)
> +bool ___list_del_entry_valid(struct list_head *entry)
>  {
>  	struct list_head *prev, *next;
>  
> @@ -65,6 +65,5 @@ bool __list_del_entry_valid(struct list_head *entry)
>  		return false;
>  
>  	return true;
> -
>  }
> -EXPORT_SYMBOL(__list_del_entry_valid);
> +EXPORT_SYMBOL(___list_del_entry_valid);

