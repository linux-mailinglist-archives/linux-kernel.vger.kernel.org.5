Return-Path: <linux-kernel+bounces-135553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5CA89C77C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CC828579D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E113F43B;
	Mon,  8 Apr 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CajWZAZ9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED813F42C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587764; cv=none; b=e1Qh2GdieqOCzYSI8AIakdvqno888bnlee6OF88LaPR0jiOkZVYebIVyrjq8yLi6W36uhj1IESh9X9NLmUI3elKnJqOkmq2WvUfCZ06ctT6Lx5SjLOTGj7p3VEaw1rNSFCivNM8kC2hUGZQH30DPywNssU+ibY6lqwVMqXpXctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587764; c=relaxed/simple;
	bh=kqABwm4SeRyyWpDPZiCA1IIfX5kotHTU4sIUNm44rds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qql7Kx0bSdzElV+2w/4wZOx6GQ3sltdEIrmyqyfxMMzIr9iDi6frMjrBZ8axbJID4dGreQLrPONDuz1az+5aqs4x5kmWUlXJw9xcFTcMzm6xg21wDVcxCKha00xZOHmzC4r7i5ioHe2YaRiS0lgf/GQjkZpCx8tf/x6FroSHasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CajWZAZ9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41649860cecso10408745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712587761; x=1713192561; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0EE/MOgIxft1vfD//KGXquYTb4qzSH0XjrabPn5Q8lo=;
        b=CajWZAZ9A4VNb96o21snoUhAZo9hBeNkQ6dtDuj8xCdU2nKuw4K5hTsPYNmdRXVFH+
         pEG1aVh5mRCdgZW43o0r3f1RaoqFtSmFxkkPjO/TgxgrR/b65L5aOTEoVOiTMonqFKny
         tOfc5xfWhkTRo0qVsmC0PFDvcvHwH9czTuKWJJ9d/GS5kzsCzI7xEYl2C4u/mEiir/CD
         eDSiBH4G7xG8bFt7ebCwKtLKMuZT2NnmwvO0BMt4PkxKgD6bPPv2d0IJDTCtQ9WZBtm3
         erwF3dtoi5+ttRz4xQ3boax104TkbLM4Vn26KGPw6K2JRCAt2feGjpsy0j4freT0jfDO
         +YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712587761; x=1713192561;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EE/MOgIxft1vfD//KGXquYTb4qzSH0XjrabPn5Q8lo=;
        b=ehJln8YgwLHHBaLVpRSTTP+8NhxcV/f9j1AoMcfnPEcHfpHn3yYUQzIP3QFgN1RTts
         T+Pce79XYBvpmbUJV0pdrMD7aybWcvxb/NMQXBoexqfC563bUhHE9ecQZFzvXZ0AxvDd
         wAWRhnjZbzqQrFIWIc9lAk5oEiSMFpyvfpmRl/ttqqz/Hsq/UnGTOuAvYgHWU2IRVvhQ
         0UTD+juhB5pwoXf/dhLEv89xpemV8jVr1y/mPZpuKiUJIR5zvYcw/MxHMVH18y2tRIiS
         403skk86Roa2YnkoN9SrgTlsOhqBiudcoNGwr3QcR8N9ijiVo00r2joRTnBVBGFmU5DK
         wy/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfTL+CXyQsweVWj+KzBUFRcnkR4ueeUExAmmjVYb59bKOP1AaXFKFdm49phseFa3KY7ngYuxHEsn1iHxCfXPKMt4XNeHwPLtIMoPBv
X-Gm-Message-State: AOJu0YzN720Pj3W+o79AspmRqB3zQuBvWZdxBcQcOzWy7Jz662E7drdY
	sjLFQoz1L99WJdod9vgjHXf36AtdQkI7odcLEnQb7Y9AC4s6bvroOeikmWWmLy8=
X-Google-Smtp-Source: AGHT+IGG9i5K+adcR32eYKb2R1dhdhIu35XUgoAG2pjKiBFFLAOeBkyufatVzBbZUYaV4XpDPUBWWg==
X-Received: by 2002:a05:600c:3acb:b0:416:7222:8a78 with SMTP id d11-20020a05600c3acb00b0041672228a78mr2201360wms.37.1712587760913;
        Mon, 08 Apr 2024 07:49:20 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id dr20-20020a5d5f94000000b0033ea499c645sm9303171wrb.4.2024.04.08.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:49:20 -0700 (PDT)
