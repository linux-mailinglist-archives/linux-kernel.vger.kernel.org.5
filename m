Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7337D37EB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjJWNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjJWNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:25:10 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8245926B7;
        Mon, 23 Oct 2023 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1698067401; x=1729603401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KraaAR9AJRx4szBcb69Mh9Dil932gzrCb3ff3bUUqeE=;
  b=T7cEzjpp2WWwpDgofDuSkW+PokhhIu1cwmSfiZsddeJpOR6AHQIw4joj
   mZ5CcrkvMSeuoRIxGaiT06Okkk5cssJym5x8TxjJZ7Ty6VpgBAmRMw0Lf
   +KdxgizhV4m9zr3dxqeJazlgrENYgXSxW+kZgSqRTX5sTcTKR+EqE65r2
   +MC+1wMyMztBI5ukvXE0RHwhnXeJtwZjye0hTHbV+7dAxSpWZTpJbGimV
   g2sYLAPvi8YfVsUdzvvh49onK3vAIiPtjg/IqvK61E5zINxlz59TM6mBp
   kqhrDECjLb+gC/4N7uejDOiv+4+byHFiVbUB9aNgX5GOLD6R1pPHvvR5b
   g==;
X-IronPort-AV: E=Sophos;i="6.03,244,1694728800"; 
   d="scan'208";a="33603121"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Oct 2023 15:23:19 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C6A0128007F;
        Mon, 23 Oct 2023 15:23:18 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mp: Add NPU Node
Date:   Mon, 23 Oct 2023 15:23:21 +0200
Message-ID: <9185912.CDJkKcVGEf@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231022161911.10792-1-aford173@gmail.com>
References: <20231022161911.10792-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

thanks for the update.

Am Sonntag, 22. Oktober 2023, 18:19:10 CEST schrieb Adam Ford:
> The NPU is based on the Vivante GC8000 and its power-domain
> is controlled my pgc_mlmix.  Since the power-domain uses
> some of these clocks, setup the clock parent and rates
> inside the power-domain, and add the NPU node.
>=20
> The data sheet states the CLK_ML_AHB should be 300MHz for
> nominal, but 800MHz clock will divide down to 266 instead.
> Boards which operate in over-drive mode should update the
> clocks on their boards accordingly.  When the driver loads,
> the NPU numerates as:
>=20
>  etnaviv-gpu 38500000.npu: model: GC8000, revision: 8002

There seems to be some race condition upon GPU/NPU detection. Sometimes I g=
et=20
these messages:
[    1.338100] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6204
[    1.344469] etnaviv-gpu 38008000.gpu: model: GC520, revision: 5341
[    1.350748] etnaviv-gpu 38500000.npu: model: GC0, revision: 0
[    1.356514] etnaviv-gpu 38500000.npu: Unknown GPU model

Sometimes I see GC8000 being detected as you have written. Despite that the=
=20
patch itself looks good.
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>=20
> V2:  Move the clock parent and rate assignments to the ppc_mlmix node
>      since clock parents should be configured before they are used,
>      and pgc_mlmix uses them first.
>      Slow the clock rates down to confirm to nominal mode instead of
>      overdrive mode.
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> c9a610ba4836..a18b9ba98ea2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -887,6 +887,15 @@ pgc_mlmix: power-domain@24 {
>  						clocks =3D <&clk=20
IMX8MP_CLK_ML_AXI>,
>  							 <&clk=20
IMX8MP_CLK_ML_AHB>,
>  							 <&clk=20
IMX8MP_CLK_NPU_ROOT>;
> +						assigned-clocks =3D=20
<&clk IMX8MP_CLK_ML_CORE>,
> +							=09
  <&clk IMX8MP_CLK_ML_AXI>,
> +							=09
  <&clk IMX8MP_CLK_ML_AHB>;
> +						assigned-clock-
parents =3D <&clk IMX8MP_SYS_PLL1_800M>,
> +							=09
	 <&clk IMX8MP_SYS_PLL1_800M>,
> +							=09
	 <&clk IMX8MP_SYS_PLL1_800M>;
> +						assigned-clock-
rates =3D <800000000>,
> +							=09
       <800000000>,
> +							=09
       <300000000>;
>  					};
>  				};
>  			};
> @@ -2012,6 +2021,18 @@ vpumix_blk_ctrl: blk-ctrl@38330000 {
>  			interconnect-names =3D "g1", "g2", "vc8000e";
>  		};
>=20
> +		npu: npu@38500000 {
> +			compatible =3D "vivante,gc";
> +			reg =3D <0x38500000 0x200000>;
> +			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk IMX8MP_CLK_NPU_ROOT>,
> +				 <&clk IMX8MP_CLK_NPU_ROOT>,
> +				 <&clk IMX8MP_CLK_ML_AXI>,
> +				 <&clk IMX8MP_CLK_ML_AHB>;
> +			clock-names =3D "core", "shader", "bus", "reg";
> +			power-domains =3D <&pgc_mlmix>;
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible =3D "arm,gic-v3";
>  			reg =3D <0x38800000 0x10000>,


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


