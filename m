Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8719A7DE0E8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbjKAM0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjKAM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:26:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B1102
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:26:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B769821863;
        Wed,  1 Nov 2023 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698841562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUDrsMocEffzwnmx5bQlZdnvq/xccGqkwAx5KwE/vNA=;
        b=QPyeegkEcQzdWmPyYP3kEtonuYQmNOrYKOj60q/jHJfKaeiIj+6Cqy1sU5SX8TvyD9Z7kn
        4BZmBNL3+S4lPjwXrfLKJ6Zd2ixHqeQu0E/tyMnEQXToQKf9tGfUbfao9Jco7+CMW919mh
        uFiFuNMKgJX3TNJCVatb/lbpfwlZBOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698841562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUDrsMocEffzwnmx5bQlZdnvq/xccGqkwAx5KwE/vNA=;
        b=cewjfxX7vl0kIVmAcly/wWqljb/CKYkRVCE8YP1a+MObpbc4CutcmOJWm94JIYkXMCCltV
        XBJAEOwF+lz/ukAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A8661348D;
        Wed,  1 Nov 2023 12:26:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ydyXHNpDQmXsUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Nov 2023 12:26:02 +0000
Message-ID: <426b5c90-8da1-831c-5f9a-fd1fd26fcafc@suse.cz>
Date:   Wed, 1 Nov 2023 13:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v4 4/9] slub: Prepare __slab_free() for unfrozen
 partial slab out of node partial list
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <20231031140741.79387-5-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231031140741.79387-5-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 15:07, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Now the partially empty slub will be frozen when taken out of node partial
> list, so the __slab_free() will know from "was_frozen" that the partially
> empty slab is not on node partial list and is a cpu or cpu partial slab
> of some cpu.
> 
> But we will change this, make partial slabs leave the node partial list
> with unfrozen state, so we need to change __slab_free() to use the new
> slab_test_node_partial() we just introduced.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index eed8ae0dbaf9..1880b483350e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3631,6 +3631,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	unsigned long counters;
>  	struct kmem_cache_node *n = NULL;
>  	unsigned long flags;
> +	bool on_node_partial;
>  
>  	stat(s, FREE_SLOWPATH);
>  
> @@ -3678,6 +3679,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  				 */
>  				spin_lock_irqsave(&n->list_lock, flags);
>  
> +				on_node_partial = slab_test_node_partial(slab);
>  			}
>  		}
>  
> @@ -3706,6 +3708,15 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		return;
>  	}
>  
> +	/*
> +	 * This slab was partially empty but not on the per-node partial list,
> +	 * in which case we shouldn't manipulate its list, just return.
> +	 */
> +	if (prior && !on_node_partial) {
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +		return;
> +	}
> +
>  	if (unlikely(!new.inuse && n->nr_partial >= s->min_partial))
>  		goto slab_empty;
>  
