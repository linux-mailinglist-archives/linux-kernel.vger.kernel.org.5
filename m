Return-Path: <linux-kernel+bounces-68895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8E85819B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B375EB26353
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D8812FB18;
	Fri, 16 Feb 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YlNB43Kt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825E5337E;
	Fri, 16 Feb 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098053; cv=none; b=iinvObBpRkoyfksi+uHSwjaehELwn1XrEICCiL8cl42z5OwPtPINSxTlZ76K5X5wfgpm2wmAvEJ6J8iVxTIY8Ql5mKQxqwI6DLGsTudki/xO1FB74yAaR1VLdx/lRB6n6ewErTF+wCFitJj3NYd1w0DX1o3iYeyYI7B2rLMgxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098053; c=relaxed/simple;
	bh=tE2GWatWT8oP2ZQhkomyvIyTdSsLPe+MKsFnCtD5OJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s6qinD2+X7su2gmRYkCAg91eOGfn66izY6OG/NkIdkpZcqC4QjGzzYn3Qs+eY2/z6mOSTUv6+FNLd44T7QIFrASmXrgzfSCIkj5BmZrqsvdxKtAphVDBrjjaQAaNkQX0avyK1k91lb049+kN19l3Kho8G6D2SvzEnPVZlYG72O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YlNB43Kt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GDZ8Bd031229;
	Fri, 16 Feb 2024 15:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kahaCjahMWDF4y8yM8htOlv1FY4glQMHTdWBNdyHkcY=; b=Yl
	NB43Kty1huwQOtg+YPiq+vqus3647/GsmwEiqhSDmK0UJQwtrkkpqjgLDhWpBoME
	5nu0VpVJPYl66kvhxE8DyVLS4xMHg5isfvLp00aiXO3Lz13If/gpLBYs7+RBvTWq
	8m+6W+eBoBEpTmZDtQ0MMuI/rxJkO34CYQTb7rc9Z4EuMS309LIzHLRw/7EUJQv1
	JJVhe8XtX86U2L1qomwhOCXKDkpOH5wjFYn2Gf+NvDiAKoQpETKQZx+fb4vWGg73
	iQ3MC5lYQRUexIA9GFlv0ttenIr03UIV0HeilVZ93s2kBKiVPBPsavcuDJqHix47
	zLYC8kTivDmMVTi88v/Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9wxf1ekg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 15:40:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GFeejx005904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 15:40:40 GMT
Received: from [10.216.32.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 07:40:33 -0800
Message-ID: <17c6b3df-2acd-45e2-8167-02c629b1e972@quicinc.com>
Date: Fri, 16 Feb 2024 21:10:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: ipq9574: Add SPI nand support
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-5-quic_mdalam@quicinc.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240215134856.1313239-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3KcsEsejO-HkA8HjskYi5QH3C9VhFz_j
X-Proofpoint-ORIG-GUID: 3KcsEsejO-HkA8HjskYi5QH3C9VhFz_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160125



On 2/15/2024 7:18 PM, Md Sadre Alam wrote:
> Add SPI NAND support for ipq9574 SoC.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>   .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 43 +++++++++++++++++++
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 27 ++++++++++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> index 91e104b0f865..5b54a027fa5d 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> @@ -139,6 +139,49 @@ gpio_leds_default: gpio-leds-default-state {
>   		drive-strength = <8>;
>   		bias-pull-up;
>   	};
> +
> +	qpic_snand_default_state: qpic-snand-default-state {
> +		clock-pins {
> +			pins = "gpio5";
> +			function = "qspi_clk";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +
> +		cs-pins {
> +			pins = "gpio4";
> +			function = "qspi_cs";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +
> +		data-pins {
> +			pins = "gpio0", "gpio1", "gpio2";


As per the pinctrl driver[1], there are 4 data pins.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-ipq9574.c#n296


> +			function = "qspi_data";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +	};
> +};
> +
> +&qpic_bam {
> +	status = "okay";
> +};
> +
> +&qpic_nand {
> +	pinctrl-0 = <&qpic_snand_default_state>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "spi-nand";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		nand-ecc-engine = <&qpic_nand>;
> +		nand-ecc-strength = <4>;
> +		nand-ecc-step-size = <512>;
> +	};
>   };
>   
>   &usb_0_dwc3 {
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7f2e5cbf3bbb..d963dd2035dd 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -319,6 +319,33 @@ tcsr: syscon@1937000 {
>   			reg = <0x01937000 0x21000>;
>   		};
>   
> +		qpic_bam: dma-controller@7984000 {


Nodes should be ordered by unit address in ascending order. So please 
move these nodes to the right place.


> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x7984000 0x1c000>;


address should be padded to 8 bytes.

> +			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_QPIC_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			status = "disabled";
> +		};
> +
> +		qpic_nand: spi@79b0000 {
> +			compatible = "qcom,ipq9574-snand";
> +			reg = <0x79b0000 0x10000>;


Ditto..

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&gcc GCC_QPIC_CLK>,
> +			<&gcc GCC_QPIC_AHB_CLK>,
> +			<&gcc GCC_QPIC_IO_MACRO_CLK>;


Fix the alignment.

> +			clock-names = "core", "aon", "iom";
> +			dmas = <&qpic_bam 0>,
> +				<&qpic_bam 1>,
> +				<&qpic_bam 2>;


Here as well.


> +			dma-names = "tx", "rx", "cmd";
> +			status = "disabled";
> +		};
> +
>   		sdhc_1: mmc@7804000 {
>   			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
>   			reg = <0x07804000 0x1000>,

