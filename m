Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1F7DE1B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjKANVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbjKANVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:21:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A8F4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65BA4215EE;
        Wed,  1 Nov 2023 13:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698844862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZN58lJbHenxUKwiOCOfOaIP86jpT8vhR/q8e1VR4s2s=;
        b=gcdJnKH7LEz0a2gzMsnBvcIbCgtD/BEuHEUtOwZC0EDBpGUgG1PGKr+/xS1GJ1v46ydD5t
        jDmxPIJVj9Xk6THcDcJCeXmPg4BXK4ixvpwo+Z0Ks90B2JwIMcKyIWBiCaBmfzUf1DY50Z
        iY1HtVzusUX1oZhUQ9i4IjJ75tJkX7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698844862;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZN58lJbHenxUKwiOCOfOaIP86jpT8vhR/q8e1VR4s2s=;
        b=ObKbcWpvHdQ4CXuNh9TzeHnq3+inGm1NXxv9HbCGencvVJcot937DbK+T9zZEQC/igCEmX
        S/yFF98WuY2eqoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F2ED1348D;
        Wed,  1 Nov 2023 13:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pv+xCr5QQmWbbAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Nov 2023 13:21:02 +0000
Message-ID: <6041f645-a3d0-367a-8f2a-c6c5a68507ca@suse.cz>
Date:   Wed, 1 Nov 2023 14:21:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v4 7/9] slub: Optimize deactivate_slab()
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <20231031140741.79387-8-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231031140741.79387-8-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/23 15:07, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since the introduce of unfrozen slabs on cpu partial list, we don't
> need to synchronize the slab frozen state under the node list_lock.
> 
> The caller of deactivate_slab() and the caller of __slab_free() won't
> manipulate the slab list concurrently.
> 
> So we can get node list_lock in the last stage if we really need to
> manipulate the slab list in this path.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 76 +++++++++++++++++++------------------------------------
>  1 file changed, 26 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index bcb5b2c4e213..c429f8baba5f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2468,10 +2468,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  			    void *freelist)
>  {
> -	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>  	int free_delta = 0;
> -	enum slab_modes mode = M_NONE;
>  	void *nextfree, *freelist_iter, *freelist_tail;
>  	int tail = DEACTIVATE_TO_HEAD;
>  	unsigned long flags = 0;
> @@ -2512,62 +2510,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	 *
>  	 * Ensure that the slab is unfrozen while the list presence
>  	 * reflects the actual number of objects during unfreeze.

I think this we can delete also these two lines. If there's no other
reason for v5, I can do it when merging the series.
