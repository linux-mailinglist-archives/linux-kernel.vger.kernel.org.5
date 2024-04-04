Return-Path: <linux-kernel+bounces-131265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C9B898576
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FC81C2104C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8DD80635;
	Thu,  4 Apr 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DmvLDlY8"
Received: from sonic310-23.consmr.mail.ne1.yahoo.com (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8C5D734
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228078; cv=none; b=olxSCSfduHEH+T6/KqWHampbYiQ6oOn7I0rYNXoBhGALbkyAvL6zvGwh11fmRBmaCU3MJkfnMeAc+gilVBX49sROv7zsh9pJMs7SN78+u8hSjjjLa2lt1ud4KI45XyEHZW4bDVX6G1AFcV60lebrho7xdKjeGw+tMzedQyJkIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228078; c=relaxed/simple;
	bh=MxQxoBonCppVTlLLBXFyLptLcdwYnAzR+/MSEkXcZNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuIYQapGB01ikWGyx6ch9i4AyCh8MkBUMkAVECw1kciMhfmapqjtXyxtpHj9B3LBQhmR1VhxKhtoDAnuiGNDS1/M39GMylpAxDei1WLIka1V6HmG69+OAa4M2nVqTCby47jxIY946YajJBG15KP0RhHnbJP84F4vhy4gQfd+21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DmvLDlY8; arc=none smtp.client-ip=66.163.186.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712228069; bh=QE4bt56tJpZUY0JhzGhSVumT8EcfxcA6F/DF3MIUkLs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DmvLDlY85qv1TcrKY69LkutOmJJypXcenkBUragLfJoT18u6lY1XR1j6c4EeqXtzw/xmeRPKYSG70IhD64tuuszWG88RxYbiPUHB8Wd8KIFHgnw3Q8lHcuc5GXD5ht1ttJLs6kkibOWG+Pg62fyvOKYyAEePRmMWqHnLjbEMdMMjSGrUWM7JofXn5L4Ef1GZQlxKA4JQRf+pvD3H6E7kcUso3IwVzQMTwl938uTXKusa4jwDt3ZsbZSMN7vmP3334sDpoEzV5xFDVL+sAQd+0HUt3uV9XQzdMhJxhNjbiwHd0L21Qgg8rFC1iwIxO4JEOy0IxMmPU8Pyp32fLB73IA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712228069; bh=Irp546x37jXPj50W3tMI1I6QiuK4JnmDig6QX4Sj59F=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MO44wwy2hTN6nHga2wSpeyqIxHnpWmVuvAhNjtqw3vjum0Ud8tBbiau9kVupqsQoXINLy2cBfbHNjSF6bJQx1e4bapTs/3uUw/YpAfflS8pztkppq0lD/Neu+gFElXlQ+xxw07bK41UR3fwpf0ERDar1ftF+qIXuhv6hJDaTwEqXAcckFuxzTElauQlMO8/sfzCfaFr4v+ZmDSSfL7548dqNMxq17Nf7RyDCXqRFSOchU9KGmU4kjvJOeshkA9kqisa7eSnj/EhXkMtjxAdlM7A+ymFEgSBYBTm5V8K9vvUoiMXdMnLbl/nMwsgSwR79Ed3KdMoSYYYNkymBT6sIwg==
X-YMail-OSG: brme_r8VM1nvMk9Fbxz_dP_Gn8nyLy52j0VpPr0NnxH7Qz5J..y4NuJQwZIzWFy
 IkE6e4pvDAwH9q.Z1ZhlO0593mGSc2QgDGA.VEIEpLeZ5kRIiANzpX6xw26FeDAetfWmf0hT5XD4
 N4RuD01a12QpUSoa9bNmCGmNgJ6pCXP4GyRZ9sOGn8qljCxiYZhsXx0rGxyvH5TLTR3GAbwWY3Sl
 KqoMv84CZk8iaPAkIDU3rq8S6.aaxJfmUOhTNFNiKoI9NOq_OrsYngnfkg28voRjh4wKWtTVBLhX
 GxUKIdwvcfAcjcw9iWe6AhyQH0V1kJFL1y1BqXAaViwXRx5dgGk7CF6Pc_QPfXsfM_o4eHERn0mj
 YyAjcgPvqn7qHAwkCVwjzgnqk9Acky1fqqwSUMfJuvsZCgKskmIwU6O_QM.xbqywo.I9j0dKfgvD
 8z16d0Kyydyokv_hwoc4rjNmsvZ9R05ueQmVWiFZO9T5dLBbEAGZsHjSVVlwiZl92sRGo.dHYZbK
 l63.IyTLAAS7twZHTGedhyuei3mSHgzT39tCMlpbOt_4F4B2K.cZebCa94Oj8q1byqQjTCpdAzkE
 mYMMaqUqiGsvNx5I_UpPTwfmHCMz7t3925IaHPZ5RMLG.H8reFcYoa2dPDWkUzyioZ2EQZyRt1i_
 yakQfxpjT.h.Hud5wKtqznRB4pcTpnrc_JF8QVsb_oCCKtsXWdmijkEeAuWxhqGTtasg9aGjXyEj
 gb2S520w_oIy79ske1jN31cLp4yNJEjnJUSnL07OJZUqQo4dsvrJol91QZOVQ9QCMrbcazEwMb.y
 Pj3C84fY7OC4V35ah9S3eMyHqe8U76mDLi.TtCeP14mgMBP71kEHDRuEsEDAB3weTsUy.iK2tdzZ
 Qn9xdD9K38doy5GBUdc.nKqU3s73X6A8PwSpUwbx1WCSUBgJjhfM3lOuNSOMmh5BMiQb1Raguqr2
 CJb0U9G4rxCsye2VeVN_vSivK.xF8kAHBMcHd1LQExfywrkpg9_1wKt73uGxSgPbatI.xojlXBp8
 EMRRSI3.nATovq3wR9kmQxSPmzFF50kqZ4sIHDWEaLStTcPB5reaYswTi1LLQiLnF7CIol2mPgx9
 fm5YRlbjr68fJMdun7fpkcFoG.cUbMZxHRG_YAXrI1KbDp5Lm1sYKrdVGRiMLlwdQGuBVvThz7Dv
 uwT58ejZWo91LifkOnm2d7U7xD0MwrvEjPyBRtAHjzRHKooUkgkhF3Oq8KKMLUCDWIssGH6Ojdtp
 k.bTN7iGFaNFsPoeEvF7pgE9ChWlQwqR4aqkf6iVZbB0o9FFjl.V4q.mhbj0WK5ZQNmHXkWKvi3U
 hYdrw9bvC_mvr0UYFgtltEgjBV52RNwBgeTBfd_24GTDJ2it08XWuV_yCqnO5LE1iYYs.R.JwBqd
 xXIx7WEl0nwCEnYrRnG76rIIvAQVRhaSjYp_xG8UspBmRqcTjabXPiV3cWY2SXYStAkP59BKv.qJ
 F5ALPpP3db76ZAloQf9IhI1M_MaT8HIHPwqXU3FWKJIW8ZaTCHNgUQq7lI9XS.BZfCZRat.JsdAF
 5Fu67hvIjh4CtfTe9YnoQkFJQlM3d.7mXMuucHFNoKvrmYoKOZIGPSiG7dtRMfLCag8fbN7Od85b
 mfl9sCYP7lcIqO7hglbZ7fZJ8GQ76Ewf1HtFHSSMJ8dDpeWHBIPbsOA_L8p8.rtxPhgqdoNU_P.D
 9sQUR.PrH2VjKOhommnRq_GpVb53zQzUyRa2afwrSJbxhv50MXsdRAr6QxjyY6yHLIVQcRFfsUvA
 zo.zoiraXHFjMdHexH8mzqTKUuwtm6.oBhSSYSKJsRV3H5RSbMWUjxDV9cU5fgze8vKKoYtILDN4
 YUcgENQtp3QzjoMMRDIbe2rOP5Ng7giX6fgNA5tDDwExFyWMgE0Dv3nr9N.GtRSgrBI5jS1T1iyt
 EG8nRHigJx9OSzRuEpjgbukZNtAY4RFZV5lJCmYXJ76S3qUEByo2xHIX.u0Yiy8HGZaa43nsK6aZ
 v_74pkv3zAKxBcas6.CBVLV5Z1.UslICOOGjRGByzVE_m02anqcq_yzCqdEO3MBSq588oPNWyVYs
 S2hiMcO3TPT1rQ5hik.Bu2YTl9RteYuKtFvFifQMSDarytgEo9EpaZbZ.W.fe2v7zXZQTAexxuXU
 vGkQpi2V0LWWkGmVJGv7bQQHWAGhyjdVH57LR8keChTVca9IpslclZb3tAAph1qCy9FtWOAmx8zg
 dBIZFOKXJD5WBRbIMhxii64X9p99DDq264IBXfj276LNumPgbtRGZF51vQsJE2B4m
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: fdf6988e-5334-4e47-92ba-56bc0a6acb38
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 4 Apr 2024 10:54:29 +0000
Received: by hermes--production-ir2-7bc88bfc75-tsgbp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c17b356668dd230d9e07e6fb818333a8;
          Thu, 04 Apr 2024 10:44:20 +0000 (UTC)
Message-ID: <b3f45655-c3a6-4dd7-a377-da87f56b9936@yahoo.com>
Date: Thu, 4 Apr 2024 12:44:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8550: Add support for Samsung
 Galaxy Z Fold5
To: neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240331-samsung-galaxy-zfold5-q5q-v3-0-17ae8d0a9fba@yahoo.com>
 <20240331-samsung-galaxy-zfold5-q5q-v3-2-17ae8d0a9fba@yahoo.com>
 <8fea7f0e-ae45-4000-994e-6cf9170fbd32@linaro.org>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <8fea7f0e-ae45-4000-994e-6cf9170fbd32@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi, thanks, that's strange, I am already using the right kernel source 
that has the mentioned patches...

I am going to check why the dtb was successfully compiled, remove all 
the mentioned issues and generate a v4


On 3/4/24 10:00, neil.armstrong@linaro.org wrote:
> Hi,
>
> On 31/03/2024 12:56, Alexandru Marc Serdeliuc via B4 Relay wrote:
>> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>>
>> Add support for Samsung Galaxy Z Fold5 (q5q) foldable phone based on 
>> sm8550
>>
>> Currently working features:
>> - Framebuffer
>> - UFS
>> - i2c
>> - Buttons
>>
>> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile               |   1 +
>>   arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 582 
>> ++++++++++++++++++++++++
>>   2 files changed, 583 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>> b/arch/arm64/boot/dts/qcom/Makefile
>> index 7d40ec5e7d21..a7503fd35b6c 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += 
>> sm8450-sony-xperia-nagara-pdx224.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-qrd.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)    += sm8550-samsung-q5q.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8650-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8650-qrd.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += x1e80100-crd.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts 
>> b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
>> new file mode 100644
>> index 000000000000..6619ed00c350
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
>> @@ -0,0 +1,582 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024, Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
>> + * Copyright (c) 2024, David Wronek <david@mainlining.org>
>> + * Copyright (c) 2022, Linaro Limited
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "sm8550.dtsi"
>> +#include "pm8550.dtsi"
>> +#include "pm8550vs.dtsi"
>> +#include "pmk8550.dtsi"
>> +
>> +/ {
>> +    model = "Samsung Galaxy Z Fold5";
>> +    compatible = "samsung,q5q", "qcom,sm8550";
>> +    chassis-type = "handset";
>> +
>> +    aliases {
>> +        serial0 = &uart7;
>> +    };
>> +
>> +    chosen {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
>> +        framebuffer: framebuffer@b8000000 {
>> +            compatible = "simple-framebuffer";
>> +            reg = <0x0 0xb8000000 0x0 0x2b00000>;
>> +            width = <2176>;
>> +            height = <1812>;
>> +            stride = <(2176 * 4)>;
>> +            format = "a8r8g8b8";
>> +        };
>> +    };
>> +
>> +    gpio-keys {
>> +        compatible = "gpio-keys";
>> +        pinctrl-0 = <&volume_up_n>;
>> +        pinctrl-names = "default";
>> +
>> +        key-volume-up {
>> +            label = "Volume Up";
>> +            linux,code = <KEY_VOLUMEUP>;
>> +            gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
>> +            debounce-interval = <15>;
>> +            linux,can-disable;
>> +            wakeup-source;
>> +        };
>> +    };
>> +
>> +    vph_pwr: vph-pwr-regulator {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "vph_pwr";
>> +        regulator-min-microvolt = <3700000>;
>> +        regulator-max-microvolt = <3700000>;
>> +        regulator-always-on;
>> +        regulator-boot-on;
>> +    };
>> +
>> +    reserved-memory {
>> +        /*
>> +         * The bootloader will only keep display hardware enabled
>> +         * if this memory region is named exactly 'splash_region'
>> +         */
>> +        splash_region@b8000000 {
>> +            reg = <0x0 0xb8000000 0x0 0x2b00000>;
>> +            no-map;
>> +        };
>> +    };
>> +};
>> +
>> +&apps_rsc {
>> +    regulators-0 {
>> +        compatible = "qcom,pm8550-rpmh-regulators";
>> +        qcom,pmic-id = "b";
>> +
>> +        vreg_bob1: bob1 {
>> +            regulator-name = "vreg_bob1";
>> +            regulator-min-microvolt = <3296000>;
>> +            regulator-max-microvolt = <3960000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_bob2: bob2 {
>> +            regulator-name = "vreg_bob2";
>> +            regulator-min-microvolt = <2720000>;
>> +            regulator-max-microvolt = <3960000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l1b_1p8: ldo1 {
>> +            regulator-name = "vreg_l1b_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2b_3p0: ldo2 {
>> +            regulator-name = "vreg_l2b_3p0";
>> +            regulator-min-microvolt = <3008000>;
>> +            regulator-max-microvolt = <3008000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l5b_3p1: ldo5 {
>> +            regulator-name = "vreg_l5b_3p1";
>> +            regulator-min-microvolt = <3104000>;
>> +            regulator-max-microvolt = <3104000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l6b_1p8: ldo6 {
>> +            regulator-name = "vreg_l6b_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <3008000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l7b_1p8: ldo7 {
>> +            regulator-name = "vreg_l7b_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <3008000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l8b_1p8: ldo8 {
>> +            regulator-name = "vreg_l8b_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <3008000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l9b_2p9: ldo9 {
>> +            regulator-name = "vreg_l9b_2p9";
>> +            regulator-min-microvolt = <2960000>;
>> +            regulator-max-microvolt = <3008000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l11b_1p2: ldo11 {
>> +            regulator-name = "vreg_l11b_1p2";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1504000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l12b_1p8: ldo12 {
>> +            regulator-name = "vreg_l12b_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l13b_3p0: ldo13 {
>> +            regulator-name = "vreg_l13b_3p0";
>> +            regulator-min-microvolt = <3000000>;
>> +            regulator-max-microvolt = <3000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l14b_3p2: ldo14 {
>> +            regulator-name = "vreg_l14b_3p2";
>> +            regulator-min-microvolt = <3200000>;
>> +            regulator-max-microvolt = <3200000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l15b_1p8: ldo15 {
>> +            regulator-name = "vreg_l15b_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +            regulator-allow-set-load;
>> +            regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
>> +                           RPMH_REGULATOR_MODE_HPM>;
>> +            regulator-always-on;
>> +        };
>> +
>> +        vreg_l16b_2p8: ldo16 {
>> +            regulator-name = "vreg_l16b_2p8";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <2800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l17b_2p5: ldo17 {
>> +            regulator-name = "vreg_l17b_2p5";
>> +            regulator-min-microvolt = <2504000>;
>> +            regulator-max-microvolt = <2504000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-1 {
>> +        compatible = "qcom,pm8550vs-rpmh-regulators";
>> +        qcom,pmic-id = "c";
>> +
>> +        vreg_l3c_0p91: ldo3 {
>> +            regulator-name = "vreg_l3c_0p9";
>> +            regulator-min-microvolt = <880000>;
>> +            regulator-max-microvolt = <912000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-2 {
>> +        compatible = "qcom,pm8550vs-rpmh-regulators";
>> +        qcom,pmic-id = "d";
>> +
>> +        vreg_l1d_0p88: ldo1 {
>> +            regulator-name = "vreg_l1d_0p88";
>> +            regulator-min-microvolt = <880000>;
>> +            regulator-max-microvolt = <920000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-3 {
>> +        compatible = "qcom,pm8550vs-rpmh-regulators";
>> +        qcom,pmic-id = "e";
>> +
>> +        vreg_s4e_0p9: smps4 {
>> +            regulator-name = "vreg_s4e_0p9";
>> +            regulator-min-microvolt = <904000>;
>> +            regulator-max-microvolt = <984000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_s5e_1p1: smps5 {
>> +            regulator-name = "vreg_s5e_1p1";
>> +            regulator-min-microvolt = <1080000>;
>> +            regulator-max-microvolt = <1120000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l1e_0p88: ldo1 {
>> +            regulator-name = "vreg_l1e_0p88";
>> +            regulator-min-microvolt = <880000>;
>> +            regulator-max-microvolt = <880000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2e_0p9: ldo2 {
>> +            regulator-name = "vreg_l2e_0p9";
>> +            regulator-min-microvolt = <904000>;
>> +            regulator-max-microvolt = <970000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l3e_1p2: ldo3 {
>> +            regulator-name = "vreg_l3e_1p2";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1200000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-4 {
>> +        compatible = "qcom,pm8550ve-rpmh-regulators";
>> +        qcom,pmic-id = "f";
>> +
>> +        vreg_s4f_0p5: smps4 {
>> +            regulator-name = "vreg_s4f_0p5";
>> +            regulator-min-microvolt = <500000>;
>> +            regulator-max-microvolt = <700000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l1f_0p9: ldo1 {
>> +            regulator-name = "vreg_l1f_0p9";
>> +            regulator-min-microvolt = <912000>;
>> +            regulator-max-microvolt = <912000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2f_0p88: ldo2 {
>> +            regulator-name = "vreg_l2f_0p88";
>> +            regulator-min-microvolt = <880000>;
>> +            regulator-max-microvolt = <912000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l3f_0p91: ldo3 {
>> +            regulator-name = "vreg_l3f_0p91";
>> +            regulator-min-microvolt = <880000>;
>> +            regulator-max-microvolt = <912000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-5 {
>> +        compatible = "qcom,pm8550vs-rpmh-regulators";
>> +        qcom,pmic-id = "g";
>> +
>> +        vreg_s1g_1p2: smps1 {
>> +            regulator-name = "vreg_s1g_1p2";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1300000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_s2g_0p8: smps2 {
>> +            regulator-name = "vreg_s2g_0p8";
>> +            regulator-min-microvolt = <800000>;
>> +            regulator-max-microvolt = <1000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_s3g_0p7: smps3 {
>> +            regulator-name = "vreg_s3g_0p7";
>> +            regulator-min-microvolt = <300000>;
>> +            regulator-max-microvolt = <1004000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_s4g_1p3: smps4 {
>> +            regulator-name = "vreg_s4g_1p3";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1352000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_s5g_0p8: smps5 {
>> +            regulator-name = "vreg_s5g_0p8";
>> +            regulator-min-microvolt = <500000>;
>> +            regulator-max-microvolt = <1004000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_s6g_1p8: smps6 {
>> +            regulator-name = "vreg_s6g_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <2000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l1g_1p2: ldo1 {
>> +            regulator-name = "vreg_l1g_1p2";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1200000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2g_1p2: ldo2 {
>> +            regulator-name = "vreg_l2g_1p2";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1200000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l3g_1p2: ldo3 {
>> +            regulator-name = "vreg_l3g_1p2";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1200000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-6 {
>> +        compatible = "qcom,pm8010-rpmh-regulators";
>> +        qcom,pmic-id = "m";
>> +
>> +        vreg_l1m_1p056: ldo1 {
>> +            regulator-name = "vreg_l1m_1p056";
>> +            regulator-min-microvolt = <1056000>;
>> +            regulator-max-microvolt = <1056000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2m_1p056: ldo2 {
>> +            regulator-name = "vreg_l2m_1p056";
>> +            regulator-min-microvolt = <1056000>;
>> +            regulator-max-microvolt = <1056000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l3m_2p8: ldo3 {
>> +            regulator-name = "vreg_l3m_2p8";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <2800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l4m_2p8: ldo4 {
>> +            regulator-name = "vreg_l4m_2p8";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <2800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l5m_1p8: ldo5 {
>> +            regulator-name = "vreg_l5m_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l6m_1p8: ldo6 {
>> +            regulator-name = "vreg_l6m_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l7m_2p9: ldo7 {
>> +            regulator-name = "vreg_l7m_2p9";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <2904000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-7 {
>> +        compatible = "qcom,pm8010-rpmh-regulators";
>> +        qcom,pmic-id = "n";
>> +
>> +        vreg_l1n_1p1: ldo1 {
>> +            regulator-name = "vreg_l1n_1p1";
>> +            regulator-min-microvolt = <1104000>;
>> +            regulator-max-microvolt = <1200000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2n_1p1: ldo2 {
>> +            regulator-name = "vreg_l2n_1p1";
>> +            regulator-min-microvolt = <1104000>;
>> +            regulator-max-microvolt = <1200000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l3n_2p8: ldo3 {
>> +            regulator-name = "vreg_l3n_2p8";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <3000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l4n_2p8: ldo4 {
>> +            regulator-name = "vreg_l4n_2p8";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <3300000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l5n_1p8: ldo5 {
>> +            regulator-name = "vreg_l5n_1p8";
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l6n_3p3: ldo6 {
>> +            regulator-name = "vreg_l6n_3p3";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <3304000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l7n_2p96: ldo7 {
>> +            regulator-name = "vreg_l7n_2p96";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <2960000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +};
>> +
>> +
>
> Spurious blank line
>
>> +&dispcc {
>> +    status = "disabled";
>> +};
>> +
>> +&i2c_master_hub_0 {
>> +    status = "okay";
>> +};
>> +
>> +&pcie_1_phy_aux_clk {
>> +    clock-frequency = <1000>;
>> +};
>> +
>
> Please rebase on 
> https://lore.kernel.org/all/20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-6-3ec0a966d52f@linaro.org/ 
> and drop this
>
>> +&pcie0 {
>> +    wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
>> +    perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
>> +    pinctrl-0 = <&pcie0_default_state>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +    vdda-phy-supply = <&vreg_l1e_0p88>;
>> +    vdda-pll-supply = <&vreg_l3e_1p2>;
>> +    status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +    wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
>> +    perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
>> +    pinctrl-0 = <&pcie1_default_state>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +    vdda-phy-supply = <&vreg_l3c_0p91>;
>> +    vdda-pll-supply = <&vreg_l3e_1p2>;
>> +    vdda-qref-supply = <&vreg_l1e_0p88>;
>> +    status = "okay";
>> +};
>
> Is the second PCIe bus really used ?
>
>> +
>> +&pm8550_gpios {
>> +    volume_up_n: volume-up-n-state {
>> +        pins = "gpio6";
>> +        function = "normal";
>> +        power-source = <1>;
>> +        bias-pull-up;
>> +        input-enable;
>> +    };
>> +};
>> +
>> +&pon_pwrkey {
>> +    status = "okay";
>> +};
>> +
>> +&pon_resin {
>> +    status = "okay";
>> +    linux,code = <KEY_VOLUMEDOWN>;
>> +};
>> +
>> +&qupv3_id_0 {
>> +    status = "okay";
>> +};
>> +
>> +&remoteproc_adsp {
>> +    firmware-name = "qcom/sm8550/adsp.mbn",
>> +            "qcom/sm8550/adsp_dtb.mbn";
>> +    status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +    firmware-name = "qcom/sm8550/cdsp.mbn",
>> +            "qcom/sm8550/cdsp_dtb.mbn";
>> +    status = "okay";
>> +};
>> +
>> +&remoteproc_mpss {
>> +    firmware-name = "qcom/sm8550/modem.mbn",
>> +            "qcom/sm8550/modem_dtb.mbn";
>> +    status = "okay";
>> +};
>> +
>> +&sleep_clk {
>> +    clock-frequency = <32000>;
>> +};
>> +
>> +&tlmm {
>> +    gpio-reserved-ranges = <36 4>, <50 2>;
>> +};
>> +
>> +&ufs_mem_hc {
>> +    reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
>> +    vcc-supply = <&vreg_l17b_2p5>;
>> +    vcc-max-microamp = <1300000>;
>> +    vccq-supply = <&vreg_l1g_1p2>;
>> +    vccq-max-microamp = <1200000>;
>> +    vdd-hba-supply = <&vreg_l3g_1p2>;
>> +    status = "okay";
>> +};
>> +
>> +&ufs_mem_phy {
>> +    vdda-phy-supply = <&vreg_l1d_0p88>;
>> +    vdda-pll-supply = <&vreg_l3e_1p2>;
>> +    status = "okay";
>> +};
>> +
>> +&xo_board {
>> +    clock-frequency = <76800000>;
>> +};
>>
>
> Thanks,
> Neil

