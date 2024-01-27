Return-Path: <linux-kernel+bounces-41046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACEE83EAB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FEA289376
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331C111CB2;
	Sat, 27 Jan 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7WmBC1Z"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C51171A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706327351; cv=none; b=aGmxZW1SZSPl/wlcNtja+bytq1EUq575Bc1Hxsdgu6YCdXX2l4RzLnDVaocEKxTppC0fSUJopZD0hpvNUMcVXR+iJaJoBKIrWD0flt44bjLoQ3CZXr3iu2LgI579qrbFUKJGO7IsMlHojd9NVHU9sJD8rdJM4zeJR1IXYH4NMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706327351; c=relaxed/simple;
	bh=CqFLZpcU/cHng9uWcAuKsJbJvMfQclzEs4mg3emAfAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUpjSuT1QbIWTqi4nj6dyxXT/Al7Jqbvl/4A1ol1xJvOPWY1LR/+JgI5MdjHaCSAn5j4Bf8ZfMwNlQenDvmru+jzNQjnrMAKb/dLFt1UUDZhnNtY1tVZkYyFTOPpTvOEYfNm78qN8CYwiunX4rS3sAvKkOFPhiHwwkMw7TMP8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v7WmBC1Z; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783045e88a6so117543085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706327347; x=1706932147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=583PxqQ0v1Dw1Mm+t8XKrYFjik5GOa7SqI5xvy3rBa0=;
        b=v7WmBC1Z1boQDIGAr1zn3NXbBtL6yPeJQRynfLQ8QoWVZIoC7+jN2ys3LNf1+UU8WZ
         u9t2K/dTxut5L5iRZS6yMamLvaPBmmqcUsl1k2mnbXsKP2x6zRyLqj/L4/ZamtZBu9S2
         CSgA3YhwYTui2bpzysBzOZvzgir38AYA8BqxGhbdjEa7C1ZJOlabSsz4SVerb+SBb+X5
         SVUwlrIDgpPzTISNEpEl1cK7qblWx54dOYXngiA2ID4r2KM2bpYa9etSEz2NNzYSxf9j
         6cXx9/jqKd37YPJNr/NLnHOz0/CTx6Phookws1C/8q0g3oVFjDxaFIb/FHzMSG4ic8wN
         0nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706327347; x=1706932147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=583PxqQ0v1Dw1Mm+t8XKrYFjik5GOa7SqI5xvy3rBa0=;
        b=HjU4HIU2q6xIYS5l/RO6XCc84QaWVrvmCK6p70lwSSTUXzJZUmh0vDu0uQBeyncizi
         Rq+NkTKTfhhafDSffcZ86UeuqSjEQwOpn7xbzYkN4L9mC3d6j1EVW6PZx7L4OBzhHeUh
         zYJqWO4npgcFEafNuQ5MvIO6yH+NKQE0bQuf0fUKRfv7bPgri2++J0qGaS8pvN6G6+6h
         Ok4/2TGIBgxgDP8TAYA2tnPzh2t8WXOVhcpHr0tI8LloqZ1QqoMJ/WTCMztDEwnX7nLx
         n267ZwS5uwGJV/pAKWsrCotmzRjwEH4wX25nqWWkWMOC0Te/Bm2rOH0ut2uV92lcKKj0
         3JVg==
X-Gm-Message-State: AOJu0YzUQ/Q2e0I0XCfZ5R/NXS54+S5WZSVJWMzpE7R+NS+Cus/fNX5K
	kMkH4CAvY9MRzfgW18vArL/udOxaRrJCV5Mk9CFq0/B348xdDBgsIiJqYg6k7aESAeXaPTaStpE
	jQXkM3IKekJYOZNdikAN+1jQLKCtaDGnFx1j7Cw==
X-Google-Smtp-Source: AGHT+IG8LlF2FiWr9DEMRxjDn1Ov3YeBr1dgNgpbqSUrY2XaVhZPblIhKvyezWMK4oLJNkPGuhdBiMehOcCYMiFPMn4=
X-Received: by 2002:a05:620a:c06:b0:783:a775:a432 with SMTP id
 l6-20020a05620a0c0600b00783a775a432mr902660qki.90.1706327347348; Fri, 26 Jan
 2024 19:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-4-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-4-andre.draszik@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 21:48:56 -0600
