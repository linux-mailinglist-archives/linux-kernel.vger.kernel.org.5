Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1897740E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHHRLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjHHRLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:11:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8067691
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:04:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B1121F853;
        Tue,  8 Aug 2023 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691507331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWcv16REQqHhPYwN0ug3QkMuy7/75HPhpbQTjYO3Z7Q=;
        b=w4qehdrYb5omMlVFfcrdUyXjnBMrr8yT00CU44ryYSj84vzc1fmI59dlRuJXtFPUGxJFhm
        GOrWu85ocY0Vi44NjEo+W4YV4MZTRQA1NFkYtJz942FnpMENYJpDfAzWElbzbyjpqtvYhM
        hzv7DMyTaqYjApsEorce9U8VYb8UiFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691507331;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWcv16REQqHhPYwN0ug3QkMuy7/75HPhpbQTjYO3Z7Q=;
        b=2TXngQdyVXn/f+KSSeli81VcHWr4fxTMxkKg6zvUyCvB/CRJCToVIMb+F9pTwTd4S0Asv2
        mJxxhM7EYUfgahAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DC37139D1;
        Tue,  8 Aug 2023 15:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jEd2BoNa0mSESQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Aug 2023 15:08:51 +0000
Message-ID: <e4344207-4236-aeb7-5d51-91e3c65451d8@suse.cz>
Date:   Tue, 8 Aug 2023 17:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC v1 4/5] maple_tree: avoid bulk alloc/free to use percpu
 array more
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Matthew Wilcox <willy@infradead.org>
References: <20230808095342.12637-7-vbabka@suse.cz>
 <20230808095342.12637-11-vbabka@suse.cz>
 <853af8fa-0cef-b00b-3fd6-9780a2008050@bytedance.com>
 <20230808142945.tulcze5bjg5ciftk@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230808142945.tulcze5bjg5ciftk@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 16:29, Liam R. Howlett wrote:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230808 07:17]:
>> 
>> 
>> 在 2023/8/8 17:53, Vlastimil Babka 写道:
>> > Using bulk alloc/free on a cache with percpu array should not be
>> > necessary and the bulk alloc actually bypasses the array (the prefill
>> > functionality currently relies on this).
>> > 
>> > The simplest change is just to convert the respective maple tree
>> > wrappers to do a loop of normal alloc/free.
>> > ---
>> >   lib/maple_tree.c | 11 +++++++++--
>> >   1 file changed, 9 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> > index 1196d0a17f03..7a8e7c467d7c 100644
>> > --- a/lib/maple_tree.c
>> > +++ b/lib/maple_tree.c
>> > @@ -161,12 +161,19 @@ static inline struct maple_node *mt_alloc_one(gfp_t gfp)
>> >   static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>> >   {
>> > -	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>> > +	int allocated = 0;
>> > +	for (size_t i = 0; i < size; i++) {
>> > +		nodes[i] = kmem_cache_alloc(maple_node_cache, gfp);
>> > +		if (nodes[i])
>> If the i-th allocation fails, node[i] will be NULL. This is wrong. We'd
>> better guarantee that mt_alloc_bulk() allocates completely successfully,
>> or returns 0. The following cases are not allowed:
>> nodes: [addr1][addr2][NULL][addr3].

Thanks, indeed. I guess it should just break; in case of failure and return
how many allocations succeeded so far.

But note this is a really a quick RFC proof of concept hack. I'd expect if
the whole idea is deemed as good, the maple tree node handling could be
redesigned (simplified?) around it and maybe there's no mt_alloc_bulk()
anymore as a result?

> Thanks for pointing this out Peng.
> 
> We can handle a lower number than requested being returned, but we
> cannot handle the sparse data.
> 
> The kmem_cache_alloc_bulk() can return a failure today - leaving the
> array to be cleaned by the caller, so if this is changed to a full
> success or full fail, then we will also have to change the caller to
> handle whatever state is returned if it differs from
> kmem_cache_alloc_bulk().
> 
> It might be best to return the size already allocated when a failure is
> encountered. This will make the caller, mas_alloc_nodes(), request more
> nodes.  Only in the case of zero allocations would this be seen as an
> OOM event.
> 
> Vlastimil, Is the first kmem_cache_alloc() call failing a possibility?

Sure, if there's no memory, it can fail. In practice if gfp is one that
allows reclaim, it will ultimately be the "too small to fail" allocation on
the page allocator level. But there are exceptions, like having received a
fatal signal, IIRC :)

> If so, what should be the corrective action?

Depends on your context, if you can pass on -ENOMEM to the caller, or need
to succeed.

>> > +			allocated++;
>> > +	}
>> > +	return allocated;
>> >   }
>> >   static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>> >   {
>> > -	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
>> > +	for (size_t i = 0; i < size; i++)
>> > +		kmem_cache_free(maple_node_cache, nodes[i]);
>> >   }
>> >   static void mt_free_rcu(struct rcu_head *head)

