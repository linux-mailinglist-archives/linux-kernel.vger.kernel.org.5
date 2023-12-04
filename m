Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E12803C1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjLDR4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjLDRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:55:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C139A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:55:57 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D5C6220DC;
        Mon,  4 Dec 2023 17:55:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13742139AA;
        Mon,  4 Dec 2023 17:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id aFNfBKwSbmWYDwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 04 Dec 2023 17:55:56 +0000
Message-ID: <93dcdf0c-336b-cb20-d646-7a48d872e08c@suse.cz>
Date:   Mon, 4 Dec 2023 18:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 7/9] slub: Optimize deactivate_slab()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, chengming.zhou@linux.dev
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-8-chengming.zhou@linux.dev>
 <CAB=+i9RR-n4q5NU6LFqmhM8ys4kM0SPqwj0zYtr4twu=yYmPPA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9RR-n4q5NU6LFqmhM8ys4kM0SPqwj0zYtr4twu=yYmPPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++
X-Spam-Score: 8.92
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 2D5C6220DC
X-Spamd-Result: default: False [8.92 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.18)[-0.885];
         RCPT_COUNT_SEVEN(0.00)[11];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         NEURAL_SPAM_LONG(2.71)[0.773];
         FREEMAIL_TO(0.00)[gmail.com,linux.dev];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/23 10:23, Hyeonggon Yoo wrote:
> On Thu, Nov 2, 2023 at 12:25 PM <chengming.zhou@linux.dev> wrote:
>>
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Since the introduce of unfrozen slabs on cpu partial list, we don't
>> need to synchronize the slab frozen state under the node list_lock.
>>
>> The caller of deactivate_slab() and the caller of __slab_free() won't
>> manipulate the slab list concurrently.
>>
>> So we can get node list_lock in the last stage if we really need to
>> manipulate the slab list in this path.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> ---
>>  mm/slub.c | 79 ++++++++++++++++++-------------------------------------
>>  1 file changed, 26 insertions(+), 53 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index bcb5b2c4e213..d137468fe4b9 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2468,10 +2468,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>                             void *freelist)
>>  {
>> -       enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>>         struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>>         int free_delta = 0;
>> -       enum slab_modes mode = M_NONE;
>>         void *nextfree, *freelist_iter, *freelist_tail;
>>         int tail = DEACTIVATE_TO_HEAD;
>>         unsigned long flags = 0;
>> @@ -2509,65 +2507,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>         /*
>>          * Stage two: Unfreeze the slab while splicing the per-cpu
>>          * freelist to the head of slab's freelist.
>> -        *
>> -        * Ensure that the slab is unfrozen while the list presence
>> -        * reflects the actual number of objects during unfreeze.
>> -        *
>> -        * We first perform cmpxchg holding lock and insert to list
>> -        * when it succeed. If there is mismatch then the slab is not
>> -        * unfrozen and number of objects in the slab may have changed.
>> -        * Then release lock and retry cmpxchg again.
>>          */
>> -redo:
>> -
>> -       old.freelist = READ_ONCE(slab->freelist);
>> -       old.counters = READ_ONCE(slab->counters);
>> -       VM_BUG_ON(!old.frozen);
>> -
>> -       /* Determine target state of the slab */
>> -       new.counters = old.counters;
>> -       if (freelist_tail) {
>> -               new.inuse -= free_delta;
>> -               set_freepointer(s, freelist_tail, old.freelist);
>> -               new.freelist = freelist;
>> -       } else
>> -               new.freelist = old.freelist;
>> -
>> -       new.frozen = 0;
>> +       do {
>> +               old.freelist = READ_ONCE(slab->freelist);
>> +               old.counters = READ_ONCE(slab->counters);
>> +               VM_BUG_ON(!old.frozen);
>> +
>> +               /* Determine target state of the slab */
>> +               new.counters = old.counters;
>> +               new.frozen = 0;
>> +               if (freelist_tail) {
>> +                       new.inuse -= free_delta;
>> +                       set_freepointer(s, freelist_tail, old.freelist);
>> +                       new.freelist = freelist;
>> +               } else {
>> +                       new.freelist = old.freelist;
>> +               }
>> +       } while (!slab_update_freelist(s, slab,
>> +               old.freelist, old.counters,
>> +               new.freelist, new.counters,
>> +               "unfreezing slab"));
>>
>> +       /*
>> +        * Stage three: Manipulate the slab list based on the updated state.
>> +        */
> 
> deactivate_slab() might unconsciously put empty slabs into partial list, like:
> 
> deactivate_slab()                    __slab_free()
> cmpxchg(), slab's not empty
>                                                cmpxchg(), slab's empty
> and unfrozen
>                                                spin_lock(&n->list_lock)
>                                                (slab's empty but not
> on partial list,
> 
> spin_unlock(&n->list_lock) and return)
> spin_lock(&n->list_lock)
> put slab into partial list
> spin_unlock(&n->list_lock)
> 
> IMHO it should be fine in the real world, but just wanted to
> mention as it doesn't seem to be intentional.

I've noticed it too during review, but then realized it's not a new
behavior, same thing could happen with deactivate_slab() already before the
series. Free slabs on partial list are supported, we even keep some
intentionally as long as "n->nr_partial < s->min_partial" (and that check is
racy too), so no need to try making this more strict.

> Otherwise it looks good to me!

Good enough for a reviewed-by? :)

