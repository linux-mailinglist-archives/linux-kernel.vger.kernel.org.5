Return-Path: <linux-kernel+bounces-95388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A295D874D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78F31C22D17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806D128390;
	Thu,  7 Mar 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7arwrH+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5112AACD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809858; cv=none; b=O2o3xymjTEImZH+dgCpefWjnIZMEY+TBsReUQq0xDjTV4O9yeetQJD5h7lDIMR/0JJKqVaR5obeMyASntsH0mTJ3Cqym+VpTwPOy9lpQ5jo26VYf1Fzq7ejLeh5Vzs6aYrppFpmz6K1joLBKNyVYdj+cec4eyfLY9Se+ca0MQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809858; c=relaxed/simple;
	bh=+QUQ7yhNC21YVITWoj5dkN0llltsA5n33KngBbOyW9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otqosi0QV+tsxfvrxmD0cnoAZQmBd0yx76i1Cg9oy0VeVQ9fIlbmhxC5U7HstLeFNXZhnLi2PSN8u7recD0HhUor8DZ68h5J9nmOgJxLg7aeOGHNXRo/0E1trU6XSVTtQQ4T8aHVWsN+ncszXY9QpPx917z+0qZSNQMP4VuDdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O7arwrH+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc13fb0133so5921995ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709809856; x=1710414656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OrNnr6gHqc42Ky1FeFcCvehza56T+Pa8i2e3OFWYmw=;
        b=O7arwrH+Ss+8IkBeHcgjhG9aSBMVkfw9MUc7kYTzSWuG9Bk+VknstQsBYatNoXYerl
         tLb3snJMwldEpZ1DZ6tHluaN+FZNQXhCnahHfnnxgSS5GqRd097aZiBJ6LlRw2ds8+aS
         A1uMvYNUIpt1YLTiQEAuy62P7WB3CsyCIH6zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809856; x=1710414656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OrNnr6gHqc42Ky1FeFcCvehza56T+Pa8i2e3OFWYmw=;
        b=PLGHRdyqArzU03Mz22cG95e3fptans2cPEydh2vSEQlEeNXkzU6+bwv/jX+hO0WuND
         xOYN/wZPIWd7ftkXCgDDuRNWc+rlozC3G4h2aTC5mZ9YB88nZRfA5stRMmUC1aL4ZO/z
         uAbBYOCkjSdGrcrSJVe+nrsGHokC9t8w2El4jcjVCowG4BJX/aG4MQ25cepGRZyRRwwd
         V9wxdM3Jg81sLswuLUV1KQ+6o+iP/bdGWTYTHB4E8Yw19rg+2c//96grIiiAVm+FZGPY
         7w4i2F5TwGD03zJiAJpyFpWmTvG2FKq/J0FPvit0HOPTxW7GLGPU4Dp0T/YycaaVIBVL
         M4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXgQOklAsOhctowPbo40V0iDBaxp8TMV4EdtnBxp2pHSyuyxBn1AnUk9PPUcBv6cdZxr6/kl1QyrYuxGkC2pXlEhHkaGX5e7DE6Mnr9
X-Gm-Message-State: AOJu0YzqW7KrqqYKVb6QYjgPyPchkMnF6NawwsFI5vLbSYuzN+HNuw9i
	lHSjhC37xpvlvecsjiK4gAnqMx/KPH11SpuP3ClfiG/SuyiBHS/xQOLxfFZ1l12ZDU0w1mtP6na
	r+EXvQmLnd/gy7rWo5VS/fLqwdISNA2k7YIpS
X-Google-Smtp-Source: AGHT+IFxA69w3fb5rTaHx0WWeDwNDwE8addr1vYQfdEOYmu/vTHtVI+D/+lM+o+ttEqHQRihTUFAaiYFNtKyeHldlLU=
X-Received: by 2002:a17:902:e84d:b0:1db:c390:1fdc with SMTP id
 t13-20020a170902e84d00b001dbc3901fdcmr9601288plg.1.1709809855695; Thu, 07 Mar
 2024 03:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108081834.408403-1-treapking@chromium.org>
 <CAGXv+5EnBt+7WrNb-QyziEaCihvjhFVf2tpzk=XyAoeELqucaw@mail.gmail.com>
 <e0e6febf-1045-49f8-a200-8bc095b0fa50@collabora.com> <CAGXv+5F5YFRKjaXu_XbXrUhqKL0NSRyt6tniQYfhRh+fsaxqmg@mail.gmail.com>
 <cc74422d-962f-4da5-867b-158a71db1a7b@collabora.com> <CAGXv+5EyRROsh_=J1Fg4K+ZgfkERF4dh4R6WoGw9MnTBMNUCgQ@mail.gmail.com>
 <dfdc6a65-3ccf-463c-95df-093f3c2fefd3@collabora.com>
