Return-Path: <linux-kernel+bounces-68542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC3857C08
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149FE1F239E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165017866C;
	Fri, 16 Feb 2024 11:47:09 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F9768FE;
	Fri, 16 Feb 2024 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084028; cv=none; b=Q7mvDmWHiPIdiNkQOQVS2/iZGuC2+phZwmRQY8ku0D9iFcsXng4HXyjkLAmsf5eqcTgx5gXOjILEJzS2Rry2dr70omvZmX66J66cCh+V3axb9ZG8j5pjZGOkE6EG+AiFOVzfIJ2wcw4/dnpFhJLMsfit0i3XXPw+82aFdpCD3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084028; c=relaxed/simple;
	bh=brDqgu+veoHirwdkbKDf0308k8BngHj6rCKvWtbcL88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxQAmC7f554DimfYKOs39as31NRbkTtH/zdd4CkoGkng1pyBpj5sq171Vw5QnFEZF/aj9jFZvQvZj8M+ZT1/VM2ZQVpU7Z4kj9syYaLaKrLT4xmQXLgHs9559/lsDyKoEQSkd/IkpC3BPfA+rAjEbqxIf0AVqfC41u6HU0yC8xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60782336a3aso4026707b3.2;
        Fri, 16 Feb 2024 03:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708084023; x=1708688823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ7tnAKFUkQOj4UEtgJN4h/6u4fraBJnTp0nHjLT6cQ=;
        b=NuY6vEBgIG9KmAvbppjbFS0iSNqaQQuVcW03ilk952q3G+5H6TS4CO8yqNT+u2VI3E
         h5kFZnwj4sGOtsD9dNyv6WnwGuIZ07vhSEItHlkLX/CJ5I7nNM5nr7aqOE7AIrPuAqOC
         1XKFJGCT9qFDXTARisTu6nFk66N8wRk4wkySY+ND1QJ+zysyGX3J38J/IVVYv6j8tDfi
         20wx1KqsCZMH8efFLpHr0WMGjRPEmFHaPIP49HMqDmw0yfzSwYltd8oc2VmrF/wI1e2F
         oGUAg/tdv0NPahRl0wLeEigZJKPOf03+kjnEqL8vFXOmQHKuG40xd8+bpGSJZFNvTZGM
         LlYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFzZ3g4WANKqtZZ9VlC7Jw/knLzFtY2VvPmEZNYbXXKPIK29Y8K2BD7BUsP+QXhKjLrNpKOR3XekjYlWQTBtSTMDqAEHdImF5IBY7jb0EIwuk276tqtUSsiYUK4dENO0BYX7/Z5tkyge9b9DM9jVgKGtN/6DMzcTjH6akhagdPVeRougKNRrc8ZhDepS2FEzk5dbEwTBKOqvh6petdRxzoDOnsASXDFRbb3wgTKDD3Acb5XhavvM4+B2NtdscptyH7AGGnweHO5QhSJ5zKhrKdEgMhqRLokglysst9E5w+RpAtXTBBCpXvz1I+rRprqc8bGJJBv+NbvFNzC6gQgVZm8tqBAbztCMNas0zOz0UkwdDDzdkdSrssNvIodA==
X-Gm-Message-State: AOJu0Yy1PyopLybDwhsRhRNyhHoX7zLqkA7Fxhoch1PliJvUdKRss3Jo
	5/dGVbJYGclu5g8Cgj+j7RgnUcW/JtnAUin0pzp9oJDY8PoNag4WzIlf3cFysgk=
X-Google-Smtp-Source: AGHT+IGOZo23mSGj2qVG09ybbc13KqERNgE2Z8Lel0v6H8fWWUPfJQWUuJf9NEMeSLF+la3qPj88JQ==
X-Received: by 2002:a81:4c8c:0:b0:607:8196:9d69 with SMTP id z134-20020a814c8c000000b0060781969d69mr4522995ywa.30.1708084023056;
        Fri, 16 Feb 2024 03:47:03 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id a125-20020a818a83000000b006040f198d3esm301001ywg.142.2024.02.16.03.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 03:47:01 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc71031680so609771276.2;
        Fri, 16 Feb 2024 03:47:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/33bHJ5WVDjuKg1h+K20HSFSmfoX0dje+Pdcke0G/yQOK9V0feprsSCKA1DfHeklL/Md53BZThhNi7KlefgL6OgBrBR3FWnNtPQ7QIZqprCc8UUjHH8if981HtunXUuEJu9HW12LvxQAxlh9H1gsyW8N6P906LUOaOkbuYSoI15GHqAhh/ny2zVu5VbToppT3ptxf5vmGpiPPnOXps/H9FUkUjH/pO7nThOnAMurKIZ+rTdWWgOxyXjr3swevrnkFK1Tne6+bGd4fNJCye27zGkM12CRl9rBM6E+cLly2ijj83hChsBpJ7DvDvy762C5JyHgc9UOieLPUd5+eKl7GtgZGvnAxKRaMCBCV6ksn7c38M2sdlkpOOvDXVA==
X-Received: by 2002:a5b:708:0:b0:dc6:cc35:35e9 with SMTP id
 g8-20020a5b0708000000b00dc6cc3535e9mr4412013ybq.35.1708084021189; Fri, 16 Feb
 2024 03:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 12:46:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXzObEqExtJZpUpXLfCWB5fW9ZhekbbotcxcMrN+uj0Ag@mail.gmail.com>
Message-ID: <CAMuHMdXzObEqExtJZpUpXLfCWB5fW9ZhekbbotcxcMrN+uj0Ag@mail.gmail.com>
Subject: Re: [PATCH] clk: constify the of_phandle_args argument of of_clk_provider
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-stm32@st-md-mailman.stormreply.com, 
	NXP Linux Team <linux-imx@nxp.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> None of the implementations of the get() and get_hw() callbacks of
> "struct of_clk_provider" modify the contents of received of_phandle_args
> pointer.  They treat it as read-only variable used to find the clock to
> return.  Make obvious that implementations are not supposed to modify
> the of_phandle_args, by making it a pointer to const.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  drivers/clk/renesas/r9a06g032-clocks.c        |  2 +-
>  drivers/clk/renesas/renesas-cpg-mssr.c        |  2 +-
>  drivers/clk/renesas/rzg2l-cpg.c               |  2 +-

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

