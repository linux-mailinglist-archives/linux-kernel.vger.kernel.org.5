Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E80806B22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377349AbjLFJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377345AbjLFJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:58:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E3CD45
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:58:07 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D07F221F4E;
        Wed,  6 Dec 2023 09:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701856685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8sXZ1VnaFvD+d6tTkWgPtcPa6GYEwUd43mPhrV5ynPM=;
        b=TyDveYqJ1PPmEvcJTebmhW9HnPauTWSbgf+eLVxRdHf3pg4SNbYaA1hyHNV79UkTke54Vu
        HcGCcODHKXIilovKNSDc1twgp8NfUkmteiiHPMaV4lP2JfqGHMjCvk72rgtDop6Jh2NxkC
        RJeqDMT5NbOZyWNlVg4NUOemsGljBgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701856685;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8sXZ1VnaFvD+d6tTkWgPtcPa6GYEwUd43mPhrV5ynPM=;
        b=bZz9l9D8qNs3n1neL4kfIUS8f12gb0EXQQkmz0qyf/LK7Jv4UR09vRg/Wh2Az9fxsTKo4i
        jJFI7UkUk5oe1SDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFFE413408;
        Wed,  6 Dec 2023 09:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id HN+WKq1FcGVxTgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 06 Dec 2023 09:58:05 +0000
Message-ID: <79e29576-12a2-a423-92f3-d8a7bcd2f0ce@suse.cz>
Date:   Wed, 6 Dec 2023 10:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm/slub: free KFENCE objects in slab_free_hook()
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz>
 <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
         RCPT_COUNT_TWELVE(0.00)[14];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,bytedance.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,googlegroups.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.80
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 14:27, Chengming Zhou wrote:
> On 2023/12/5 03:34, Vlastimil Babka wrote:
>> When freeing an object that was allocated from KFENCE, we do that in the
>> slowpath __slab_free(), relying on the fact that KFENCE "slab" cannot be
>> the cpu slab, so the fastpath has to fallback to the slowpath.
>> 
>> This optimization doesn't help much though, because is_kfence_address()
>> is checked earlier anyway during the free hook processing or detached
>> freelist building. Thus we can simplify the code by making the
>> slab_free_hook() free the KFENCE object immediately, similarly to KASAN
>> quarantine.
>> 
>> In slab_free_hook() we can place kfence_free() above init processing, as
>> callers have been making sure to set init to false for KFENCE objects.
>> This simplifies slab_free(). This places it also above kasan_slab_free()
>> which is ok as that skips KFENCE objects anyway.
>> 
>> While at it also determine the init value in slab_free_freelist_hook()
>> outside of the loop.
>> 
>> This change will also make introducing per cpu array caches easier.
>> 
>> Tested-by: Marco Elver <elver@google.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 22 ++++++++++------------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index ed2fa92e914c..e38c2b712f6c 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2039,7 +2039,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>>   * production configuration these hooks all should produce no code at all.
>>   *
>>   * Returns true if freeing of the object can proceed, false if its reuse
>> - * was delayed by KASAN quarantine.
>> + * was delayed by KASAN quarantine, or it was returned to KFENCE.
>>   */
>>  static __always_inline
>>  bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>> @@ -2057,6 +2057,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>>  		__kcsan_check_access(x, s->object_size,
>>  				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
>>  
>> +	if (kfence_free(kasan_reset_tag(x)))
> 
> I'm wondering if "kasan_reset_tag()" is needed here?

I think so, because AFAICS the is_kfence_address() check in kfence_free()
could be a false negative otherwise. In fact now I even question some of the
other is_kfence_address() checks in mm/slub.c, mainly
build_detached_freelist() which starts from pointers coming directly from
slab users. Insight from KASAN/KFENCE folks appreciated :)

> The patch looks good to me!
> 
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks!

> Thanks.
> 
>> +		return false;
>> +
>>  	/*
>>  	 * As memory initialization might be integrated into KASAN,
>>  	 * kasan_slab_free and initialization memset's must be
>> @@ -2086,23 +2089,25 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>>  	void *object;
>>  	void *next = *head;
>>  	void *old_tail = *tail;
>> +	bool init;
>>  
>>  	if (is_kfence_address(next)) {
>>  		slab_free_hook(s, next, false);
>> -		return true;
>> +		return false;
>>  	}
>>  
>>  	/* Head and tail of the reconstructed freelist */
>>  	*head = NULL;
>>  	*tail = NULL;
>>  
>> +	init = slab_want_init_on_free(s);
>> +
>>  	do {
>>  		object = next;
>>  		next = get_freepointer(s, object);
>>  
>>  		/* If object's reuse doesn't have to be delayed */
>> -		if (likely(slab_free_hook(s, object,
>> -					  slab_want_init_on_free(s)))) {
>> +		if (likely(slab_free_hook(s, object, init))) {
>>  			/* Move object to the new freelist */
>>  			set_freepointer(s, object, *head);
>>  			*head = object;
>> @@ -4103,9 +4108,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>  
>>  	stat(s, FREE_SLOWPATH);
>>  
>> -	if (kfence_free(head))
>> -		return;
>> -
>>  	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>>  		free_to_partial_list(s, slab, head, tail, cnt, addr);
>>  		return;
>> @@ -4290,13 +4292,9 @@ static __fastpath_inline
>>  void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>  	       unsigned long addr)
>>  {
>> -	bool init;
>> -
>>  	memcg_slab_free_hook(s, slab, &object, 1);
>>  
>> -	init = !is_kfence_address(object) && slab_want_init_on_free(s);
>> -
>> -	if (likely(slab_free_hook(s, object, init)))
>> +	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>>  		do_slab_free(s, slab, object, object, 1, addr);
>>  }
>>  
>> 

