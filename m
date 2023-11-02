Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6647DEA8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348232AbjKBCLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBCLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:11:30 -0400
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2362110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:11:24 -0700 (PDT)
Message-ID: <93306e1c-37ad-45cf-b2ee-92535a89021d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698891083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxZ3oaZqaTui4AQcHS61VY5yG4ph5EDEsHHAdJZLzqY=;
        b=RFZlqwpOHWsC7a7Tg0hdb7bk4pWxe9MNd7QDFp5BscMj4maPbhyhtS2beT4OdyGEcRnjoz
        ++rZOgp7oK2vw+853bzGeQaX5wXxx34ehtmxh7KX3ZuWb5hamJNeKkjBX9rWemLNRceivT
        zLTx05wfqg49PxV4Qe1EXVqyT+Z6RFA=
Date:   Thu, 2 Nov 2023 10:10:53 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4 7/9] slub: Optimize deactivate_slab()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <20231031140741.79387-8-chengming.zhou@linux.dev>
 <6041f645-a3d0-367a-8f2a-c6c5a68507ca@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <6041f645-a3d0-367a-8f2a-c6c5a68507ca@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/1 21:21, Vlastimil Babka wrote:
> 
> 
> On 10/31/23 15:07, chengming.zhou@linux.dev wrote:
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
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
>> ---
>>  mm/slub.c | 76 +++++++++++++++++++------------------------------------
>>  1 file changed, 26 insertions(+), 50 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index bcb5b2c4e213..c429f8baba5f 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2468,10 +2468,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>  			    void *freelist)
>>  {
>> -	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>>  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>>  	int free_delta = 0;
>> -	enum slab_modes mode = M_NONE;
>>  	void *nextfree, *freelist_iter, *freelist_tail;
>>  	int tail = DEACTIVATE_TO_HEAD;
>>  	unsigned long flags = 0;
>> @@ -2512,62 +2510,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>>  	 *
>>  	 * Ensure that the slab is unfrozen while the list presence
>>  	 * reflects the actual number of objects during unfreeze.
> 
> I think this we can delete also these two lines. If there's no other
> reason for v5, I can do it when merging the series.

Ok, I will delete it in v5.

Thanks!
