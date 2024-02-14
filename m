Return-Path: <linux-kernel+bounces-65345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF91854B94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3241C21761
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6C5A7B5;
	Wed, 14 Feb 2024 14:36:39 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B55C5F6;
	Wed, 14 Feb 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921399; cv=none; b=Ag2TdIJHmZ4uc+RQks39rJjzDXyeoK72pSD5sYI1dGGG3LheOiwWB8kfSFfiEhBsh1Lq4rd84g6d3Q/kQmDr++7O7aw5H6g92Amt0qvXogzZIGMoEZ3+DRntmY1HzFu1Cr+icstBXF6TSy4O604FHCD0e2XPfd42yq3CJD/SrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921399; c=relaxed/simple;
	bh=9s+3bWSnic4DE8OGfUz8obCTSG7tBE8fyRjkpHHqq/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF6T1MBVrpw26dByp2xKFUNFCcbaJLJZ9vtz7zVACB93llAASyWKYhG0Lewi0+iaBLeUO8PoHqBctR1oUWAhQm69QFPQMCvk1ZtH1c8W94iYF34k0wyTTqtRg2MdvTVO5w6PzBfrRLhA+hXgR7B1IoBtmY9wxPkNcDeSGFColdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e1126f57f1so253272b3a.2;
        Wed, 14 Feb 2024 06:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921396; x=1708526196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieRFgVX+l5qNLg5VWXa9Hrv9zNfV92pS7+FucPfjsp8=;
        b=TIn6iGB8ztOQMIJCtg7bls9/hfdwhL5nKJ4mTSgnahoN4DPkAYtB9Ny44lN1c30Lnz
         MhRdswMstMSVBIPpS8IXy1b52kAVTvYkBymq5VBk26OUoG+BB+NzPOERQryO3cN5+6i6
         tYrZnFS4fkb3awHJvp6EVK9CnOkgkWoZq+egJrsJIaOqEWEI4U90aQpg+SPuPEgur59w
         fM1s5etn763y0c6vq8Q683xC0cnFLCjKwWjIQNqSclnu///tHgsPNliPkey0pA34KzU3
         DqdoZ5QfxHxAai1Lw91z6cH0STnWuRllBJa5xAIOjkR1F4WtMukwYcfx3HXWKtRsutAx
         y7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU5wQ7h4awE2K4u3EdoXwVfN0iTriYIsOL4yqfwdvzD1/o5Y0ITyGvMaBo61uy9pr+EW3GtS/1GaRe+RivheVbai5uW2t3kqN/2x65ubIsLMc+xBDTZt4XtQOxrio1ShPXc8nGNUZvZ2vy51nN1hdYXpluySBMETdKPNkNyfg4QuBBqH+GUcqkiXhoOITnvcJjrW+3A+p09unzwk1QWIfKy0lMUymGmMn582CvXzEB+HM4+ROXr6YbyiEMUfLJN4hkUTpQ21cqBfvzhgLXgJB6eaVPS3WHyP2l0R8EL+K5EfCHIa0D6KqP09ojpUmdIBZRAGP3Ps6WbVABkU4s4cfTbQ==
X-Gm-Message-State: AOJu0YznFu3p6BnZPrBY6N+HSQPzlRAt9wG11h1KZ47bpK168Y/ydT9P
	vKe9Xr5U4nSTbu4T6weYMPoA+QZjCdOu4r5uILFHMFU6aURBwx3WPEQT0BcwnEE=
X-Google-Smtp-Source: AGHT+IFFthSxEtonVcXe87bmhUo29Pvsbr76NaU5tedM998ASq+hhSiMEVbXD23MUhFikYczz43kMg==
X-Received: by 2002:a62:cfc1:0:b0:6e0:9e95:b3f8 with SMTP id b184-20020a62cfc1000000b006e09e95b3f8mr2324722pfg.9.1707921395714;
        Wed, 14 Feb 2024 06:36:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiXj8laBX/0QpFfAU4AHfZrChi3AZvxbSiqzlknIyB0GjNrpDnP9OJpYeVZqli80RsNWDywVErwazZ9oH9+sK90qpRtHOpXS89vzIIsoBnAHvA90ftvO8uFHPfYiFPO5Ss0Om+6wBItmwQC/rGykolO4ytM0OqiFb4sXYTFkfc1N1YkmnkVSkpH7V2Q+F/0soF0Hjg+udc4goR9kb6nK3ZdkF2Jka71ipF4Ju6CiVFtSKqbXW8btVafOxRbiMzS71/z4Ev5/H3Q3xyP7mjD2H63r43A6hwdfFzN0YPh50fRitSP9wfFlZzWpMNcDWRMJMHZgcGXxjm3oYo5L7cdlgl8A==
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com. [209.85.214.169])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b006e0825acbc3sm9321977pfn.77.2024.02.14.06.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 06:36:35 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1db51e55023so6923745ad.1;
        Wed, 14 Feb 2024 06:36:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtmGx2z2ck1NE7BFwLs8WgYpa13xWvvwC1Yuyo9C6gcWyrXqUUk4tGlw5D675zE6oGRA9mIcz/HhoNGNsSS2QOYeKmvCorzzpsD7mkQ5mJikfjkk/dx5cy+7o5W39ecsRG8Md9UXejzkS4ikb4pJPphIuBVUddh5zvQZ/y/ScYi8A3+TjzEZbavf/9k4d2XBnyaDR+TJCy2eW2fXu2nXOgibu+C2xLs6APZ1h/ORaMxOUiw4VYIAscAtVjJJIlPC/2X8P8P+vqlHY5DefKyX2FfN05o4GPddY62Hj6+q4G11cbfyUyFucz/lG+R1RTZ28ACxG/JcrSmNd8dzgqOXmE8A==
X-Received: by 2002:a25:8686:0:b0:dc7:4546:d107 with SMTP id
 z6-20020a258686000000b00dc74546d107mr2758581ybk.23.1707921374648; Wed, 14 Feb
 2024 06:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org> <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
In-Reply-To: <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 15:36:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjJcsFiusnBQmJg1p-oy-NPmr+qyt0znOk0n+wL8TrnA@mail.gmail.com>
Message-ID: <CAMuHMdXjJcsFiusnBQmJg1p-oy-NPmr+qyt0znOk0n+wL8TrnA@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: Fix dtc interrupt_provider warnings
To: Rob Herring <robh@kernel.org>
Cc: soc@kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>, 
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

On Tue, Feb 13, 2024 at 8:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> The dtc interrupt_provider warning is off by default. Fix all the warning=
s
> so it can be enabled.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  arch/arm64/boot/dts/renesas/ulcb-kf.dtsi            | 4 ++++

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

