Return-Path: <linux-kernel+bounces-64235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC272853C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F14C1F2848F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937061673;
	Tue, 13 Feb 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8z167fI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487B60872;
	Tue, 13 Feb 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857799; cv=none; b=fo1cv/fGj81U9bevWoFhYckXFrF6N9lHwTNLWUXiPexX9gmPAruhVWmtWWmRmY5THhwtSlocjnKkH8F1ovOMARBDY4NJsm2qM4fyuCLmb+g8onAsA01GCtwc0tar7+7fyfEvj6g8npr6lC8o5us1Mh0My9d7N0JTAtJhJzosKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857799; c=relaxed/simple;
	bh=D4LSaj+s1Zug+tnZej27exr9mIRN2BETmj/yUE3GRW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxZNvpX7MZqxVJmddaKS/aQuyAWfcVTDSK26tOaflWI7lFVEJZATT7oTbGpCPbiJryUIdHR0wRK4jSHpCgdLcgTE/d7yWsGcNNKZoUjoKRwXMy/k2uToCjTeqFsb8iLYZjXcH8pDx+WY8SQxn4cN6OERIcR0K6Wwx3nT1gNzZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8z167fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F96C43394;
	Tue, 13 Feb 2024 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857799;
	bh=D4LSaj+s1Zug+tnZej27exr9mIRN2BETmj/yUE3GRW0=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=h8z167fI+5EvVkodKTckqmfSIQBf8bdxud3DuPAkVZ5nSxa6AgTf5i7nXqeViSnpi
	 NzO6i/FEKZSrNSaZhsZiu2isfEu9pYLf9ncp9DW53jt4N2LykEt8h44nUoOhqQ6wzq
	 Ggcsv4u6mzWx2wdqmvlX28t9zk2NlXqOWy5t5t4fQeo+oWFyEFkOS0xLVSr/qesP2L
	 fwdUdRaFtwEmZNvFvliwu+RdNbxIx3QOILsH4x+QzGQ1ZxuRAimv1Lf9dytp6XdUoL
	 Ta4KKLP5W5oz3ppD6qfiudZEwLy9x5gy5g8BMoIVZOsaUuW10i9gm2Sv5wKnvMmJkQ
	 aanImS7s/f5Fg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511831801f3so3675805e87.2;
        Tue, 13 Feb 2024 12:56:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXA8wu8fK8fTvxPEq9xriH32femcjagzaIPCBUwIfKksWPkLCvTl584fUnYLejXqQHi4WITcKk/wnWXd6cEQPN8npK9cPlIDYytrFAYvXy2ZTexJ47GN6kslCwG+IOz74yxdAaHyIA87iM/mEb5IWjXJd7UifhphWCSmrMMsQ3w1h1tNR+wHcle661K3TBeSIn5o+Y8NyKYHfHBZw5CtJLwIfyaiTba96PhZiQF3xBblKiWC53n7UcwWGCzmP9Xczhx1SDoQl8/mVyMbSVotddIaJhulLJyXnRpcb8cRMX7iQpYH+qa+AZzeXIHn+anprL9j+TTnHN0/6nF7K1fjx3I3w==
X-Gm-Message-State: AOJu0YwXH0G2Okbc2oV2YVFjnP4M/CAkWe517YSbeLiG6WZ8lMG+AGb3
	SUbxv3Lf38Rcnrcfa2C77dfM7zFCLcrp+XyC69Kgc8suVAcylnqZ9NKi74P6x4xLBOtmsbBtmve
	Jw4nXqb2rVHQ+JlxYg3oiWRoXlQ==
X-Google-Smtp-Source: AGHT+IHaVnixOZOBNn0WypWTPscuLN4ELDvcVIU+BZ+gCn9OLEVbEJc+WSHECitxZrPyjoAQls55JHpdFFIbqmURVBc=
X-Received: by 2002:a2e:9bc7:0:b0:2d1:107b:3bbd with SMTP id
 w7-20020a2e9bc7000000b002d1107b3bbdmr506655ljj.9.1707857776326; Tue, 13 Feb
 2024 12:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org> <20240213-wafer-garnish-88287bc5d4a5@spud>
In-Reply-To: <20240213-wafer-garnish-88287bc5d4a5@spud>
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 20:56:03 +0000
X-Gmail-Original-Message-ID: <CAL_Jsq+9BwYyV9Vu1gfCnK_QjdRHvw2anM==Z6fsJvjyqLYFLw@mail.gmail.com>
Message-ID: <CAL_Jsq+9BwYyV9Vu1gfCnK_QjdRHvw2anM==Z6fsJvjyqLYFLw@mail.gmail.com>
Subject: Re: [PATCH 0/6] dts: Fix dtc interrupt warnings
To: Conor Dooley <conor@kernel.org>
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
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-tegra@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:27=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Feb 13, 2024 at 01:34:24PM -0600, Rob Herring wrote:
> > I had a branch with most of these changes sitting in my tree for some
> > time. Geert's asking about some errors not getting found prompted me to
> > clean it up and send it out. This series fixes all* interrupt related
> > warnings and enables the check by default.
> >
> > SoC maintainers, Can you please take this series directly.
> >
> > Rob
> >
> > *There's a few Renesas warnings still Geert said he would fix.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Rob Herring (6):
> >       arm64: dts: freescale: Disable interrupt_map check
> >       arm: dts: Fix dtc interrupt_provider warnings
> >       arm64: dts: Fix dtc interrupt_provider warnings
> >       arm: dts: Fix dtc interrupt_map warnings
> >       arm64: dts: qcom: Fix interrupt-map cell sizes
> >       dtc: Enable dtc interrupt_provider check
>
> Only fixing it for arm, Sadge.

I was assuming you had things in order. ;)

> Co-incidentally I noticed there was one for riscv while looking at
> Krzysztof's underscore in node name patch earlier, so I'd already
> written a patch to fix it :)

See, I was right.

Actually, I did remember to check right after I sent this and noticed the s=
ame.

For powerpc, no one else can be bothered to care, so neither do I. I
think powerpc has been spewing dtc warnings by default for some time
now.

Rob

