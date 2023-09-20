Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5C7A87C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjITPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjITPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:02:01 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF8A9;
        Wed, 20 Sep 2023 08:01:52 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5CD444013B;
        Wed, 20 Sep 2023 20:01:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1695222108; bh=SWx/UK/CnipXd9eT0wDFQZTm4wj0E8HoB9K/FI6n/NI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z0JKKJ+fhTAOEH2Dyzosh//+nrSR3/D2EeWLE1Ow+30zhQXp+LAAZpE+Axg1dIdol
         pGHhJ4MyknqTeuPP48Ym0p30FihO9YGjj4yEJCFtErQMDA7r1gN1Kr9vC2MBPfrm7I
         thT9eXSWAXwhopv5YSbrTX0scfhqdTeYD28X0jJgEDfpgTP8YUgBOA2A0ZXpSfmFI0
         jct1F0MfhfHsJZzncykQoidsAS/M9V6j35jufCa3qu9KyMMJ2Zm2EDiSXiMWo3suOa
         lJuiTAlX7SIuwEApzpUInTBtR2gT4RoLRuf8SMqlaVbHq+qrcBd9VaKry3KPf/FOrh
         ZfczAQye9iuyA==
MIME-Version: 1.0
Date:   Wed, 20 Sep 2023 20:01:47 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 battery and charger
In-Reply-To: <b45a5263-c6dd-f446-babe-1da287dbf74f@linaro.org>
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
 <20230916-pm8916-dtsi-bms-lbc-v1-3-7db0b42f9fb1@trvn.ru>
 <b45a5263-c6dd-f446-babe-1da287dbf74f@linaro.org>
Message-ID: <0b5a2c5b5204eb639095dd7df489f838@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 20.09.2023 19:50:
> On 9/16/23 15:57, Nikita Travkin wrote:
>> Longcheer L8150 doesn't have any dedicated fuel-gauge or charger,
>> instead making use of the pmic hardware blocks for those purposes.
>>
>> Add pm8916 bms and charger, as well as the battery cell description
>> that those devices rely on.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>   .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 43 +++++++++++++++++++---
>>   1 file changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
>> index 3892ad4f639a..95dddf3b3880 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
>> @@ -33,6 +33,25 @@ wcnss_mem: wcnss@8b600000 {
>>   		};
>>   	};
>>   +	battery: battery {
>> +		compatible = "simple-battery";
>> +		voltage-min-design-microvolt = <3400000>;
>> +		voltage-max-design-microvolt = <4350000>;
>> +		energy-full-design-microwatt-hours = <9500000>;
>> +		charge-full-design-microamp-hours = <2500000>;
>> +
>> +		ocv-capacity-celsius = <25>;
>> +		ocv-capacity-table-0 = <4330000 100>, <4265000 95>,
>> +			<4208000 90>, <4153000 85>, <4100000 80>, <4049000 75>,
>> +			<4001000 70>, <3962000 65>, <3919000 60>, <3872000 55>,
>> +			<3839000 50>, <3817000 45>, <3798000 40>, <3783000 35>,
>> +			<3767000 30>, <3747000 25>, <3729000 20>, <3709000 16>,
>> +			<3688000 13>, <3681000 11>, <3680000 10>, <3679000 9>,
>> +			<3677000 8>, <3674000 7>, <3666000 6>, <3641000 5>,
>> +			<3597000 4>, <3537000 3>, <3457000 2>, <3336000 1>,
>> +			<3000000 0>;
>> +	};
>> +
>>   	gpio-keys {
>>   		compatible = "gpio-keys";
>>   @@ -220,6 +239,22 @@ &blsp_uart2 {
>>   	status = "okay";
>>   };
>>   +&pm8916_bms {
>> +	status = "okay";
> status last
> 

Would be inconsistent for this file then and resorting those in
bulk was nacked already.

https://lore.kernel.org/all/20230119033428.ga6sbu42jaueac5o@builder.lan/

Nikita

> Konrad
