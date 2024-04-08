Return-Path: <linux-kernel+bounces-134794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BEF89B6FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D10B20FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6FB6FB9;
	Mon,  8 Apr 2024 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t57GBb19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2F63AE;
	Mon,  8 Apr 2024 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712551129; cv=none; b=rLDdvNaajz6L5pp9bjXzHhY7H/rqHD/uU0yhw4SQTlukKpKadOCTKcIymeAtkd6YJtj/Fdfnxn+AvRQ3JqVJDunEDFWMaoDNJ1aum4l2BOS6MkP2BmqYMgWtYNZ+Vfr8w7dfgYUqGVG99aTVttS0Z0TnL4hGxQsFBLB4dVAtPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712551129; c=relaxed/simple;
	bh=jW0HOzZx0chmSo4CS4bYPAqUuVJL9YFJVxgudK72DAk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=njzYDA8egUimrJ+YOEWuocZBM5iKzET7tIKbPNEO/v36KcC2/kGup4jrUP/IDZ0glLeKs0SihLzqwDAPcmljj84r07jjxwwAEXHCDU4AhVFA7NBk5nMbmmJZc0nqoT96ZBCE7l9y3biGkS/S/SLGpgh1ViJ8Hu56Naugo6/ZD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t57GBb19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D03C433F1;
	Mon,  8 Apr 2024 04:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712551128;
	bh=jW0HOzZx0chmSo4CS4bYPAqUuVJL9YFJVxgudK72DAk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=t57GBb195OPD/sUJ2TG40eUgBFGHeRKNJpB7nX/Rhb/5ZhlKQwQe6PoqSVCqoe3jj
	 Akusy1fvhtQUzSgWXCl9ToFI6NyHJYz2JL0Gw0I3xn1LeggAIk5dKS3DMb8W9FkgQP
	 ZDCSGY5zUHXgb0tJlaPXjrobfjr4NuTuQVcRY7hm3yBoDd4rRWIzLNocsbnkSZP0an
	 ukZmRSPbB4yx6aF3vB/p7kN3zzhD4qzI8P5MdKXtyCXEqbMjoGeEvWD7K8IK7zCFFB
	 0KA8RqLjpNnqgMhUb++WlZfkC0n0cMTD6VKla/lvpgnC1jJxPF14pmCOqSUbb1LwzD
	 i2yTElggYFz5Q==
Message-ID: <7027a28723d2597d9f620f4e0e1da97e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240325210025.1448717-2-cristian.marussi@arm.com>
References: <20240325210025.1448717-1-cristian.marussi@arm.com> <20240325210025.1448717-2-cristian.marussi@arm.com>
Subject: Re: [PATCH v2 1/5] clk: scmi: Allocate CLK operations dynamically
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, mturquette@baylibre.com, Cristian Marussi <cristian.marussi@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 07 Apr 2024 21:38:46 -0700
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-03-25 14:00:21)
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 8cbe24789c24..d5d369b052bd 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -16,6 +16,14 @@
>  #define NOT_ATOMIC     false
>  #define ATOMIC         true
> =20
> +enum scmi_clk_feats {
> +       SCMI_CLK_ATOMIC_SUPPORTED,
> +       SCMI_CLK_MAX_FEATS
> +};
> +
> +#define SCMI_MAX_CLK_OPS       (1 << SCMI_CLK_MAX_FEATS)
> +
> +static const struct clk_ops *clk_ops_db[SCMI_MAX_CLK_OPS];

Can it be 'scmi_clk_ops_db' for some name spacing?

