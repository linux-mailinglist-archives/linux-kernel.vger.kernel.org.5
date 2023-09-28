Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7F7B2169
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjI1PdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjI1PdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:33:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA136C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:33:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B351FB;
        Thu, 28 Sep 2023 08:33:55 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3792D3F59C;
        Thu, 28 Sep 2023 08:33:15 -0700 (PDT)
Message-ID: <f0b03b73-cb01-f613-c4a6-da546ab47464@arm.com>
Date:   Thu, 28 Sep 2023 16:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Content-Language: en-GB
To:     Arnd Bergmann <arnd@arndb.de>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
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
 <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com>
 <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
 <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 4:16 pm, Arnd Bergmann wrote:
> On Thu, Sep 28, 2023, at 10:00, Jim Quinlan wrote:
>> On Thu, Sep 28, 2023 at 9:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Thu, Sep 28, 2023, at 08:07, Jim Quinlan wrote:
>>>> On Wed, Sep 27, 2023 at 7:10 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>
>>>>> Clearly if you want to do this, surely the ARM-specific
>>>>> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
>>>>> needs to be removed at the same time?
>>>>
>>>>
>>>> Yes, this is the reason I used "RFC" as the fix looked too easy to be viable :-)
>>>> I debugged it enough to see that the host driver's
>>>> writes to the dma_alloc_coherent() region  were not appearing in
>>>> memory, and that
>>>> led me to DMA_DIRECT_REMAP.
>>>
>>> Usually when you see a mismatch between the data observed by the
>>> device and the CPU, the problem is an incorrect "dma-coherent"
>>> property in the DT: either the device is coherent and accesses
>>> the cache but the CPU tries to bypass it because the property
>>> is missing, or there is an extraneous property and the CPU
>>> goes the through the cache but the devices bypasses it.
>>
>> I just searched, there are no "dt-coherent" properties in our device tree.
>> Also, even if we did have them, wouldn't things also fail when not using
>> restricted DMA?
> 
> Correct, it should be independent of restricted DMA, but it might
> work by chance that way even if it's still wrong. If your DT
> is marked as non-coherent (note: the property to look for
> is "dma-coherent", not "dt-coherent"), can you check the
> datasheet of the SoC to if that is actually correct?
> 
> If the chip is designed to support high-speed devices on
> PCIe, it's likely that the PCIe root complex is either coherent
> with the caches, or can (and should) be configured that way
> for performance reasons.
> 
>>> It could also be a driver bug if the device  mixes up the
>>> address spaces, e.g. passing virt_to_phys(pointer) rather
>>> than the DMA address returned by dma_alloc_coherent().
>>
>> This is an Intel 7260 part using the iwlwifi driver, I doubt it has
>> errors of that kind.
> 
> It's unlikely but not impossible, as the driver has some
> unusual constructs, using a lot of coherent mappings that
> might otherwise be streaming mappings, and relying on
> dma_sync_single_for_device(..., DMA_BIDIRECTIONAL) for other
> data, but without the corresponding dma_sync_single_for_cpu().
> If all the testing happens on x86, this might easily lead
> to a bug that only shows up on non-coherent systems but
> is never seen during testing.

Probably the significant thing about restricted DMA is that it forces 
all streaming DMA to be bounce-buffered. That should expose busted 
synchronisation even more decisively than a lack of coherency. If 
there's no IOMMU, then testing the driver in the absence of restricted 
DMA but with "swiotlb=force" should confirm or disprove that.

Robin.

> If the problem is not the "dma-coherent" property, can you
> double-check if using a different PCIe device works, or narrow
> down which specific buffer you saw get corrupted?
> 
>       Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
