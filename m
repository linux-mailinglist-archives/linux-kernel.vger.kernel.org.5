Return-Path: <linux-kernel+bounces-159471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59D8B2F01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9853CB22B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE378C60;
	Fri, 26 Apr 2024 03:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QO7rpWZq"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E278274;
	Fri, 26 Apr 2024 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102545; cv=none; b=KZqXlWi/lzKcp7opmkWLQJcmAY2hb+7YeiDOnJKNFv4vvMbFoc50SyV8lloxXynKKI+kiII5o4nS53E5zE6jcfN1b/4fgC6ycxxOC7duoShPdFsgj/jpniUtrYNLNyYIEbesH1Veof/+/oKKPV5vjVWEE+AmjWk5slA2rBq6B0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102545; c=relaxed/simple;
	bh=xnK1asdDas5LoMEk3JtBBR01NBRCWwKZnB1/eTDniT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PqSuXaWc0wuf4Lv8MjS/WctZP7Zwp6zbVse7k4FzPx7XJi/mX9vudvJUHBkDl492bA56COQAlDK08Drc0tlpPp5+d9/11n9q/RPpfKoC2K0MPAllQuL5jxbMPiliqcjkoVJwQBo1bL4bcmoboiuwIgucQmC3hXVIypezDIoM/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QO7rpWZq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714102537;
	bh=Ief0h6FyGKOWO9Y6HPCZkBTtzt0lhbnXEi25+gFT4+k=;
	h=Date:From:To:Cc:Subject:From;
	b=QO7rpWZq5/QJOD3kI8+XQSITjd7Vgz4oMhPNkvJYcdMounPzDmv1HqZSyNIGSkynX
	 i6xwdtF6wxpwhKsLa4oLphvC9z1BPK6fFEpAmkgxAEdXzlgLuKqa+fZ2EF1a+sQ1xS
	 3Y6nHP1ubOUnjMRxdnVEwMoQB/XaZki5kIPQrjkG+APQyzaYoqhw8PYUSc6EXkYSzB
	 j3tUtpl6mLu9tBmxvHmAeowoBW7hVw2g8QTQqWAud0SjHAr7IWiNNxYoNouay2R1T5
	 xK6f1+H8AUmP5DU16HKYBK0yiaQNtxduNVPk07NuCliKHxnFan4Bw/FabvsIh61TNr
	 IfKNSFUOtLRww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQdfJ5lLyz4wc8;
	Fri, 26 Apr 2024 13:35:36 +1000 (AEST)
Date: Fri, 26 Apr 2024 13:35:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexandre Torgue <alexandre.torgue@st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the stm32 tree
Message-ID: <20240426133535.683c976f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jey+jU/5Im.5d+j=IA3W02+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jey+jU/5Im.5d+j=IA3W02+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/arm64/boot/dts/st/stm32mp251.dtsi

between commit:

  2886ab7437de ("arm64: dts: st: add rcc support for STM32MP25")

