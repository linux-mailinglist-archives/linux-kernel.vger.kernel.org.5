Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B477FC2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbjK1QbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344331AbjK1QbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:31:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E37DAB;
        Tue, 28 Nov 2023 08:31:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A2DC15;
        Tue, 28 Nov 2023 08:32:12 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5732C3F6C4;
        Tue, 28 Nov 2023 08:31:22 -0800 (PST)
Message-ID: <a91938e3-a7cb-4f74-aeaa-7cb56c0b43a4@arm.com>
Date:   Tue, 28 Nov 2023 16:31:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in add_dma_entry()'s debugging code
Content-Language: en-GB
To:     Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew <travneff@gmail.com>,
        Ferry Toth <ferry.toth@elsinga.info>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 3:18 pm, Alan Stern wrote:
> On Tue, Nov 28, 2023 at 02:37:02PM +0100, Christoph Hellwig wrote:
>> I'd actually go one step back:
>>
>>   1) for not cache coherent DMA you can't do overlapping operations inside
>>      a cache line
> 
> Rephrasing slightly: You mustn't perform multiple non-cache-coherent DMA
> operations that touch the same cache line concurrently.  (The word
> "overlapping" is a a little ambiguous in this context.)
> 
> (Right now dma-debug considers only DMA-IN operations.  In theory this
> restriction should apply even when some of the concurrent operations are
> DMA-OUT, provided that at least one of them is DMA-IN.  Minor point...)
> 
>>   2) dma-debug is intended to find DMA API misuses, even if they don't
>>      have bad effects on your particular system
>>   3) the fact that the kmalloc implementation returns differently aligned
>>      memory depending on the platform breaks how dma-debug works currently
> 
> Exactly.  That's essentially what Bugzilla #215740 is about.
> 
>> The logical confcusion from that would be that IFF dma-debug is enabled on
>> any platform we need to set ARCH_DMA_MINALIGN to the cache line size.
> 
> (IF, not IFF.)  And tell distributions that CONFIG_DMA_API_DEBUG is not
> meant for production systems but rather for kernel testing, right?

Yikes, I'd hope that distros are heeding the warning that the Kconfig 
calls out already. It's perhaps somewhat understated, as I'd describe 
the performance impact to large modern systems with high-bandwidth I/O 
as somewhere between "severe" and "crippling".

>> BUT:  we're actually reduzing our dependency on ARCH_DMA_MINALIGN by
>> moving to bounce buffering unaligned memory for non-coherent
>> architectures,
> 
> What's the reason for this?  To allow the minimum allocation size to be
> smaller than the cache line size?  Does the savings in memory make up
> for the extra overhead of bounce buffering?

Yes, on systems where non-coherent streaming DMA is expected to be rare, 
or at least not performance-critical, not having to allocate 128 bytes 
every time we want just 8 or so soon adds up.

> Or is this just to allow people to be more careless about how they
> allocate their DMA buffers (which doesn't seem to make sense)?
> 
>>   which makes this even more complicated.  Right now I
>> don't have a good idea how to actually deal with having the cachline
>> sanity checks with that, but I'm Ccing some of the usual suspects if
>> they have a better idea.
> 
> I get the impression that you would really like to have two different
> versions of kmalloc() and friends: one for buffers that will be used in
> DMA (and hence require cache-line alignment) and one for buffers that
> won't be.

That approach was mooted, but still has potentially-fiddly corner cases 
like when the DMA buffer is a member of a larger struct, so we settled 
on the bounce-buffering solution as the most robust compromise.

Thanks,
Robin.
