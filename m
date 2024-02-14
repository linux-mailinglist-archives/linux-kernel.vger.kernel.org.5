Return-Path: <linux-kernel+bounces-65429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718EE854CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1061B1F2306A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D28D5A4E1;
	Wed, 14 Feb 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REdAzMQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0C5A785;
	Wed, 14 Feb 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924694; cv=none; b=MFvqbo6pSMg8S0863aF/3Vbvje97KBgLQ2waBoVOsUY792ezqBtTcPjmU0nRK4UfOMVxeqMSmrWrzmlUuWkm7fFk5VmUjTI/k5K7Yk/0LoGrngiIh1SMPZNL/s/c0fjMh1A6WkqryNSRE9jcVqyFHRt2Kiib7jxWTMpEbRHplxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924694; c=relaxed/simple;
	bh=4JlFA01oQWdtvRaP+CnWQqdwr1cP142uEyw13TLrbN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iooSc41YuovBKrAWcpe5NxXMN+UGZZt8xbzAZqWoVjtT1YVpzUXbGLjObYUNxdfUUY433Fxnxqhpulyo3xscGdKn7UB6/pWnWfIvrxNr6YGyHCKYYGXoNcWlzKHeRtSyqf1khXs0bnrvNyPjOvdx6Til1Go9gwByB+xL7+nfVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REdAzMQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD5EC433F1;
	Wed, 14 Feb 2024 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707924694;
	bh=4JlFA01oQWdtvRaP+CnWQqdwr1cP142uEyw13TLrbN8=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=REdAzMQNUKQthunqIYd1xXRZvyRazfzeeHO6U9IdkqpQocmGPZO0MqL1dce3y5y1b
	 PFeEIPsWTolML15+QzASJcdeWR5n3IAnWbJf7gcLrasH+H8HI8o4G8CRjOmNuEAXXZ
	 JPJN0CaZp3PLCjJjy61EfrhMHYHUHlJL+wd+mTzJYfZGvX6odSfmQZTFtUVb0aybMe
	 ViowSODx6riqYuR9wKjBYsEm3o3VxzwN8Mp3sn9zRKC3cerkcEYU/VGXs0MoG5uQuI
	 g6xuLSibBrZHt98G3dsRPMywRLrzlLMAc3Dp44/uxlOpcqrH3cKuiu41UkhGcoS0W2
	 /cPQAX+TUIULg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3cfacf0eadso225218566b.2;
        Wed, 14 Feb 2024 07:31:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGZNJGMmjKejeaWtBosHD6k7Pgafh0XZkZ+/U5iT1VkDgyC/B7rIXKZVDybI3pEzqNX4qgThnsOMAkFxMhfuzZo/UtfiiQrEyorHlnwLSAwuSMuRxR4AZarrF09dqIPysEI+dYB6sxCTcJyFQ6Lf8MiYIxGbSviuhriTBmzoBFjmRFk6r/xYfMEoLXS1JcDXLqRHFRXr3ZNxCvI5Hl4d4DUkV87l/TLcecTy7lChLB1mRIqoJ6AMKe5t/2DzMWW6iV7isLJLIIZ7SwljsmLqVcJDnmEePBuqanmaO2zBUS2mZDljAnV4UoBpWm1LvovmoMCZI3l027MbXp/CNfG49BcQ==
X-Gm-Message-State: AOJu0YxjGyedI+X5FA64Q7slzCo4wsTnjRstdIYdhMdtcYScwc847O56
	DR3UjafFsvfE5ZThTJFfBrDlKOs9nVUjCTcE9TA8vPROFN55gVaaaXsJTkvifZPB03nYTIQHzFq
	7HZ5Plg9IMnDNHgRlRaAUycx2Gw==
X-Google-Smtp-Source: AGHT+IH8/isML9jhNTe8vUWU49jrNm4p0HUKpD8NeE7Izp0zgWowWPvoVR9vvZmOadC5fdJrnpVWN3J0XGbdjt6xmGE=
X-Received: by 2002:a2e:b888:0:b0:2d0:dfad:2863 with SMTP id
 r8-20020a2eb888000000b002d0dfad2863mr2522106ljp.46.1707924672118; Wed, 14 Feb
 2024 07:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org> <CAMuHMdWgvD9szXksK+jzyvwLQ8ufWWf1TPQ7s-5z4JWgrvXmkg@mail.gmail.com>
In-Reply-To: <CAMuHMdWgvD9szXksK+jzyvwLQ8ufWWf1TPQ7s-5z4JWgrvXmkg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 14 Feb 2024 15:30:57 +0000
X-Gmail-Original-Message-ID: <CAL_JsqKbDdUzkuSBrBTYm0PF8KehK0DnUwTBHqJ6tZfaE=B2_w@mail.gmail.com>
Message-ID: <CAL_JsqKbDdUzkuSBrBTYm0PF8KehK0DnUwTBHqJ6tZfaE=B2_w@mail.gmail.com>
Subject: Re: [PATCH 0/6] dts: Fix dtc interrupt warnings
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: soc@kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <atenart@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
	Tony Lindgren <tony@atomide.com>, Chanho Min <chanho.min@lge.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Imre Kaloz <kaloz@openwrt.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:01=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> On Tue, Feb 13, 2024 at 8:35=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > I had a branch with most of these changes sitting in my tree for some
> > time. Geert's asking about some errors not getting found prompted me to
> > clean it up and send it out. This series fixes all* interrupt related
> > warnings and enables the check by default.
>
> > *There's a few Renesas warnings still Geert said he would fix.
>
> Thanks, fix sent
> https://lore.kernel.org/r/a351e503ea97fb1af68395843f513925ff1bdf26.170792=
2460.git.geert+renesas@glider.be
>
> >       dtc: Enable dtc interrupt_provider check
>
> >  scripts/Makefile.lib                                  |  3 +--
>
> Just wondering, can the remaining disabler be removed, too?
>
> Documentation/devicetree/bindings/Makefile:     -Wno-interrupt_provider \

I was too. Shockingly, that too will require some fixes. Though I
remember when configuring the warnings for bindings, trying to make
them stricter. So there must have been some case where
no-interrupt_provider was needed. It may have been related to how we
parse interrupts in examples, but that changed back when switching to
validate dtbs directly.

Rob

