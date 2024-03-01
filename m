Return-Path: <linux-kernel+bounces-87767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9086D8B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E3284C67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FCC2B9DE;
	Fri,  1 Mar 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiOYsPfa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE32B9B9;
	Fri,  1 Mar 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256165; cv=none; b=a4r4Z8mVimmWg68+ApERYI3bvGAhajlBqZeZNq1SIBZMDWlDqRbmIkz2t95n549wlQYQwhV0cgCfXv+JuP6CpcEvkTwSgMlHTnVSw6mdiz7eDvTZz+PzMPoRAI66p8ISv5wiHGC1x2cW1obtPjtR3MQc6bbeCNnPx9R1RrmPsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256165; c=relaxed/simple;
	bh=Oee51/suQ1XPnx1xnNg/uLW6h0O1NUHrmn4Zq4TJUTA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ZvKv+4145UnxF9zGBHFSW1W3ZOQAj8JCywty6UvU64zUdKy+UbSCa8KK1LcODxde8cDmkWN+qy1/DnO1ERPnWCZh/cYoJW71V7Yb/UvJ/y038+e5FeejYwooDkH7ZaLHmzELI8MFTsmRAGW/N64rMPY9vnDvVTiTNf1GOxdKvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiOYsPfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FCBC433C7;
	Fri,  1 Mar 2024 01:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256164;
	bh=Oee51/suQ1XPnx1xnNg/uLW6h0O1NUHrmn4Zq4TJUTA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QiOYsPfa02DeluqZmfBpByGi6OJyt+mmB5tzn/xV8/Lz+biLAHDCwu+8cAPwLnzoy
	 +BizdOR3mQLv+cPQLomp1VZgOYyqaizYDOBoofmmbcD/e2zTgksewypcIcc4I6o3bG
	 zdqVbSVG1KcuFIui4o5fxz6tSa7Wf6hAMoDELe9TOsBebQ9e4Z9ZGxCtzeOL/MsdUs
	 +fDx042osRa2rN8kbl4BnTGIaVYI16qTItE3ZsmK8BCLmxP00v50Wuc7sMMLaN3BV6
	 Ti+CoC4Q4SX8ty9/ZIuQlYc6vEn1wEIGS6Hf1gSOHEGnSlHVKpS+HYzYgSVLf63c1d
	 dED2W+YqmCHGQ==
Message-ID: <856febae4f00b1129f695cf3c75dd380.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <365f9a90.55b0.18df5394935.Coremail.duoming@zju.edu.cn>
References: <20240229122250.24786-1-duoming@zju.edu.cn> <2b274111-e65a-4b99-8f07-220324f1e214@amd.com> <365f9a90.55b0.18df5394935.Coremail.duoming@zju.edu.cn>
Subject: Re: [PATCH v2] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, mturquette@baylibre.com
To: Michal Simek <michal.simek@amd.com>, duoming@zju.edu.cn
Date: Thu, 29 Feb 2024 17:22:42 -0800
User-Agent: alot/0.10

Quoting duoming@zju.edu.cn (2024-02-29 06:16:28)
> On Thu, 29 Feb 2024 13:45:54 +0100 Michal Simek wrote:
>=20
> The length of "mio_clk_00x" is 11 bytes, and the kernel will alloc 16 byt=
es to it.
> I use a local variable whose size is 16 bytes to replace it. The detail i=
s shown
> below:
>=20
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 7bdeaff2bfd..81d530e3357 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -215,7 +215,7 @@ static void __init zynq_clk_setup(struct device_node =
*np)
>         int i;
>         u32 tmp;
>         int ret;
> -       char *clk_name;
> +       char clk_name[16];
>         unsigned int fclk_enable =3D 0;
>         const char *clk_output_name[clk_max];
>         const char *cpu_parents[4];
> @@ -427,7 +427,6 @@ static void __init zynq_clk_setup(struct device_node =
*np)
>                         SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
>=20
>         tmp =3D strlen("mio_clk_00x");

Is tmp used now?

> -       clk_name =3D kmalloc(tmp, GFP_KERNEL);
>         for (i =3D 0; i < NUM_MIO_PINS; i++) {
>                 int idx;
>=20
> @@ -439,7 +438,6 @@ static void __init zynq_clk_setup(struct device_node =
*np)
>                 else
>                         can_mio_mux_parents[i] =3D dummy_nm;
>         }
> -       kfree(clk_name);
>         clk_register_mux(NULL, "can_mux", periph_parents, 4,
>                         CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2=
, 0,
>                         &canclk_lock);
>=20
> Do you think the above is better?
>=20

It's getting there.

