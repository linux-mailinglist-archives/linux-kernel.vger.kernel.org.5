Return-Path: <linux-kernel+bounces-42427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F983840141
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4BB22678
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190F54FA9;
	Mon, 29 Jan 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+Zw8yen"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42355E7A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519922; cv=none; b=dyUAg6MyWoqg+eLwiL3CWH4+SOYTtsRnsE6FqGpJcrqplJoj2nH5h1qqlmudI1kE9a98OF4EuF1EUxEE8J8zKw4AAqJMLiOT6/QbVvVW4kA+Ch0UgHCOZ4TvIXPpWOo9ANP8xVfrT5N3mkdOcFGc01snVRgeNQJAc6ilSb6XTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519922; c=relaxed/simple;
	bh=sFozMJoAolAGCF8tscjr3ajpcwVLl1NfdfeFIagusCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esgFD6gsTezn8i7aOsFfWLJcbzMp/r3LP3lnK1Gt8a9eiYjBoCzhL1b79luJuNOV3MR4FmFuhOITpqgP/H2D9XXaalc56qOlIWPZ6IygmwyjOV+1eHyT6wO4ljYzdtiO2hXz52/JoGau2SxYGUgSWWPrL9PF8sa80ZrvhUpPGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+Zw8yen; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c2f4c3282so21451756d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706519918; x=1707124718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8QUCC8mxaAYBk9a7j4VTD2YmBLyr7XLPrPfEMJfXSE=;
        b=O+Zw8yenzEoPh/vaH6nKmPzzb1zsqsmaYbBFktz6RVnBM709pNz15R6Rgvr27AfR0o
         MwO7/mLx21K8jGrMCKDJyuUSUseeMayD/QLFWdsrc+sYiEy0UxlWS6E7t0S4BsZuBLgM
         HB4AbIL3J5FtCKzhg84o0DXq49wR1NpIQzAEy3/4RwjvXPxHsIEeFC/gcBRsVpN1UZAa
         Po0CsTl3vBnKZxWjSs89KtSYk9WZ9XK6y6CuaqRcWYufniEVgL21lo9vy703ZfCX+kKL
         rpLjP6jUhISNkU87OLmhnLmZPUAaAsAfMhMyGoums+jBARQj3aM3vkv55eXhSsUqDY7B
         nTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519918; x=1707124718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8QUCC8mxaAYBk9a7j4VTD2YmBLyr7XLPrPfEMJfXSE=;
        b=tup1wFMbvakkTjPy7KcBxSJQA6+luz2rt2P0ClLVOMHKFv6y5MkFLrpsz8JcpsmYS7
         aUDC3FO4NrWo4BKP1VhtYGYqw0QGTfzU/RjiXqos/Wbl3kZHQeA73DGEk6DwWc2Wkz81
         8Vei0VSmimzHmAw3kkU359ZnU6iPSzmJwiYtJvSKGgaV5iB5+/z+sIkdHT1IezFZUb1q
         Etzf+l9HNtFeUV5LSgs5ksGuVDuCaAIy2dNiIcmHGqXnGYGWZqYofGUAzfYewtINmfV4
         OASKUN27nBC5Ny/Mt/PLnWVsGQIunrO4Uw0Ss8lSuvCaMU0EaZEfyDJg7kjneGymOYKf
         YRsg==
X-Gm-Message-State: AOJu0YxmaDrApmqXn1AG/3xFeLMwitqt09/i9Gyp4g9lAVsY2O2JEiew
	MNFWJrQCPKOHOxiUR+p5zgwM/2BZ6bhC9W92vE+j7Moo3IPpdKlte0ECM3rDlUnuh7B7ajOS+UW
	nUyv3wpvs/fz1mqpVqSQIEOt60tDCz15xjZFQFA==
X-Google-Smtp-Source: AGHT+IHMF9jA2tNnrgpg+GOHbhcFMUcNlosZdvmduCi5ermtTKqbkzvQ64jyco/nTt46T/fJWnSt6/5J7Zh94ctVnIA=
X-Received: by 2002:a05:6214:2a4e:b0:685:cf86:45eb with SMTP id
 jf14-20020a0562142a4e00b00685cf8645ebmr6633834qvb.104.1706519918653; Mon, 29
 Jan 2024 01:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-3-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-3-andre.draszik@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 29 Jan 2024 09:18:27 +0000
Message-ID: <CADrjBPox_NDkq+-XxX5cuxAhYDubMHnqjnpwj4+76_A=izuhjw@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: clock: google,gs101-clock: add PERIC1
 clock management unit
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

