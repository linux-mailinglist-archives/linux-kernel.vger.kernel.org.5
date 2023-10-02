Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B07B5661
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbjJBPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbjJBPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:08:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0053B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:08:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19935C15;
        Mon,  2 Oct 2023 08:09:32 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB5D3F762;
        Mon,  2 Oct 2023 08:08:43 -0700 (PDT)
Message-ID: <478adaab-75fe-4d67-10e5-b45bcb2e08d0@arm.com>
Date:   Mon, 2 Oct 2023 16:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Content-Language: en-GB
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Claire Chang <tientzu@chromium.org>
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com>
 <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
 <d0d1452f-3746-a357-3255-c164222ba4bf@arm.com>
 <CA+-6iNyj2ZuosbeNb2kB=BXh6XjW=VKS37CVK0uh4YFvLVHBFg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+-6iNyj2ZuosbeNb2kB=BXh6XjW=VKS37CVK0uh4YFvLVHBFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 1:33 pm, Jim Quinlan wrote:
> On Thu, Sep 28, 2023 at 11:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 28/09/2023 1:07 pm, Jim Quinlan wrote:
>>> On Wed, Sep 27, 2023 at 7:10 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>
>>>> Hi Jim,
>>>>
>>>> thanks for your patch!
>>>>
>>>> On Tue, Sep 26, 2023 at 7:52 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>>>>
>>>>> Without this commit, the use of dma_alloc_coherent() while
>>>>> using CONFIG_DMA_RESTRICTED_POOL=y breaks devices from working.
>>>>> For example, the common Wifi 7260 chip (iwlwifi) works fine
>>>>> on arm64 with restricted memory but not on arm, unless this
>>>>> commit is applied.
>>>>>
>>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>
>>>> (...)
>>>>> +       select DMA_DIRECT_REMAP
>>>>
>>>> Christoph invented that symbol so he can certainly
>>>> explain what is missing to use this on ARM.
>>>>
>>>> This looks weird to me, because:
>>>>> git grep atomic_pool_init
>>>> arch/arm/mm/dma-mapping.c:static int __init atomic_pool_init(void)
>>>> kernel/dma/pool.c:static int __init dma_atomic_pool_init(void)
>>>>
>>>> Now you have two atomic DMA pools in the kernel,
>>>> and a lot more than that is duplicated. I'm amazed that it
>>>> compiles at all.
>>>>
>>>> Clearly if you want to do this, surely the ARM-specific
>>>> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
>>>> needs to be removed at the same time?
>>>>
>>>> However I don't think it's that simple, because Christoph would surely
>>>> had done this a long time ago if it was that simple.
>>>
>>> Hello Linus,
>>>
>>> Yes, this is the reason I used "RFC" as the fix looked too easy to be viable :-)
>>> I debugged it enough to see that the host driver's
>>> writes to the dma_alloc_coherent() region  were not appearing in
>>> memory, and that
>>> led me to DMA_DIRECT_REMAP.
>>
>> Oh, another thing - the restricted-dma-pool is really only for streaming
>> DMA - IIRC there can be cases where the emergency fallback of trying to
>> allocate out of the bounce buffer won't work properly. Are you also
>> using an additional shared-dma-pool carveout to satisfy the coherent
>> allocations, per the DT binding?
> 
> Hello Robin,
> Sorry for the delay.  We use "restricted DMA" as a poor person's IOMMU; we can
> restrict the DMA memory of a device to a narrow region, and our memory
> bus HW has
> "checkers' to enforce said region for a specific memory client, e.g. PCIe.
> 
> We can confirm the assignment of restricted DMA in the bootlog when the device
> is probed:
> 
>          iwlwifi 0001:01:00.0: assigned reserved memory node pcieSR1@4a000000
>          iwlwifi 0001:01:00.0: enabling device (0000 -> 0002)
> 
> As far as your other question, why don't I  just post our relevant DT [1].

OK, I spent a while reminding myself of the restricted DMA code, and I'm 
at least 95% confident that I now recall the relevant details...

Restricted DMA has never actually been supported on ARM, or various 
other platforms which the config doesn't do a great job of reflecting. 
ARM does not fully use dma-direct, and its arch_dma_alloc() 
implementation doesn't understand how to call the swiotlb_alloc() 
fallback path. TBH I'm now rather puzzled that you get any semblance of 
working at all, since AFAICS what ARM's arch_dma_alloc() should end up 
doing is giving you a non-cacheable remap as expected, but of some 
regular kernel memory outside the restricted address range, which 
oughtn't to work at all if something is actually restricting device 
accesses.

Secondly, the case I was half-remembering above is that the 
aforementioned fallback path fundamentally *only* works for non-coherent 
devices where dma_alloc_coherent() calls are in non-blocking context. 
The only way to make atomic coherent allocations come from the 
restricted range is to set up part of it as a per-device coherent pool, 
via an additional reserved-memory region as mentioned.

Thanks,
Robin.

> 
> Regards,
> Jim Quinlan
> Broardcom STB/CM
> 
> [1]
> memory {
>          device_type = "memory";
>          reg = <0x0 0x40000000 0x1 0x0>;
> };
> 
> reserved-memory {
>          #address-cells = <0x2>;
>          #size-cells = <0x2>;
>          ranges;
>          /* ... */
> 
>          pcieSR1@4a000000 {
>                  linux,phandle = <0x2a>;
>                  phandle = <0x2a>;
>                  compatible = "restricted-dma-pool";
>                  reserved-names = "pcieSR1";
>                  reg = <0x0 0x4a000000 0x0 0x2400000>;
>          };
> };
> pcie@8b20000 {
>          /* ... */
>          pci@0,0 {
>                  /* ... */
>                  pci-ep@0,0 {
>                          memory-region = <0x2a>;
>                          reg = <0x10000 0x0 0x0 0x0 0x0>;
>                  };
>          };
> };
> 
> 
> 
> 
>>
>> Thanks,
>> Robin.
