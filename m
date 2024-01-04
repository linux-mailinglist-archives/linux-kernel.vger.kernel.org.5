Return-Path: <linux-kernel+bounces-17248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2748824A64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392691F2555E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1F2C84B;
	Thu,  4 Jan 2024 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB32WZeX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330D2C681;
	Thu,  4 Jan 2024 21:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD073C433C7;
	Thu,  4 Jan 2024 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704404204;
	bh=/gPJhI0luavzDAMUU3piZFqDvBPXXQmqih0y6CbPkDo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZB32WZeXi9pWrXUs4nFLQOKWQKvgsLCPhg8HTDvMQhFsZ49JD/Jw1deYXZPm3o/SX
	 x52TbzbuJ7w7zaPewansJqg+zHb8lttmaWATUuJ4SzSl2jH0rDh8pyJ0iU5ZL7JpUG
	 vFdiAbo3/Wr0UkClMHKumsYsjy4P6fS5q0ps/1H+5gWzENdb1M7jhPF3lcCu88uGgd
	 +kSOVjghQwtXpWwsXrwqrQtKVeiA5ju118sbwaMmC//4Joihr8xYDaOi0xhWHdOMRH
	 S5Xl1Es0N99dCoAyn/X2I5yqMKsNE+B3EYqNsYzomPekVxXw++Ccp437MMTItRCG3i
	 3UMzW9jMRxsjA==
Message-ID: <988ae72846dc680382f98b63b61a8c32.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240104-sm8150-dfs-support-v1-1-a5eebfdc1b12@quicinc.com>
References: <20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com> <20240104-sm8150-dfs-support-v1-1-a5eebfdc1b12@quicinc.com>
Subject: Re: [PATCH 1/3] clk: qcom: gcc-sm8150: Register QUPv3 RCGs for DFS on SM8150
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Deepak Katragadda <dkatraga@codeaurora.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Date: Thu, 04 Jan 2024 13:36:41 -0800
User-Agent: alot/0.10

Quoting Satya Priya Kakitapalli (2024-01-04 06:23:04)
> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> index 05d115c52dfe..6d76fd344ddf 100644
> --- a/drivers/clk/qcom/gcc-sm8150.c
> +++ b/drivers/clk/qcom/gcc-sm8150.c
> @@ -453,19 +453,29 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s=
0_clk_src[] =3D {
>         { }
>  };
> =20
> +static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init =3D {

Can these be const?

> +       .name =3D "gcc_qupv3_wrap0_s0_clk_src",
> +       .parent_data =3D gcc_parents_0,
> +       .num_parents =3D ARRAY_SIZE(gcc_parents_0),
> +       .flags =3D CLK_SET_RATE_PARENT,
> +       .ops =3D &clk_rcg2_ops,
> +};
> +
>  static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src =3D {
>         .cmd_rcgr =3D 0x17148,
>         .mnd_width =3D 16,
>         .hid_width =3D 5,
>         .parent_map =3D gcc_parent_map_0,
>         .freq_tbl =3D ftbl_gcc_qupv3_wrap0_s0_clk_src,
> -       .clkr.hw.init =3D &(struct clk_init_data){
> -               .name =3D "gcc_qupv3_wrap0_s0_clk_src",
[...]
> @@ -3786,6 +3850,13 @@ static int gcc_sm8150_probe(struct platform_device=
 *pdev)
>         regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
>         regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> =20
> +       ret =3D qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
> +                                      ARRAY_SIZE(gcc_dfs_clocks));
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register with DFS!\n");

Use=20

		return dev_err_probe(...);

