Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887FD7BAA49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjJETiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJETiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:38:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E1CE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 12:38:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05119C433C7;
        Thu,  5 Oct 2023 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696534689;
        bh=wCkgJNiv1NgzfO5wNG4eTiNqnwm45TDHUoeqPO7QiYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xt6O4S8w1dZ4xED9rkInAY2s9ejjZxpg0oYRNu1dK7EWsU7ElKUSLDoWND3et/XEB
         JKo3wv8KTYeOVJtFRfu3QBxrLJ5eA9Zykez/iOS2+Uyv6Y9eLYo8Q1E09vRhcKYlPh
         OryVQntHhR1ejpZNTKjryNW5N+X+DwX/oufBOotYwZJzLiIAVCCivynIuSZl7rzQCC
         RKrvIBiOq+9KzwJI54WSVZ0qeMRWBGWV3/1n1U3nnd0NM4CshMiDwP047/gE28zkWW
         EysLq3LzyKAl3kkMjQ9KZn8qKPmv+DPhqgyYM0yL8KEnhqZ3HtEkB2yfY0Kdxmv7cK
         rcP8JpiPmKWpg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EAA340508; Thu,  5 Oct 2023 16:38:06 -0300 (-03)
Date:   Thu, 5 Oct 2023 16:38:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/5] perf tools: Add get_unaligned_leNN()
Message-ID: <ZR8QnasisGEsaaDR@kernel.org>
References: <20231005190451.175568-1-adrian.hunter@intel.com>
 <20231005190451.175568-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005190451.175568-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 05, 2023 at 10:04:47PM +0300, Adrian Hunter escreveu:
> Add get_unaligned_le16(), get_unaligned_le32 and get_unaligned_le64, same
> as include/asm-generic/unaligned.h.
> 
> Use diagnostic pragmas to ignore -Wpacked used by perf build.

Can we get the tools copy of include/asm-generic/unaligned.h closer and
have it in check-headers.sh?

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/include/asm-generic/unaligned.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
> index 47387c607035..9140bb4e16c6 100644
> --- a/tools/include/asm-generic/unaligned.h
> +++ b/tools/include/asm-generic/unaligned.h
> @@ -6,6 +6,9 @@
>  #ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
>  #define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
>  
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wpacked"
> +
>  #define __get_unaligned_t(type, ptr) ({						\
>  	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
>  	__pptr->x;								\
> @@ -19,5 +22,22 @@
>  #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
>  #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
>  
> +static inline u16 get_unaligned_le16(const void *p)
> +{
> +	return le16_to_cpu(__get_unaligned_t(__le16, p));
> +}
> +
> +static inline u32 get_unaligned_le32(const void *p)
> +{
> +	return le32_to_cpu(__get_unaligned_t(__le32, p));
> +}
> +
> +static inline u64 get_unaligned_le64(const void *p)
> +{
> +	return le64_to_cpu(__get_unaligned_t(__le64, p));
> +}
> +
> +#pragma GCC diagnostic pop
> +
>  #endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
>  
> -- 
> 2.34.1
> 

-- 

- Arnaldo