In-Reply-To: <dfdc6a65-3ccf-463c-95df-093f3c2fefd3@collabora.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Thu, 7 Mar 2024 19:10:44 +0800
Message-ID: <CAEXTbpcPfWQr4iuD2U0zgJUi+BF-rLfyF4iDDiQYBrrv9U=6Xg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Weiyi Lu <weiyi.lu@mediatek.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo and Chen-yu,

I tried enabling the runtime PM regardless of the .need_pm_runtime
flag, and my MT8183 device works well with that with no obvious boot
regression.

Should I send out another patch that always enables runtime PM in
__mtk_clk_simple_probe()? Or is there anything I should test?

Regards,
Pin-yen

On Thu, Feb 29, 2024 at 6:36=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/02/24 11:34, Chen-Yu Tsai ha scritto:
> > On Thu, Feb 29, 2024 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 29/02/24 08:17, Chen-Yu Tsai ha scritto:
> >>> On Mon, Feb 26, 2024 at 7:16=E2=80=AFPM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 23/02/24 05:27, Chen-Yu Tsai ha scritto:
> >>>>> On Mon, Jan 8, 2024 at 4:18=E2=80=AFPM Pin-yen Lin <treapking@chrom=
ium.org> wrote:
> >>>>>>
> >>>>>> Introduce a new need_pm_runtime variable to mtk_clk_desc to indica=
te
> >>>>>> this clock controller needs runtime PM for its operations.
> >>>>>> Also do a runtime PM get on the clock controller during the
> >>>>>> probing stage to workaround a possible deadlock.
> >>>>>>
> >>>>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >>>>>
> >>>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>>>
> >>>>> The patch itself looks fine.
> >>>>>
> >>>>> Besides the MT8183 MFG clock issues, we do actually need this for t=
he
> >>>>> MT8192 ADSP clock. Its power domain is not enabled by default.
> >>>>>
> >>>>
> >>>> ...but on MT8195 the ADSP clock works - because the ADSP node exists=
.
> >>>
> >>> That's an indirect dependency that should not be relied on. Say the c=
lock
> >>> driver probed but the ADSP hasn't, and you try to read out the curren=
t
> >>> status. What would happen?
> >>>
> >>> - Read out works fine, because the power domain is default on, and ha=
sn't
> >>>     been turned off by late cleanup
> >>> - Read out is bogus (but you can't tell)
> >>> - Read out hangs.
> >>>
> >>> The third is what happens on MT8192. There's still some issues on tha=
t
> >>> front, as even after I applied the ADSP power domain patches from Med=
iaTek,
> >>> the readout was still hanging.
> >>>
> >>
> >> That MT8192 lockup story is getting crazy in my head... anyway, beside=
s that,
> >> I get the point - I was somehow ignoring the fact that kernel modules =
do exist.
> >>
> >> Eh, sorry about that :-)
> >>
> >>>> This poses a question: should we make clock controllers depend on po=
wer domains,
> >>>> or should we keep everything powered off (hence clocks down - no pow=
er consumption)
> >>>> *unless* the user exists?
> >>>
> >>> That's a policy discussion separate from actual hardware dependencies=
.
> >>> *If* the clock controller needs the power domain to be active for the
> >>> registers to be accessed, the clock controller *must* have a direct
> >>> dependency on the power domain.
> >>>
> >>
> >> I admit I should've worded that better.
> >>
> >> "should we make clock controllers depend on power domains" was actuall=
y implying
> >> "IF those need one" :-)
> >>
> >> I really wonder if - at this point - it's simply a better idea to not =
restrict
> >> the call to devm_pm_runtime_enable/resume_and_get to `need_runtime_pm =
=3D=3D true`.
> >>
> >> Do we really need to exclude that on other clock controllers that don'=
t have
> >> any power domain dependency? Any side effect?
> >>
> >> Saying this because if we can avoid yet another per-SoC flag I'm reall=
y happy,
> >> as readability is also impacted and besides - if we ever find out that=
 one of
> >> those need a power domain in the future, we'll need just one commit an=
d just
> >> only in the devicetree, instead of enabling a flag in driver X as well=
 as that,
> >> avoiding some (potentially unnecessary) noise... I guess.
> >>
> >> P.S.: I just noticed that the return value for the devm_pm_runtime_ena=
ble() call
> >>         is not being checked!
> >>
> >> .......
> >>
> >> In short....
> >>
> >> Chen-Yu, at this point, do you have any reason why we wouldn't be able=
 and/or it
> >> wouldn't be a good idea to just avoid adding the `need_runtime_pm` fla=
g (meaning
> >> that we perform pm_runtime calls for all clock drivers unconditionally=
)?
> >>
> >> If this is about longer boot time, I don't think that it's going to be=
 more than
