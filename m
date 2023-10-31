Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A47DC9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjJaJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjJaJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1BEC2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8CC81F38C;
        Tue, 31 Oct 2023 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698745817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmDB3ZoDEHTn9+Fzo12LCAKVuElxwSgtEkkn5Gsrlpw=;
        b=ozFrpdZdqvIodxUouCteImh+vwVdBdUAjxTpTMC6G44Bm+oX2sK6BFcCxHxb/QrLkj5fvL
        IRBMj3aughr2iO67uezAtmzahtbNf4hd6q9f02wrxIBrcoSvbbuVxq2Bhn3kd44Z+89B5l
        liHbRUYYQj1UvAbGByn5F8nbjqtR5/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698745817;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmDB3ZoDEHTn9+Fzo12LCAKVuElxwSgtEkkn5Gsrlpw=;
        b=nRTQoFQCzDbSNuEj/BqAmcyG++PhOUY388ZS85rAY0YlzAlYmN/jAHTtjy7lLOGSSQUbbG
        PaWn7jR/4rYR+fCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95104138EF;
        Tue, 31 Oct 2023 09:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A1WVI9nNQGW4bwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 31 Oct 2023 09:50:17 +0000
Message-ID: <6257318a-3d39-ccdf-a85f-dc1008a8f425@suse.cz>
Date:   Tue, 31 Oct 2023 10:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 6/7] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-7-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231024093345.3676493-7-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Now we will freeze slabs when moving them out of node partial list to
> cpu partial list, this method needs two cmpxchg_double operations:
> 
> 1. freeze slab (acquire_slab()) under the node list_lock
> 2. get_freelist() when pick used in ___slab_alloc()
> 
> Actually we don't need to freeze when moving slabs out of node partial
> list, we can delay freezing to when use slab freelist in ___slab_alloc(),
> so we can save one cmpxchg_double().
> 
> And there are other good points:
>  - The moving of slabs between node partial list and cpu partial list
>    becomes simpler, since we don't need to freeze or unfreeze at all.
> 
>  - The node list_lock contention would be less, since we don't need to
>    freeze any slab under the node list_lock.
> 
> We can achieve this because there is no concurrent path would manipulate
> the partial slab list except the __slab_free() path, which is serialized
> now.

"which is now serialized by slab_test_node_partial() under the list_lock." ?

> Since the slab returned by get_partial() interfaces is not frozen anymore
> and no freelist in the partial_context, so we need to use the introduced

		 ^ is returned in

> freeze_slab() to freeze it and get its freelist.
> 
> Similarly, the slabs on the CPU partial list are not frozen anymore,
> we need to freeze_slab() on it before use.

We can now delete acquire_slab() as it became unused.

> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

With the fixup for CONFIG_SLUB_CPU_PARTIAL you mentioned,
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Also agreed with followup patch to rename unfreeze_partials().
Thanks!

