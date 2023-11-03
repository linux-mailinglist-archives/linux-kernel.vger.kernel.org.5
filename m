Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01A67E0581
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjKCPXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKCPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:23:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CC58112;
        Fri,  3 Nov 2023 08:23:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AECC2F4;
        Fri,  3 Nov 2023 08:24:20 -0700 (PDT)
Received: from [10.57.81.32] (unknown [10.57.81.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6FC03F64C;
        Fri,  3 Nov 2023 08:23:31 -0700 (PDT)
Message-ID: <3b4ac48b-e29d-415f-89f1-6d354f18c4a4@arm.com>
Date:   Fri, 3 Nov 2023 15:23:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] ASoC: pxa: Suppress SSPA on ARM64
Content-Language: en-GB
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>,
        kernel test robot <lkp@intel.com>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
 <dc7aaff0-f767-494e-9a3a-40fcacc1674e@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <dc7aaff0-f767-494e-9a3a-40fcacc1674e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-02 3:26 pm, Mark Brown wrote:
> On Thu, Nov 02, 2023 at 04:20:29PM +0100, Duje Mihanović wrote:
>> The SSPA driver currently seems to generate ARM32 assembly, which causes
>> build errors when building a kernel for an ARM64 ARCH_MMP platform.
>>
>> Fixes: fa375d42f0e5 ("ASoC: mmp: add sspa support")
>> Reported-by: kernel test robot <lkp@intel.com>
> 
>>   	tristate "SoC Audio via MMP SSPA ports"
>> -	depends on ARCH_MMP
>> +	depends on ARCH_MMP && ARM
> 
> This isn't a fix for the existing code, AFAICT the issue here is that
> ARCH_MMP is currently only available for arm and presumably something in
> the rest of your series makes it available for arm64.  This would be a
> prerequisite for that patch.
> 
> Please don't just insert random fixes tags just because you can.

FWIW it doesn't even seem to be the right reason either. AFACIT the 
issue being introduced is that SND_MMP_SOC_SSPA selects SND_ARM which 
depends on ARM, but after patch #8 ARCH_MMP itself will no longer 
necessarily imply ARM. The fact that selecting SND_ARM with unmet 
dependencies also allows SND_ARMAACI to be enabled (which appears to be 
the only thing actually containing open-coded Arm asm) is tangential.

Robin.