> >> a millisecond or two, so that should be completely ignorable.
> >
> > I think it's just more of a "don't enable features you don't need" thin=
g.
> > We already ran into a weird deadlock, which is why the devm_pm_runtime_=
enable()
> > call has that comment.
> >
> > I don't think anyone has actually looked at it. As you said it shouldn'=
t be
> > much, at least during boot time. It's one call per clock controller.
> >
> >> Can you please do a test for that, or should I?
> >
> > The earliest I can work on it would be some time next week. Does that w=
ork
> > for you?
> >
>
> The earliest I'd be able to work on this myself would be at the end of ne=
xt
> week if not later.. so yes, please take your time, no worries.
>
> Thank you!
>
> > ChenYu
> >
> >> Cheers
> >> Angelo
> >>
> >>>> For the second one, this means that the *device* gets the power doma=
in (adsp), and
> >>>> not the clock controller (which clocks are effectively useless if th=
ere's no user).
> >>>
> >>> No. See my previous paragraph.
> >>>
> >>> ChenYu
> >>>
> >>>> Angelo
> >>>>
> >>>>>> ---
> >>>>>>
> >>>>>> Changes in v3:
> >>>>>> - Update the commit message and the comments before runtime PM cal=
l
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>> - Fix the order of error handling
> >>>>>> - Update the commit message and add a comment before the runtime P=
M call
> >>>>>>
> >>>>>>     drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
> >>>>>>     drivers/clk/mediatek/clk-mtk.h |  2 ++
> >>>>>>     2 files changed, 21 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek=
/clk-mtk.c
> >>>>>> index 2e55368dc4d8..ba1d1c495bc2 100644
> >>>>>> --- a/drivers/clk/mediatek/clk-mtk.c
> >>>>>> +++ b/drivers/clk/mediatek/clk-mtk.c
> >>>>>> @@ -13,6 +13,7 @@
> >>>>>>     #include <linux/of.h>
> >>>>>>     #include <linux/of_address.h>
> >>>>>>     #include <linux/platform_device.h>
> >>>>>> +#include <linux/pm_runtime.h>
> >>>>>>     #include <linux/slab.h>
> >>>>>>
> >>>>>>     #include "clk-mtk.h"
> >>>>>> @@ -494,6 +495,18 @@ static int __mtk_clk_simple_probe(struct plat=
form_device *pdev,
> >>>>>>                            return IS_ERR(base) ? PTR_ERR(base) : -=
ENOMEM;
> >>>>>>            }
> >>>>>>
> >>>>>> +
> >>>>>> +       if (mcd->need_runtime_pm) {
> >>>>>> +               devm_pm_runtime_enable(&pdev->dev);
> >>>>>> +               /*
> >>>>>> +                * Do a pm_runtime_resume_and_get() to workaround =
a possible
> >>>>>> +                * deadlock between clk_register() and the genpd f=
ramework.
> >>>>>> +                */
> >>>>>> +               r =3D pm_runtime_resume_and_get(&pdev->dev);
> >>>>>> +               if (r)
> >>>>>> +                       return r;
> >>>>>> +       }
> >>>>>> +
> >>>>>>            /* Calculate how many clk_hw_onecell_data entries to al=
locate */
> >>>>>>            num_clks =3D mcd->num_clks + mcd->num_composite_clks;
> >>>>>>            num_clks +=3D mcd->num_fixed_clks + mcd->num_factor_clk=
s;
> >>>>>> @@ -574,6 +587,9 @@ static int __mtk_clk_simple_probe(struct platf=
orm_device *pdev,
> >>>>>>                            goto unregister_clks;
> >>>>>>            }
> >>>>>>
> >>>>>> +       if (mcd->need_runtime_pm)
> >>>>>> +               pm_runtime_put(&pdev->dev);
> >>>>>> +
> >>>>>>            return r;
> >>>>>>
> >>>>>>     unregister_clks:
> >>>>>> @@ -604,6 +620,9 @@ static int __mtk_clk_simple_probe(struct platf=
orm_device *pdev,
> >>>>>>     free_base:
> >>>>>>            if (mcd->shared_io && base)
> >>>>>>                    iounmap(base);
> >>>>>> +
> >>>>>> +       if (mcd->need_runtime_pm)
> >>>>>> +               pm_runtime_put(&pdev->dev);
> >>>>>>            return r;
> >>>>>>     }
> >>>>>>
> >>>>>> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek=
/clk-mtk.h
> >>>>>> index 22096501a60a..c17fe1c2d732 100644
> >>>>>> --- a/drivers/clk/mediatek/clk-mtk.h
> >>>>>> +++ b/drivers/clk/mediatek/clk-mtk.h
> >>>>>> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
> >>>>>>
> >>>>>>            int (*clk_notifier_func)(struct device *dev, struct clk=
 *clk);
> >>>>>>            unsigned int mfg_clk_idx;
> >>>>>> +
> >>>>>> +       bool need_runtime_pm;
> >>>>>>     };
> >>>>>>
> >>>>>>     int mtk_clk_pdev_probe(struct platform_device *pdev);
> >>>>>> --
> >>>>>> 2.43.0.472.g3155946c3a-goog
> >>>>>>
> >>>>
> >>>>
> >>>>
> >>
> >>
> >>
>