Message-ID: <CAPLW+4=F37PpuPj86q_r7EiBosDLBjABPgJKEF_S4YOhWvVfMA@mail.gmail.com>
Subject: Re: [PATCH 3/9] clk: samsung: gs101: add support for cmu_peric1
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, alim.akhtar@samsung.com, 
	s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> CMU_PERIC1 is the clock management unit used for the peric1 block which
> is used for additional USI, I3C and PWM interfaces/busses. Add support
> for muxes, dividers and gates of cmu_peric1, except for
> CLK_GOUT_PERIC1_IP which isn't well described in the datasheet and
> which downstream also ignores (similar to cmu_peric0).
>
> Two clocks have been marked as CLK_IS_CRITICAL for the following
> reason:
>     * disabling them makes it impossible to access any peric1
>       registers, (including those two registers).
>     * disabling gout_peric1_lhm_axi_p_peric1_i_clk sometimes has the
>       additional effect of making the whole system unresponsive.
>
> The clocks marked as CLK_IGNORE_UNUSED need to be kept on until we have
> updated the respective drivers for the following reasons:
>     * gout_peric1_gpio_peric1_pclk is required by the pinctrl
>       configuration. With this clock disabled, reconfiguring the pins
>       (for USI/I2C, USI/UART) will hang during register access.
>       Since pingctrl-samsung doesn't support a clock at the moment, we
>       just keep the kernel from disabling it at boot, until we have an
>       update for samsung-pinctrl, at which point we'll drop the flag.
>     * gout_peric1_sysreg_peric1_pclk needs to be hooked up to
>       sysreg_peric1 in DT which will be done in a followup-patch, at
>       which point we'll drop the special treatment from here. We're
>       adding the flag temporarily here so as to not break the boot (due
>       to pclk otherwise getting disabled).
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Note for future reference: To ensure consistent naming throughout this
> driver, the clock names have been derived from the data sheet using the
> following, with the expectation for all future additions to this file
> to use the same:
>     sed \
>         -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|fout_\L\1_pll|' \
>         \
>         -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_\(.*\)|mout_\L\1_\2|' \
>         -e 's|^PLL_CON0_PLL_\(.*\)|mout_pll_\L\1|' \
>         -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|mout_\L\1|' \
>         -e '/^PLL_CON[1-4]_[^_]\+_/d' \
>         -e '/^[^_]\+_CMU_[^_]\+_CONTROLLER_OPTION/d' \
>         -e '/^CLKOUT_CON_BLK_[^_]\+_CMU_[^_]\+_CLKOUT0/d' \
>         \
>         -e 's|_IPCLKPORT||' \
>         -e 's|_RSTNSYNC||' \
>         \
>         -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_\(.*\)|dout_\L\1_\2|' \
>         \
>         -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_\(.*\)|gout_\L\1_\2|' \
>         -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
>         -e 's|^gout_[^_]\+_[^_]\+_cmu_\([^_]\+\)_pclk$|gout_\1_\1_pclk|' =
\
>         -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' =
\
>         -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|gout_\L\1_clk_\L\1_\2|' =
\
>         \
>         -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
> ---
>  drivers/clk/samsung/clk-gs101.c | 346 ++++++++++++++++++++++++++++++++
>  1 file changed, 346 insertions(+)
>
> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs=
101.c
> index 27debbafdce4..7f6c3b52d9ff 100644
> --- a/drivers/clk/samsung/clk-gs101.c
> +++ b/drivers/clk/samsung/clk-gs101.c
> @@ -21,6 +21,7 @@
>  #define CLKS_NR_APM    (CLK_APM_PLL_DIV16_APM + 1)
>  #define CLKS_NR_MISC   (CLK_GOUT_MISC_XIU_D_MISC_ACLK + 1)
>  #define CLKS_NR_PERIC0 (CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
> +#define CLKS_NR_PERIC1 (CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
>
>  /* ---- CMU_TOP --------------------------------------------------------=
----- */
>
> @@ -3066,6 +3067,348 @@ static const struct samsung_cmu_info peric0_cmu_i=
nfo __initconst =3D {
>         .clk_name               =3D "bus",
>  };
>
> +/* ---- CMU_PERIC1 -----------------------------------------------------=
----- */
> +
> +/* Register Offset definitions for CMU_PERIC1 (0x10c00000) */
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_BUS_USER                             =
               0x0600
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_BUS_USER                             =
               0x0604
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER                             =
               0x0610
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_I3C_USER                             =
               0x0614
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER                        =
               0x0620
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_USI0_USI_USER                        =
               0x0624
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER                       =
               0x0630
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_USI10_USI_USER                       =
               0x0634
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER                       =
               0x0640
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_USI11_USI_USER                       =
               0x0644
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER                       =
               0x0650
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_USI12_USI_USER                       =
               0x0654
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER                       =
               0x0660
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_USI13_USI_USER                       =
               0x0664
