Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546957E8F01
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 08:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjKLHjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 02:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKLHjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 02:39:16 -0500
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE572D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 23:39:11 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id C606C440394;
        Sun, 12 Nov 2023 09:38:08 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1699774688;
        bh=CT+4CTFw3TWups965GYXi3kRzFYumSfG7ykeet06X+Q=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=bhw7d3xBy9NQ3TQC6P+MHKyj3rncKvZmIZJRmPXI1e2PnhZS5rHhlBEISOjJnW0No
         9dXTtjiK6ht5C8HYmYy+jYhT0QjiTAAv/xgSHMOFq+EuCnUzuXjL4BAe2Svc6XFo59
         wYLO+VutkrA9bW3WqDVKBD7Yu8xvTg046vN0UrRxGCUgTmRcjdZ2pSOBfaJiJEtB8C
         BLAaHRQktThnRbvl7qQ5fKjJMRpTT33b4b1ewOM9p1bIpo16SA3N7IidxT3VYsHx0T
         wWKAc1SCXEoSLqtVD+2A2NlKhkOvdWi4sDkHZeBf6EYSYmu+v+8rga54/xea+WW1YK
         cYqoI4cRaOffA==
References: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
 <ZU0QEL9ByWNYVki1@arm.com>
User-agent: mu4e 1.9.21; emacs 29.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ramon Fried <ramon@neureality.ai>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] arm64: DMA zone above 4GB
Date:   Sun, 12 Nov 2023 09:25:46 +0200
In-reply-to: <ZU0QEL9ByWNYVki1@arm.com>
Message-ID: <877cmn7750.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin, Petr,

Thanks for your detailed response.

See below a few comments and questions.

On Thu, Nov 09 2023, Catalin Marinas wrote:
> On Wed, Nov 08, 2023 at 07:30:22PM +0200, Baruch Siach wrote:
>> Consider a bus with this 'dma-ranges' property:
>> 
>>   #address-cells = <2>;
>>   #size-cells = <2>;
>>   dma-ranges = <0x00000000 0xc0000000 0x00000008 0x00000000 0x0 0x40000000>;
>> 
>> Devices under this bus can see 1GB of DMA range between 3GB-4GB. This
>> range is mapped to CPU memory at 32GB-33GB.
>
> Is this on real hardware or just theoretical for now (the rest of your
> email implies it's real)? Normally I'd expected the first GB (or first
> two) of RAM from 32G to be aliased to the lower 32-bit range for the CPU
> view as well, not just for devices. You'd then get a ZONE_DMA without
> having to play with DMA offsets.

This hardware is currently in fabrication past tapeout. Software tests
are running on FPGA models and software simulators.

CPU view of the 3GB-4GB range is not linear with DMA addresses. That is,
for offset N where 0 <= N <= 1GB, the CPU address 3GB+N does not map to
the same physical location of DMA address 3GB+N. Hardware engineers are
not sure this is fixable. So as is often the case we look at software to
save us. After all, from hardware perspective this design "works".

>> Current zone_sizes_init() code considers 'dma-ranges' only when it maps
>> to RAM under 4GB, because zone_dma_bits is limited to 32. In this case
>> 'dma-ranges' is ignored in practice, since DMA/DMA32 zones are both
>> assumed to be located under 4GB. The result is that the stmmac driver
>> DMA buffers allocation GFP_DMA32 flag has no effect. As a result DMA
>> buffer allocations fail.
>> 
>> The patch below is a crude workaround hack. It makes the  DMA zone
>> cover the 1GB memory area that is visible to stmmac DMA as follows:
>> 
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
>> ...
>> [    0.000000] software IO TLB: mapped [mem 0x000000083bfff000-0x000000083ffff000] (64MB)
>> 
>> With this hack the stmmac driver works on my platform with no
>> modification.
>> 
>> Clearly this can't be the right solutions. zone_dma_bits is now wrong for
>> one. It probably breaks other code as well.
>
> zone_dma_bits ends up as 36 if I counted correctly. So DMA_BIT_MASK(36)
> is 0xf_ffff_ffff and the phys_limit for your device is below this mask,
> so dma_direct_optimal_gfp_mask() does end up setting GFP_DMA. However,
> looking at how it sets GFP_DMA32, it is obvious that the code is not set
> up for such configurations. I'm also not a big fan of zone_dma_bits
> describing a mask that goes well above what the device can access.
>
> A workaround would be for zone_dma_bits to become a *_limit and sort out
> all places where we compare masks with masks derived from zone_dma_bits
> (e.g. cma_in_zone(), dma_direct_supported()).

I was also thinking along these lines. I wasn't sure I see the entire
picture, so I hesitated to suggest a patch. Specifically, the assumption
that DMA range limits are power of 2 looks deeply ingrained in the
code. Another assumption is that DMA32 zone is in low 4GB range.

I can work on an RFC implementation of this approach.

Petr suggested a more radical solution of per bus DMA constraints to
replace DMA/DMA32 zones. As Petr acknowledged, this does not look like a
near future solution.

> Alternatively, take the DMA offset into account when comparing the
> physical address corresponding to zone_dma_bits and keep zone_dma_bits
> small (phys offset subtracted, so in your case it would be 30 rather
> than 36).

I am not following here. Care to elaborate?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