from the stm32 tree and commit:

  fbc3facb0b5c ("arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/st/stm32mp251.dtsi
index 4b48e4ed2d28,e7d1614dc744..000000000000
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@@ -356,93 -168,99 +356,186 @@@
  			};
  		};
 =20
 +		rcc: clock-controller@44200000 {
 +			compatible =3D "st,stm32mp25-rcc";
 +			reg =3D <0x44200000 0x10000>;
 +			#clock-cells =3D <1>;
 +			#reset-cells =3D <1>;
 +			clocks =3D <&scmi_clk CK_SCMI_HSE>,
 +				<&scmi_clk CK_SCMI_HSI>,
 +				<&scmi_clk CK_SCMI_MSI>,
 +				<&scmi_clk CK_SCMI_LSE>,
 +				<&scmi_clk CK_SCMI_LSI>,
 +				<&scmi_clk CK_SCMI_HSE_DIV2>,
 +				<&scmi_clk CK_SCMI_ICN_HS_MCU>,
 +				<&scmi_clk CK_SCMI_ICN_LS_MCU>,
 +				<&scmi_clk CK_SCMI_ICN_SDMMC>,
 +				<&scmi_clk CK_SCMI_ICN_DDR>,
 +				<&scmi_clk CK_SCMI_ICN_DISPLAY>,
 +				<&scmi_clk CK_SCMI_ICN_HSL>,
 +				<&scmi_clk CK_SCMI_ICN_NIC>,
 +				<&scmi_clk CK_SCMI_ICN_VID>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_07>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_08>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_09>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_10>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_11>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_12>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_13>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_14>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_15>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_16>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_17>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_18>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_19>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_20>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_21>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_22>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_23>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_24>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_25>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_26>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_27>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_28>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_29>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_30>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_31>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_32>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_33>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_34>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_35>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_36>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_37>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_38>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_39>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_40>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_41>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_42>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_43>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_44>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_45>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_46>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_47>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_48>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_49>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_50>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_51>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_52>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_53>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_54>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_55>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_56>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_57>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_58>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_59>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_60>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_61>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_62>,
 +				<&scmi_clk CK_SCMI_FLEXGEN_63>,
 +				<&scmi_clk CK_SCMI_ICN_APB1>,
 +				<&scmi_clk CK_SCMI_ICN_APB2>,
 +				<&scmi_clk CK_SCMI_ICN_APB3>,
 +				<&scmi_clk CK_SCMI_ICN_APB4>,
 +				<&scmi_clk CK_SCMI_ICN_APBDBG>,
 +				<&scmi_clk CK_SCMI_TIMG1>,
 +				<&scmi_clk CK_SCMI_TIMG2>,
 +				<&scmi_clk CK_SCMI_PLL3>,
 +				<&clk_dsi_txbyte>;
 +		};
 +
+ 		exti1: interrupt-controller@44220000 {
+ 			compatible =3D "st,stm32mp1-exti", "syscon";
+ 			interrupt-controller;
+ 			#interrupt-cells =3D <2>;
+ 			reg =3D <0x44220000 0x400>;
+ 			interrupts-extended =3D
+ 				<&intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+ 				<&intc GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+ 				<&intc GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+ 				<0>,						/* EXTI_20 */
+ 				<&intc GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+ 				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+ 				<0>,
+ 				<&intc GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
+ 				<&intc GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+ 				<0>,
+ 				<0>,
+ 				<0>,
+ 				<0>,
+ 				<0>,
+ 				<0>,
+ 				<0>,
+ 				<0>,
+ 				<&intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+ 				<0>,						/* EXTI_60 */
+ 				<&intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+ 				<0>,
+ 				<0>,
+ 				<&intc GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+ 				<0>,
+ 				<0>,
+ 				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+ 				<0>,
+ 				<&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
+ 				<0>,
+ 				<&intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+ 				<0>,						/* EXTI_80 */
+ 				<0>,
+ 				<0>,
+ 				<&intc GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+ 				<&intc GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+ 		};
+=20
  		syscfg: syscon@44230000 {
  			compatible =3D "st,stm32mp25-syscfg", "syscon";
  			reg =3D <0x44230000 0x10000>;

--Sig_/jey+jU/5Im.5d+j=IA3W02+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrIQcACgkQAVBC80lX
0Gwk3QgAkjdgU/6fAVnoytInOyposxDv6+dlZBk8lRv+ajIGoXa1OMFQcbs7S/30
47T2vEHmKhqALyfwhtNyNa/yV5U1zwxG9I71KNYyafUoCxoxpWZTpA87gnwt2kGl
VXKj9NbUu0B+nyWlYBnBDPsqjmQFvNggnCEZ4mTj25CTWujlB/GhvfX4NClSc2kC
q7TfkTGubTGRMZ/yfq5woZVzUhtkKz+GJWN1fFhjiQzXOjrySbtOdfrYVleJ9C1Y
pubO6mLcAxidGJa5N4RJMdf1B6pTl+OGKG58SHdKXSugq5EWY46/5KwNefLbc+UL
dLP7KXzRn4i6j/jwKpk9ZvuhYWT4gg==
=9SZk
-----END PGP SIGNATURE-----

--Sig_/jey+jU/5Im.5d+j=IA3W02+--

