Return-Path: <linux-kernel+bounces-65375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F79854C15
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CE01F25E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3815B5C901;
	Wed, 14 Feb 2024 15:01:26 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B15B21C;
	Wed, 14 Feb 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922885; cv=none; b=lCAFSoH0DlpPuQ+ZevTKFWx7hm6t2xjFXExIWw01dxGjbCE28ktMrGfbWXg94/Tt84aHSwo9EsLpISRDssR0GQdDYUjS3m2S1c306/IWfvc8t35XsCEOFe+Im33cZkanrsBcoDmJ1VIuw++ihXbb9x0CfonlSC0HfXXmD9aezdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922885; c=relaxed/simple;
	bh=wRhBbftaNujCFlZk6BVtFbm/sKIU58sYu+5kiELSP7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7IhcU5tDQBv+K1g2l2p9EHqY0lNgIbKRGhjD8vp5a5tlWc/RkBSwp2klwjxn7Oxb9Q8mpJtZtPp4NPtpuDs44uem1+sQzK6d+58hma2ltKKgCHrbYdASDhjJhpvgAPLSTjrtGMIEDdRHHztqbz2QgP0yPoKCqyXHt4KvFx80yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7853a9eb5daso188543485a.2;
        Wed, 14 Feb 2024 07:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707922881; x=1708527681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6upARWbXs1k8V4Vnc/YI44n6rxziwjW/OPtXVVY76s=;
        b=juBjOjG6RNr9evWHSZ/09nizJEVK9dodFGbt3nbqZ+snJ773VLz59DEOWPkZlXnwbw
         yuHzl7P8+TRd8AgxoyVf6ojP2QaO3xQCfkYUUorymqXYF7QjCF3VJ7LSkvCbHALufMjk
         NiSHIl7608gCwXlIsnqkjlu/7hqxN/iqaZemKtaTgbEnJj6ukeKJzjRl0NaqoSbgQM/D
         z456IvvGr5tCDQkXQqouVkcKE7jaYO32plUQyAWYVupe8eldzkIkJQjKYbG6AeJz0un0
         VjS8D21vOdzlkf2G1qnRFc25k1R3DPcR/OiqXhlIAp0cbtv1LD1knY+KMS8e9WAg8djl
         eORg==
X-Forwarded-Encrypted: i=1; AJvYcCXD/D9CkimvEmtbtC85uzY4/T7w1dx+VzNbz9VwXZWMTjdQkD/cY1oVZZ6ygsj8EM04OuMAaX1MDfzbmRwMg52z4tZGWl72sGL1KbzNDLQxckD1A/OaTslRWF5AjqPsAMK4pgikvEPjLMzV5YdplJIp3+9B9IUAKA97xjoLL6YzYTYNHvNqup5ZQPnfmFt0vLWiuN1kPDE09012/lPqHNL2gzG7MuS8hfTQFYimJMMwC3WWbJc/XL8TPwza2kmakj5PHkdmPbTsPdakD9oD7eW11V25okqv/E/L01G4bqsn3kiBICVXf1sKoulY9uVV1VscV/UbkK1I1TfF+LVW7Qxfig==
X-Gm-Message-State: AOJu0Yz3FfBHSphQEdAQfflo8c1EqfzX3Zk8R1G00qmBsXFU0jjWDNcG
	1oUXcV+RpDreqVczgHu2wmod/j38huHWeur5DsfDlLREYcb47IMb4kZHO8J794c=
X-Google-Smtp-Source: AGHT+IHFn6eY5rp1w7jUMyO4UeaIh9i34RYopBCHwdFZAa5Auq13KfwzuOv5oquw8sHm7FbvjKfJzQ==
X-Received: by 2002:a05:620a:438b:b0:785:d6a9:734f with SMTP id a11-20020a05620a438b00b00785d6a9734fmr3530707qkp.46.1707922878529;
        Wed, 14 Feb 2024 07:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOpVWYB2+ehgyPQ2AelOzgxuW1SKU3bWkZZghJaolLB+H/bhnUH8p99cnRxJ/HuF1q37yQpv9bmDmijuI4cEf9NvjJtRTHMPowe6JfC45pAka1LI/BfpOz0dgohCFqjKCUSNns+oicXrIQTePS+bjFTHskwKh3BB4STphbREOBFbNcJzijpOIcCyrQJ32bFUrQAA0QnmeAXosAD9lhK6yq/FNMNnkvIckGQ/OAE1zbehJfAkeinVpBV7Y2FABfpfR3m4XnhzPwFFOLDNW3aoJT/THy5huzTXsSnMfa/I7TKJa7lkqgHsyD/VC2YM+WohFITnWaQ6S3XuwpGc9YiESIiw==
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id r11-20020a05620a03cb00b00785d7f634bcsm2481639qkm.8.2024.02.14.07.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:01:18 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8a3973c5so28297761cf.2;
        Wed, 14 Feb 2024 07:01:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkiCmkrcPoyS+NdSQfqmW3UfmIjV75JLSBFBZbycI6ZQxzWlm2P8tQCYMLXleNE71aKauBXoVvSo+LozJwSRo8/hmgMCEn22dqLyl1Z8OqftAI5j51MnTPNJt+PmpoBVBBFQkdT4b8tLFAWfsb/aymtYHx1BZxOsUvzQ0ntqFSgSG0E2Z1D7iFFlYs/rCvi6uyg/qw8hZQPbiFqwD2r01i2I0JrQXRovTG3hn87qvlcftLpQbbNX6o5xajhBxy/aic1FqGWwZn8+eBm7au5zqRm8q05rtoh/5Q6YMuIyb6HdqkJcLep/RZLGhJ1LN4I1hyHzzy7Lqzteel5zldnWXkBw==
X-Received: by 2002:a25:84c9:0:b0:dc2:3fbd:82fe with SMTP id
 x9-20020a2584c9000000b00dc23fbd82femr2322270ybm.46.1707922857034; Wed, 14 Feb
 2024 07:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 16:00:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgvD9szXksK+jzyvwLQ8ufWWf1TPQ7s-5z4JWgrvXmkg@mail.gmail.com>
Message-ID: <CAMuHMdWgvD9szXksK+jzyvwLQ8ufWWf1TPQ7s-5z4JWgrvXmkg@mail.gmail.com>
Subject: Re: [PATCH 0/6] dts: Fix dtc interrupt warnings
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

Hi Rob,

On Tue, Feb 13, 2024 at 8:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> I had a branch with most of these changes sitting in my tree for some
> time. Geert's asking about some errors not getting found prompted me to
> clean it up and send it out. This series fixes all* interrupt related
> warnings and enables the check by default.

> *There's a few Renesas warnings still Geert said he would fix.

Thanks, fix sent
https://lore.kernel.org/r/a351e503ea97fb1af68395843f513925ff1bdf26.17079224=
60.git.geert+renesas@glider.be

>       dtc: Enable dtc interrupt_provider check

>  scripts/Makefile.lib                                  |  3 +--

Just wondering, can the remaining disabler be removed, too?

Documentation/devicetree/bindings/Makefile:     -Wno-interrupt_provider \

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

