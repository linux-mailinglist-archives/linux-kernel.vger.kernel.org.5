Return-Path: <linux-kernel+bounces-75950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7E85F10E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5EE1C2127D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F8168BD;
	Thu, 22 Feb 2024 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHliQxYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761BD15EB0;
	Thu, 22 Feb 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580657; cv=none; b=VMMUPcBQFYwnaB/I/nre6t2DVxlT7Cis4/dr2Due6X7THGUcUKrr6lfbsLRxZWDrgjVXqIEmJhwt6L3sJvLxXhWC5Lievp4X7T/wEbXSuLaZBlmCGzcApum8siXX2giE4G3xFYuSypyS+QI7orIcBmQSzAszTGFz7hNzZr+xCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580657; c=relaxed/simple;
	bh=EoK1x3aOU4KJEXAJZ+xJQ2/KF+ApDpnlxBCrJBs7IDA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mID7hZdK9THopGcxNS28GYf4JNoZeFWw1j9OoTrEfnnpqfg19ymSzGZQNu21EMNZeP5Bkrk06C0vdfEDkCjs7obE+rwjW7r9rG5XC9r7ZUKR6qgQwMc+IAcPPUY3yT0hyzfwKpnyRbxicoov00WCxX40m0g3XGn1KPRl2aKocxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHliQxYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA1DC433B1;
	Thu, 22 Feb 2024 05:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708580657;
	bh=EoK1x3aOU4KJEXAJZ+xJQ2/KF+ApDpnlxBCrJBs7IDA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SHliQxYtc3GAHDCZrE6/bnd/TwGUUVslEgbgQID/TSKeNsFWQ/cDA3VlhWj8r2cF4
	 ckru0rEbjgYXo8sv7c9YfAX1wdfMUdbKVQIcvmxO9C551bX6KsCxvd1falGRYAXTNN
	 EoYR/uOHKe4t+A4LsvJv259Hq8JZZpIF8eEvWSqXR39vqMr4jUJvP+YFAjC3cOJ+Nc
	 AWe7mXTZJfdtPAe+lrTGCBy+6Tp7SjBOcFmPS/SGjrr0G0kzDUrKSap/GX0tNzTSMZ
	 LoF3PVg+tj7haBr2C5ux08x3ItGcPgSWhK8QwBG64J6EC+B31vkDvxtfAQau85I+Ww
	 5LWslA7+hqnBg==
Message-ID: <500e265eb7c6a03a40e0067c8806e059.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240214183006.3403207-7-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com> <20240214183006.3403207-7-cristian.marussi@arm.com>
Subject: Re: [PATCH 6/7] clk: scmi: Allocate CLK operations dynamically
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, Cristian Marussi <cristian.marussi@arm.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2024 21:44:14 -0800
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-02-14 10:30:05)
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 5747b6d651f0..b91a0dbd2fe0 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -158,51 +158,6 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw =
*hw)
>         return !!enabled;
>  }
> =20
> -/*
> - * We can provide enable/disable/is_enabled atomic callbacks only if the
> - * underlying SCMI transport for an SCMI instance is configured to handle
> - * SCMI commands in an atomic manner.
> - *
> - * When no SCMI atomic transport support is available we instead provide=
 only
> - * the prepare/unprepare API, as allowed by the clock framework when ato=
mic
> - * calls are not available.
> - *
> - * Two distinct sets of clk_ops are provided since we could have multipl=
e SCMI
> - * instances with different underlying transport quality, so they cannot=
 be
> - * shared.
> - */
> -static const struct clk_ops scmi_clk_ops =3D {
> -       .recalc_rate =3D scmi_clk_recalc_rate,
> -       .round_rate =3D scmi_clk_round_rate,
> -       .set_rate =3D scmi_clk_set_rate,
> -       .prepare =3D scmi_clk_enable,
> -       .unprepare =3D scmi_clk_disable,
> -       .set_parent =3D scmi_clk_set_parent,
> -       .get_parent =3D scmi_clk_get_parent,
> -       .determine_rate =3D scmi_clk_determine_rate,
> -};
> -
> -static const struct clk_ops scmi_atomic_clk_ops =3D {

It's not great to move these function pointer structs out of RO memory
to RW. I'm also not convinced that it's any better to construct them at
runtime. Isn't there a constant set of possible clk configurations? Or
why can't we simply add some failures to the clk_ops functions instead?

> -       .recalc_rate =3D scmi_clk_recalc_rate,
> -       .round_rate =3D scmi_clk_round_rate,
> -       .set_rate =3D scmi_clk_set_rate,
> -       .enable =3D scmi_clk_atomic_enable,
> -       .disable =3D scmi_clk_atomic_disable,
> -       .is_enabled =3D scmi_clk_atomic_is_enabled,

