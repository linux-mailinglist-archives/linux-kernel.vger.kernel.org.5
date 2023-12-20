Return-Path: <linux-kernel+bounces-7407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC681A77A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6F5287321
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4CF487AF;
	Wed, 20 Dec 2023 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYCEt0zb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F947771;
	Wed, 20 Dec 2023 20:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BD5C433C9;
	Wed, 20 Dec 2023 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703102741;
	bh=4Na6zHOF3IuiCd92bkpwf7VYHr722ENTcJQapD0mvbI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GYCEt0zbeTjsCwTyUEClYJa+WEHAfzX5NHOgLwDmBrNkFf4NoxSX5rDb0ErBRwuYD
	 B+kwSxTjp4m7890M4CfzAaAuYDGbvUZygPGFtxe/s/v9iCUvHB6t9eQtXcqXP9EJVg
	 o68t5tufAT2VaRce+2PL3spq5BIGez4rNf8qdcskBLLtUT8/XqkAI1a9coMQd5R3vX
	 mX+t6ChBiK6dLC5A9o09V9giirFqH0DNHmF3m1fu72qBIpFqyMwp5lWE48QUCBEtEY
	 ju+YaJ1H7jLRtuFTAVFgV48WabEeYq1gMa5JLsaWn8bUAaHgjqysCDKF+yfHr3CoJY
	 fJyhzkoiUOXSw==
Message-ID: <ba20c2000c5c37c14c03b94f208b2961.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231124151847.1915-3-ansuelsmth@gmail.com>
References: <20231124151847.1915-1-ansuelsmth@gmail.com> <20231124151847.1915-3-ansuelsmth@gmail.com>
Subject: Re: [PATCH v7 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
From: Stephen Boyd <sboyd@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 20 Dec 2023 12:05:39 -0800
User-Agent: alot/0.10

Quoting Christian Marangi (2023-11-24 07:18:46)
> Some RCG frequency can be reached by multiple configuration.
>=20
> Add clk_rcg2_fm_ops ops to support these special RCG configurations.
>=20
> These alternative ops will select the frequency using a CEIL policy.
>=20
> When the correct frequency is found, the correct config is selected by
> calculating the final rate (by checking the defined parent and values
> in the config that is being checked) and deciding based on the one that
> is less different than the requested one.
>=20
> These check are skipped if there is just on config for the requested

s/on/one/

> freq.
>=20
> qcom_find_freq_multi is added to search the freq with the new struct
> freq_multi_tbl.
> __clk_rcg2_select_conf is used to select the correct conf by simulating
> the final clock.
> If a conf can't be found due to parent not reachable, a WARN is printed
> and -EINVAL is returned.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
[...]
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e22baf3a7112..2393c7df0402 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -266,6 +266,115 @@ static int _freq_tbl_determine_rate(struct clk_hw *=
hw, const struct freq_tbl *f,
>         return 0;
>  }
> =20
> +static const struct freq_conf *
> +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> +                      unsigned long req_rate)
> +{
> +       unsigned long rate_diff, best_rate_diff =3D ULONG_MAX;
> +       const struct freq_conf *conf, *best_conf =3D NULL;
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       const char *name =3D clk_hw_get_name(hw);
> +       unsigned long parent_rate, rate;
> +       struct clk_hw *p;
> +       int index, i;
> +
> +       /* Exit early if only one config is defined */
> +       if (f->num_confs =3D=3D 1) {
> +               best_conf =3D f->confs;
> +               goto exit;
> +       }
> +
> +       /* Search in each provided config the one that is near the wanted=
 rate */
> +       for (i =3D 0, conf =3D f->confs; i < f->num_confs; i++, conf++) {
> +               index =3D qcom_find_src_index(hw, rcg->parent_map, conf->=
src);
> +               if (index < 0)
> +                       continue;
> +
> +               p =3D clk_hw_get_parent_by_index(hw, index);
> +               if (!p)
> +                       continue;
> +
> +               parent_rate =3D  clk_hw_get_rate(p);
> +               rate =3D calc_rate(parent_rate, conf->n, conf->m, conf->n=
, conf->pre_div);
> +
> +               if (rate =3D=3D req_rate) {
> +                       best_conf =3D conf;
> +                       goto exit;
> +               }
> +
> +               rate_diff =3D abs(req_rate - rate);

Use abs_diff() please.

> +               if (rate_diff < best_rate_diff) {
> +                       best_rate_diff =3D rate_diff;
> +                       best_conf =3D conf;
> +               }
> +       }
> +
> +       /*
> +        * Very unlikely. Warn if we couldn't find a correct config
> +        * due to parent not found in every config.
> +        */
> +       if (unlikely(!best_conf)) {
> +               WARN(1, "%s: can't find a configuration for rate %lu.",

Needs a newline in the format string and should drop the period.

> +                    name, req_rate);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +exit:
> +       return best_conf;
> +}
> +
[...]
> +
>  static int clk_rcg2_determine_rate(struct clk_hw *hw,
>                                    struct clk_rate_request *req)
>  {
> @@ -377,6 +494,30 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, un=
signed long rate,
>         return clk_rcg2_configure(rcg, f);
>  }
> =20
> +static int __clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       const struct freq_multi_tbl *f;
> +       const struct freq_conf *conf;
> +       struct freq_tbl f_tbl;

		f_tbl =3D { }

In case we want to add more fields so this isn't a time bomb.

> +
> +       f =3D qcom_find_freq_multi(rcg->freq_multi_tbl, rate);
> +       if (!f || !f->confs)
> +               return -EINVAL;
> +
> +       conf =3D __clk_rcg2_select_conf(hw, f, rate);
> +       if (IS_ERR(conf))
> +               return PTR_ERR(conf);
> +
> +       f_tbl.freq =3D f->freq;
> +       f_tbl.src =3D conf->src;
> +       f_tbl.pre_div =3D conf->pre_div;
> +       f_tbl.m =3D conf->m;
> +       f_tbl.n =3D conf->n;
> +
> +       return clk_rcg2_configure(rcg, &f_tbl);
> +}
> +
>  static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>                             unsigned long parent_rate)
>  {

