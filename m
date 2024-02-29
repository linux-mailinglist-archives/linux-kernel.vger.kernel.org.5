Return-Path: <linux-kernel+bounces-86557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D6B86C704
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FB41C20B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD5179DA3;
	Thu, 29 Feb 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mD4ISzz+"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88179939
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202858; cv=none; b=DaXKrwEFXTqGlLwyJo8E84H57OpgUpCgW92r2wn5XR9L1NQIiR5sZRwUYuCcbIVWpvBdVyNrROtHrEJK7sxFG53t18/SdMF3lFm2A+oZIa2P3EVuB2gXsSLAoE+wnIjrCuzuOiTW6Jl+5ohKU4j4zJ9h1WBMc7L6NTUyU+DIexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202858; c=relaxed/simple;
	bh=GgnUOEffRZJ42r2OeGvZTo9UXmfKm4tTxUBXBAl7ztw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2cq0ZNXgM03fpbavAkiqUFNnbMGA0oJCxlcyTbE8zvP1jkV7tJyR4S+0yMqFs5WDzuhO6R0p4UCSbppAHGPETVcST3PBv+hNjsEJW59XwE6oK0B0Tk2JyKAOpKogg2AO60r/vhnXCowkzyQ7DuTT+CpTyoeJ34fUVuvAJdWO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mD4ISzz+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so9463041fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709202855; x=1709807655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWZLhJtXrXREGkrkVHASBqM4/svUa094tHpDRDPD6v0=;
        b=mD4ISzz+CVkN2N+yqGMERL0VOBx5jGqUBwZDe1pMIZc/Gc+RCjWD0u2MaNPZZN87Js
         svqbP6fu6vhM9a0uqtk3F07K3OZVYAcIG1KpNU/4NzHaSyVVa3/i75CFG6OQWQGe4971
         /UfDbzgqjd2Jm8w2ylcO6OJNR0pvr4Da/qgBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202855; x=1709807655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWZLhJtXrXREGkrkVHASBqM4/svUa094tHpDRDPD6v0=;
        b=S0Ggs/kxE3pa6wkYFm/X48V5zAB/EVPTeRc2bk4GKbNyMhes5hBj1ogSwMEhredgxp
         3nHHalc3jbKEUH5ZYLzj6QIj+ZCY5a76yVNCXjyD/73iP0rY+Zjpw2JJFSkmvyttcQX+
         7R1paUAw7b04s/F25j28EUn4y8exTBzl1nUPKsPcRUSgepyAXEMXsWx4pVnWlQnCN3mW
         YtTjGLmrNdWICJX+sex8R0vODgCpNMLpkQeIuXqPjOpF8AlwKbMcTd9sYTZ3+V/MV6Uq
         uL+pGqgJNpmVU1S6D4WgSBSxuWZyQNmveRZLXJEoIIFnYtwxf6eiRK4ff2SB5sVfVVyT
         Lilw==
X-Forwarded-Encrypted: i=1; AJvYcCXvqhOrSbsN9xL9AAvGwG9/g21exwxssaGl9QAFjQNscb8d17sb6uNkLkbblGhSSAnjYnjcpDiS6hQIAQhSvxEslpLB4tpJBr60fHLu
X-Gm-Message-State: AOJu0Yz6HFKWUlsGeczPsdCTbM7Q1zbznm75tlUDBUamNyjWQ+iy+4U2
	f/33KCXBkvDwa7sVAwVjByT23foBj9Nf7mjlRuyT8cE6cC1daEyS3HxD1jJAFqkYWZNuC4p2cc6
	tXdo5Gpf6BwM606w40aSsxCoQwiKvvigs0dmr
X-Google-Smtp-Source: AGHT+IELVLBuIjaHjgQS6YTzenmUUL0wJhr5x7w//aBk4NGvQfMzL/tLB7zOQ0ThYx2rN5H+hKvedRKUhGpFkSxdgmI=
X-Received: by 2002:a2e:9490:0:b0:2d2:5129:4ffd with SMTP id
 c16-20020a2e9490000000b002d251294ffdmr1046646ljh.53.1709202854811; Thu, 29
 Feb 2024 02:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108081834.408403-1-treapking@chromium.org>
 <CAGXv+5EnBt+7WrNb-QyziEaCihvjhFVf2tpzk=XyAoeELqucaw@mail.gmail.com>
 <e0e6febf-1045-49f8-a200-8bc095b0fa50@collabora.com> <CAGXv+5F5YFRKjaXu_XbXrUhqKL0NSRyt6tniQYfhRh+fsaxqmg@mail.gmail.com>
 <cc74422d-962f-4da5-867b-158a71db1a7b@collabora.com>