Message-ID: <6c2b060b3b32b2da46bafbdc33236c319b6cec62.camel@linaro.org>
Subject: Re: [PATCH 08/17] clk: samsung: gs101: add support for cmu_hsi2
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
 avri.altman@wdc.com,  bvanassche@acm.org, s.nawrocki@samsung.com,
 cw00.choi@samsung.com,  jejb@linux.ibm.com, martin.petersen@oracle.com,
 chanho61.park@samsung.com,  ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Date: Mon, 08 Apr 2024 15:49:18 +0100
In-Reply-To: <20240404122559.898930-9-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
	 <20240404122559.898930-9-peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pete,

On Thu, 2024-04-04 at 13:25 +0100, Peter Griffin wrote:
> CMU_HSI2 is the clock management unit used for the hsi2 block.
> HSI stands for High Speed Interface and as such it generates
> clocks for PCIe, UFS and MMC card.
>=20
> This patch adds support for the muxes, dividers, and gates in
> cmu_hsi2.
>=20
> CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK is marked as CLK_IS_CRITICAL
> as disabling it leads to an immediate system hang.
>=20
> CLK_GOUT_HSI2_SYSREG_HSI2_PCLK is also marked CLK_IS_CRITICAL.
> A hang is not observed with fine grained clock control, but
> UFS IP does not function with syscon controlling this clock
> just around hsi2_sysreg register accesses.

Would it make sense to add this clock to the &ufs_0 node in the DTS
instead? Seems more natural than a clock that's constantly enabled?

