Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF017D3D68
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjJWRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:23:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2EF3A2;
        Mon, 23 Oct 2023 10:23:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DEDE2F4;
        Mon, 23 Oct 2023 10:23:43 -0700 (PDT)
Received: from [10.57.5.125] (unknown [10.57.5.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19BFE3F762;
        Mon, 23 Oct 2023 10:22:58 -0700 (PDT)
Message-ID: <289f5f83-adc7-4077-b4c0-c951484dd092@arm.com>
Date:   Mon, 23 Oct 2023 18:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] dma: Use free_decrypted_pages()
Content-Language: en-GB
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
 <20231017202505.340906-7-rick.p.edgecombe@intel.com>
 <b4dc423b-a658-449f-9c6d-1502685a2f1b@arm.com>
 <ea8ad4e75303178ee907682797dea7de36441c95.camel@intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ea8ad4e75303178ee907682797dea7de36441c95.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-23 17:46, Edgecombe, Rick P wrote:
> On Wed, 2023-10-18 at 18:42 +0100, Robin Murphy wrote:
>> On 2023-10-17 21:25, Rick Edgecombe wrote:
>>> On TDX it is possible for the untrusted host to cause
>>> set_memory_encrypted() or set_memory_decrypted() to fail such that
>>> an
>>> error is returned and the resulting memory is shared. Callers need
>>> to take
>>> care to handle these errors to avoid returning decrypted (shared)
>>> memory to
>>> the page allocator, which could lead to functional or security
>>> issues.
>>>
>>> DMA could free decrypted/shared pages if set_memory_decrypted()
>>> fails.
>>> Use the recently added free_decrypted_pages() to avoid this.
>>>
>>> Several paths also result in proper encrypted pages being freed
>>> through
>>> the same freeing function. Rely on free_decrypted_pages() to not
>>> leak the
>>> memory in these cases.
>>
>> If something's needed in the fallback path here, what about the
>> cma_release() paths?
> 
> You mean inside cma_release(). If so, unfortunately I think it won't
> fit great because there are callers that are never dealing with shared
> memory (huge tlb). The reset-to-private operation does extra work that
> would be nice to avoid when possible.
> 
> The cases I thought exhibited the issue were the two calls sites of
> dma_set_decrypted(). Playing around with it, I was thinking it might be
> easier to just fix those to open code leaking the pages on
> dma_set_decrypted() error. In which case it won't have the re-encrypt
> problem.
> 
> It make's it less fool proof, but more efficient. And
> free_decrypted_pages() doesn't fit great anyway, as pointed out by
> Christoph.

My point is that in dma_direct_alloc(), we get some memory either 
straight from the page allocator *or* from a CMA area, then call 
set_memory_decrypted() on it. If the problem is that 
set_memory_decrypted() can fail and require cleanup, then logically if 
that cleanup is necessary for the dma_free_contiguous()->__free_pages() 
call, then surely it must also be necessary for the 
dma_free_contiguous()->cma_release()->free_contig_range()->__free_page() 
calls.

Thanks,
Robin.
