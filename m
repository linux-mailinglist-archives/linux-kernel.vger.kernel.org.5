Return-Path: <linux-kernel+bounces-7838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1281AE12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7221F230DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097A8F48;
	Thu, 21 Dec 2023 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PudtbnkL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CBAD31;
	Thu, 21 Dec 2023 04:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA1DC433C8;
	Thu, 21 Dec 2023 04:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703133385;
	bh=Ye0z8hSnZkvGRVITl2wlNpanlqLTvzdlfbhdatzGoR4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PudtbnkLI0SC9Z0NDsUUSzMU0ipAjqo60oSzraQ7xsNN3sdgdBZAAUxAiLxBLQcxm
	 C3r9vtGIiK4fwmrQce1zVRLHaZD+6R1nASG367QBQV0YIgHS10p7UUpjKFcOP9fhuV
	 M0dPvCvdsLHf3kD/dx9weNUjr8R575aiZvYX27vMePLLepvRuWwrXz6BsR6fDcHTll
	 Lanq0JZV+JeXdzeAQRndBdLNx2P02z2ViR6g1fozSAe30hXvqka96EGodMSbJzaWYM
	 P+2XObkg0V6nk0JfnilGyuUV2PZLi6oaBTdKjRsZL59k89Nbsgf1GWNO+sYPOdVqPA
	 lHZkPIkJ7EDtQ==
Message-ID: <d0fe9a3302f8c367a26dd5b4b1b29c68.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231220-sa8295p-gpu-v1-2-d8cdf2257f97@quicinc.com>
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com> <20231220-sa8295p-gpu-v1-2-d8cdf2257f97@quicinc.com>
Subject: Re: [PATCH 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX handler
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bjorn Andersson <quic_bjorande@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, Ulf Hansson <ulf.hansson@linaro.org>, Will Deacon <will@kernel.org>
Date: Wed, 20 Dec 2023 20:36:23 -0800
User-Agent: alot/0.10

Quoting Bjorn Andersson (2023-12-20 19:50:36)
> The GX GDSC is modelled to aid the GMU in powering down the GPU in the
> event that the GPU crashes, so that it can be restarted again. But in
> the event that the power-domain is supplied through a dedicated
> regulator (in contrast to being a subdomin of another power-domain),
> something needs to turn that regulator on, both to make sure things are
> powered and to match the operation in gdsc_disable().
>=20
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/clk/qcom/gdsc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..d1139c895503 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -557,7 +557,13 @@ void gdsc_unregister(struct gdsc_desc *desc)
>   */
>  int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
>  {
> +       struct gdsc *sc =3D domain_to_gdsc(domain);
> +       int ret =3D 0;
> +
>         /* Do nothing but give genpd the impression that we were successf=
ul */

Update this comment.

> -       return 0;
> +       if (sc->rsupply)
> +               ret =3D regulator_enable(sc->rsupply);
> +
> +       return ret;
>  }

