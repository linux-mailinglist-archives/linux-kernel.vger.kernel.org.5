Return-Path: <linux-kernel+bounces-102621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798287B4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30409284EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48625D460;
	Wed, 13 Mar 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOGnVL1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407459175;
	Wed, 13 Mar 2024 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370659; cv=none; b=S2rjINgwizo6Y+CZsofDH9rTgOu6ABUSOw2mBGt9bm8t8lwwledjOk4cwiHxfm9Hpin7M67MxtMhcV6arwr+8sVTJAMLRoReBGQd3PckLe/T7mk7r+p2n8//jBIzqkDTw+Ys/cBuNJauXkasWt470p6qysKrvD/bYAmnNcxJsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370659; c=relaxed/simple;
	bh=fhEKMDp9mGMZ7v7bPio8nfMLeshVTznOT/0NauTYUDY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=uUWXW4uvnBT1NXCDsCSefuZtmRwt1nlp5rooD3ti3a1E5dNYJrnFo1nawAkNwxnkz93R3RV6Jc2W5uRVSFekUzYq6H+p8E47Z6mWKeEvQZHElb1BabnDzaGWB8Urcocsg9B/sqTaH5eGJQAK2XHIqOaX02STmSSNIpWGyHsuZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOGnVL1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B495C433F1;
	Wed, 13 Mar 2024 22:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710370658;
	bh=fhEKMDp9mGMZ7v7bPio8nfMLeshVTznOT/0NauTYUDY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rOGnVL1HARPz334CSqeD1U/hcmfeFVCUSzsyrQONOhk9uuTXwqpI0QujUyKrHfOeA
	 LrGmEhGYoQvzPDaTnW1JDY0IVJD9cL22uq5Z2APjbpsZYb7+wgupyQQpj5bCc+vbSm
	 oEPs52em7h/MuXTFCJ4gDrLYq+RC0fM/bnihJejqCdZdMSRZkODqh1D/uOfPxRJ+ix
	 1Rtk0kbqXQcgopZEm01GAND6dLF3C+xO3guehBXW9qLshmFuJwaxX6rjoa2WPoVTNX
	 jIjwy40HpF/N4Fo7RGqpksYtQucksXgzaeEQyuKhf6WZh25PYFME5Dh11kjJr8/lBW
	 +ODmL7RuAJYhg==
Message-ID: <219f3eeba68fd0542d4954205c35bafa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
References: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Gabor Juhos <j4g8y7@gmail.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>
Date: Wed, 13 Mar 2024 15:57:36 -0700
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-03-11 08:06:36)
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-=
pll.c
> index 678b805f13d45..11f1ae59438f7 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -55,6 +55,24 @@ static struct clk_alpha_pll ipq_pll_huayra =3D {
>         },
>  };
> =20
> +static struct clk_alpha_pll ipq_pll_stromer =3D {
> +       .offset =3D 0x0,
> +       .regs =3D ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> +       .flags =3D SUPPORTS_DYNAMIC_UPDATE,
> +       .clkr =3D {
> +               .enable_reg =3D 0x0,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

const?