On Sat, 27 Jan 2024 at 00:19, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Add dt-schema documentation and clock IDs for the Connectivity
> Peripheral 1 (PERIC1) clock management unit.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Thanks for working on these regexes! That should make enabling more
clock units and other Exynos SoCs a bit easier.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> Note for future reference: To ensure consistent naming throughout this
> file, the IDs have been derived from the data sheet using the
> following, with the expectation for all future additions to this file
> to use the same:
>     sed \
>         -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|CLK_FOUT_\1_PLL|' \
>         \
>         -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_|CLK_MOUT_\1_|' \
>         -e 's|^PLL_CON0_PLL_\(.*\)|CLK_MOUT_PLL_\1|' \
>         -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|CLK_MOUT_\1|' \
>         -e '/^PLL_CON[1-4]_[^_]\+_/d' \
>         -e '/^[^_]\+_CMU_[^_]\+_CONTROLLER_OPTION/d' \
>         -e '/^CLKOUT_CON_BLK_[^_]\+_CMU_[^_]\+_CLKOUT0/d' \
>         \
>         -e 's|_IPCLKPORT||' \
>         -e 's|_RSTNSYNC||' \
>         \
>         -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_|CLK_DOUT_\1_|' \
>         \
>         -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_GOUT_[^_]\+_[^_]\+_CMU_\([^_]\+\)_PCLK$|CLK_GOUT_\1_PC=
LK|' \
>         -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|CLK_GOUT_\1_CLK_\1_\2|' =
\
>         \
>         -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
> ---
>  .../bindings/clock/google,gs101-clock.yaml    |  9 ++--
>  include/dt-bindings/clock/google,gs101.h      | 48 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.y=
aml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> index 03698cdecf7a..1d2bcea41c85 100644
> --- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> @@ -31,6 +31,7 @@ properties:
>        - google,gs101-cmu-apm
>        - google,gs101-cmu-misc
>        - google,gs101-cmu-peric0
> +      - google,gs101-cmu-peric1
>
>    clocks:
>      minItems: 1
> @@ -93,15 +94,17 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: google,gs101-cmu-peric0
> +            enum:
> +              - google,gs101-cmu-peric0
> +              - google,gs101-cmu-peric1
>
>      then:
>        properties:
>          clocks:
>            items:
>              - description: External reference clock (24.576 MHz)
> -            - description: Connectivity Peripheral 0 bus clock (from CMU=
_TOP)
> -            - description: Connectivity Peripheral 0 IP clock (from CMU_=
TOP)
> +            - description: Connectivity Peripheral 0/1 bus clock (from C=
MU_TOP)
> +            - description: Connectivity Peripheral 0/1 IP clock (from CM=
U_TOP)
>
>          clock-names:
>            items:
> diff --git a/include/dt-bindings/clock/google,gs101.h b/include/dt-bindin=
gs/clock/google,gs101.h
> index 64e6bdc6359c..3dac3577788a 100644
> --- a/include/dt-bindings/clock/google,gs101.h
> +++ b/include/dt-bindings/clock/google,gs101.h
> @@ -470,4 +470,52 @@
>  #define CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK                78
>  #define CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK             79
>
> +/* CMU_PERIC1 */
> +#define CLK_MOUT_PERIC1_BUS_USER                       1
> +#define CLK_MOUT_PERIC1_I3C_USER                       2
> +#define CLK_MOUT_PERIC1_USI0_USI_USER                  3
> +#define CLK_MOUT_PERIC1_USI10_USI_USER                 4
> +#define CLK_MOUT_PERIC1_USI11_USI_USER                 5
> +#define CLK_MOUT_PERIC1_USI12_USI_USER                 6
> +#define CLK_MOUT_PERIC1_USI13_USI_USER                 7
> +#define CLK_MOUT_PERIC1_USI9_USI_USER                  8
> +#define CLK_DOUT_PERIC1_I3C                            9
> +#define CLK_DOUT_PERIC1_USI0_USI                       10
> +#define CLK_DOUT_PERIC1_USI10_USI                      11
> +#define CLK_DOUT_PERIC1_USI11_USI                      12
> +#define CLK_DOUT_PERIC1_USI12_USI                      13
> +#define CLK_DOUT_PERIC1_USI13_USI                      14
> +#define CLK_DOUT_PERIC1_USI9_USI                       15
> +#define CLK_GOUT_PERIC1_IP                             16
> +#define CLK_GOUT_PERIC1_PCLK                           17
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_I3C_CLK             18
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_OSCCLK_CLK          19
> +#define CLK_GOUT_PERIC1_D_TZPC_PERIC1_PCLK             20
> +#define CLK_GOUT_PERIC1_GPC_PERIC1_PCLK                        21
> +#define CLK_GOUT_PERIC1_GPIO_PERIC1_PCLK               22
> +#define CLK_GOUT_PERIC1_LHM_AXI_P_PERIC1_I_CLK         23
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1            24
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2            25
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3            26
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4            27
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5            28
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6            29
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_8            30
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_1             31
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_15            32
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_2             33
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_3             34
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_4             35
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5             36
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_6             37
> +#define CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_8             38
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_BUSP_CLK            39
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_USI0_USI_CLK                40
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_USI10_USI_CLK       41
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_USI11_USI_CLK       42
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_USI12_USI_CLK       43
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_USI13_USI_CLK       44
> +#define CLK_GOUT_PERIC1_CLK_PERIC1_USI9_USI_CLK                45
> +#define CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK             46
> +
>  #endif /* _DT_BINDINGS_CLOCK_GOOGLE_GS101_H */
> --
> 2.43.0.429.g432eaa2c6b-goog
>