> +#define PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER                        =
               0x0670
> +#define PLL_CON1_MUX_CLKCMU_PERIC1_USI9_USI_USER                        =
               0x0674
> +#define PERIC1_CMU_PERIC1_CONTROLLER_OPTION                             =
               0x0800
> +#define CLKOUT_CON_BLK_PERIC1_CMU_PERIC1_CLKOUT0                        =
               0x0810
> +#define CLK_CON_DIV_DIV_CLK_PERIC1_I3C                                  =
               0x1800
> +#define CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI                             =
               0x1804
> +#define CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI                            =
               0x1808
> +#define CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI                            =
               0x180c
> +#define CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI                            =
               0x1810
> +#define CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI                            =
               0x1814
> +#define CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI                             =
               0x1818
> +#define CLK_CON_BUF_CLKBUF_PERIC1_IP                                    =
               0x2000
> +#define CLK_CON_GAT_CLK_BLK_PERIC1_UID_PERIC1_CMU_PERIC1_IPCLKPORT_PCLK =
                       0x2004
> +#define CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_I3C_IPCLKPORT=
_CLK           0x2008
> +#define CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_OSCCLK_IPCLKP=
ORT_CLK                0x200c
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_D_TZPC_PERIC1_IPCLKPORT_PCLK    =
               0x2010
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPC_PERIC1_IPCLKPORT_PCLK       =
               0x2014
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPIO_PERIC1_IPCLKPORT_PCLK      =
               0x2018
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_LHM_AXI_P_PERIC1_IPCLKPORT_I_CLK=
               0x201c
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_1   =
               0x2020
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_2   =
               0x2024
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_3   =
               0x2028
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_4   =
               0x202c
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_5   =
               0x2030
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_6   =
               0x2034
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_8   =
               0x2038
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_1    =
               0x203c
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_15   =
               0x2040
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_2    =
               0x2044
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_3    =
               0x2048
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_4    =
               0x204c
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_5    =
               0x2050
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_6    =
               0x2054
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_8    =
               0x2058
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_BUSP_IPCLKPO=
RT_CLK         0x205c
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI0_USI_IPC=
LKPORT_CLK     0x2060
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI10_USI_IP=
CLKPORT_CLK    0x2064
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI11_USI_IP=
CLKPORT_CLK    0x2068
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI12_USI_IP=
CLKPORT_CLK    0x206c
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI13_USI_IP=
CLKPORT_CLK    0x2070
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI9_USI_IPC=
LKPORT_CLK     0x2074
> +#define CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_PERIC1_IPCLKPORT_PCLK    =
               0x2078
> +#define DMYQCH_CON_PERIC1_TOP0_QCH_S                                    =
               0x3000
> +#define PCH_CON_LHM_AXI_P_PERIC1_PCH                                    =
               0x3004
> +#define QCH_CON_D_TZPC_PERIC1_QCH                                       =
               0x3008
