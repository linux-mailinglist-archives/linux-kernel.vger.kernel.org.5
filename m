Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4A7B8156
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbjJDNuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:50:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C82A1;
        Wed,  4 Oct 2023 06:50:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2008CDA7;
        Wed,  4 Oct 2023 06:50:45 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 591733F59C;
        Wed,  4 Oct 2023 06:50:03 -0700 (PDT)
Message-ID: <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com>
Date:   Wed, 4 Oct 2023 14:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
Content-Language: en-GB
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Christoph Hellwig <hch@lst.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux-MM <linux-mm@kvack.org>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
 <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
 <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker>
 <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 2:02 pm, Lad, Prabhakar wrote:
> + CC linux-mm and Robin Murphy
> 
> On Wed, Oct 4, 2023 at 12:42 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>>
>> On Mon, Oct 02, 2023 at 09:37:44PM -0700, Drew Fustini wrote:
>>> On Fri, Sep 22, 2023 at 05:48:21PM -0500, Robert Nelson wrote:
>>>> On Fri, Sep 22, 2023 at 2:08 PM Robert Nelson <robertcnelson@gmail.com> wrote:
>>>>>
>>>>> On Thu, Sep 21, 2023 at 8:51 PM Drew Fustini <dfustini@baylibre.com> wrote:
>>>>>>
>>>>>> This series adds support for the eMMC on the BeagleV Ahead and the
>>>>>> Sipeed LicheePi 4A. This allows the kernel to boot with the rootfs on
>>>>>> eMMC.
>>>>>>
>>>>>> I tested on top of v6.6-rc2 with this config [1]. I was able to boot
>>>>>> both the Ahead [2] and LPi4a [3] from eMMC. The following prerequisites
>>>>>> are required:
>>>>>>
>>>>>>    [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [4]
>>>>>>
>>>>>> I pushed a branch [5] with this patch series and the above patch for
>>>>>> those that find a git branch easier to test.
>>>>>>
>>>>>> Please note that only the MMC controller connected to the eMMC device
>>>>>> is enabled in the device trees for these two boards. I did not yet
>>>>>> attempt to configure and use the microSD card slot. My preference is to
>>>>>> address that in a future patch series.
>>>>>>
>>>>>> References:
>>>>>> [1] https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
>>>>>> [2] https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
>>>>>> [3] https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
>>>>>> [4] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@kernel.org/
>>>>>> [5] https://github.com/pdp7/linux/tree/b4/th1520-mmc
>>>>>
>>>>> This patchset came out very nice!
>>>>>
>>>>> v6.6-rc2 with Last RFC v2:
>>>>>
>>>>> [    4.066630] mmc0: SDHCI controller on ffe7080000.mmc
>>>>> [ffe7080000.mmc] using PIO
>>>>>
>>>>> debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
>>>>>
>>>>> /dev/mmcblk0:
>>>>>   Timing cached reads:   1516 MB in  2.00 seconds = 758.09 MB/sec
>>>>>   Timing buffered disk reads:  84 MB in  3.01 seconds =  27.94 MB/sec
>>>>>
>>>>> vs v6.6-rc2 with this patchset:
>>>>>
>>>>>   [    4.096837] mmc0: SDHCI controller on ffe7080000.mmc
>>>>> [ffe7080000.mmc] using DMA
>>>>>
>>>>> debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
>>>>>
>>>>> /dev/mmcblk0:
>>>>>   Timing cached reads:   1580 MB in  2.00 seconds = 790.97 MB/sec
>>>>>   Timing buffered disk reads: 418 MB in  3.00 seconds = 139.11 MB/sec
>>>>
>>>> Drew pointed out on Slack, this was not quite right.. After more
>>>> digging by Drew, CONFIG_DMA_GLOBAL_POOL is causing a DMA limitation
>>>> with the multiplatform defconfig. so with,
>>>>
>>>> ./scripts/config --disable CONFIG_ARCH_R9A07G043
>>>>
>>>> (to remove CONFIG_DMA_GLOBAL_POOL)... another 2x in buffered reads..
>>>>
>>>> [    4.059242] mmc0: SDHCI controller on ffe7080000.mmc
>>>> [ffe7080000.mmc] using ADMA 64-bit
>>>>
>>>> debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
>>>>
>>>> /dev/mmcblk0:
>>>>   Timing cached reads:   1600 MB in  2.00 seconds = 800.93 MB/sec
>>>>   Timing buffered disk reads: 892 MB in  3.00 seconds = 297.06 MB/sec
>>>
>>> It seems CONFIG_DMA_GLOBAL_POOL=y causes ADMA buffer alloc to fail [1]:
>>>
>>>    mmc0: Unable to allocate ADMA buffers - falling back to standard DMA
>>>
>>> Prabhakar's AX45MP non-coherent DMA support [2] series introduced the
>>> selection of DMA_GLOBAL_POOL for ARCH_R9A07G043 and the riscv defconfig
>>> selects ARCH_R9A07G043.
>>>
>>> Patch 5 in the series [3] states that:
>>>
>>>    With DMA_GLOBAL_POOL enabled all DMA allocations happen from this
>>>    region and synchronization callbacks are implemented to synchronize
>>>    when doing DMA transactions.
>>>
>>> This example of a "shared-dma-pool" node was given:
>>>
>>>          pma_resv0@58000000 {
>>>              compatible = "shared-dma-pool";
>>>              reg = <0x0 0x58000000 0x0 0x08000000>;
>>>              no-map;
>>>              linux,dma-default;
>>>          };
>>>
>>> I've copied that to th1520-beaglev-ahead.dts. The address of 0x58000000
>>> has no significance on th1520, but the existence of shared-dma-pool
>>> seems to fix the problem. ADMA mode [4] is now working even though
>>> CONFIG_DMA_GLOBAL_POOL=y.
>>
>> + Christoph, Lad
>>
>> IMHO, this is not TH1520 specific but a generic issue.
>>
>> I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select the
>> required configs for RZ/Five SoC") can cause regression on all
>> non-dma-coherent riscv platforms with generic defconfig. This is
>> a common issue. The logic here is: generic riscv defconfig selects
>> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
>> non-dma-coherent riscv platforms have a dma global pool, this assumption
>> seems not correct. And I believe DMA_GLOBAL_POOL should not be
>> selected by ARCH_SOCFAMILIY, instead, only ARCH under some specific
>> conditions can select it globaly, for example NOMMU ARM and so on.
>>
>> Since this is a regression, what's proper fix? any suggestion is
>> appreciated.

I think the answer is to not select DMA_GLOBAL_POOL, since that is only 
designed for nommu cases where non-cacheable memory lives in a fixed 
place in the physical address map, and regular kernel pages can't be 
remapped. As far as I'm aware, RISCV_DMA_NONCOHERENT is the thing you 
want, such that DMA_DIRECT_REMAP can dynamically provide non-cacheable 
coherent buffers for non-hardware-coherent devices.

Thanks,
Robin.

>>
>> Thanks
>>
>>>
>>> Thanks,
>>> Drew
>>>
>>> [1] https://gist.github.com/pdp7/73041ed808bbc7dd445836fb90574979
>>> [2] https://lore.kernel.org/linux-riscv/20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>>> [3] https://lore.kernel.org/linux-riscv/20230818135723.80612-6-prabhakar.mahadev-lad.rj@bp.renesas.com/
>>> [4] https://gist.github.com/pdp7/91e72a663d3bb73eb28182337ad8bbcb
