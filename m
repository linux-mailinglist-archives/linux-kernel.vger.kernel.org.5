Return-Path: <linux-kernel+bounces-127305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1C89496E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B45286221
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F0616419;
	Tue,  2 Apr 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SRZK/lh+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487DF9DA;
	Tue,  2 Apr 2024 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024843; cv=none; b=LI4wwtJEqwI8BYsozEU48U1blcK4e+kC/Jxi30RTvFwj0jMV7JWq940NVA0c998LOmx8/a0ku//eu5OiJy3s6PL52DyAXmYuHiNSlhx+Kadu6oHu4iaS7PUxyzJ8NC6SrU2vZA/uUAIehdFeMEi9SxTZsxmI/MkWG0f/XRJL3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024843; c=relaxed/simple;
	bh=AO3ckvbbrDVadM3u8Le9zR3+tds6qlX6eNZlAe8ATmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=clZObnBx6koY/FkHUx8/vYi0Z9Xf2mWXoCX4GcEKae5wQSYNbCDkstAvcY0loLIjQjz1slLoHcSlj0ioVrRi3zP8AVb83B6hB/51kdbfxC2W4kMOZIvjd1j9icGsBIJkZlSg3Sd6ZHMK89M5NbDjCGG88Bl8rUmtx/mINK2hZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SRZK/lh+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4320SHe6022104;
	Tue, 2 Apr 2024 02:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=clUxwDzpe3Hen9RaHAafT3qN6XpYWqnATDNVuwDHe6o=; b=SR
	ZK/lh+KeRrFgR8Q1nK8/g2l4Ze9wkQlUG2j7y+8/3zvTeM6m3pjItcmZRkDBluxE
	NcKi63zoqeNka+mkRT/wRFyKjXHL4huHKYILHzBGtdUbH86Wuek4Kw8161GYF+aF
	RfqKDB8c0wWk0nkJR4kvSQwS6MbZRYi2IRYPvx7oPk6AO7yXTZYl2afErYa/qC9Y
	g85CKYiUfNNZn05/pxJzY+LYxd8BQEniqjPoVzx+/0wFCIVuDfcGXe5Sd+E6+jef
	hGu84B1brEUFdusko48QdA9DC9mZByleOb5LghPtC/AyySIWrsq3CITcx6D31+uV
	+yFCf1Z99GD/ZQOEIjwg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7xrfhbw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 02:27:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4322R0Cp021719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 02:27:00 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 19:26:54 -0700
Message-ID: <1d089a8c-b869-4bfa-9f9b-127d1ea3a489@quicinc.com>
Date: Tue, 2 Apr 2024 10:26:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESEND 4/4] arm64: dts: qcom: aim300: add AIM300 AIoT
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Qiang Yu <quic_qianyu@quicinc.com>,
        Ziyue Zhang
	<quic_ziyuzhan@quicinc.com>
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
 <20240401093843.2591147-5-quic_tengfan@quicinc.com>
 <CAA8EJpoUgP8Ec-0-WO=65Sdzh0ASwsMqvMP-HUnZ0Q7sjLg-YQ@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJpoUgP8Ec-0-WO=65Sdzh0ASwsMqvMP-HUnZ0Q7sjLg-YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NN2rcKWBjPa6cZWsZbxo6V150MW12BA-
X-Proofpoint-ORIG-GUID: NN2rcKWBjPa6cZWsZbxo6V150MW12BA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020016



