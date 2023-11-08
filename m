Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A177E4E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjKHBC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjKHBC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:02:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF310E;
        Tue,  7 Nov 2023 17:02:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A23C433C8;
        Wed,  8 Nov 2023 01:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405375;
        bh=ZEcloge7EvcLciwxWbJyUqAK3+uw3aSKssS3rdqKcW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uCKJOlaPPiAsb3hjysLpyMF41K+ef7+yYrBxLUm1WAIj3099aNHo4EkCPdeh4tDk0
         VeEVVdJCqzXceYtRXU0ToKjiDpojWlOjWfy58365MVFwUc1VBcPCXe8xrlxbBUTR6P
         KBoH+BWOxinsiV9SrxfwJ84gQMGF3iJRNBl9Qt2QFCtzN1pCMLPAvbNjs+TN/Wvtb9
         tQy1HH7D6dr/H6erkEeOlktdCsRg7yLIOsI/4KdPFdqkRVjYa3dsRS/W6YThKyO7X8
         JuFRlhDJZK0o1OOz4+lrIliNlXL/5b/G7ImphrGhx54MwBQLxF/QhtT58M44l/4LRw
         X4yggtgrv2vNQ==
Date:   Wed, 8 Nov 2023 10:02:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        geert@linux-m68k.org, andi.shyti@linux.intel.com, mingo@kernel.org,
        palmer@rivosinc.com, andrzej.hajda@intel.com, arnd@arndb.de,
        peterz@infradead.orgm, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mattwu@163.com, linux@roeck-us.ne
Subject: Re: [PATCH v2 2/4] locking/atomic: arc: arch_cmpxchg[64]_local
 undefined
Message-Id: <20231108100248.5376b99c62a1b24fb0ce62c0@kernel.org>
In-Reply-To: <20231104091615.4884-3-wuqiang.matt@bytedance.com>
References: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
        <20231104091615.4884-3-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Nov 2023 17:16:13 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> For architectures that support native cmpxchg, we'd like to
> implement arch_cmpxchg[64]_local with the native variants of
> supported data size. If not, the generci_cmpxchg[64]_local
> will be used.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  arch/arc/include/asm/cmpxchg.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index bf46514f6f12..91429f2350df 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -80,6 +80,34 @@
>  
>  #endif
>  
> +/*
> + * always make arch_cmpxchg[64]_local available, native cmpxchg
> + * will be used if available, then generic_cmpxchg[64]_local
> + */
> +#include <asm-generic/cmpxchg-local.h>
> +static inline unsigned long __cmpxchg_local(volatile void *ptr,
> +				      unsigned long old,
> +				      unsigned long new, int size)
> +{
> +	switch (size) {
> +#ifdef CONFIG_ARC_HAS_LLSC
> +	case 4:
> +		return __cmpxchg_32((int32_t *)ptr, old, new);
> +#endif
> +	default:
> +		return __generic_cmpxchg_local(ptr, old, new, size);
> +	}
> +
> +	return old;
> +}
> +#define arch_cmpxchg_local(ptr, o, n) ({				\
> +	(__typeof__(*ptr))__cmpxchg_local((ptr),			\
> +					(unsigned long)(o),		\
> +					(unsigned long)(n),		\
> +					sizeof(*(ptr)));		\
> +})
> +#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
> +
>  /*
>   * xchg
>   */
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
