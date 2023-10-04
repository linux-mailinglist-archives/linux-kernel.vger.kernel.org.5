Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698B7B821F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbjJDOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbjJDOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:18:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58743AB;
        Wed,  4 Oct 2023 07:18:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C5C7DA7;
        Wed,  4 Oct 2023 07:19:06 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8454B3F59C;
        Wed,  4 Oct 2023 07:18:24 -0700 (PDT)
Message-ID: <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com>
Date:   Wed, 4 Oct 2023 15:18:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
Content-Language: en-GB
To:     Icenowy Zheng <uwu@icenowy.me>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux-MM <linux-mm@kvack.org>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
 <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
 <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker>
 <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
 <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com>
 <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 3:02 pm, Icenowy Zheng wrote:
[...]
>>>> I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select the
>>>> required configs for RZ/Five SoC") can cause regression on all
>>>> non-dma-coherent riscv platforms with generic defconfig. This is
>>>> a common issue. The logic here is: generic riscv defconfig
>>>> selects
>>>> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
>>>> non-dma-coherent riscv platforms have a dma global pool, this
>>>> assumption
>>>> seems not correct. And I believe DMA_GLOBAL_POOL should not be
>>>> selected by ARCH_SOCFAMILIY, instead, only ARCH under some
>>>> specific
>>>> conditions can select it globaly, for example NOMMU ARM and so
>>>> on.
>>>>
>>>> Since this is a regression, what's proper fix? any suggestion is
>>>> appreciated.
>>
>> I think the answer is to not select DMA_GLOBAL_POOL, since that is
>> only
> 
> Well I think for RISC-V, it's not NOMMU only but applicable for every
> core that does not support Svpbmt or vendor-specific alternatives,
> because the original RISC-V priv spec does not define memory attributes
> in page table entries.
> 
> For the Renesas/Andes case I think a pool is set by OpenSBI with
> vendor-specific M-mode facility and then passed in DT, and the S-mode
> (which MMU is enabled in) just sees fixed memory attributes, in this
> case I think DMA_GLOBAL_POOL is needed.

Oh wow, is that really a thing? In that case, either you just can't 
support this platform in a multi-platform kernel, or someone needs to do 
some fiddly work in dma-direct to a) introduce the notion of an optional 
global pool, and b) make it somehow cope with DMA_DIRECT_REMAP being 
enabled but non-functional.

Thanks,
Robin.
