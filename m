Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A217B21A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjI1PrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjI1PrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:47:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6A771A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:47:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A03C11FB;
        Thu, 28 Sep 2023 08:47:49 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8C5D3F59C;
        Thu, 28 Sep 2023 08:47:08 -0700 (PDT)
Message-ID: <d0d1452f-3746-a357-3255-c164222ba4bf@arm.com>
Date:   Thu, 28 Sep 2023 16:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Content-Language: en-GB
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
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

On 28/09/2023 1:07 pm, Jim Quinlan wrote:
> On Wed, Sep 27, 2023 at 7:10 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> Hi Jim,
>>
>> thanks for your patch!
>>
>> On Tue, Sep 26, 2023 at 7:52 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>>
>>> Without this commit, the use of dma_alloc_coherent() while
>>> using CONFIG_DMA_RESTRICTED_POOL=y breaks devices from working.
>>> For example, the common Wifi 7260 chip (iwlwifi) works fine
>>> on arm64 with restricted memory but not on arm, unless this
>>> commit is applied.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>
>> (...)
>>> +       select DMA_DIRECT_REMAP
>>
>> Christoph invented that symbol so he can certainly
>> explain what is missing to use this on ARM.
>>
>> This looks weird to me, because:
>>> git grep atomic_pool_init
>> arch/arm/mm/dma-mapping.c:static int __init atomic_pool_init(void)
>> kernel/dma/pool.c:static int __init dma_atomic_pool_init(void)
>>
>> Now you have two atomic DMA pools in the kernel,
>> and a lot more than that is duplicated. I'm amazed that it
>> compiles at all.
>>
>> Clearly if you want to do this, surely the ARM-specific
>> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
>> needs to be removed at the same time?
>>
>> However I don't think it's that simple, because Christoph would surely
>> had done this a long time ago if it was that simple.
> 
> Hello Linus,
> 
> Yes, this is the reason I used "RFC" as the fix looked too easy to be viable :-)
> I debugged it enough to see that the host driver's
> writes to the dma_alloc_coherent() region  were not appearing in
> memory, and that
> led me to DMA_DIRECT_REMAP.

Oh, another thing - the restricted-dma-pool is really only for streaming 
DMA - IIRC there can be cases where the emergency fallback of trying to 
allocate out of the bounce buffer won't work properly. Are you also 
using an additional shared-dma-pool carveout to satisfy the coherent 
allocations, per the DT binding?

Thanks,
Robin.
