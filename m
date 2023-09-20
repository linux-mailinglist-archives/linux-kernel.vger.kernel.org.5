Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5E7A7755
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjITJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjITJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:26:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BE12E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:25:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2673F1FE69;
        Wed, 20 Sep 2023 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695201946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxkQ4+wBOTwkXTk8BbRT0PH/v1p4CUyHigmCVxQwZR0=;
        b=jSu2tOJNw4XVBaM+Wbuv4u8eTxnqs0bFgJIBBkPkpAkFxrrcey8Vy6MDoHEnySk1jimpEw
        PJSrsmdaVdrP/w8FfgFcD0TcRLBv2h0EJg82+kXMe/opBAnPtSQmTVFu3xI31+ccOMH8UA
        hMzgCIqc0HSDAJuJbWEehuub8eZlLlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695201946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxkQ4+wBOTwkXTk8BbRT0PH/v1p4CUyHigmCVxQwZR0=;
        b=5l44mGML64eFxRVyCE0NOQnoMb9XfEGpgVZ2MsA6e9i50UmBlvsAWkPG2qVFFyFO363Ujw
        gyqFyPdjPk9QPVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 002521333E;
        Wed, 20 Sep 2023 09:25:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rAv/Opm6CmXKdAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Sep 2023 09:25:45 +0000
Message-ID: <dece2b69-a62a-4c73-046a-c3be6f363622@suse.cz>
Date:   Wed, 20 Sep 2023 11:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm/slub: add sanity check for slub_min/max_order cmdline
 setup
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230920074413.1361547-1-feng.tang@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230920074413.1361547-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 09:44, Feng Tang wrote:
> Currently there are 2 parameters could be setup from kernel cmdline:
> slub_min_order and slub_max_order. It's possible that the user
> configured slub_min_order is bigger than the default slub_max_order
> [1], which can still take effect, as calculate_oder() will use MAX_ORDER
> as a fallback to check against, but has some downsides:
> 
> * the kernel message about SLUB will be strange in showing min/max
>   orders:
> 
>     SLUB: HWalign=64, Order=9-3, MinObjects=0, CPUs=16, Nodes=1
> 
> * in calculate_order() called by each slab, the 2 loops of
>   calc_slab_order() will all be meaningless due to slub_min_order
>   is bigger than slub_max_order
> 
> * prevent future code cleanup like in [2].
> 
> Fix it by adding some sanity check to enforce the min/max semantics.
> 
> [1]. https://lore.kernel.org/lkml/21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com/
> [2]. https://lore.kernel.org/lkml/20230908145302.30320-7-vbabka@suse.cz/
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Thanks, applied!

> ---
>  mm/slub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f7940048138c..b36e5eb0ccb7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4711,6 +4711,9 @@ static int __init setup_slub_min_order(char *str)
>  {
>  	get_option(&str, (int *)&slub_min_order);
>  
> +	if (slub_min_order > slub_max_order)
> +		slub_max_order = slub_min_order;
> +
>  	return 1;
>  }
>  
> @@ -4721,6 +4724,9 @@ static int __init setup_slub_max_order(char *str)
>  	get_option(&str, (int *)&slub_max_order);
>  	slub_max_order = min_t(unsigned int, slub_max_order, MAX_ORDER);
>  
> +	if (slub_min_order > slub_max_order)
> +		slub_min_order = slub_max_order;
> +
>  	return 1;
>  }
>  

