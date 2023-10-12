Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0058E7C69CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjJLJg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJLJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:36:53 -0400
Received: from out-207.mta1.migadu.com (out-207.mta1.migadu.com [IPv6:2001:41d0:203:375::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE42A91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:36:51 -0700 (PDT)
Message-ID: <ed62f766-d59d-072b-b811-0b4dabf6f000@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697103409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ7Hvxze07BnW+iLsUmdQvphJeSNuEhC6cbejDQqx+I=;
        b=M2oWhf1WUsxDITd54dPtMLI0p3RWx+acBeFB5GSpNUhWhAGw1KPbjcG2VQrdbLyqgBC0gH
        KJS7kna6ZLAum46fmEE7Xp+j/LMMue+3QAAseUsK71VQEKViOAeqaiHh/4w8KAoWAa5wtc
        dKqc2eV2+sFyCv1qemE4x1zsTydVCuE=
Date:   Thu, 12 Oct 2023 17:36:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
 <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
 <20231002084708.GZ3303@kernel.org>
 <f7e6f67a-4cac-73bd-1d5e-5020c6c8423d@redhat.com>
 <20231002111051.GA3303@kernel.org>
 <3057dab3-19f2-99ca-f125-e91a094975ed@redhat.com>
 <8c9ee3bd-6d71-4111-8f4e-91bc52b42ed4@linux.dev>
 <20231005050619.GB3303@kernel.org>
 <6545ac4c-1205-6c09-49ea-e00c24d1a2ff@linux.dev>
 <20231012091906.GQ3303@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231012091906.GQ3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 2023/10/12 17:19, Mike Rapoport wrote:
> On Thu, Oct 05, 2023 at 10:04:28PM +0800, Yajun Deng wrote:
>>>>>>>> That 'if' breaks the invariant that __free_pages_core is
>>>>>>>> always called for pages with initialized page count. Adding
>>>>>>>> it may lead to subtle bugs and random memory corruption so we
>>>>>>>> don't want to add it at the first place.
>>>>>>> As long as we have to special-case memory hotplug, we know that
>>>>>>> we are always coming via generic_online_page() in that case. We
>>>>>>> could either move some logic over there, or let
>>>>>>> __free_pages_core() know what it should do.
>>>>>> Looks like the patch rather special cases MEMINIT_EARLY, although
>>>>>> I didn't check throughfully other code paths.  Anyway, relying on
>>>>>> page_count() to be correct in different ways for different
>>>>>> callers of __free_pages_core() does not sound right to me.
>>>>> Absolutely agreed.
>>>>>
>>>> I already sent v5  a few days ago. Comments, please...
>>> Does it address all the feedback from this thread?
>> Except hotplug.
> Please reread carefully the last comments from me and from David above.
>

I replied in another thread about that 'if' statement. David just 
replied to me, let's discuss in another thread.

