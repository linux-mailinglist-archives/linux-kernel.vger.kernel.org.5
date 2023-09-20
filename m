Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39517A784A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjITJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjITJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:58:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3826A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:58:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 63F492212A;
        Wed, 20 Sep 2023 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695203894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7etg/EV2WUJEwG7wK9oO1aQjQJcvB5sBjEfwzI17Yw=;
        b=MR3L8ZSGioj7/m7NYCndkX9AGXys7GHVywviOzZM5a5LphNVXQ1teZMYKlz/w04kvFM601
        15ZHupLaiynIlKNq/itEKLGkpswIDQUWMuk3gY5YWLB3SaDlvTUcqNScl+rbI2p4ABI8Dp
        1MPWZgdaHQpCOrYNEN0v21SO5vXrlHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695203894;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7etg/EV2WUJEwG7wK9oO1aQjQJcvB5sBjEfwzI17Yw=;
        b=lKFd2Oq5A4hZPiuD4O26oaYs7nJ4/7Y92ui8qz7Z4BkeNYRmo0RP/JUpxCslLVhfVVDur3
        OdzYhgAn86I6dvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35F0E1333E;
        Wed, 20 Sep 2023 09:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FgB0DDbCCmUXCAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Sep 2023 09:58:14 +0000
Message-ID: <5569ec99-b441-f7f0-060b-168abc089b23@suse.cz>
Date:   Wed, 20 Sep 2023 11:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Kees Cook' <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Eric Dumazet' <edumazet@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
 <202309071235.CB4F6B2@keescook>
 <20ca0a567a874052a1161e9be0870463@AcuMS.aculab.com>
 <e17c58a4-2dd8-4a1b-9feb-ab307e3877c2@suse.cz>
 <1bf41b7c8d7c428c8bfb5504ec9f680e@AcuMS.aculab.com>
 <1d634412-c0e5-4c16-92a4-447bde684ad6@suse.cz>
 <e12d3085c8b8414b837bfc737af0c9de@AcuMS.aculab.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e12d3085c8b8414b837bfc737af0c9de@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 18:38, David Laight wrote:
>> >> So perhaps the best would be to return size for c == NULL, but also do a
>> >> WARN_ONCE?
>> >
>> > That would add a real function call to an otherwise leaf function
>> > and almost certainly require the compiler create a stack frame.
>> 
>> Hm I thought WARN is done by tripping on undefined instruction like BUG
>> these days. Also any code that accepts the call to kmalloc_size_roundup
>> probably could accept that too.
> 
> It's probably just worth removing the c == NULL check and
> assuming there won't be any fallout.
> The NULL pointer deref is an easy to debug as anything else.
> 
> If it gets called in any early init code it'll soon show up.
 
Good point, early crash should be ok.
So how about this with my tweaks, looks ok? I'll put it in -next and
send with another hotfix to 6.6 next week.
----8<----
From f5de1ee7b35d7ab35c21c79dd13cea49fbe239b7 Mon Sep 17 00:00:00 2001
From: David Laight <david.laight@aculab.com>
Date: Thu, 7 Sep 2023 12:42:20 +0000
Subject: [PATCH] Subject: [PATCH v2] slab: kmalloc_size_roundup() must not
 return 0 for non-zero size

The typical use of kmalloc_size_roundup() is:

	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
	if (!ptr) return -ENOMEM.

This means it is vitally important that the returned value isn't less
than the argument even if the argument is insane.
In particular if kmalloc_slab() fails or the value is above
(MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
its single zero-length buffer ZERO_SIZE_PTR.

Fix this by returning the input size if the size exceeds
KMALLOC_MAX_SIZE. kmalloc() will then return NULL as the size really is
too big.

kmalloc_slab() should not normally return NULL, unless called too early.
Again, returning zero is not the correct action as it can be in some
usage scenarios stored to a variable and only later cause kmalloc()
return ZERO_SIZE_PTR and subsequent crashes on access. Instead we can
simply stop checking the kmalloc_slab() result completely, as calling
kmalloc_size_roundup() too early would then result in an immediate crash
during boot and the developer noticing an issue in their code.

[vbabka@suse.cz: remove kmalloc_slab() result check, tweak comments and
 commit log]
Signed-off-by: David Laight <david.laight@aculab.com>
Fixes: 05a940656e1e ("slab: Introduce kmalloc_size_roundup()")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e99e821065c3..1dc108224bd1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -747,22 +747,25 @@ size_t kmalloc_size_roundup(size_t size)
 {
 	struct kmem_cache *c;
 
-	/* Short-circuit the 0 size case. */
-	if (unlikely(size == 0))
-		return 0;
-	/* Short-circuit saturated "too-large" case. */
-	if (unlikely(size == SIZE_MAX))
-		return SIZE_MAX;
+	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
+		/*
+		 * The flags don't matter since size_index is common to all.
+		 * Neither does the caller for just getting ->object_size.
+		 */
+		c = kmalloc_slab(size, GFP_KERNEL, 0);
+		return c->object_size;
+	}
+
 	/* Above the smaller buckets, size is a multiple of page size. */
-	if (size > KMALLOC_MAX_CACHE_SIZE)
+	if (size && size <= KMALLOC_MAX_SIZE)
 		return PAGE_SIZE << get_order(size);
 
 	/*
-	 * The flags don't matter since size_index is common to all.
-	 * Neither does the caller for just getting ->object_size.
+	 * Return 'size' for 0 - kmalloc() returns ZERO_SIZE_PTR
+	 * and very large size - kmalloc() may fail.
 	 */
-	c = kmalloc_slab(size, GFP_KERNEL, 0);
-	return c ? c->object_size : 0;
+	return size;
+
 }
 EXPORT_SYMBOL(kmalloc_size_roundup);
 
-- 
2.42.0



