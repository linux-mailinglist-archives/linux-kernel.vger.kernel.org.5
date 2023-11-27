Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4D67F9EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjK0Lol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjK0Loj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:44:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA4B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:44:44 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 779451FD85;
        Mon, 27 Nov 2023 11:44:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 552381379A;
        Mon, 27 Nov 2023 11:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id aQluFCmBZGX2bwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 27 Nov 2023 11:44:41 +0000
Message-ID: <1f2f5a9f-61aa-094d-f9ed-be97e3671fb1@suse.cz>
Date:   Mon, 27 Nov 2023 12:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
Content-Language: en-US
To:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <20231122231202.121277-1-andrey.konovalov@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231122231202.121277-1-andrey.konovalov@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++++++++++
X-Spam-Score: 14.28
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 779451FD85
X-Spamd-Result: default: False [14.28 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.09)[99.96%];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         RCPT_COUNT_TWELVE(0.00)[14];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.dev:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FREEMAIL_CC(0.00)[gmail.com,google.com,googlegroups.com,suse.de,intel.com,kvack.org,vger.kernel.org];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 00:12, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> When both KASAN and slub_debug are enabled, when a free object is being
> prepared in setup_object, slub_debug poisons the object data before KASAN
> initializes its per-object metadata.
> 
> Right now, in setup_object, KASAN only initializes the alloc metadata,
> which is always stored outside of the object. slub_debug is aware of
> this and it skips poisoning and checking that memory area.
> 
> However, with the following patch in this series, KASAN also starts
> initializing its free medata in setup_object. As this metadata might be
> stored within the object, this initialization might overwrite the
> slub_debug poisoning. This leads to slub_debug reports.
> 
> Thus, skip checking slub_debug poisoning of the object data area that
> overlaps with the in-object KASAN free metadata.
> 
> Also make slub_debug poisoning of tail kmalloc redzones more precise when
> KASAN is enabled: slub_debug can still poison and check the tail kmalloc
> allocation area that comes after the KASAN free metadata.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

> ---
> 
> Andrew, please put this patch right before "kasan: use stack_depot_put
> for Generic mode".
> ---
>  mm/slub.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..782bd8a6bd34 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -870,20 +870,20 @@ static inline void set_orig_size(struct kmem_cache *s,
>  				void *object, unsigned int orig_size)
>  {
>  	void *p = kasan_reset_tag(object);
> +	unsigned int kasan_meta_size;
>  
>  	if (!slub_debug_orig_size(s))
>  		return;
>  
> -#ifdef CONFIG_KASAN_GENERIC
>  	/*
> -	 * KASAN could save its free meta data in object's data area at
> -	 * offset 0, if the size is larger than 'orig_size', it will
> -	 * overlap the data redzone in [orig_size+1, object_size], and
> -	 * the check should be skipped.
> +	 * KASAN can save its free meta data inside of the object at offset 0.
> +	 * If this meta data size is larger than 'orig_size', it will overlap
> +	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
> +	 * 'orig_size' to be as at least as big as KASAN's meta data.
>  	 */
> -	if (kasan_metadata_size(s, true) > orig_size)
> -		orig_size = s->object_size;
> -#endif
> +	kasan_meta_size = kasan_metadata_size(s, true);
> +	if (kasan_meta_size > orig_size)
> +		orig_size = kasan_meta_size;
>  
>  	p += get_info_end(s);
>  	p += sizeof(struct track) * 2;
> @@ -1192,7 +1192,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  {
>  	u8 *p = object;
>  	u8 *endobject = object + s->object_size;
> -	unsigned int orig_size;
> +	unsigned int orig_size, kasan_meta_size;
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> @@ -1222,12 +1222,23 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  	}
>  
>  	if (s->flags & SLAB_POISON) {
> -		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
> -			(!check_bytes_and_report(s, slab, p, "Poison", p,
> -					POISON_FREE, s->object_size - 1) ||
> -			 !check_bytes_and_report(s, slab, p, "End Poison",
> -				p + s->object_size - 1, POISON_END, 1)))
> -			return 0;
> +		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON)) {
> +			/*
> +			 * KASAN can save its free meta data inside of the
> +			 * object at offset 0. Thus, skip checking the part of
> +			 * the redzone that overlaps with the meta data.
> +			 */
> +			kasan_meta_size = kasan_metadata_size(s, true);
> +			if (kasan_meta_size < s->object_size - 1 &&
> +			    !check_bytes_and_report(s, slab, p, "Poison",
> +					p + kasan_meta_size, POISON_FREE,
> +					s->object_size - kasan_meta_size - 1))
> +				return 0;
> +			if (kasan_meta_size < s->object_size &&
> +			    !check_bytes_and_report(s, slab, p, "End Poison",
> +					p + s->object_size - 1, POISON_END, 1))
> +				return 0;
> +		}
>  		/*
>  		 * check_pad_bytes cleans up on its own.
>  		 */

