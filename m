Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489E8774731
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjHHTLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjHHTKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5ADE9E6;
        Tue,  8 Aug 2023 09:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827D362456;
        Tue,  8 Aug 2023 16:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB7C433C7;
        Tue,  8 Aug 2023 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691512307;
        bh=i13P5MPqrTGWCc+X/5J6OL6JOdO6y17/4r5Ys53Uur0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUMo/ilNQjbTst5YG3/9ijxPs5mOI9ZLOnEjxhzeCm7KVteaFEsYSUu5F6P5kCu+c
         cDaMjxIKKwWidt/oceJJBCYnV4cFJKtfctLYSJ4ksPmAW/mb38/qSvKosaEX4A4AjN
         CJHDCGGD7KwDVjPZfJb+G4cSKBX6ud/7sUKmGVrFJHLfmwsYj9VVWTHu9mNAOWjzdW
         AKx8NFq+92kLHrAdr4HfDc3o4JkeKHf6cNUluVZhfJcInujueS73luI8vViMDUBWyO
         mRE2WFQtt7XWsExLES5NjKAfQgypy4Ibl5O1/3olZO1Bx3mrMHCF1On6OrRysXMZRm
         JHDn+8ZoDXNMw==
Date:   Tue, 8 Aug 2023 10:32:50 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v2] netfilter: ebtables: fix fortify warnings
Message-ID: <ZNJuMoe37L02TP20@work>
References: <20230808133038.771316-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808133038.771316-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:30:38PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler is complaining:
> 
> memcpy(&offsets[1], &entry->watchers_offset,
>                        sizeof(offsets) - sizeof(offsets[0]));
> 
> where memcpy reads beyong &entry->watchers_offset to copy
> {watchers,target,next}_offset altogether into offsets[]. Silence the
> warning by wrapping these three up via struct_group().
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
> 
> v2: fix HDRTEST error by replacing struct_group() with __struct_group(),
> since it's a uapi header.
> 
>  include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
>  net/bridge/netfilter/ebtables.c                |  3 +--
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
> index a494cf43a755..b0caad82b693 100644
> --- a/include/uapi/linux/netfilter_bridge/ebtables.h
> +++ b/include/uapi/linux/netfilter_bridge/ebtables.h
> @@ -182,12 +182,14 @@ struct ebt_entry {
>  	unsigned char sourcemsk[ETH_ALEN];
>  	unsigned char destmac[ETH_ALEN];
>  	unsigned char destmsk[ETH_ALEN];
> -	/* sizeof ebt_entry + matches */
> -	unsigned int watchers_offset;
> -	/* sizeof ebt_entry + matches + watchers */
> -	unsigned int target_offset;
> -	/* sizeof ebt_entry + matches + watchers + target */
> -	unsigned int next_offset;
> +	__struct_group(/* no tag */, offsets, /* no attrs */,
> +		/* sizeof ebt_entry + matches */
> +		unsigned int watchers_offset;
> +		/* sizeof ebt_entry + matches + watchers */
> +		unsigned int target_offset;
> +		/* sizeof ebt_entry + matches + watchers + target */
> +		unsigned int next_offset;
> +	);
>  	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
>  };
>  
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index 757ec46fc45a..5ec66b1ebb64 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
>  		return ret;
>  
>  	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
> -	memcpy(&offsets[1], &entry->watchers_offset,
> -			sizeof(offsets) - sizeof(offsets[0]));
> +	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets[0]));
							^^^^^^^^^^^^
You now can replace this ____________________________________|
with just `sizeof(entry->offsets)`

With that change you can add my
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thank you
--
Gustavo

>  
>  	if (state->buf_kern_start) {
>  		buf_start = state->buf_kern_start + state->buf_kern_offset;
> -- 
> 2.41.0
> 
