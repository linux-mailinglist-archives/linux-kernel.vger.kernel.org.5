Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD17DC4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjJaCvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjJaCvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:51:09 -0400
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D21ED
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:51:05 -0700 (PDT)
Message-ID: <1dcc9969-da5b-4384-96d8-d03c835f198e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698720663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJGocIrvJOpdyaBLIvTHhgCm+KI16lXmHvQhyhxns3g=;
        b=DaUqksiPCxsm2P165op2FK7Z8jYJPEvUwhHu13OegGDh0aU+2Tiwtn57XudzehhMgoy8UP
        U8AQyOlzpM2iuBqadciwZOGw1uL+zJ+Ff+tWhoRJkd9utrVWeNs0dpamyA6/eApsWZlxwe
        Lbsc9oPhgDPuaSRlZzVNAb6sVtZuBZY=
Date:   Tue, 31 Oct 2023 10:50:33 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Christoph Lameter <cl@linux.com>, vbabka@suse.cz
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com>
 <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
 <7f70d130-c05a-3cb7-9509-41c21c3014fb@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <7f70d130-c05a-3cb7-9509-41c21c3014fb@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/31 03:25, Christoph Lameter wrote:
> On Sat, 28 Oct 2023, Chengming Zhou wrote:
> 
>> 2. But for full slab (slab->freelist == NULL), PG_workingset is not much useful, we don't
>>   safely know whether it's used as the cpu slab or not just from this flag. So __slab_free()
>>   still rely on the "frozen" bit to know it.
>>
>> 3. And the maintaining of "frozen" has no extra cost now, since it's changed together with "freelist"
>>   and other counter using cmpxchg, we already have the cmpxchg when start to use a slab as the cpu slab.
>>
>> Maybe I missed something, I don't know how to drop the frozen flag.
> 
> 
> Maybe frozen is now = PG_Workingset | cmpxchg-frozen?
> 
> 

The current scheme (which this series implemented) is:

- node partial slabs: PG_Workingset (set or clear with per-node list_lock protection)
- cpu partial slabs: !PG_Workingset
- cpu slabs: !PG_Workingset && frozen (set or clear using cmpxchg together with freelist)
- full slabs: !PG_Workingset

As Vlastimil noted, it's possible to drop "frozen" bit for cpu slabs, but
we keep it for performance, since we don't need to grab node list_lock to
check whether PG_Workingset is set or not if the "frozen" bit is set.

Thanks!
