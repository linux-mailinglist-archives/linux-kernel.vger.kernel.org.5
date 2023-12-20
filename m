Return-Path: <linux-kernel+bounces-6453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F681991C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA2B25C34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6D14F98;
	Wed, 20 Dec 2023 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="MDcUmSB4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44917732;
	Wed, 20 Dec 2023 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Sw4R8464Sz9spg;
	Wed, 20 Dec 2023 08:08:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1703056116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpZoNtkkDCmi/GIcUCtUwUBihXR4v8Tro3usQTKcxlk=;
	b=MDcUmSB4S9LKW4ZTc+NtSRMKxUEdcUnY0wn6l44qvlbFTTroJ8WZz5Qv8ECcVX6DcWjZEB
	jQ3/re3xsmLKWlT56zs7kSvnpxqaGqUyTpFPXRYcHlxzWtOpgwLi842VLkgNnvurZyx3u/
	pU8yvY2kHZV45dGMVHz4hRINvsyVJ0sWMFDjlDz9We995sS9ko94Wzrbqf0Zguf4yeuezP
	Dp+RlKPjalQPUv2yalY2J3y9A07U/nS5YMDRzud4jdtIzGnBAI065q5SH+W7caLMt6wG06
	yZODhREY6WZtsf7PhjmuFdeVjEA7uEAzTtE1kr3gkp/S35umgtp6o59UeK4Dkg==
References: <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-1-e238b6ed6dc1@oltmanns.dev>
 <5736273.DvuYhMxLoT@jernej-laptop>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
 <samuel@sholland.org>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team
 <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/5] clk: sunxi-ng: nkm: Support constraints on m/n
 ratio and parent rate
Date: Wed, 20 Dec 2023 07:58:07 +0100
In-reply-to: <5736273.DvuYhMxLoT@jernej-laptop>
Message-ID: <87msu59wrc.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jernej!

On 2023-12-19 at 17:46:08 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmail.=
com> wrote:
> Hi Frank!
>
> Dne ponedeljek, 18. december 2023 ob 14:35:19 CET je Frank Oltmanns napis=
al(a):
>> The Allwinner A64 manual lists the following constraints for the
>> PLL-MIPI clock:
>>  - M/N >=3D 3
>
> This should be "<=3D"

Yes, good catch! I will fix it in V2.

>
>>  - (PLL_VIDEO0)/M >=3D 24MHz
>>
>> The PLL-MIPI clock is implemented as ccu_nkm. Therefore, add support for
>> these constraints.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 23 +++++++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu_nkm.h |  8 ++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_n=
km.c
>> index eed64547ad42..2af5c1ebd527 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -16,6 +16,20 @@ struct _ccu_nkm {
>>  	unsigned long	m, min_m, max_m;
>>  };
>>
>> +static bool ccu_nkm_is_valid_rate(struct ccu_common *common, unsigned l=
ong parent,
>> +				  unsigned long n, unsigned long m)
>> +{
>> +	struct ccu_nkm *nkm =3D container_of(common, struct ccu_nkm, common);
>> +
>> +	if (nkm->max_mn_ratio && (m > nkm->max_mn_ratio * n))
>> +		return false;
>> +
>> +	if (nkm->parent_wo_nk && (parent < nkm->parent_wo_nk * m))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_commo=
n *common,
>>  						       struct clk_hw *parent_hw,
>>  						       unsigned long *parent, unsigned long rate,
>> @@ -32,6 +46,9 @@ static unsigned long ccu_nkm_find_best_with_parent_adj=
(struct ccu_common *common
>>
>>  				tmp_parent =3D clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
>>
>> +				if (!ccu_nkm_is_valid_rate(common, tmp_parent, _n, _m))
>> +					continue;
>> +
>>  				tmp_rate =3D tmp_parent * _n * _k / _m;
>>
>>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
>> @@ -65,6 +82,12 @@ static unsigned long ccu_nkm_find_best(unsigned long =
parent, unsigned long rate,
>>  	for (_k =3D nkm->min_k; _k <=3D nkm->max_k; _k++) {
>>  		for (_n =3D nkm->min_n; _n <=3D nkm->max_n; _n++) {
>>  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
>> +				if ((common->reg =3D=3D 0x040) && (_m > 3 * _n))
>> +					break;
>> +
>> +				if ((common->reg =3D=3D 0x040) && (parent < 24000000 * _m))
>> +					continue;
>> +
>
> You already figured this part.
>
>>  				unsigned long tmp_rate;
>>
>>  				tmp_rate =3D parent * _n * _k / _m;
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_n=
km.h
>> index 6601defb3f38..d3d3eaf55faf 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
>> @@ -16,6 +16,12 @@
>>   * struct ccu_nkm - Definition of an N-K-M clock
>>   *
>>   * Clocks based on the formula parent * N * K / M
>> + *
>> + * @max_mn_ratio:	Maximum value for M / N.
>> + * @parent_wo_nk:	The minimum rate the parent must provide after applyi=
ng the divisor,
>> + *			but without applying the multipliers, i.e. the contstraint
>> + *			   (parent rate)/M >=3D parent_wo_nk
>> + *			must be fulfilled.
>>   */
>>  struct ccu_nkm {
>>  	u32			enable;
>> @@ -27,6 +33,8 @@ struct ccu_nkm {
>>  	struct ccu_mux_internal	mux;
>>
>>  	unsigned int		fixed_post_div;
>> +	unsigned long		max_mn_ratio;
>> +	unsigned long           parent_wo_nk;
>
> What about max_m_n_ratio and max_parent_m_ratio, to be consistent? This
> should also allow to simplify description.

Jernej, thank you so much! This is brilliant! I was racking my brain for
a good name but failed. Now, that I see your proposal, I don't know why
I hadn't come up with it. It's the obvious choice.

I'd say with the new names we should be able to get rid of the comments
describing the new struct members (also in ccu_nm.h). What are your
thoughts on that?

Best regards,
  Frank

>
> Best regards,
> Jernej
>
>>
>>  	struct ccu_common	common;
>>  };
>>
>>

