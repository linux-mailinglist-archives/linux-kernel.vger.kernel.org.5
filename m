Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F357A708A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjITCct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:32:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45885C5;
        Tue, 19 Sep 2023 19:32:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B06C433C8;
        Wed, 20 Sep 2023 02:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695177161;
        bh=QAx4rLvgG+w2aUwmQ646qZI9UZ3PUZjDBZgyQ3QPOgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8ElquWin/1W6/gst+K+zSMiCjreKw+YozMNHyehraxBXhuXMcVV+hZwskCJLqNha
         MxnqpZRhjeD95kEld9liGXQ7dtH+RgEn4IL2NYKcc05md50yX07ns2Zoyc3X3QuAwz
         llgw/dpXPLy2cfdJaBIDO6LsHVAzj0HuwAPVJwruDa4VfrNLkU0lS+ot+ysrRs6RXV
         HkYYTcbhLL4Iye8RUnhQbP0sczSe7U+5up81d2UMJf3YAkqNOswz3kMTeXNKdNj3/C
         T+Z8jeNvQ+8IWg68+Yo0nIIsw6BkzAjZNZ38dbKXtdwqb0sFbFzhO8XUfrEQkJXvaR
         e0Rl2xBV3Q9DA==
Date:   Tue, 19 Sep 2023 19:36:49 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Priyansh Jain <quic_priyjain@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Enable tsens and thermal for
 sa8775p SoC
Message-ID: <m46dsg4zx2fg4wrccmk24nrw34eyv3ikx2omadfyyqhl6kpy77@pkleypnfma2v>
References: <20230824123001.26778-1-quic_priyjain@quicinc.com>
 <20230824123001.26778-3-quic_priyjain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824123001.26778-3-quic_priyjain@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 06:00:01PM +0530, Priyansh Jain wrote:
> Add tsens and thermal devicetree node for sa8775p SoC.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1096 +++++++++++++++++++++++++
>  1 file changed, 1096 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index b130136acffe..abba42ea5946 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -2306,6 +2306,1102 @@
>  
>  			#freq-domain-cells = <1>;

I believe this would be the tail of the cpufreq_hw node, @0x18591000.

>  		};
> +
> +		tsens0: thermal-sensor@c222000 {
> +			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
> +			reg = <0x0 0x0c263000 0x0 0x1ff>,

If so, then this is not inserted to maintain the sort order (by address)
of the nodes under /soc. Please update the placement of this node.

Also, the unit address above is c222000, but based on this cell it
should be c263000.

> +			      <0x0 0x0c222000 0x0 0x8>;
> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +			#qcom,sensors = <12>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@c223000 {
> +			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
> +			reg = <0x0 0x0c265000 0x0 0x1ff>,
> +			      <0x0 0x0c223000 0x0 0x8>;
> +			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> +			#qcom,sensors = <12>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens2: thermal-sensor@c224000 {
> +			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
> +			reg = <0x0 0x0c251000 0x0 0x1ff>,

0x0c251000 < 0x0c265000, please order them properly.

> +			      <0x0 0x0c224000 0x0 0x8>;
> +			interrupts = <GIC_SPI 572 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 609 IRQ_TYPE_LEVEL_HIGH>;
> +			#qcom,sensors = <13>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens3: thermal-sensor@c225000 {
> +			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
> +			reg = <0x0 0x0c252000 0x0 0x1ff>,
> +			      <0x0 0x0c225000 0x0 0x8>;
> +			interrupts = <GIC_SPI 573 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 610 IRQ_TYPE_LEVEL_HIGH>;
> +			#qcom,sensors = <13>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		thermal_zones: thermal-zones {

This does not belong alongside the mmio-devices under /soc, move this
out (and keep / sorted alphabetically on the node name).

> +			aoss-0-thermal {
> +				polling-delay-passive = <0>;
> +				polling-delay = <0>;
> +
> +				thermal-sensors = <&tsens0 0>;
> +
> +				trips {
> +					aoss0_alert0: trip-point0 {

Why does all these nodes have labels?

> +						temperature = <105000>;
> +						hysteresis = <5000>;
> +						type = "passive";
> +					};
> +
> +					aoss0_alert1: trip-point1 {
> +						temperature = <115000>;
> +						hysteresis = <5000>;
> +						type = "passive";
> +					};
> +				};
> +			};
> +
[..]
> +		};

/soc does not end here anymore, please remember to rebase the change on
v6.6-rc1.

Thanks,
Bjorn

>  	};
>  
>  	arch_timer: timer {
> -- 
> 2.17.1
> 
