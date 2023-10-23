Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727FE7D3F73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjJWSor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:44:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63604100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:44:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01A5921B13;
        Mon, 23 Oct 2023 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698086682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/EtPfwtnJ/lv0lToPBnLwDwjqcHgx6IPTIbuy0W1QnE=;
        b=HbaDqIPAOsTTMwn4Ahd31fHf8ZBOUwkzL91+TgfESYl0u9aSgjFhzVeLzjGAbnpfUuVXXt
        zYQmO3ogXQhPSTtCyfL6BFwD3h9gEYCydQemJTwd+YnXdLSHcXo3/jTkj4NTNVouGOiYbY
        Y6KmzjeR4RqXMgtR0vAAvGCF2pB9V+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698086682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/EtPfwtnJ/lv0lToPBnLwDwjqcHgx6IPTIbuy0W1QnE=;
        b=xwbQtoBmvvXm3TKcF4EnJxbECg4EjqY54ERIVx/j1MkTMOnYoKI7rNpTJgjls1MAKSfuah
        b59/ufdEn24km/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A52B5139C2;
        Mon, 23 Oct 2023 18:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BWKIJxm/NmWlcgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Oct 2023 18:44:41 +0000
Message-ID: <ba3d6ac7-6900-3e8d-46b5-8302ca61f8ef@suse.cz>
Date:   Mon, 23 Oct 2023 20:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc:     chengming.zhou@linux.dev, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, willy@infradead.org,
        pcc@google.com, tytso@mit.edu, maz@kernel.org,
        ruansy.fnst@fujitsu.com, vishal.moola@gmail.com,
        lrh2000@pku.edu.cn, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <4134b039-fa99-70cd-3486-3d0c7632e4a3@suse.cz>
 <fcb9b7f0-fb21-cce8-d452-766a5cc73d4a@gentwo.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <fcb9b7f0-fb21-cce8-d452-766a5cc73d4a@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -9.60
X-Spamd-Result: default: False [-9.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FREEMAIL_CC(0.00)[linux.dev,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,infradead.org,mit.edu,fujitsu.com,pku.edu.cn,vger.kernel.org,kvack.org,bytedance.com];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[19];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 19:00, Christoph Lameter (Ampere) wrote:
> On Mon, 23 Oct 2023, Vlastimil Babka wrote:
> 
>>>
>>> The slab will be delay frozen when it's picked to actively use by the
>>> CPU, it becomes full at the same time, in which case we still need to
>>> rely on "frozen" bit to avoid manipulating its list. So the slab will
>>> be frozen only when activate use and be unfrozen only when deactivate.
>>
>> Interesting solution! I wonder if we could go a bit further and remove
>> acquire_slab() completely. Because AFAICS even after your changes,
>> acquire_slab() is still attempted including freezing the slab, which means
>> still doing an cmpxchg_double under the list_lock, and now also handling the
>> special case when it failed, but we at least filled percpu partial lists.
>> What if we only filled the partial list without freezing, and then froze the
>> first slab outside of the list_lock?
>>
>> Or more precisely, instead of returning the acquired "object" we would
>> return the first slab removed from partial list. I think it would simplify
>> the code a bit, and further reduce list_lock holding times.
>>
>> I'll also point out a few more details, but it's not a full detailed review
>> as the suggestion above, and another for 4/5, could mean a rather
>> significant change for v3.
> 
> This is not that easy. The frozen bit indicates that list management does 
> not have to be done for a slab if its processed in free. If you take a 
> slab off the list without setting that bit then something else needs to 
> provide the information that "frozen" provided.

Yes, that's the new slab_node_partial flag in patch 1, protected by list_lock.

> If the frozen bit changes can be handled in a different way than 
> with cmpxchg then that is a good optimization.

Frozen bit stays the same, but some scenarios can now avoid it.

> For much of the frozen handling we must be holding the node list lock 
> anyways in order to add/remove from the list. So we already have a lock 
> that could be used to protect flag operations.

I can see the following differences between the traditional frozen bit and
the new flag:

frozen bit advantage:
- __slab_free() on an already-frozen slab can ignore list operations and
list_lock completely

frozen bit disadvantage:
- acquire_slab() trying to do cmpxchg_double() under list_lock (see commit
9b1ea29bc0d7)

slab_node_partial flag advantage:
- we can take slabs off from node partial list without cmpxchg_double()
- probably less cmpxchg_double() operations overall

slab_node_partial flag disadvantage:
- a __slab_free() that encouters a slab that's not frozen (but
slab_node_partial flag is not set) might have to do more work, including
taking the list_lock only to find out that slab_node_partial flag is false
(but AFAICS that happens only when the slab becomes fully free by the free
operation, thus relatively rarely).

Put together, I think we might indeed get the best of both if the frozen
flag is kept to use for cpu slabs, and we rely on slab_node_partial flag for
cpu partial slabs, as the series does.

