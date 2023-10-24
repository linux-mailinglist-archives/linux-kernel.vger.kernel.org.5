Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5C7D4CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjJXJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjJXJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:40:29 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E3F1BCE;
        Tue, 24 Oct 2023 02:30:07 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 71434403C2;
        Tue, 24 Oct 2023 14:29:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698139798; bh=r9TCrD1Taj9N39LOJkMvCUyhLxDk2EU51QorwsqEIP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DyZ5ATjGay9uJdJWM3VKywt/uGPlWIMw4zPa3vJfAHCVgNTsyXnsYxSv3HVwitcsA
         JKyxBMgNl7dTDO3ruIt8Bk+3JQdUtGwDcw0Ewi782Sy+kpdCh6mAJ5WZ5SJpBf/3EP
         rjfhkagGp6CTTAyQK0DBYZYgg4ptRUJdrTQXnrqqpHT7VjH2egs0zOWePUEhTd0lzy
         8w3X3D5ft3ZJCYxjzTm+sxvBDfiidtGvl3tN30vlD3QMUVl8v7SEPSGZ94S+HNbL59
         +7Ao8SoAHoVbFxGevR9HeifBvmCdVEeYN3vaqeDvu3n6bwxEO5BtGkEgncy9WRVUY5
         vJY1fCrCwGTxg==
MIME-Version: 1.0
Date:   Tue, 24 Oct 2023 14:29:48 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
In-Reply-To: <3dff444b-c439-4c40-9d21-1e390f449840@linaro.org>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-2-343e3dbf423e@trvn.ru>
 <3dff444b-c439-4c40-9d21-1e390f449840@linaro.org>
Message-ID: <b9c7f8662e4c02a4f9f275d27469f3be@trvn.ru>
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

Konrad Dybcio писал(а) 24.10.2023 13:34:
> On 10/23/23 08:20, Nikita Travkin wrote:
>> pm8916 contains some hardware blocks for battery powered devices:
>>
>> - VM-BMS: Battery voltage monitoring block.
>> - LBC: Linear battery charger.
>>
>> Add them to the pmic dtsi so the devices that make use of those blocks
>> can enable them.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>   arch/arm64/boot/dts/qcom/pm8916.dtsi | 48 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>> index f4de86787743..4b2e8fb47d2d 100644
>> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>> @@ -41,6 +41,35 @@ watchdog {
>>   			};
>>   		};
>>   +		pm8916_charger: charger@1000 {
>> +			compatible = "qcom,pm8916-lbc";
>> +			reg = <0x1000>, <0x1200>, <0x1300>, <0x1600>;
>> +			reg-names = "chgr", "bat_if", "usb", "misc";
>> +
>> +			interrupts = <0x0 0x10 0 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x10 6 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x13 0 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
>> +				     <0x0 0x13 4 IRQ_TYPE_EDGE_BOTH>;
>> +			interrupt-names = "vbat_det",
>> +					  "fast_chg",
>> +					  "chg_fail",
>> +					  "chg_done",
>> +					  "bat_pres",
>> +					  "temp_ok",
>> +					  "coarse_det",
>> +					  "usb_vbus",
> So, both the charger and the USBIN driver use the same irq? :/
> 

AFAIU the usbin extcon driver pretty much just tracks the state
of the IRQ to report extcon. It happens to assume the same part
of the pmic though, yes, which also means there will be no user
that would enable both charger and vbus extcon, since charger
driver provides this functionality as well.

Nikita

> Konrad
