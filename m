Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E747FC155
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345691AbjK1Rhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345554AbjK1Rhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:37:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571C18E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:37:43 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 799691F898;
        Tue, 28 Nov 2023 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701193062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+i5r2yvkp2KHtyBUrIaJjpJl5CnUbwkzKW05rea7ko=;
        b=ab6DbNmgVBMW3eV//yivo3/keAC9735txBK7u92TwnRnmTmKewU8dQr3MiwQ5B1RauIJY/
        08xL76q52zCBsRiJR4EqPWrQplbxo5VCmpSi7CVBddDz22aC4gLeeaHc/6a330SYuNKYVM
        jU4dWX2/KZHlzCVT58tpWu//PQKaAVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701193062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+i5r2yvkp2KHtyBUrIaJjpJl5CnUbwkzKW05rea7ko=;
        b=aqjk3GPtzHIzOIwcRoG0lszJaX1TyWWg0ZKXlPB4e5/pWtknVgriH2HvR7OOzl/5Pf/Ffa
        MBmXNwlrPx0WJHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B3B41343E;
        Tue, 28 Nov 2023 17:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id VaO3FWYlZmWAdwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Tue, 28 Nov 2023 17:37:42 +0000
Message-ID: <077e8e97-e88f-0b8e-2788-4031458be090@suse.cz>
Date:   Tue, 28 Nov 2023 18:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v2 2/7] mm, slub: add opt-in slub_percpu_array
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230810163627.6206-9-vbabka@suse.cz>
 <20230810163627.6206-11-vbabka@suse.cz>
 <CAB=+i9TSMVURktFvr7sAt4T2BdaUvsWFapAjTZNtk0AKS01O9A@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9TSMVURktFvr7sAt4T2BdaUvsWFapAjTZNtk0AKS01O9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.80
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 16:57, Hyeonggon Yoo wrote:
> Hi,
> 
> On Fri, Aug 11, 2023 at 1:36 AM Vlastimil Babka <vbabka@suse.cz> wrote:

Oops, looks like I forgot reply, sorry (preparing v3 now).

>>
>> kmem_cache_setup_percpu_array() will allocate a per-cpu array for
>> caching alloc/free objects of given size for the cache. The cache
>> has to be created with SLAB_NO_MERGE flag.
>>
>> The array is filled by freeing. When empty for alloc or full for
>> freeing, it's simply bypassed by the operation, there's currently no
>> batch freeing/allocations.
>>
>> The locking is copied from the page allocator's pcplists, based on
>> embedded spin locks. Interrupts are not disabled, only preemption (cpu
>> migration on RT). Trylock is attempted to avoid deadlock due to
>> an intnerrupt, trylock failure means the array is bypassed.
> 
> nit: s/intnerrupt/interrupt/

Thanks.

> 
>>  /*
>>   * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
>>   * have the fastpath folded into their functions. So no function call
>> @@ -3465,7 +3564,11 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>>         if (unlikely(object))
>>                 goto out;
>>
>> -       object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
>> +       if (s->cpu_array)
>> +               object = alloc_from_pca(s);
>> +
>> +       if (!object)
>> +               object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
>>
>>         maybe_wipe_obj_freeptr(s, object);
>>         init = slab_want_init_on_alloc(gfpflags, s);
>> @@ -3715,6 +3818,34 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>         discard_slab(s, slab);
>>  }
> 
>>  #ifndef CONFIG_SLUB_TINY
>>  /*
>>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
>> @@ -3740,6 +3871,11 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>>         unsigned long tid;
>>         void **freelist;
>>
>> +       if (s->cpu_array && cnt == 1) {
>> +               if (free_to_pca(s, head))
>> +                       return;
>> +       }
>> +
>>  redo:
>>         /*
>>          * Determine the currently cpus per cpu slab.
>> @@ -3793,6 +3929,11 @@ static void do_slab_free(struct kmem_cache *s,
>>  {
>>         void *tail_obj = tail ? : head;
>>
>> +       if (s->cpu_array && cnt == 1) {
>> +               if (free_to_pca(s, head))
>> +                       return;
>> +       }
>> +
>>         __slab_free(s, slab, head, tail_obj, cnt, addr);
>>  }
>>  #endif /* CONFIG_SLUB_TINY */
> 
> Is this functionality needed for SLUB_TINY?

Due to the prefill semantics, I think it has to be be even in TINY, or we
risk running out of memory reserves. Also later I want to investigate
extending this approach for supporting allocations in very constrained
contexts (NMI) so e.g. bpf doesn't have to reimplement the slab allocator,
and that would also not be good to limit to !SLUB_TINY.

>> @@ -4060,6 +4201,45 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>>  }
>>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>>
>> +int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int count,
>> +               gfp_t gfp)
>> +{
>> +       struct slub_percpu_array *pca;
>> +       void *objects[32];
>> +       unsigned int used;
>> +       unsigned int allocated;
>> +
>> +       if (!s->cpu_array)
>> +               return -EINVAL;
>> +
>> +       /* racy but we don't care */
>> +       pca = raw_cpu_ptr(s->cpu_array);
>> +
>> +       used = READ_ONCE(pca->used);
> 
> Hmm for the prefill to be meaningful,
> remote allocation should be possible, right?

Remote in what sense?

> Otherwise it only prefills for the CPU that requested it.

If there's a cpu migration between the prefill and usage, it might run out
of the cached array, but assumption is to be rare enough to become an issue.

>> +       if (used >= count)
>> +               return 0;
>> +
>> +       if (pca->count < count)
>> +               return -EINVAL;
>> +
>> +       count -= used;
>> +
>> +       /* TODO fix later */
>> +       if (count > 32)
>> +               count = 32;
>> +
>> +       for (int i = 0; i < count; i++)
>> +               objects[i] = NULL;
>> +       allocated = kmem_cache_alloc_bulk(s, gfp, count, &objects[0]);
>> +
>> +       for (int i = 0; i < count; i++) {
>> +               if (objects[i]) {
>> +                       kmem_cache_free(s, objects[i]);
>> +               }
>> +       }
> 
> nit: why not
> 
> for (int i = 0; i < allocated; i++) {
>     kmem_cache_free(s, objects[i]);
> }
> 
> and skip objects[i] = NULL
> 

This is rewritten significantly in v3 so I think it doesn't apply anymore.

>> +       return allocated;
>> +}
> 
> And a question:
> Does SLUB still need to maintain per-cpu partial slab lists even when
> an opt-in percpu array is used?

Good question :) didn't investigate it yet. We can, once this settles.

Thanks.