In-Reply-To: <cc74422d-962f-4da5-867b-158a71db1a7b@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 29 Feb 2024 18:34:03 +0800
Message-ID: <CAGXv+5EyRROsh_=J1Fg4K+ZgfkERF4dh4R6WoGw9MnTBMNUCgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pin-yen Lin <treapking@chromium.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Weiyi Lu <weiyi.lu@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/02/24 08:17, Chen-Yu Tsai ha scritto:
> > On Mon, Feb 26, 2024 at 7:16=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 23/02/24 05:27, Chen-Yu Tsai ha scritto:
> >>> On Mon, Jan 8, 2024 at 4:18=E2=80=AFPM Pin-yen Lin <treapking@chromiu=
m.org> wrote:
> >>>>
> >>>> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
> >>>> this clock controller needs runtime PM for its operations.
> >>>> Also do a runtime PM get on the clock controller during the
> >>>> probing stage to workaround a possible deadlock.
> >>>>
> >>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >>>
> >>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>
> >>> The patch itself looks fine.
> >>>
> >>> Besides the MT8183 MFG clock issues, we do actually need this for the
> >>> MT8192 ADSP clock. Its power domain is not enabled by default.
> >>>
> >>
> >> ...but on MT8195 the ADSP clock works - because the ADSP node exists.
> >
> > That's an indirect dependency that should not be relied on. Say the clo=
ck
> > driver probed but the ADSP hasn't, and you try to read out the current
> > status. What would happen?
> >
> > - Read out works fine, because the power domain is default on, and hasn=
't
> >    been turned off by late cleanup
> > - Read out is bogus (but you can't tell)
> > - Read out hangs.
> >
> > The third is what happens on MT8192. There's still some issues on that
> > front, as even after I applied the ADSP power domain patches from Media=
Tek,
> > the readout was still hanging.
> >
>
> That MT8192 lockup story is getting crazy in my head... anyway, besides t=
hat,
> I get the point - I was somehow ignoring the fact that kernel modules do =
exist.
>
> Eh, sorry about that :-)
>
> >> This poses a question: should we make clock controllers depend on powe=
r domains,
> >> or should we keep everything powered off (hence clocks down - no power=
 consumption)
> >> *unless* the user exists?
> >
> > That's a policy discussion separate from actual hardware dependencies.
> > *If* the clock controller needs the power domain to be active for the
> > registers to be accessed, the clock controller *must* have a direct
> > dependency on the power domain.
> >
>
> I admit I should've worded that better.
>
> "should we make clock controllers depend on power domains" was actually i=
mplying
> "IF those need one" :-)
>
> I really wonder if - at this point - it's simply a better idea to not res=
trict
> the call to devm_pm_runtime_enable/resume_and_get to `need_runtime_pm =3D=
=3D true`.
>
> Do we really need to exclude that on other clock controllers that don't h=
ave
> any power domain dependency? Any side effect?
>
> Saying this because if we can avoid yet another per-SoC flag I'm really h=
appy,
> as readability is also impacted and besides - if we ever find out that on=
e of
> those need a power domain in the future, we'll need just one commit and j=
ust
> only in the devicetree, instead of enabling a flag in driver X as well as=
 that,
> avoiding some (potentially unnecessary) noise... I guess.
>
> P.S.: I just noticed that the return value for the devm_pm_runtime_enable=
() call
>        is not being checked!
>
> .......
>
> In short....
>
> Chen-Yu, at this point, do you have any reason why we wouldn't be able an=
d/or it
> wouldn't be a good idea to just avoid adding the `need_runtime_pm` flag (=
meaning
> that we perform pm_runtime calls for all clock drivers unconditionally)?
>
> If this is about longer boot time, I don't think that it's going to be mo=
re than
> a millisecond or two, so that should be completely ignorable.

I think it's just more of a "don't enable features you don't need" thing.
We already ran into a weird deadlock, which is why the devm_pm_runtime_enab=
le()
call has that comment.

I don't think anyone has actually looked at it. As you said it shouldn't be
much, at least during boot time. It's one call per clock controller.

