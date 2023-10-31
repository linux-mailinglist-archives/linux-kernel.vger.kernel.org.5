Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD67DC476
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjJaCac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJaCa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:30:29 -0400
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE144C5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:30:26 -0700 (PDT)
Message-ID: <a3b588fd-002a-4f40-95d8-aaf672c81fb5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698719425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3D3NG9Rr5nexXkejnTZubHojYTPIvCsAncG92DOezQ=;
        b=hRg+Yo3YilYdpwUOalAS1b9MuHcI/s8JdbFEwfZhaStPXBmmwzD67ar2kTezMVGcTXLIPj
        b+1e0sKFI01VF3F2XWYKdtstzZhrIXy6Zz664pEHQirjdclh2ZnSJBEP/e1aTLbhmM5LbC
        8YRGA4xKKwn4RKT72ZUnyxREve+V54w=
Date:   Tue, 31 Oct 2023 10:29:53 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com>
 <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
 <04cbf4cd-3f62-9068-b4fd-c90158f2f116@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <04cbf4cd-3f62-9068-b4fd-c90158f2f116@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/31 00:19, Vlastimil Babka wrote:
> On 10/28/23 04:36, Chengming Zhou wrote:
>>>
>>>
>>> After this patch the PG_workingset indicates the state of being on the partial lists.
>>>
>>> What does "frozen slab" then mean? The slab is being allocated from? Is that information useful or can we drop the frozen flag?
>>
>> Right, frozen slab is the cpu slab, which is being allocated from by the cpu that froze it.
>>
>> IMHO, the "frozen" bit is useful because:
>>
>> 1. PG_workingset is only useful on partial slab, which indicates the slab is on the node
>>    partial list, so we can manipulate its list in the __slab_free() path.
>>
>> 2. But for full slab (slab->freelist == NULL), PG_workingset is not much useful, we don't
>>    safely know whether it's used as the cpu slab or not just from this flag. So __slab_free()
>>    still rely on the "frozen" bit to know it.
> 
> Well, we could extend the meaning of PG_workingset to mean "not a cpu slab
> or pecpu partial slab" i.e. both on node partial list and full. However it
> would increase the number of cases where __slab_free() has to lock the
> list_lock and check the PG_working set. "slab->freelist == NULL" might
> happen often exactly because the freelist became cpu freelist.

Ah, right, it's possible to do like this.

> 
>> 3. And the maintaining of "frozen" has no extra cost now, since it's changed together with "freelist"
>>    and other counter using cmpxchg, we already have the cmpxchg when start to use a slab as the cpu slab.
> 
> And together with this point, I don't see a reason to drop the frozen bit.
> It's still useful for cpu slabs. It just wasn't the best possible solution
> for percpu partial slabs.
> 
>> Maybe I missed something, I don't know how to drop the frozen flag.
> 
> Should be possible, but not worth it IMHO.

Agree, we'll just keep "frozen" for the cpu slabs.

Thanks!
