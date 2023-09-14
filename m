Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86AA7A0AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjINQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbjINQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:20:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD411FC8;
        Thu, 14 Sep 2023 09:20:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B319BC433CA;
        Thu, 14 Sep 2023 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694708452;
        bh=Iz3OaOq7Jg3c1k6+q2I0zpdnqpko+95FwExIqjkenD0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=amWJ5kA7hssVaXF52M2JWRhuM24paxEfVHoyO8i16sRm1p6hKsaBklVQWnDFuqi4P
         1wwiUeNAPex238n8USkb1lB9ZAcWs6g4aUI7DoCibiyqAkV0yC6/qGnbVb/TOkygdY
         c4NEqUMAysIOELbbIbz8sly0D3eKpmTZhdmn6cLgXIhXKgzDKNEIDc9llQPOt1ufUM
         W+2G4kzWuVF34rQWA0wa+MyfWGovzAJlHEzkoDLb0sBKFNaaLPE8McmE7HdzqtXgRB
         QjRiP+rLsc+B2RT9LOARgp3ct8O6nrv56m5H6Bw5qTcNhWpjK7/6IYDVMvoADQO3G+
         IWllD+t5RBvVQ==
Message-ID: <539752971c7a61ce7a5deddc1478686a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230913175612.8685-1-danila@jiaxyga.com>
References: <20230913175612.8685-1-danila@jiaxyga.com>
Subject: Re: [PATCH] clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     danila@jiaxyga.com, adomerlee@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Danila Tikhonov <danila@jiaxyga.com>, agross@kernel.org,
        andersson@kernel.org, dkatraga@codeaurora.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        quic_tdas@quicinc.com, vkoul@kernel.org
Date:   Thu, 14 Sep 2023 09:20:50 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Danila Tikhonov (2023-09-13 10:56:11)
> Set .flags =3D CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
> didn't update its configuration" error.
>=20
> Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver =
for SM8150")
> Tested-by: Arseniy Velikanov <adomerlee@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/clk/qcom/gcc-sm8150.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> index 41ab210875fb..05d115c52dfe 100644
> --- a/drivers/clk/qcom/gcc-sm8150.c
> +++ b/drivers/clk/qcom/gcc-sm8150.c
> @@ -774,7 +774,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src =3D {
>                 .name =3D "gcc_sdcc2_apps_clk_src",
>                 .parent_data =3D gcc_parents_6,
>                 .num_parents =3D ARRAY_SIZE(gcc_parents_6),
> -               .flags =3D CLK_SET_RATE_PARENT,
> +               .flags =3D CLK_OPS_PARENT_ENABLE,
>                 .ops =3D &clk_rcg2_floor_ops,

In what case are we getting the rcg stuck? I thought that you could
write the rcg registers while the parent was off and switch to that
parent if the parent isn't enabled and it wouldn't get stuck.
