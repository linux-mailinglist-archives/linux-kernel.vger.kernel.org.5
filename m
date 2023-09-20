Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032B27A7110
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjITDnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITDnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:43:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8785AB;
        Tue, 19 Sep 2023 20:42:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B037AC433C7;
        Wed, 20 Sep 2023 03:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695181378;
        bh=G4xGO/2XKxt+lP9JCfnQGZ2wDydEFDtzqQ6wAO8WvAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIB1Au/i7Vr59eXBcS6Jd1h9abRkhC9Cq5bfeMnBwXcmAB8bg9bMQOTHLuToTwEcn
         dLLXS+uaUgXbNlG3+sYoYth6pIIliwhqI1jBtWeCCi/T79HxvB4uIy97GkfWoWuoe6
         3BZh7tpe1ElQwzfzcu+Bjjx4MzlMeuj/YbaGwqeIAGG5eaLY7l8YxyJKPiUWfNY2TQ
         46/AysOnUze0nN2CaN+N97xAo8uhIxjR3OuWgHg6jgQBwBVrYzOvG7a8CiGR9O4TdX
         qApxfuEY7ufnQDRraYzq0kdHGKRn1GK/t+qhem5yNZwEYJTg3OnJADrQ3HRbcn82XT
         5qNx+0hciOI1A==
Date:   Tue, 19 Sep 2023 20:47:05 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com, geert+renesas@glider.be, arnd@arndb.de,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: add uart console support for
 SM4450
Message-ID: <ieoxb7avgrmty7ktuycvkdf3sgfzw5jjkxuo3br3nfctg2hj7v@7jzeofaal7sy>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-9-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915021509.25773-9-quic_tengfan@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:15:08AM +0800, Tengfei Fan wrote:
> Add base description of UART, TLMM, interconnect, TCSRCC and SMMU nodes
> which helps SM4450 boot to shell with console on boards with this SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm4450-qrd.dts |  18 +-
>  arch/arm64/boot/dts/qcom/sm4450.dtsi    | 313 +++++++++++++++++++++---
>  2 files changed, 301 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> index 00a1c81ca397..0f253a2ba170 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
> @@ -10,9 +10,23 @@
>  	model = "Qualcomm Technologies, Inc. SM4450 QRD";
>  	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>  
> -	aliases { };
> +	aliases {
> +		serial0 = &uart7;
> +	};
>  
>  	chosen {
> -		bootargs = "console=hvc0";
> +		stdout-path = "serial0:115200n8";
>  	};
>  };
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <136 1>;
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
[..]
> +		qupv3_id_0: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0x00ac0000 0x0 0x2000>;
> +			ranges;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			iommus = <&apps_smmu 0x163 0x0>;
> +			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
> +			interconnect-names = "qup-core";

The patch ends up adding a smorgasbord of different things, some of
which do relate to giving you a console and others mostly not related at
all, because of the iommus and interconnects here.

If you omit these three properties from this, you can add the
console, then add iommu and interconnect nodes in three clear patches.


PS. Commit message says this is all needed for boot-to-shell, but I
don't think you need scm, nor tcsr nodes to achieve that.

Regards,
Bjorn
