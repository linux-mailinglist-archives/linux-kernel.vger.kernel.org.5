Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51047AE732
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjIZH5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:57:33 -0400
Received: from out-207.mta1.migadu.com (out-207.mta1.migadu.com [IPv6:2001:41d0:203:375::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5592
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:57:25 -0700 (PDT)
Message-ID: <b6f0abbc-91e3-6561-a1ba-09048a999161@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695715043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4sxViBIUK9Xji+V4y3qHtoLu+O9zEJAdt1f5evurSk=;
        b=O7QO+SS6VfuE5VU28oGjgYJJrfpLy4LXAXb0BuMjnB77fMIS4Kuaq73n0R3ast6O70EIYW
        sp7jEOG44o4xGZe3I618U9aKhErG1lySKFbFiOa8fktlxogj2ZIL0QEVvCOV1/hgHweOgq
        VFlolSYazVCdSFuv5DNJz/ljXpDBqw8=
Date:   Tue, 26 Sep 2023 15:57:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] mm: pass page count and reserved to
 __init_single_page
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        rppt@kernel.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230926023341.991124-1-yajun.deng@linux.dev>
 <20230926023341.991124-2-yajun.deng@linux.dev>
 <9777812e-c8c8-2105-cd2c-443438786172@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <9777812e-c8c8-2105-cd2c-443438786172@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/26 15:44, David Hildenbrand wrote:
> On 26.09.23 04:33, Yajun Deng wrote:
>> When we init a single page, we need to mark this page reserved if it
>> does. 
>
> I failed to parse the last part of this sentence.
>
>> And some pages may not need to set page count, such as compound
>> pages.
>
> Usually, the refcount of all tail pages *must* be zero. Otherwise, 
> get_page_unless_zero() would work on tail pages.
>
> Can you elaborate why it should be okay here?
>
>
It means the following code in memmap_init_compound().

-               __init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+               __init_zone_device_page(page, pfn, zone_idx, nid, pgmap, 0);
                 prep_compound_tail(head, pfn - head_pfn);
                 set_page_count(page, 0);

As we can see, it will reset the page count by 'set_page_count(page, 0)'.

Therefore, we don't need to set page count in __init_zone_device_page(). 
I wasn't clear enough in the commit.

Maybe we can remove the 'set_page_count(page, 0)',  But I didn't do 
that, just to be safe.

