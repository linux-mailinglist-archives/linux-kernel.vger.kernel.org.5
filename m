Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761317F41CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjKVJhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:37:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ECBBD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:37:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B97421940;
        Wed, 22 Nov 2023 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700645860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy17+oNWzei3WX/QIj/LJHOt0qY0/3p6N33SxwYAQD0=;
        b=oFi9Jq/JdIsnTbc9d2pmWLUlVeXCQpuDwVMbVR44e/1WLk7qqNtEeilB2ooP2gcSzAyRw2
        PXOxYhsl0DMvY7lMJw5vVJ0xBlzy58++kV6EXSl5oMzgQOyo6GxDenXvyV2HVWTGfPbe6o
        bqva54R/t6JctJxOxm6CrV37+sJ+Hfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700645860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy17+oNWzei3WX/QIj/LJHOt0qY0/3p6N33SxwYAQD0=;
        b=TwkFmVDhwOag+85NhQs6n3T8GipbgY/4mbvw2B33Wewnyj9seiq+LspDOkNIYa0zrhX7aM
        jK0Wr486/oKa9vBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D2E813461;
        Wed, 22 Nov 2023 09:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9qsoEuTLXWWRewAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Nov 2023 09:37:40 +0000
Message-ID: <83ff4b9e-94f1-8b35-1233-3dd414ea4dfe@suse.cz>
Date:   Wed, 22 Nov 2023 10:37:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, chengming.zhou@linux.dev
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.40
X-Spamd-Result: default: False [0.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MID_RHS_MATCH_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         BAYES_HAM(-3.00)[100.00%];
         RCPT_COUNT_TWELVE(0.00)[13];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com,infradead.org];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 19:49, Mark Brown wrote:
> On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>> 
>> Now we will freeze slabs when moving them out of node partial list to
>> cpu partial list, this method needs two cmpxchg_double operations:
>> 
>> 1. freeze slab (acquire_slab()) under the node list_lock
>> 2. get_freelist() when pick used in ___slab_alloc()
> 
> Recently -next has been failing to boot on a Raspberry Pi 3 with an arm
> multi_v7_defconfig and a NFS rootfs, a bisect appears to point to this
> patch (in -next as c8d312e039030edab25836a326bcaeb2a3d4db14) as having
> introduced the issue.  I've included the full bisect log below.
> 
> When we see problems we see RCU stalls while logging in, for example:

Can you try this, please?

----8<----
From 000030c1ff055ef6a2ca624d0142f08f3ef19d51 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 22 Nov 2023 10:32:41 +0100
Subject: [PATCH] mm/slub: try to fix hangs without cmpxchg64/128

If we don't have cmpxchg64/128 and resort to slab_lock()/slab_unlock()
which uses PG_locked, we can get RMW with the newly introduced
slab_set/clear_node_partial() operation that modify PG_workingset so all
the operations have to be atomic now.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bcb5b2c4e213..f2cdb81ab02e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -522,7 +522,7 @@ static __always_inline void slab_unlock(struct slab *slab)
 	struct page *page = slab_page(slab);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	__bit_spin_unlock(PG_locked, &page->flags);
+	bit_spin_unlock(PG_locked, &page->flags);
 }
 
 static inline bool
@@ -2127,12 +2127,12 @@ static inline bool slab_test_node_partial(const struct slab *slab)
 
 static inline void slab_set_node_partial(struct slab *slab)
 {
-	__set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
+	set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
 }
 
 static inline void slab_clear_node_partial(struct slab *slab)
 {
-	__clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
+	clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
 }
 
 /*
-- 
2.42.1