On 4/2/2024 3:22 AM, Dmitry Baryshkov wrote:
> On Mon, 1 Apr 2024 at 12:40, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>> Add AIM300 AIoT Carrier board DTS support, including usb, UART, PCIe,
>> I2C functions support.
>> Here is a diagram of AIM300 AIoT Carrie Board and SoM
>>   +--------------------------------------------------+
>>   |             AIM300 AIOT Carrie Board             |
>>   |                                                  |
>>   |           +-----------------+                    |
>>   |power----->| Fixed regulator |---------+          |
>>   |           +-----------------+         |          |
>>   |                                       |          |
>>   |                                       v VPH_PWR  |
>>   | +----------------------------------------------+ |
>>   | |                          AIM300 SOM |        | |
>>   | |                                     |VPH_PWR | |
>>   | |                                     v        | |
>>   | |   +-------+       +--------+     +------+    | |
>>   | |   | UFS   |       | QCS8550|     |PMIC  |    | |
>>   | |   +-------+       +--------+     +------+    | |
>>   | |                                              | |
>>   | +----------------------------------------------+ |
>>   |                                                  |
>>   |                    +----+          +------+      |
>>   |                    |USB |          | UART |      |
>>   |                    +----+          +------+      |
>>   +--------------------------------------------------+
>>
>> Co-developed-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Co-developed-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>   .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 384 ++++++++++++++++++
>>   2 files changed, 385 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 7d40ec5e7d21..02d9bc3bfce7 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -96,6 +96,7 @@ dtb-$(CONFIG_ARCH_QCOM)       += qcm6490-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-1000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-4000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs6490-rb3gen2.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)        += qcs8550-aim300-aiot.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qdu1000-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qrb2210-rb1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qrb4210-rb2.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
>> new file mode 100644
>> index 000000000000..8188766c3d84
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
>> @@ -0,0 +1,384 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/leds/common.h>
>> +#include "qcs8550-aim300.dtsi"
>> +#include "pm8010.dtsi"
>> +#include "pmr735d_a.dtsi"
>> +#include "pmr735d_b.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. QCS8550 AIM300 AIOT";
>> +       compatible = "qcom,qcs8550-aim300-aiot", "qcom,qcs8550-aim300", "qcom,qcs8550",
>> +                    "qcom,sm8550";
>> +
>> +       aliases {
>> +               serial0 = &uart7;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       gpio-keys {
>> +               compatible = "gpio-keys";
>> +
>> +               pinctrl-0 = <&volume_up_n>;
>> +               pinctrl-names = "default";
>> +
>> +               key-volume-up {
>> +                       label = "Volume Up";
>> +                       debounce-interval = <15>;
>> +                       gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
>> +                       linux,code = <KEY_VOLUMEUP>;
>> +                       linux,can-disable;
>> +                       wakeup-source;
>> +               };
>> +       };
>> +
>> +       pmic-glink {
>> +               compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
>> +
>> +               connector@0 {
>> +                       compatible = "usb-c-connector";
>> +                       reg = <0>;
>> +                       power-role = "dual";
>> +                       data-role = "dual";
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>> +                                       reg = <0>;
>> +
>> +                                       pmic_glink_hs_in: endpoint {
>> +                                               remote-endpoint = <&usb_1_dwc3_hs>;
>> +                                       };
>> +                               };
>> +
>> +                               port@1 {
>> +                                       reg = <1>;
>> +
>> +                                       pmic_glink_ss_in: endpoint {
>> +                                               remote-endpoint = <&redriver_ss_out>;
>> +                                       };
>> +                               };
>> +
>> +                               port@2 {
>> +                                       reg = <2>;
>> +
>> +                                       pmic_glink_sbu: endpoint {
>> +                                               remote-endpoint = <&fsa4480_sbu_mux>;
>> +                                       };
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       vph_pwr: regulator-vph-pwr {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vph_pwr";
>> +               regulator-min-microvolt = <3700000>;
>> +               regulator-max-microvolt = <3700000>;
>> +
>> +               regulator-always-on;
>> +               regulator-boot-on;
>> +       };
>> +};
>> +
>> +&apps_rsc {
>> +       regulators-0 {
>> +               vdd-bob1-supply = <&vph_pwr>;
>> +               vdd-bob2-supply = <&vph_pwr>;
>> +       };
>> +
>> +       regulators-3 {
>> +               vdd-s4-supply = <&vph_pwr>;
>> +               vdd-s5-supply = <&vph_pwr>;
>> +       };
>> +
>> +       regulators-4 {
>> +               vdd-s4-supply = <&vph_pwr>;
>> +       };
>> +
>> +       regulators-5 {
>> +               vdd-s1-supply = <&vph_pwr>;
>> +               vdd-s2-supply = <&vph_pwr>;
>> +               vdd-s3-supply = <&vph_pwr>;
>> +               vdd-s4-supply = <&vph_pwr>;
>> +               vdd-s5-supply = <&vph_pwr>;
>> +               vdd-s6-supply = <&vph_pwr>;
>> +       };
>> +};
>> +
>> +&i2c_hub_2 {
>> +       status = "okay";
>> +
>> +       typec-mux@42 {
>> +               compatible = "fcs,fsa4480";
>> +               reg = <0x42>;
>> +
>> +               vcc-supply = <&vreg_bob1>;
>> +
>> +               mode-switch;
>> +               orientation-switch;
>> +
>> +               port {
>> +                       fsa4480_sbu_mux: endpoint {
>> +                               remote-endpoint = <&pmic_glink_sbu>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       typec-retimer@1c {
>> +               compatible = "onnn,nb7vpq904m";
>> +               reg = <0x1c>;
>> +
>> +               vcc-supply = <&vreg_l15b_1p8>;
>> +
>> +               orientation-switch;
>> +               retimer-switch;
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port@0 {
>> +                               reg = <0>;
>> +
>> +                               redriver_ss_out: endpoint {
>> +                                       remote-endpoint = <&pmic_glink_ss_in>;
>> +                               };
>> +                       };
>> +
>> +                       port@1 {
>> +                               reg = <1>;
>> +
>> +                               redriver_ss_in: endpoint {
>> +                                       data-lanes = <3 2 1 0>;
>> +                                       remote-endpoint = <&usb_dp_qmpphy_out>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&mdss_dsi0 {
>> +       vdda-supply = <&vreg_l3e_1p2>;
> 
> Is this wired on the carrier board or on the AIC300 SoM?

I checked schematic diagram, this should be on the AIM300 SoM.

> 
>> +       status = "okay";
>> +
>> +       panel@0 {
>> +               compatible = "visionox,vtdr6130";
>> +               reg = <0>;
>> +
>> +               pinctrl-0 = <&dsi_active>, <&te_active>;
>> +               pinctrl-1 = <&dsi_suspend>, <&te_suspend>;
>> +               pinctrl-names = "default", "sleep";
>> +
>> +               reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
>> +
>> +               vci-supply = <&vreg_l13b_3p0>;
>> +               vdd-supply = <&vreg_l11b_1p2>;
>> +               vddio-supply = <&vreg_l12b_1p8>;
>> +
>> +               port {
>> +                       panel0_in: endpoint {
>> +                               remote-endpoint = <&mdss_dsi0_out>;
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&mdss_dsi0_out {
>> +       remote-endpoint = <&panel0_in>;
>> +       data-lanes = <0 1 2 3>;
>> +};
>> +
>> +&mdss_dsi0_phy {
>> +       vdds-supply = <&vreg_l1e_0p88>;
> 
> This too

This also should be on the AIM300 SoM.

> 
>> +       status = "okay";
>> +};
>> +
>> +&pcie0 {
>> +       perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
>> +       wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> 
> And this

I checked schematic diagram, this should be on the AIM300 SoM.

> 
>> +
>> +       pinctrl-0 = <&pcie0_default_state>;
>> +       pinctrl-names = "default";
>> +
>> +       status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +       vdda-phy-supply = <&vreg_l1e_0p88>;
>> +       vdda-pll-supply = <&vreg_l3e_1p2>;
> 
> You guess the question. I think I'll stop here. Please review your
> changes here, which are really specific to the carrier board and which
> apply to the SoM.

I will review this change totally, then I will distinguish all these 
nodes which are on the carrier board and which are on the AIM300 SoM. 
Then I will update change series.

> 
>> +
>> +       status = "okay";
>> +};
>> +
>> +&pcie_1_phy_aux_clk {
>> +       clock-frequency = <1000>;
>> +};
>> +
>> +&pcie1 {
>> +       perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
>> +       wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
>> +
>> +       pinctrl-0 = <&pcie1_default_state>;
>> +       pinctrl-names = "default";
>> +
>> +       status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +       vdda-phy-supply = <&vreg_l3c_0p9>;
>> +       vdda-pll-supply = <&vreg_l3e_1p2>;
>> +       vdda-qref-supply = <&vreg_l1e_0p88>;
>> +
>> +       status = "okay";
>> +};
>> +
>> +&pm8550_gpios {
>> +       volume_up_n: volume-up-n-state {
>> +               pins = "gpio6";
>> +               function = "normal";
>> +               power-source = <1>;
>> +               bias-pull-up;
>> +               input-enable;
>> +       };
>> +};
>> +
>> +&pm8550b_eusb2_repeater {
>> +       vdd18-supply = <&vreg_l15b_1p8>;
>> +       vdd3-supply = <&vreg_l5b_3p1>;
>> +};
>> +
>> +
>> +&pon_pwrkey {
>> +       status = "okay";
>> +};
>> +
>> +&pon_resin {
>> +       linux,code = <KEY_VOLUMEDOWN>;
>> +
>> +       status = "okay";
>> +};
>> +
>> +&qupv3_id_0 {
>> +       status = "okay";
>> +};
>> +
>> +&remoteproc_adsp {
>> +       firmware-name = "qcom/qcs8550/adsp.mbn",
>> +                       "qcom/qcs8550/adsp_dtbs.elf";
>> +       status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +       firmware-name = "qcom/qcs8550/cdsp.mbn",
>> +                       "qcom/qcs8550/cdsp_dtbs.elf";
>> +       status = "okay";
>> +};
>> +
>> +&sleep_clk {
>> +       clock-frequency = <32000>;
>> +};
>> +
>> +&swr1 {
>> +       status = "okay";
>> +};
>> +
>> +&swr2 {
>> +       status = "okay";
>> +};
>> +
>> +&tlmm {
>> +       gpio-reserved-ranges = <32 8>;
>> +
>> +       dsi_active: dsi-active-state {
>> +               pins = "gpio133";
>> +               function = "gpio";
>> +               drive-strength = <8>;
>> +               bias-disable;
>> +       };
>> +
>> +       dsi_suspend: dsi-suspend-state {
>> +               pins = "gpio133";
>> +               function = "gpio";
>> +               drive-strength = <2>;
>> +               bias-pull-down;
>> +       };
>> +
>> +       te_active: te-active-state {
>> +               pins = "gpio86";
>> +               function = "mdp_vsync";
>> +               drive-strength = <2>;
>> +               bias-pull-down;
>> +       };
>> +
>> +       te_suspend: te-suspend-state {
>> +               pins = "gpio86";
>> +               function = "mdp_vsync";
>> +               drive-strength = <2>;
>> +               bias-pull-down;
>> +       };
>> +};
>> +
>> +&uart7 {
>> +       status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +       status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +       dr_mode = "otg";
>> +       usb-role-switch;
>> +};
>> +
>> +&usb_1_dwc3_hs {
>> +       remote-endpoint = <&pmic_glink_hs_in>;
>> +};
>> +
>> +&usb_1_dwc3_ss {
>> +       remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
>> +};
>> +
>> +&usb_1_hsphy {
>> +       phys = <&pm8550b_eusb2_repeater>;
>> +
>> +       vdd-supply = <&vreg_l1e_0p88>;
>> +       vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +       status = "okay";
>> +};
>> +
>> +&usb_dp_qmpphy {
>> +       vdda-phy-supply = <&vreg_l3e_1p2>;
>> +       vdda-pll-supply = <&vreg_l3f_0p88>;
>> +
>> +       orientation-switch;
>> +
>> +       status = "okay";
>> +};
>> +
>> +&usb_dp_qmpphy_out {
>> +       remote-endpoint = <&redriver_ss_in>;
>> +};
>> +
>> +&usb_dp_qmpphy_usb_ss_in {
>> +       remote-endpoint = <&usb_1_dwc3_ss>;
>> +};
>> +
>> +&xo_board {
>> +       clock-frequency = <76800000>;
>> +};
>> --
>> 2.25.1
>>
>>
> 
> 

-- 
Thx and BRs,
Tengfei Fan

