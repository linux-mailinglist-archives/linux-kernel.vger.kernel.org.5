Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F27BA517
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbjJEQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbjJEQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A1DB2A2;
        Thu,  5 Oct 2023 08:30:37 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qoQJ3-0006a1-Rc; Thu, 05 Oct 2023 17:30:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: rk3588is: Add AV1 decoder node
Date:   Thu, 05 Oct 2023 17:30:29 +0200
Message-ID: <2298521.ElGaqSPkdT@phil>
In-Reply-To: <20231005151210.nqdx2uoixqjhrtrx@mercury.elektranox.org>
References: <20231005145420.169594-1-benjamin.gaignard@collabora.com>
 <20231005151210.nqdx2uoixqjhrtrx@mercury.elektranox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2023, 17:12:10 CEST schrieb Sebastian Reichel:
> Hi,
> 
> On Thu, Oct 05, 2023 at 04:54:20PM +0200, Benjamin Gaignard wrote:
> > Add node for AV1 video decoder.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> No need for my SoB. Instead have this one:
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Also worth mentioning, that this Patch needs one small fix in the DT
> binding (adding "resets") and one small fix in the driver for out of
> the box AV1 support:
> 
> https://lore.kernel.org/all/20231005144934.169356-1-benjamin.gaignard@collabora.com/
> https://lore.kernel.org/all/20231005145116.169411-1-benjamin.gaignard@collabora.com/

additionally the node name should be generic.
The phandle can of course be av1d but the node
name itself needs a change.

Heiko


> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > index 5544f66c6ff4..835e66d85d5f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -2304,6 +2304,20 @@ gpio4: gpio@fec50000 {
> >  			#interrupt-cells = <2>;
> >  		};
> >  	};
> > +
> > +	av1d: av1d@fdc70000 {
> > +		compatible = "rockchip,rk3588-av1-vpu";
> > +		reg = <0x0 0xfdc70000 0x0 0x800>;
> > +		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
> > +		interrupt-names = "vdpu";
> > +		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> > +		clock-names = "aclk", "hclk";
> > +		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> > +		assigned-clock-rates = <400000000>, <400000000>;
> > +		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
> > +		power-domains = <&power RK3588_PD_AV1>;
> > +		status = "okay";
> > +	};
> >  };
> >  
> >  #include "rk3588s-pinctrl.dtsi"
> 




