Return-Path: <linux-kernel+bounces-14855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A62A82233B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF242281E4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C02168B4;
	Tue,  2 Jan 2024 21:26:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C795168A6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B6E5820145;
	Tue,  2 Jan 2024 22:17:46 +0100 (CET)
Date: Tue, 2 Jan 2024 22:17:45 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Alexey Minnekhanov <alexeymin@postmarketos.org>, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-usb@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: sdm630: Drop RPM bus clocks
Message-ID: <6b3eetuyhg6y6wgqgxn2ruovjfrg24dbwsictlryealtwtnq6t@xk6nm3mxwbeh>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-6-1e506593b1bd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-6-1e506593b1bd@linaro.org>

On 2023-09-12 15:31:44, Konrad Dybcio wrote:
> These clocks are now handled from within the icc framework and are
> no longer registered from within the CCF. Remove them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

This makes the USB and IOMMUs probe again on SDM630 devices like the Sony Xperia
XA2 Ultra.  Thanks!

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

+cc Dmitry who was talking to me about this SoC.

> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 49 +++++++-----------------------------
>  1 file changed, 9 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index ec6003212c4d..f11d2a07508c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -605,9 +605,6 @@ bimc: interconnect@1008000 {
>  			compatible = "qcom,sdm660-bimc";
>  			reg = <0x01008000 0x78000>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> -				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
>  		};
>  
>  		restart@10ac000 {
> @@ -619,28 +616,17 @@ cnoc: interconnect@1500000 {
>  			compatible = "qcom,sdm660-cnoc";
>  			reg = <0x01500000 0x10000>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> -				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
>  		};
>  
>  		snoc: interconnect@1626000 {
>  			compatible = "qcom,sdm660-snoc";
>  			reg = <0x01626000 0x7090>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> -				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>  		};
>  
>  		anoc2_smmu: iommu@16c0000 {
>  			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>  			reg = <0x016c0000 0x40000>;
> -
> -			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			assigned-clock-rates = <1000>;
> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			clock-names = "bus";
>  			#global-interrupts = <2>;
>  			#iommu-cells = <1>;
>  
> @@ -685,16 +671,12 @@ a2noc: interconnect@1704000 {
>  			compatible = "qcom,sdm660-a2noc";
>  			reg = <0x01704000 0xc100>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus",
> -				      "bus_a",
> -				      "ipa",
> +			clock-names = "ipa",
>  				      "ufs_axi",
>  				      "aggre2_ufs_axi",
>  				      "aggre2_usb3_axi",
>  				      "cfg_noc_usb2_axi";
> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
> -				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
> -				 <&rpmcc RPM_SMD_IPA_CLK>,
> +			clocks = <&rpmcc RPM_SMD_IPA_CLK>,
>  				 <&gcc GCC_UFS_AXI_CLK>,
>  				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
>  				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
> @@ -705,10 +687,8 @@ mnoc: interconnect@1745000 {
>  			compatible = "qcom,sdm660-mnoc";
>  			reg = <0x01745000 0xa010>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a", "iface";
> -			clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
> -				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
> -				 <&mmcc AHB_CLK_SRC>;
> +			clock-names = "iface";
> +			clocks = <&mmcc AHB_CLK_SRC>;
>  		};
>  
>  		tsens: thermal-sensor@10ae000 {
> @@ -1228,20 +1208,16 @@ usb3: usb@a8f8800 {
>  				 <&gcc GCC_USB30_MASTER_CLK>,
>  				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
>  				 <&gcc GCC_USB30_SLEEP_CLK>,
> -				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> -				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> +				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
>  			clock-names = "cfg_noc",
>  				      "core",
>  				      "iface",
>  				      "sleep",
> -				      "mock_utmi",
> -				      "bus";
> +				      "mock_utmi";
>  
>  			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> -					  <&gcc GCC_USB30_MASTER_CLK>,
> -					  <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			assigned-clock-rates = <19200000>, <120000000>,
> -					       <19200000>;
> +					  <&gcc GCC_USB30_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <120000000>;
>  
>  			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2144,10 +2120,9 @@ mmss_smmu: iommu@cd00000 {
>  
>  			clocks = <&mmcc MNOC_AHB_CLK>,
>  				 <&mmcc BIMC_SMMU_AHB_CLK>,
> -				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
>  				 <&mmcc BIMC_SMMU_AXI_CLK>;
>  			clock-names = "iface-mm", "iface-smmu",
> -				      "bus-mm", "bus-smmu";
> +				      "bus-smmu";
>  			#global-interrupts = <2>;
>  			#iommu-cells = <1>;
>  
> @@ -2264,12 +2239,6 @@ gnoc: interconnect@17900000 {
>  			compatible = "qcom,sdm660-gnoc";
>  			reg = <0x17900000 0xe000>;
>  			#interconnect-cells = <1>;
> -			/*
> -			 * This one apparently features no clocks,
> -			 * so let's not mess with the driver needlessly
> -			 */
> -			clock-names = "bus", "bus_a";
> -			clocks = <&xo_board>, <&xo_board>;
>  		};
>  
>  		apcs_glb: mailbox@17911000 {
> 
> -- 
> 2.42.0
> 