> +#define QCH_CON_GPC_PERIC1_QCH                                          =
               0x300c
> +#define QCH_CON_GPIO_PERIC1_QCH                                         =
                       0x3010
> +#define QCH_CON_LHM_AXI_P_PERIC1_QCH                                    =
               0x3014
> +#define QCH_CON_PERIC1_CMU_PERIC1_QCH                                   =
               0x3018
> +#define QCH_CON_PERIC1_TOP0_QCH_I3C0                                    =
               0x301c
> +#define QCH_CON_PERIC1_TOP0_QCH_PWM                                     =
               0x3020
> +#define QCH_CON_PERIC1_TOP0_QCH_USI0_USI                                =
               0x3024
> +#define QCH_CON_PERIC1_TOP0_QCH_USI10_USI                               =
               0x3028
> +#define QCH_CON_PERIC1_TOP0_QCH_USI11_USI                               =
               0x302c
> +#define QCH_CON_PERIC1_TOP0_QCH_USI12_USI                               =
               0x3030
> +#define QCH_CON_PERIC1_TOP0_QCH_USI13_USI                               =
               0x3034
> +#define QCH_CON_PERIC1_TOP0_QCH_USI9_USI                                =
               0x3038
> +#define QCH_CON_SYSREG_PERIC1_QCH                                       =
               0x303c
> +#define QUEUE_CTRL_REG_BLK_PERIC1_CMU_PERIC1                            =
               0x3c00
