Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6887E4E62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjKHBDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjKHBDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:03:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC0101;
        Tue,  7 Nov 2023 17:03:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC996C433C7;
        Wed,  8 Nov 2023 01:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405409;
        bh=FhuUtj4Vli4JUQLTpu9zmfbY9d6phMLcbPPqo75tvlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lqf7oMoEtheco4hmoHN5t08uEwJpvPetjmMKlRC7aPRnbcSay0n04O+dmA9ifts7B
         giswChG53tAVKDO+OagzQF8T/DZzzBLMar5XCJlhVYWFoTfZr1dcrrzXhXEATNGL8h
         RuZYoylX6+hyh3+8LdntBU7IrCmuUSHO7QTW98vLpVCAA0u1H3QVtzash3Gku+GPHb
         vvsgBELDYFvBl4F9m4yjWT5tlCIJsNao0rQZv5CFhqJnmyi6OtRVeM6Cxfg7ABc241
         oxxfXf9xlBpjxtGJoTaz2IABfaZfC0EFbIqTmhZhpIQbVeWhORg1MLUf0ZkLniV1h0
         EXQOVSkXauVRQ==
Date:   Wed, 8 Nov 2023 10:03:22 +0900
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
Subject: Re: [PATCH v2 3/4] locking/atomic: openrisc: arch_cmpxchg[64]_local
 undefined
Message-Id: <20231108100322.06cc58b4fd142ccbb8d3751e@kernel.org>
In-Reply-To: <20231104091615.4884-4-wuqiang.matt@bytedance.com>
References: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
        <20231104091615.4884-4-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Nov 2023 17:16:14 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> For architectures that support native cmpxchg, we'd like to
> implement arch_cmpxchg[64]_local with the native variants of
> supported data size. If not, the generci_cmpxchg[64]_local
> will be used.


Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  arch/openrisc/include/asm/cmpxchg.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
> index 8ee151c072e4..f1ffe8b6f5ef 100644
> --- a/arch/openrisc/include/asm/cmpxchg.h
> +++ b/arch/openrisc/include/asm/cmpxchg.h
> @@ -139,6 +139,12 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>  					       (unsigned long)(n),	\
>  					       sizeof(*(ptr)));		\
>  	})
> +#define arch_cmpxchg_local arch_cmpxchg
> +
> +/* always make arch_cmpxchg64_local available for openrisc */
> +#include <asm-generic/cmpxchg-local.h>
> +
> +#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
>  
>  /*
>   * This function doesn't exist, so you'll get a linker error if
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
