Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95D773FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjHHQw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjHHQvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:51:23 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE48C2132;
        Tue,  8 Aug 2023 08:57:58 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6733F827D;
        Tue,  8 Aug 2023 15:38:52 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 8 Aug
 2023 15:38:52 +0800
Received: from [192.168.155.152] (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 8 Aug
 2023 15:38:47 +0800
Message-ID: <cbc3c9db-6a47-4e4f-5e5d-892d048ef924@starfivetech.com>
Date:   Tue, 8 Aug 2023 15:38:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] riscv: dts: starfive - Add crypto and DMA node for
 JH7110
To:     Conor Dooley <conor@kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230808061150.81491-1-jiajie.ho@starfivetech.com>
 <20230808061150.81491-2-jiajie.ho@starfivetech.com>
 <20230808-cilantro-fondue-21485b78e83e@spud>
Content-Language: en-US
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <20230808-cilantro-fondue-21485b78e83e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 3:16 pm, Conor Dooley wrote:
> On Tue, Aug 08, 2023 at 02:11:49PM +0800, Jia Jie Ho wrote:
>> Add hardware crypto module and dedicated dma controller node to StarFive
>> JH7110 SoC.
>> 
>> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
>> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
>> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 28 ++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index a608433200e8..47cd12ccc988 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -821,6 +821,34 @@ watchdog@13070000 {
>>  				 <&syscrg JH7110_SYSRST_WDT_CORE>;
>>  		};
>>  
>> +		crypto: crypto@16000000 {
>> +			compatible = "starfive,jh7110-crypto";
>> +			reg = <0x0 0x16000000 0x0 0x4000>;
>> +			clocks = <&stgcrg JH7110_STGCLK_SEC_AHB>,
>> +				 <&stgcrg JH7110_STGCLK_SEC_MISC_AHB>;
>> +			clock-names = "hclk", "ahb";
>> +			interrupts = <28>;
>> +			resets = <&stgcrg JH7110_STGRST_SEC_AHB>;
>> +			dmas = <&sdma 1 2>, <&sdma 0 2>;
>> +			dma-names = "tx", "rx";
>> +		};
>> +
>> +		sdma: dma@16008000 {
>> +			compatible = "arm,pl080", "arm,primecell";
>> +			arm,primecell-periphid = <0x00041080>;
>> +			reg = <0x0 0x16008000 0x0 0x4000>;
>> +			interrupts = <29>;
>> +			clocks = <&stgcrg JH7110_STGCLK_SEC_AHB>,
>> +				 <&stgcrg JH7110_STGCLK_SEC_MISC_AHB>;
>> +			clock-names = "hclk", "apb_pclk";
>> +			resets = <&stgcrg JH7110_STGRST_SEC_AHB>;
>> +			lli-bus-interface-ahb1;
>> +			mem-bus-interface-ahb1;
>> +			memcpy-burst-size = <256>;
>> +			memcpy-bus-width = <32>;
>> +			#dma-cells = <2>;
>> +		};
>> +
> 
> Against linux-next, I get these warnings:
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: dma@16008000: $nodename:0: 'dma@16008000' does not match '^dma-controller(@.*)?$'
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: dma@16008000: clocks: [[26, 15], [26, 16]] is too long
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: dma@16008000: clock-names: ['hclk', 'apb_pclk'] is too long
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: dma@16008000: Unevaluated properties are not allowed ('#dma-cells' was unexpected)
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: dma@16008000: $nodename:0: 'dma@16008000' does not match '^dma-controller(@.*)?$'
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: dma@16008000: clocks: [[26, 15], [26, 16]] is too long
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: dma@16008000: clock-names: ['hclk', 'apb_pclk'] is too long
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: dma@16008000: Unevaluated properties are not allowed ('#dma-cells' was unexpected)
>         from schema $id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
> 
> Please fix these & submit a tested v2.
> 

Sorry, I missed testing the dma node.
Will fix this in next version.

Regards,
Jia Jie

