Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD97DC590
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjJaE6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjJaE6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:58:01 -0400
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4470CC9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:57:58 -0700 (PDT)
Message-ID: <82797556-eb7b-4867-86a1-859d11598fc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698728276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=glWEhzZHw9Q8o2NIQUVWc3t/rkBW4T0mk7G578550ZM=;
        b=NJhb/Usj6xad87QL0WNtaCOAmbeXuKQfq+jsoJOwO7gOwL4fogLqIAPnNnjrVQuTZT1AG4
        GxP2z/vcct3bhuY5AnRe2M4gD2trbrWGyqpZQmh1kTJxpDrL/ktryO6GrXi4U2Tpb5jev7
        2ybIqJFQAOWF3aAXyb4ImbrEcAJD970=
Date:   Tue, 31 Oct 2023 12:57:23 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Christoph Lameter <cl@linux.com>
Cc:     vbabka@suse.cz, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com>
 <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev>
 <7f70d130-c05a-3cb7-9509-41c21c3014fb@linux.com>
 <1dcc9969-da5b-4384-96d8-d03c835f198e@linux.dev>
 <edd0197b-7a79-9cb5-8ac5-5d202c2ed51b@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <edd0197b-7a79-9cb5-8ac5-5d202c2ed51b@linux.com>
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

On 2023/10/31 11:47, Christoph Lameter wrote:
> On Tue, 31 Oct 2023, Chengming Zhou wrote:
> 
>> The current scheme (which this series implemented) is:
>>
>> - node partial slabs: PG_Workingset (set or clear with per-node list_lock protection)
>> - cpu partial slabs: !PG_Workingset
> 
> And then the frozen flag needs to be set. Otherwise slab_free() would conclude it is on a partial list?
> 

- cpu partial slabs: !PG_Workingset && !frozen

Here comes the optimization that "frozen" is not set for the cpu partial slabs,
slab_free() will grab node list_lock then check by !PG_Workingset that it's not
on a node partial list.

>> - cpu slabs: !PG_Workingset && frozen (set or clear using cmpxchg together with freelist)
> 
> 
> 
>> - full slabs: !PG_Workingset
> 
> And frozen is clear? Otherwise it is the same as a cpu partial slab.
> 

Right, - full slabs: !PG_Workingset && !frozen

Yes, it's the same as a cpu partial slab from only these two flags, but
slab_free() also know whether it was full or not.

>> As Vlastimil noted, it's possible to drop "frozen" bit for cpu slabs, but
>> we keep it for performance, since we don't need to grab node list_lock to
>> check whether PG_Workingset is set or not if the "frozen" bit is set.
>>
>> Thanks!
>>
