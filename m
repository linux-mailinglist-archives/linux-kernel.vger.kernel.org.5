Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3BC811B56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441905AbjLMRi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjLMRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:38:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A1B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:38:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ACBC433C7;
        Wed, 13 Dec 2023 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702489110;
        bh=27cCuNNlr0k/6GtYxt0e4EOa/N1Nghrs6dzqZcWq72Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6zv71lLi/wR9iYiX5qrn+a4OU/BACTvRrvTGl6CAk6PH1XHmtQSOe2fglpaGlX83
         zLeyRY8RbYzULmB8XEg02yBHKY65u0R/1FLfOoXD72gdAI0K4BuiqML6PB6Iu91gW6
         JiOl+RiDCX/li3CIHSJYhwh6YmwiaThWKR6sQF/0aQMZlti+8jndieu6h7cm3KrRZG
         8E6rrfSYblkT6lAkPwO/YWQ467EPqYyTgyJ4f7nf/nrqhJwJ4aCut3Q/Fx4rA7jb3t
         zI4uW5IL4ioqqmtY4GDyxDmHyFu13smWcCKPn9hE8i4Yaiseqlhk84VDo50D3gShSd
         QuYMlzOYqutjg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDTBk-0007iv-1i;
        Wed, 13 Dec 2023 18:38:28 +0100
Date:   Wed, 13 Dec 2023 18:38:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM/arm64: dts: qcom: fix USB wakeup interrupt
 types
Message-ID: <ZXnsFIl9i6Ix-woH@hovoldconsulting.com>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <ZXc7KcjF82EgiXWd@hovoldconsulting.com>
 <06354190-b572-46e4-8036-0fae7f15dd15@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06354190-b572-46e4-8036-0fae7f15dd15@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:00:07PM +0530, Krishna Kurapati PSSNV wrote:
> On 12/11/2023 10:09 PM, Johan Hovold wrote:
> > On Mon, Nov 20, 2023 at 05:43:20PM +0100, Johan Hovold wrote:

> > Konrad reported off-list that the sc8180x patch in this series breaks
> > probe of the dwc3 driver.
> > 
> > Turns out a number of these SoCs were using GIC interrupts for the
> > DP/DM_HS_PHY interrupts despite the fact that the driver tries to
> > reconfigure these as IRQ_TYPE_EDGE_FALLING (which the GIC does not
> > support) to detect disconnect events during suspend.
> > 
> > This is obviously broken and the proper fix is to replace the GIC
> > interrupts with the corresponding PDC interrupts. I believe Konrad is
> > digging out the magic numbers at this moment.
> > 
> > The following patches will need a follow-up fix:
> > 
> >>    ARM: dts: qcom: sdx55: fix USB wakeup interrupt types
> > 
> >>    arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types
> >>    arm64: dts: qcom: sdm670: fix USB wakeup interrupt types
> >>    arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
> >>    arm64: dts: qcom: sm6375: fix USB wakeup interrupt types
> >>    arm64: dts: qcom: sm8150: fix USB wakeup interrupt types

>   If it helps, I tried to dig up the PDC numbers for corresponding 
> GIC_SPI vectors:

Thanks, Krisha, that helps a lot.

I've sent two series (for arm and arm64) based on yours and Konrad's
input:

	https://lore.kernel.org/lkml/20231213173131.29436-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20231213173403.29544-1-johan+linaro@kernel.org/

> SM8150:
> 
> eud_p0_dpse_int_mx	apps_pdc_irq_out[9]	SYS_apcsQgicSPI[489]
> eud_p0_dmse_int_mx    apps_pdc_irq_out[8]	SYS_apcsQgicSPI[488]
> qmp_usb3_lfps_rxterm_irq apps_pdc_irq_out[6]	SYS_apcsQgicSPI[486]
> usb31_power_event_irq	SYS_apcsQgicSPI[130]
> usb31_hs_phy_irq	SYS_apcsQgicSPI[131]
> 
> interrupts-extended = <&pdc 9 IRQ_TYPE_EDGE_RISING>,
> 			<&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> 			<&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> 			<&pdc 8 IRQ_TYPE_EDGE_RISING>;
> 
> interrupt-names = "dp_hs_phy_irq", "pwr_event_irq",
> 		"ss_phy_irq", "dm_hs_phy_irq";

Do you have the corresponding numbers also for the second controller on
SM8150? I inferred them from SDM845, but it would good to verify that.

And can someone dig out the corresponding SS PHY interrupt for sc8180x?

Johan