>  static const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
> =20
>  struct scmi_clk {
> @@ -230,6 +202,106 @@ static int scmi_clk_ops_init(struct device *dev, st=
ruct scmi_clk *sclk,
>         return ret;
>  }
> =20
> +/**
> + * scmi_clk_ops_alloc() - Alloc and configure clock operations
> + * @dev: A device reference for devres
> + * @feats_key: A bitmap representing the desired clk_ops capabilities.

Drop the period please because it's not consistent with the previous
argument descriptor.

> + *
> + * Allocate and configure a proper set of clock operations depending on =
the
> + * specifically required SCMI clock features.
> + *
> + * Return: A pointer to the allocated and configured clk_ops on Success,

Lowercase 'Success'.

> +
> +/**
> + * scmi_clk_ops_select() - Select a proper set of clock operations
> + * @sclk: A reference to an SCMI clock descriptor
> + * @atomic_capable: A flag to indicate if atomic mode is supported by the
> + *                 transport
> + * @atomic_threshold: Platform atomic threshold value

Is this in nanoseconds, microseconds, or ??? Maybe a better description is
"clk_ops are atomic when clk enable_latency is less than X [time unit]"=20

> + *
> + * After having built a bitmap descriptor to represent the set of featur=
es
> + * needed by this SCMI clock, at first use it to lookup into the set of
> + * previously allocated clk_ops to check if a suitable combination of cl=
ock
> + * operations was already created; when no match is found allocate a bra=
nd new
> + * set of clk_ops satisfying the required combination of features and sa=
ve it
> + * for future references.
> + *
> + * In this way only one set of clk_ops is ever created for each different
> + * combination that is effectively needed.
> + *
> + * Return: A pointer to the allocated and configured clk_ops on Success,=
 or

Lowercase 'Success'.

> + *        NULL otherwise.
> + */
> +static const struct clk_ops *
> +scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
> +                   unsigned int atomic_threshold)
> +{
> +       const struct scmi_clock_info *ci =3D sclk->info;
> +       unsigned int feats_key =3D 0;
> +       const struct clk_ops *ops;
> +
> +       /*
> +        * Note that when transport is atomic but SCMI protocol did not
> +        * specify (or support) an enable_latency associated with a
> +        * clock, we default to use atomic operations mode.
> +        */
> +       if (atomic_capable && ci->enable_latency <=3D atomic_threshold)
> +               feats_key |=3D BIT(SCMI_CLK_ATOMIC_SUPPORTED);
> +

Can we have a static_assert() here that makes sure 'feats_key' isn't
larger than the size of clk_ops_db?

	static_assert(ARRAY_SIZE(clk_ops_db) >=3D feats_key);

> +       /* Lookup previously allocated ops */
> +       ops =3D clk_ops_db[feats_key];
> +       if (!ops) {
> +               ops =3D scmi_clk_ops_alloc(sclk->dev, feats_key);
> +               if (!ops)
> +                       return NULL;

This could be less nested if the first lookup is put in
scmi_clk_ops_alloc() and the store below is folded in. Or an early
return if found.

	ops =3D clk_ops_db[feats_key];
	if (ops)
		return ops;

	/* Didn't find one */
	ops =3D scmi_clk_ops_alloc(...)
	if (!ops)
		return NULL;

	clk_ops_db[feats_key] =3D ops;
	return ops;
	=09
> +
> +               /* Store new ops combinations */
> +               clk_ops_db[feats_key] =3D ops;
> +       }
> +
> +       return ops;
> +}
> +
>  static int scmi_clocks_probe(struct scmi_device *sdev)
>  {
>         int idx, count, err;
> @@ -285,16 +357,10 @@ static int scmi_clocks_probe(struct scmi_device *sd=
ev)
>                 sclk->ph =3D ph;
>                 sclk->dev =3D dev;
> =20
> -               /*
> -                * Note that when transport is atomic but SCMI protocol d=
id not
> -                * specify (or support) an enable_latency associated with=
 a
> -                * clock, we default to use atomic operations mode.
> -                */
> -               if (is_atomic &&
> -                   sclk->info->enable_latency <=3D atomic_threshold)
> -                       scmi_ops =3D &scmi_atomic_clk_ops;
> -               else
> -                       scmi_ops =3D &scmi_clk_ops;
> +               scmi_ops =3D scmi_clk_ops_select(sclk, is_atomic,

'is_atomic' should probably be 'transport_is_atomic' so this reads
easier.

> +                                              atomic_threshold);
> +               if (!scmi_ops)
> +                       return -ENOMEM;
> =20
>                 /* Initialize clock parent data. */
>                 if (sclk->info->num_parents > 0) {

