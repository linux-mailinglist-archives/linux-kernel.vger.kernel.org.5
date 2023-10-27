Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1EC7D9CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbjJ0PSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346302AbjJ0PSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:18:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E11A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:18:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 066E11FDF3;
        Fri, 27 Oct 2023 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698419921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwE0ZStLbRjJE3iyZ3Dw9rRbnaHu1wJnEb27z8r+e8g=;
        b=li6hS+hfRz7Md7RFzXZkF44zwzsgtbfG1OtiRFY+fFg2WHQ+P6qAX7HfJ9zyJ3i8Do+0WU
        zbteD2Uv8Z6F5tF74TiqJuYNJ0mzYBs61h54Vi1i7U8c1W1EMdAV8MpDBv5g8VFzoYIZCM
        adfFsX5llVCrrEk4+bzRZvWuH4I4e9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698419921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwE0ZStLbRjJE3iyZ3Dw9rRbnaHu1wJnEb27z8r+e8g=;
        b=EJbqdv8ckiwAt86OBzUyILHLHy5BXniL9i7FmKBNNxUQ2/G/pOX/dVMEwcjZfv8qFegO4h
        QDI1secq6EMG/HAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C23051358C;
        Fri, 27 Oct 2023 15:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fWO3LtDUO2WTFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 27 Oct 2023 15:18:40 +0000
Message-ID: <43da5c9a-aeff-1bff-81a8-4611470c2514@suse.cz>
Date:   Fri, 27 Oct 2023 17:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 2/7] slub: Prepare __slab_free() for unfrozen
 partial slab out of node partial list
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-3-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231024093345.3676493-3-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.60
X-Spamd-Result: default: False [-5.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FREEMAIL_CC(0.00)[google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Now the partial slub will be frozen when taken out of node partial list,

	  partially empty slab

> so the __slab_free() will know from "was_frozen" that the partial slab
> is not on node partial list and is used by one kmem_cache_cpu.

				... is a cpu or cpu partial slab of some cpu.

> But we will change this, make partial slabs leave the node partial list
> with unfrozen state, so we need to change __slab_free() to use the new
> slab_test_node_partial() we just introduced.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/slub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3fad4edca34b..f568a32d7332 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3610,6 +3610,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	unsigned long counters;
>  	struct kmem_cache_node *n = NULL;
>  	unsigned long flags;
> +	bool on_node_partial;
>  
>  	stat(s, FREE_SLOWPATH);
>  
> @@ -3657,6 +3658,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  				 */
>  				spin_lock_irqsave(&n->list_lock, flags);
>  
> +				on_node_partial = slab_test_node_partial(slab);
>  			}
>  		}
>  
> @@ -3685,6 +3687,15 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		return;
>  	}
>  
> +	/*
> +	 * This slab was partial but not on the per-node partial list,

This slab was partially empty ...

Otherwise LGTM!

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