> [...]
>=20
> Updated regex for clock name mangling
> =C2=A0=C2=A0=C2=A0 sed \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^PLL_LOCKTIME_PLL_\([^_]=
\+\)|fout_\L\1_pll|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^PLL_CON0_MUX_CLKCMU_\([=
^_]\+\)_\(.*\)|mout_\L\1_\2|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^PLL_CON0_PLL_\(.*\)|mou=
t_pll_\L\1|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^CLK_CON_MUX_MUX_CLK_\(.=
*\)|mout_\L\1|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e '/^PLL_CON[1-4]_[^_]\+_/d' =
\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e '/^[^_]\+_CMU_[^_]\+_CONTRO=
LLER_OPTION/d' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e '/^CLKOUT_CON_BLK_[^_]\+_CM=
U_[^_]\+_CLKOUT0/d' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_IPCLKPORT||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_RSTNSYNC||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_G4X2_DWC_PCIE_CTL||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_G4X1_DWC_PCIE_CTL||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_PCIE_SUB_CTRL||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_INST_0||g' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_LN05LPE||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_TM_WRAPPER||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|_SF||' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^CLK_CON_DIV_DIV_CLK_\([=
^_]\+\)_\(.*\)|dout_\L\1_\2|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^CLK_CON_BUF_CLKBUF_\([^=
_]\+\)_\(.*\)|gout_\L\1_\2|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^CLK_CON_GAT_CLK_BLK_\([=
^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^gout_[^_]\+_[^_]\+_cmu_=
\([^_]\+\)_pclk$|gout_\1_\1_pclk|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^CLK_CON_GAT_GOUT_BLK_\(=
[^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's|^CLK_CON_GAT_CLK_\([^_]\=
+\)_\(.*\)|gout_\L\1_clk_\L\1_\2|' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e '/^\(DMYQCH\|PCH\|QCH\|QUEU=
E\)_/d'

Thank you for the updated regex.

> ---
> =C2=A0drivers/clk/samsung/clk-gs101.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 558 +++++++++++++++++++++++
> =C2=A0include/dt-bindings/clock/google,gs101.h |=C2=A0 63 +++
> =C2=A02 files changed, 621 insertions(+)
>=20
> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs=
101.c
> index d065e343a85d..b9f84c7d5c22 100644
> --- a/drivers/clk/samsung/clk-gs101.c
> +++ b/drivers/clk/samsung/clk-gs101.c
> @@ -22,6 +22,7 @@
> =C2=A0#define CLKS_NR_MISC	(CLK_GOUT_MISC_XIU_D_MISC_ACLK + 1)
> =C2=A0#define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
> =C2=A0#define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
> +#define CLKS_NR_HSI2	(CLK_GOUT_HSI2_XIU_P_HSI2_ACLK + 1)
> =C2=A0
> =C2=A0/* ---- CMU_TOP ---------------------------------------------------=
---------- */
> =C2=A0
> @@ -3409,6 +3410,560 @@ static const struct samsung_cmu_info peric1_cmu_i=
nfo __initconst =3D {
> =C2=A0	.clk_name		=3D "bus",
> =C2=A0};
> =C2=A0
> +/* ---- CMU_HSI2 -------------------------------------------------------=
--- */

This comment is shorter that all the other similar comments in this file.

> [...]
> +
> +PNAME(mout_hsi2_bus_user_p)	=3D { "oscclk", "dout_cmu_hsi2_bus" };
> +PNAME(mout_hsi2_pcie_user_p)	=3D { "oscclk", "dout_cmu_hsi2_pcie" };
> +PNAME(mout_hsi2_ufs_embd_user_p) =3D { "oscclk", "dout_cmu_hsi2_ufs_embd=
" };
> +PNAME(mout_hsi2_mmc_card_user_p) =3D { "oscclk", "dout_cmu_hsi2_mmc_card=
" };

Can you make these alphabetical, too, please, which would also match their =
usage
below:

> +
> +static const struct samsung_mux_clock hsi2_mux_clks[] __initconst =3D {
> +	MUX(CLK_MOUT_HSI2_BUS_USER, "mout_hsi2_bus_user", mout_hsi2_bus_user_p,
> +	=C2=A0=C2=A0=C2=A0 PLL_CON0_MUX_CLKCMU_HSI2_BUS_USER, 4, 1),
> +	MUX(CLK_MOUT_HSI2_MMC_CARD_USER, "mout_hsi2_mmc_card_user",
> +	=C2=A0=C2=A0=C2=A0 mout_hsi2_mmc_card_user_p, PLL_CON0_MUX_CLKCMU_HSI2_=
MMC_CARD_USER,
> +	=C2=A0=C2=A0=C2=A0 4, 1),
> +	MUX(CLK_MOUT_HSI2_PCIE_USER, "mout_hsi2_pcie_user",
> +	=C2=A0=C2=A0=C2=A0 mout_hsi2_pcie_user_p, PLL_CON0_MUX_CLKCMU_HSI2_PCIE=
_USER,
> +	=C2=A0=C2=A0=C2=A0 4, 1),
> +	MUX(CLK_MOUT_HSI2_UFS_EMBD_USER, "mout_hsi2_ufs_embd_user",
> +	=C2=A0=C2=A0=C2=A0 mout_hsi2_ufs_embd_user_p, PLL_CON0_MUX_CLKCMU_HSI2_=
UFS_EMBD_USER,
> +	=C2=A0=C2=A0=C2=A0 4, 1),
> +};
> +
> +static const struct samsung_gate_clock hsi2_gate_clks[] __initconst =3D =
{
> +

Here and below: all these extra empty lines are not needed.

> +	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_PHY_REFCLK_IN,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "gout_hsi2_pcie_gen4_1_pcie_003_phy_refclk_in"=
,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "mout_hsi2_pcie_user",
> +	=C2=A0=C2=A0=C2=A0=C2=A0 CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLK=
PORT_PCIE_003_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 21, 0, 0),
> +
> +	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_PHY_REFCLK_IN,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "gout_hsi2_pcie_gen4_1_pcie_004_phy_refclk_in"=
,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "mout_hsi2_pcie_user",
> +	=C2=A0=C2=A0=C2=A0=C2=A0 CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLK=
PORT_PCIE_004_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 21, 0, 0),
> +
> +	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_ACLK,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "gout_hsi2_ssmt_pcie_ia_gen4a_1_aclk",
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "mout_hsi2_bus_user",

The two strings fit on the same line.

> +	=C2=A0=C2=A0=C2=A0=C2=A0 CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4=
A_1_IPCLKPORT_ACLK,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 21, 0, 0),
> +
> +	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_PCLK,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "gout_hsi2_ssmt_pcie_ia_gen4a_1_pclk",
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "mout_hsi2_bus_user",

dito.

> [...]
> +	/* Disabling this clock makes the system hang. Mark the clock as critic=
al. */
> +	GATE(CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 "gout_hsi2_hsi2_cmu_hsi2_pclk", "mout_hsi2_bus=
_user",
> +	=C2=A0=C2=A0=C2=A0=C2=A0 CLK_CON_GAT_GOUT_BLK_HSI2_UID_HSI2_CMU_HSI2_IP=
CLKPORT_PCLK,
> +	=C2=A0=C2=A0=C2=A0=C2=A0 21, CLK_IS_CRITICAL, 0),

I have a similar clock in USB, which also causes a hang if off, I wonder wh=
at we
could do better here.


Cheers,
Andre'


