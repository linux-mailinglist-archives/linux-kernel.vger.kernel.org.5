Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C8803AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjLDQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLDQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:58:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8576CB9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:58:10 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5CE11F894;
        Mon,  4 Dec 2023 16:58:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC0D01398A;
        Mon,  4 Dec 2023 16:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id WmKLLSAFbmU2eAAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 04 Dec 2023 16:58:08 +0000
Message-ID: <7cd33b23-64f5-a736-ea69-b29e40d42e78@suse.cz>
Date:   Mon, 4 Dec 2023 17:58:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <CAB=+i9TK-_WcmQLVV5BTvngfTfTZra0Xi-XZ2m8JGbamwWDuoA@mail.gmail.com>
 <98763097-d05e-40cd-afe0-4df65083d104@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <98763097-d05e-40cd-afe0-4df65083d104@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.39 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         BAYES_HAM(-3.00)[100.00%];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FREEMAIL_TO(0.00)[linux.dev,gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 5.39
X-Rspamd-Queue-Id: D5CE11F894
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/23 11:15, Chengming Zhou wrote:
> On 2023/12/3 14:53, Hyeonggon Yoo wrote:
>> On Thu, Nov 2, 2023 at 12:25 PM <chengming.zhou@linux.dev> wrote:
>>>
>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> Now we will freeze slabs when moving them out of node partial list to
>>> cpu partial list, this method needs two cmpxchg_double operations:
>>>
>>> 1. freeze slab (acquire_slab()) under the node list_lock
>>> 2. get_freelist() when pick used in ___slab_alloc()
>>>
>>> Actually we don't need to freeze when moving slabs out of node partial
>>> list, we can delay freezing to when use slab freelist in ___slab_alloc(),
>>> so we can save one cmpxchg_double().
>>>
>>> And there are other good points:
>>>  - The moving of slabs between node partial list and cpu partial list
>>>    becomes simpler, since we don't need to freeze or unfreeze at all.
>>>
>>>  - The node list_lock contention would be less, since we don't need to
>>>    freeze any slab under the node list_lock.
>>>
>>> We can achieve this because there is no concurrent path would manipulate
>>> the partial slab list except the __slab_free() path, which is now
>>> serialized by slab_test_node_partial() under the list_lock.
>>>
>>> Since the slab returned by get_partial() interfaces is not frozen anymore
>>> and no freelist is returned in the partial_context, so we need to use the
>>> introduced freeze_slab() to freeze it and get its freelist.
>>>
>>> Similarly, the slabs on the CPU partial list are not frozen anymore,
>>> we need to freeze_slab() on it before use.
>>>
>>> We can now delete acquire_slab() as it became unused.
>>>
>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>> ---
>>>  mm/slub.c | 113 +++++++++++-------------------------------------------
>>>  1 file changed, 23 insertions(+), 90 deletions(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index edf567971679..bcb5b2c4e213 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2234,51 +2234,6 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
>>>         return object;
>>>  }
>>>
>>> -/*
>>> - * Remove slab from the partial list, freeze it and
>>> - * return the pointer to the freelist.
>>> - *
>>> - * Returns a list of objects or NULL if it fails.
>>> - */
>>> -static inline void *acquire_slab(struct kmem_cache *s,
>>> -               struct kmem_cache_node *n, struct slab *slab,
>>> -               int mode)
>> 
>> Nit: alloc_single_from_partial()'s comment still refers to acquire_slab().
>> 
> 
> Ah, right! It should be changed to remove_partial().
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 437485a2408d..623c17a4cdd6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2463,7 +2463,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
>  }
> 
>  /*
> - * Called only for kmem_cache_debug() caches instead of acquire_slab(), with a
> + * Called only for kmem_cache_debug() caches instead of remove_partial(), with a
>   * slab from the n->partial list. Remove only a single object from the slab, do
>   * the alloc_debug_processing() checks and leave the slab on the list, or move
>   * it to full list if it was the last free object.
> 
> Hi Vlastimil, could you please help to fold it?

Done, thanks.

