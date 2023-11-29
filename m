Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67307FD7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjK2NZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjK2NZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:25:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FA983
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:25:34 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A3BCF210DF;
        Wed, 29 Nov 2023 13:25:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 861A113637;
        Wed, 29 Nov 2023 13:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 47hXIMw7Z2XlRAAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 29 Nov 2023 13:25:32 +0000
Message-ID: <e0647e65-d348-35a0-bc5a-66d1ad02ea53@suse.cz>
Date:   Wed, 29 Nov 2023 14:25:32 +0100
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
 <077e8e97-e88f-0b8e-2788-4031458be090@suse.cz>
 <CAB=+i9SQBhYBjOSHDeqgJJ5YARqZCS3oUUutzr4m+2V+ZvySpg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9SQBhYBjOSHDeqgJJ5YARqZCS3oUUutzr4m+2V+ZvySpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++
X-Spam-Score: 11.63
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: A3BCF210DF
X-Spamd-Result: default: False [11.63 / 50.00];
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
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.05)[-0.257];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         NEURAL_SPAM_LONG(2.29)[0.655];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 01:46, Hyeonggon Yoo wrote:
> On Wed, Nov 29, 2023 at 2:37 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> >> @@ -4060,6 +4201,45 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>> >>  }
>> >>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>> >>
>> >> +int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int count,
>> >> +               gfp_t gfp)
>> >> +{
>> >> +       struct slub_percpu_array *pca;
>> >> +       void *objects[32];
>> >> +       unsigned int used;
>> >> +       unsigned int allocated;
>> >> +
>> >> +       if (!s->cpu_array)
>> >> +               return -EINVAL;
>> >> +
>> >> +       /* racy but we don't care */
>> >> +       pca = raw_cpu_ptr(s->cpu_array);
>> >> +
>> >> +       used = READ_ONCE(pca->used);
>> >
>> > Hmm for the prefill to be meaningful,
>> > remote allocation should be possible, right?
>>
>> Remote in what sense?
> 
> TL;DR) What I wanted to ask was:
> "How pre-filling a number of objects works when the pre-filled objects
> are not shared between CPUs"
> 
> IIUC the prefill is opportunistically filling the array so (hopefully)
> expecting there are
> some objects filled in it.

Yes.

> Let's say CPU X calls kmem_cache_prefill_percpu_array(32) and all 32
> objects are filled into CPU X's array.
> But if CPU Y can't allocate from CPU X's array (which I referred to as
> "remote allocation"), the semantics differ from
> the maple tree's perspective because preallocated objects were shared
> between CPUs before, but now it's not?

The assumption is that the operation will prefill on CPU X and then consume
it also on X, because shortly after prefill it will enter some restricted
context (i.e. spin_lock_irqsave or whatnot) that prevents it from migrating.
That's not guaranteed of course, but migration in a bad moment and
subsequent depleted array should be rare enough that we'll just handle it in
the slow paths, and if it results in dipping into reserves, it won't be too
disruptive.

> Thanks!
> 
> --
> Hyeonggon