> +
> +static const unsigned long peric1_clk_regs[] __initconst =3D {
> +       PLL_CON0_MUX_CLKCMU_PERIC1_BUS_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_BUS_USER,
> +       PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_I3C_USER,
> +       PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_USI0_USI_USER,
> +       PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_USI10_USI_USER,
> +       PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_USI11_USI_USER,
> +       PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_USI12_USI_USER,
> +       PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_USI13_USI_USER,
> +       PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER,
> +       PLL_CON1_MUX_CLKCMU_PERIC1_USI9_USI_USER,
> +       PERIC1_CMU_PERIC1_CONTROLLER_OPTION,
> +       CLKOUT_CON_BLK_PERIC1_CMU_PERIC1_CLKOUT0,
> +       CLK_CON_DIV_DIV_CLK_PERIC1_I3C,
> +       CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI,
> +       CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI,
> +       CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI,
> +       CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI,
> +       CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI,
> +       CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI,
> +       CLK_CON_BUF_CLKBUF_PERIC1_IP,
> +       CLK_CON_GAT_CLK_BLK_PERIC1_UID_PERIC1_CMU_PERIC1_IPCLKPORT_PCLK,
> +       CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_I3C_IPCLKPORT_=
CLK,
> +       CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_OSCCLK_IPCLKPO=
RT_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_D_TZPC_PERIC1_IPCLKPORT_PCLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPC_PERIC1_IPCLKPORT_PCLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPIO_PERIC1_IPCLKPORT_PCLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_LHM_AXI_P_PERIC1_IPCLKPORT_I_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_1,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_2,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_3,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_4,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_5,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_6,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_8,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_1,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_15,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_2,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_3,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_4,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_5,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_6,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_8,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_BUSP_IPCLKPOR=
T_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI0_USI_IPCL=
KPORT_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI10_USI_IPC=
LKPORT_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI11_USI_IPC=
LKPORT_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI12_USI_IPC=
LKPORT_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI13_USI_IPC=
LKPORT_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI9_USI_IPCL=
KPORT_CLK,
> +       CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_PERIC1_IPCLKPORT_PCLK,
> +       DMYQCH_CON_PERIC1_TOP0_QCH_S,
> +       PCH_CON_LHM_AXI_P_PERIC1_PCH,
> +       QCH_CON_D_TZPC_PERIC1_QCH,
> +       QCH_CON_GPC_PERIC1_QCH,
> +       QCH_CON_GPIO_PERIC1_QCH,
> +       QCH_CON_LHM_AXI_P_PERIC1_QCH,
> +       QCH_CON_PERIC1_CMU_PERIC1_QCH,
> +       QCH_CON_PERIC1_TOP0_QCH_I3C0,
> +       QCH_CON_PERIC1_TOP0_QCH_PWM,
> +       QCH_CON_PERIC1_TOP0_QCH_USI0_USI,
> +       QCH_CON_PERIC1_TOP0_QCH_USI10_USI,
> +       QCH_CON_PERIC1_TOP0_QCH_USI11_USI,
> +       QCH_CON_PERIC1_TOP0_QCH_USI12_USI,
> +       QCH_CON_PERIC1_TOP0_QCH_USI13_USI,
> +       QCH_CON_PERIC1_TOP0_QCH_USI9_USI,
> +       QCH_CON_SYSREG_PERIC1_QCH,
> +       QUEUE_CTRL_REG_BLK_PERIC1_CMU_PERIC1,
> +};
> +
> +/* List of parent clocks for Muxes in CMU_PERIC1 */
> +PNAME(mout_peric1_bus_user_p)          =3D { "oscclk", "dout_cmu_peric1_=
bus" };
> +PNAME(mout_peric1_nonbususer_p)                =3D { "oscclk", "dout_cmu=
_peric1_ip" };
> +
> +static const struct samsung_mux_clock peric1_mux_clks[] __initconst =3D =
{
> +       MUX(CLK_MOUT_PERIC1_BUS_USER, "mout_peric1_bus_user",
> +           mout_peric1_bus_user_p, PLL_CON0_MUX_CLKCMU_PERIC1_BUS_USER, =
4, 1),
> +       MUX(CLK_MOUT_PERIC1_I3C_USER,
> +           "mout_peric1_i3c_user", mout_peric1_nonbususer_p,
> +           PLL_CON0_MUX_CLKCMU_PERIC1_I3C_USER, 4, 1),
> +       MUX(CLK_MOUT_PERIC1_USI0_USI_USER,
> +           "mout_peric1_usi0_usi_user", mout_peric1_nonbususer_p,
> +           PLL_CON0_MUX_CLKCMU_PERIC1_USI0_USI_USER, 4, 1),
> +       MUX(CLK_MOUT_PERIC1_USI10_USI_USER,
> +           "mout_peric1_usi10_usi_user", mout_peric1_nonbususer_p,
> +           PLL_CON0_MUX_CLKCMU_PERIC1_USI10_USI_USER, 4, 1),
> +       MUX(CLK_MOUT_PERIC1_USI11_USI_USER,
> +           "mout_peric1_usi11_usi_user", mout_peric1_nonbususer_p,
> +           PLL_CON0_MUX_CLKCMU_PERIC1_USI11_USI_USER, 4, 1),
> +       MUX(CLK_MOUT_PERIC1_USI12_USI_USER,
> +           "mout_peric1_usi12_usi_user", mout_peric1_nonbususer_p,
> +           PLL_CON0_MUX_CLKCMU_PERIC1_USI12_USI_USER, 4, 1),
> +       MUX(CLK_MOUT_PERIC1_USI13_USI_USER,
> +           "mout_peric1_usi13_usi_user", mout_peric1_nonbususer_p,
> +           PLL_CON0_MUX_CLKCMU_PERIC1_USI13_USI_USER, 4, 1),
> +       MUX(CLK_MOUT_PERIC1_USI9_USI_USER,
> +           "mout_peric1_usi9_usi_user", mout_peric1_nonbususer_p,
> +           PLL_CON0_MUX_CLKCMU_PERIC1_USI9_USI_USER, 4, 1),
> +};
> +
> +static const struct samsung_div_clock peric1_div_clks[] __initconst =3D =
{
> +       DIV(CLK_DOUT_PERIC1_I3C, "dout_peric1_i3c", "mout_peric1_i3c_user=
",
> +           CLK_CON_DIV_DIV_CLK_PERIC1_I3C, 0, 4),
> +       DIV(CLK_DOUT_PERIC1_USI0_USI,
> +           "dout_peric1_usi0_usi", "mout_peric1_usi0_usi_user",
> +           CLK_CON_DIV_DIV_CLK_PERIC1_USI0_USI, 0, 4),
> +       DIV(CLK_DOUT_PERIC1_USI10_USI,
> +           "dout_peric1_usi10_usi", "mout_peric1_usi10_usi_user",
> +           CLK_CON_DIV_DIV_CLK_PERIC1_USI10_USI, 0, 4),
> +       DIV(CLK_DOUT_PERIC1_USI11_USI,
> +           "dout_peric1_usi11_usi", "mout_peric1_usi11_usi_user",
> +           CLK_CON_DIV_DIV_CLK_PERIC1_USI11_USI, 0, 4),
> +       DIV(CLK_DOUT_PERIC1_USI12_USI,
> +           "dout_peric1_usi12_usi", "mout_peric1_usi12_usi_user",
> +           CLK_CON_DIV_DIV_CLK_PERIC1_USI12_USI, 0, 4),
> +       DIV(CLK_DOUT_PERIC1_USI13_USI,
> +           "dout_peric1_usi13_usi", "mout_peric1_usi13_usi_user",
> +           CLK_CON_DIV_DIV_CLK_PERIC1_USI13_USI, 0, 4),
> +       DIV(CLK_DOUT_PERIC1_USI9_USI,
> +           "dout_peric1_usi9_usi", "mout_peric1_usi9_usi_user",
> +           CLK_CON_DIV_DIV_CLK_PERIC1_USI9_USI, 0, 4),
> +};
> +
> +static const struct samsung_gate_clock peric1_gate_clks[] __initconst =
=3D {
> +       GATE(CLK_GOUT_PERIC1_PCLK,
> +            "gout_peric1_peric1_pclk", "mout_peric1_bus_user",
> +            CLK_CON_GAT_CLK_BLK_PERIC1_UID_PERIC1_CMU_PERIC1_IPCLKPORT_P=
CLK,
> +            21, CLK_IS_CRITICAL, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_I3C_CLK,
> +            "gout_peric1_clk_peric1_i3c_clk", "dout_peric1_i3c",
> +            CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_I3C_IPCLK=
PORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_OSCCLK_CLK,
> +            "gout_peric1_clk_peric1_oscclk_clk", "oscclk",
> +            CLK_CON_GAT_CLK_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_OSCCLK_IP=
CLKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_D_TZPC_PERIC1_PCLK,
> +            "gout_peric1_d_tzpc_peric1_pclk", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_D_TZPC_PERIC1_IPCLKPORT_PCLK=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_GPC_PERIC1_PCLK,
> +            "gout_peric1_gpc_peric1_pclk", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPC_PERIC1_IPCLKPORT_PCLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_GPIO_PERIC1_PCLK,
> +            "gout_peric1_gpio_peric1_pclk", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_GPIO_PERIC1_IPCLKPORT_PCLK,
> +            21, CLK_IGNORE_UNUSED, 0),
> +       GATE(CLK_GOUT_PERIC1_LHM_AXI_P_PERIC1_I_CLK,
> +            "gout_peric1_lhm_axi_p_peric1_i_clk", "mout_peric1_bus_user"=
,
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_LHM_AXI_P_PERIC1_IPCLKPORT_I=
_CLK,
> +            21, CLK_IS_CRITICAL, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1,
> +            "gout_peric1_peric1_top0_ipclk_1", "dout_peric1_usi0_usi",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_=
1,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2,
> +            "gout_peric1_peric1_top0_ipclk_2", "dout_peric1_usi9_usi",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_=
2,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3,
> +            "gout_peric1_peric1_top0_ipclk_3", "dout_peric1_usi10_usi",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_=
3,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4,
> +            "gout_peric1_peric1_top0_ipclk_4", "dout_peric1_usi11_usi",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_=
4,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5,
> +            "gout_peric1_peric1_top0_ipclk_5", "dout_peric1_usi12_usi",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_=
5,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6,
> +            "gout_peric1_peric1_top0_ipclk_6", "dout_peric1_usi13_usi",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_=
6,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_8,
> +            "gout_peric1_peric1_top0_ipclk_8", "dout_peric1_i3c",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_IPCLK_=
8,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_1,
> +            "gout_peric1_peric1_top0_pclk_1", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_1=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_15,
> +            "gout_peric1_peric1_top0_pclk_15", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_1=
5,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_2,
> +            "gout_peric1_peric1_top0_pclk_2", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_2=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_3,
> +            "gout_peric1_peric1_top0_pclk_3", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_3=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_4,
> +            "gout_peric1_peric1_top0_pclk_4", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_4=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5,
> +            "gout_peric1_peric1_top0_pclk_5", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_5=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_6,
> +            "gout_peric1_peric1_top0_pclk_6", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_6=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_8,
> +            "gout_peric1_peric1_top0_pclk_8", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_PERIC1_TOP0_IPCLKPORT_PCLK_8=
,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_BUSP_CLK,
> +            "gout_peric1_clk_peric1_busp_clk", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_BUSP_IPC=
LKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI0_USI_CLK,
> +            "gout_peric1_clk_peric1_usi0_usi_clk", "dout_peric1_usi0_usi=
",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI0_USI=
_IPCLKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI10_USI_CLK,
> +            "gout_peric1_clk_peric1_usi10_usi_clk", "dout_peric1_usi10_u=
si",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI10_US=
I_IPCLKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI11_USI_CLK,
> +            "gout_peric1_clk_peric1_usi11_usi_clk", "dout_peric1_usi11_u=
si",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI11_US=
I_IPCLKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI12_USI_CLK,
> +            "gout_peric1_clk_peric1_usi12_usi_clk", "dout_peric1_usi12_u=
si",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI12_US=
I_IPCLKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI13_USI_CLK,
> +            "gout_peric1_clk_peric1_usi13_usi_clk", "dout_peric1_usi13_u=
si",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI13_US=
I_IPCLKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_CLK_PERIC1_USI9_USI_CLK,
> +            "gout_peric1_clk_peric1_usi9_usi_clk", "dout_peric1_usi9_usi=
",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_RSTNSYNC_CLK_PERIC1_USI9_USI=
_IPCLKPORT_CLK,
> +            21, 0, 0),
> +       GATE(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK,
> +            "gout_peric1_sysreg_peric1_pclk", "mout_peric1_bus_user",
> +            CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_PERIC1_IPCLKPORT_PCLK=
,
> +            21, CLK_IGNORE_UNUSED, 0),
> +};
> +
> +static const struct samsung_cmu_info peric1_cmu_info __initconst =3D {
> +       .mux_clks               =3D peric1_mux_clks,
> +       .nr_mux_clks            =3D ARRAY_SIZE(peric1_mux_clks),
> +       .div_clks               =3D peric1_div_clks,
> +       .nr_div_clks            =3D ARRAY_SIZE(peric1_div_clks),
> +       .gate_clks              =3D peric1_gate_clks,
> +       .nr_gate_clks           =3D ARRAY_SIZE(peric1_gate_clks),
> +       .nr_clk_ids             =3D CLKS_NR_PERIC1,
> +       .clk_regs               =3D peric1_clk_regs,
> +       .nr_clk_regs            =3D ARRAY_SIZE(peric1_clk_regs),
> +       .clk_name               =3D "bus",
> +};
> +
>  /* ---- platform_driver ------------------------------------------------=
----- */
>
>  static int __init gs101_cmu_probe(struct platform_device *pdev)
> @@ -3086,6 +3429,9 @@ static const struct of_device_id gs101_cmu_of_match=
[] =3D {
>         }, {
>                 .compatible =3D "google,gs101-cmu-peric0",
>                 .data =3D &peric0_cmu_info,
> +       }, {
> +               .compatible =3D "google,gs101-cmu-peric1",
> +               .data =3D &peric1_cmu_info,
>         }, {
>         },
>  };
> --
> 2.43.0.429.g432eaa2c6b-goog
>

