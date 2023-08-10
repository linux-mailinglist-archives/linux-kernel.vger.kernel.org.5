Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874477780F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHJTDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjHJTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:03:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F133E26A0;
        Thu, 10 Aug 2023 12:03:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A228D75;
        Thu, 10 Aug 2023 12:03:44 -0700 (PDT)
Received: from [192.168.0.23] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1517F3F6C4;
        Thu, 10 Aug 2023 12:02:59 -0700 (PDT)
Message-ID: <1b68f3fd-54d8-4bcd-a986-c84ec2219b9c@arm.com>
Date:   Thu, 10 Aug 2023 20:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com> <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 18:47, David Hildenbrand wrote:
> On 10.08.23 19:15, Peter Xu wrote:
>> On Thu, Aug 10, 2023 at 11:48:27AM +0100, Ryan Roberts wrote:
>>>> For PTE-mapped THP, it might be a bit bigger noise, although I doubt it is
>>>> really significant (judging from my experience on managing PageAnonExclusive
>>>> using set_bit/test_bit/clear_bit when (un)mapping anon pages).
>>>>
>>>> As folio_add_file_rmap_range() indicates, for PTE-mapped THPs we should be
>>>> batching where possible (and Ryan is working on some more rmap batching).
>>>
>>> Yes, I've just posted [1] which batches the rmap removal. That would allow you
>>> to convert the per-page atomic_dec() into a (usually) single per-large-folio
>>> atomic_sub().
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/20230810103332.3062143-1-ryan.roberts@arm.com/
>>
>> Right, that'll definitely make more sense, thanks for the link; I'd be very
>> happy to read more later (finally I got some free time recently..).  But
>> then does it mean David's patch can be attached at the end instead of
>> proposed separately and early?
> 
> Not in my opinion. Batching rmap makes sense even without this change, and this
> change makes sense even without batching.

FWIW, I agree that my series and David's series should be treated independently.
There is independent value in both.

It's also worth pointing out that with my series, the amount of batching you see
in practice still depends on large folios being mapped, which isn't quite the
common case yet.
