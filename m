Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129A7DA4A5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 03:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjJ1Bbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 21:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjJ1Bbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 21:31:46 -0400
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E719183
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 18:31:43 -0700 (PDT)
Message-ID: <b3f0e14f-03df-44e3-a524-4ed43cb8f980@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698456698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvs+eTtJ66DLSNeg3WuDmtpcRjw+t6vm77/M+6Bl8Z4=;
        b=rRUEy/vzoQOeLfVrTuptdU2ev1h2MguLRiuU6o8ZnW0z2OzfBJY0I2fjNOSyuIlDeUcq4i
        aQD6HgjVcsjnghs0+hNZ4TLcJpz9irVHmY8U3Epvn6ZInIYttIdbVTSTV3vLCPpP4cGvS3
        DojuUxSerOM50VJNytmOsglYvUV32G4=
Date:   Sat, 28 Oct 2023 09:30:54 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 1/7] slub: Keep track of whether slub is on the
 per-node partial list
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-2-chengming.zhou@linux.dev>
 <6d054dbe-c90d-591d-11ca-b9ad3787683d@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <6d054dbe-c90d-591d-11ca-b9ad3787683d@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/27 23:09, Vlastimil Babka wrote:
> On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Now we rely on the "frozen" bit to see if we should manipulate the
>> slab->slab_list, which will be changed in the following patch.
>>
>> Instead we introduce another way to keep track of whether slub is on
>> the per-node partial list, here we reuse the PG_workingset bit.
>>
>> We use __set_bit and __clear_bit directly instead of the atomic version
>> for better performance and it's safe since it's protected by the slub
>> node list_lock.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/slab.h | 19 +++++++++++++++++++
>>  mm/slub.c |  3 +++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 8cd3294fedf5..50522b688cfb 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
> 
> I think these helper might just go to mm/slub.c as nothing else would use them.
> 

Ok.

>> @@ -193,6 +193,25 @@ static inline void __slab_clear_pfmemalloc(struct slab *slab)
>>  	__folio_clear_active(slab_folio(slab));
>>  }
>>  
>> +/*
>> + * Slub reuse PG_workingset bit to keep track of whether it's on
> 
> "SLUB reuses" ...
> 
> Looks fine otherwise!
> 

Will fix it. Thanks!
