Return-Path: <linux-kernel+bounces-138121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD4F89ECD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A09B2564B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1388313D500;
	Wed, 10 Apr 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFupmW7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8813D29E;
	Wed, 10 Apr 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735895; cv=none; b=PNwqSxobsYGAC3OGyGbddkUBkQq2ABu1mZWaHOfT0uWZd/BGOlcKvuBRFroEoX1vKBkwlhbc6AEbfp8AHO46bjGcjbW6TBwsIJqEDWDYmRcvkVfIqY0xzJwBIZOFhcVKjb41dxiJewxx1oeH5IVJAeDfpd8XoszvL/oiMObTlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735895; c=relaxed/simple;
	bh=K/eDjeU8Zri/YVQwV2qqe0Qm0px/fLneFb5gHVWAUxo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=GPb9s0pQNrXPLoP7LRITx38Z55dUL+XHkZi2OdcIHSgA+okh2+SPbIrU1ZY+oN3TwLYEweasw7iQ0wadaM1hq5kj+4BZ/1JOtm/sHlHLW9xs7CzXiRQyeiHWc4o5GvvXRJTZsASXvaENMURQ6OYxpHWvK0d87qbngqFJ2tgL344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFupmW7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDBC433C7;
	Wed, 10 Apr 2024 07:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712735894;
	bh=K/eDjeU8Zri/YVQwV2qqe0Qm0px/fLneFb5gHVWAUxo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bFupmW7Tlfsnv2qcx3KCImDyVWL/qCvyNMXXxmV16EXbhEDlOjSy/aTx1HPNnvwBJ
	 H0RSqWI31Fnv1gaZsQo9a4FQvHrUqKBZ0kG69NT6sSfjx8b3C2ZF+/AoDL5BkmSuGS
	 1iL+tHfz4Lj4uzZwblWR3k3ffJ4NB274arbgIdFRcp8aIJZ2XJ/4NuAhwNPceq5TeT
	 gvVkuCXzL2XbYKS+8i6utnWpuU7qZKYBS+CPXmKfGqAXfOBCHt0fhR1vUWR2u4h3AG
	 xJz4MKuRRQ66aOqWxpoQqze6Wo2RRA0LQDz43l/xDbjhPRQe4DzAqB9qYGIto54H57
	 q0DgaMBDq7t4Q==
Message-ID: <858299c27c63aa2974b169f9adf624e9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240410033148.213991-2-xingyu.wu@starfivetech.com>
References: <20240410033148.213991-1-xingyu.wu@starfivetech.com> <20240410033148.213991-2-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v4 1/2] clk: starfive: jh7110-sys: Add notifier for PLL clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
To: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Xingyu Wu <xingyu.wu@starfivetech.com>
Date: Wed, 10 Apr 2024 00:58:12 -0700
User-Agent: alot/0.10

Quoting Xingyu Wu (2024-04-09 20:31:47)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk=
/starfive/clk-starfive-jh7110-sys.c
> index 8f5e5abfa178..adf62e4d94e4 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -385,6 +385,32 @@ int jh7110_reset_controller_register(struct jh71x0_c=
lk_priv *priv,
>  }
>  EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
> =20
> +/*
> + * This clock notifier is called when the rate of PLL0 clock is to be ch=
ange,

s/change,/changed./

> + * The cpu_root clock should save curent parent clock and swicth its par=
ent

s/swicth/switch/

> + * clock to osc before PLL0 rate will be changed. And switch its parent =
clock
> + * back after PLL rate finished.