> Can you please do a test for that, or should I?

The earliest I can work on it would be some time next week. Does that work
for you?

ChenYu

> Cheers
> Angelo
>
> >> For the second one, this means that the *device* gets the power domain=
 (adsp), and
> >> not the clock controller (which clocks are effectively useless if ther=
e's no user).
> >
> > No. See my previous paragraph.
> >
> > ChenYu
> >
> >> Angelo
> >>
> >>>> ---
> >>>>
> >>>> Changes in v3:
> >>>> - Update the commit message and the comments before runtime PM call
> >>>>
> >>>> Changes in v2:
> >>>> - Fix the order of error handling
> >>>> - Update the commit message and add a comment before the runtime PM =
call
> >>>>
> >>>>    drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
> >>>>    drivers/clk/mediatek/clk-mtk.h |  2 ++
> >>>>    2 files changed, 21 insertions(+)
> >>>>
> >>>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/c=
lk-mtk.c
> >>>> index 2e55368dc4d8..ba1d1c495bc2 100644
> >>>> --- a/drivers/clk/mediatek/clk-mtk.c
> >>>> +++ b/drivers/clk/mediatek/clk-mtk.c
> >>>> @@ -13,6 +13,7 @@
> >>>>    #include <linux/of.h>
> >>>>    #include <linux/of_address.h>
> >>>>    #include <linux/platform_device.h>
> >>>> +#include <linux/pm_runtime.h>
> >>>>    #include <linux/slab.h>
> >>>>
> >>>>    #include "clk-mtk.h"
> >>>> @@ -494,6 +495,18 @@ static int __mtk_clk_simple_probe(struct platfo=
rm_device *pdev,
> >>>>                           return IS_ERR(base) ? PTR_ERR(base) : -ENO=
MEM;
> >>>>           }
> >>>>
> >>>> +
> >>>> +       if (mcd->need_runtime_pm) {
> >>>> +               devm_pm_runtime_enable(&pdev->dev);
> >>>> +               /*
> >>>> +                * Do a pm_runtime_resume_and_get() to workaround a =
possible
> >>>> +                * deadlock between clk_register() and the genpd fra=
mework.
> >>>> +                */
> >>>> +               r =3D pm_runtime_resume_and_get(&pdev->dev);
> >>>> +               if (r)
> >>>> +                       return r;
> >>>> +       }
> >>>> +
> >>>>           /* Calculate how many clk_hw_onecell_data entries to alloc=
ate */
> >>>>           num_clks =3D mcd->num_clks + mcd->num_composite_clks;
> >>>>           num_clks +=3D mcd->num_fixed_clks + mcd->num_factor_clks;
> >>>> @@ -574,6 +587,9 @@ static int __mtk_clk_simple_probe(struct platfor=
m_device *pdev,
> >>>>                           goto unregister_clks;
> >>>>           }
> >>>>
> >>>> +       if (mcd->need_runtime_pm)
> >>>> +               pm_runtime_put(&pdev->dev);
> >>>> +
> >>>>           return r;
> >>>>
> >>>>    unregister_clks:
> >>>> @@ -604,6 +620,9 @@ static int __mtk_clk_simple_probe(struct platfor=
m_device *pdev,
> >>>>    free_base:
> >>>>           if (mcd->shared_io && base)
> >>>>                   iounmap(base);
> >>>> +
> >>>> +       if (mcd->need_runtime_pm)
> >>>> +               pm_runtime_put(&pdev->dev);
> >>>>           return r;
> >>>>    }
> >>>>
> >>>> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/c=
lk-mtk.h
> >>>> index 22096501a60a..c17fe1c2d732 100644
> >>>> --- a/drivers/clk/mediatek/clk-mtk.h
> >>>> +++ b/drivers/clk/mediatek/clk-mtk.h
> >>>> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
> >>>>
> >>>>           int (*clk_notifier_func)(struct device *dev, struct clk *c=
lk);
> >>>>           unsigned int mfg_clk_idx;
> >>>> +
> >>>> +       bool need_runtime_pm;
> >>>>    };
> >>>>
> >>>>    int mtk_clk_pdev_probe(struct platform_device *pdev);
> >>>> --
> >>>> 2.43.0.472.g3155946c3a-goog
> >>>>
> >>
> >>
> >>
>
>
>

