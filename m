Return-Path: <linux-kernel+bounces-100029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC6879107
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A24B2362F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ABD7826D;
	Tue, 12 Mar 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OGGN0hgP"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764177F32
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236137; cv=none; b=KWIKLtSPuk0lZqYh0utslvTctvlqnVA7+tfOLzgkkTXNa0jevB1nL996qx9Q9d9ksEaDjTx6nJ64KBytUpzD2xbqy6Z5hb1RlmZmR93FRl7rxXaPssu93L2Gw8rXK4Fv3c3isjjxu9+xpXG+JvseZuRJhC9/cAAhPgZgmnX00Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236137; c=relaxed/simple;
	bh=GSPlH5+pAXLIZKGJbEywqVhjn1mLUK2kKRA9D3gLmLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umeB6NLjo9LthpK5osuaD2ZiX67irPgJ0nKJaWhmYkHPUHORv9Ed53CqLn534ZU66mJWPcO4vlqK2T+ayvgqMCpWKJwPXwsVDh00DrhxxAB0AFD3Mc0ImDnQO9OrXeBjp9+EKhNTJ2wj4GGBdJEHTsQD6OdBCF3MdQSQHqtGfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OGGN0hgP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ddbad556a8so2164925ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710236134; x=1710840934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67mIt70RA651hiRrdK60hZHecYixcfjG1H+3EdtMaw8=;
        b=OGGN0hgPlVwscLVLCSdYtcUz1DzqnzA5kLppGDWWuGcrw4VQBLI+nqgwU5eL+rehen
         ifTDKDJbqLrGvn4vit0vb33muMpHENYqXKgH5tchrTdEn4RV1XUCvIS5UK9xmOhLSCSD
         A5ewujSlaJ0uLH9ifHKtocYiEtWgUpuH9JTvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236134; x=1710840934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67mIt70RA651hiRrdK60hZHecYixcfjG1H+3EdtMaw8=;
        b=UwTiYgWnJnj14+Q7XKCIXXWcP+xf6EkwxUrcL1/uI2kVoAY5bx76k33En+6JXXTp6b
         0ZG1TZRNfFSGPefdVTCcUOHm7woy0X8p7fbfWcTVAry+EAbaPXhq4kmIZmpW4+rQBHIb
         /WBW8WwX6RlwwAjvtwcgObTuz4vMhODLfjWqjv+NEjzVPhij5ZMUf3Hzl7dPO2onmqOI
         UnrTOsfZoIgICZIfZsjkrp/2N1dPCWUF273o6W/WTCl4Yp7ucoj5STEGj9XqCXp4o8P1
         2G7ZfeKkqqSyIpO1s2w36GA4mZ9prhdDH/qkhwgefGaZX3qDVNrJAkOBpuCi5FsBiDf7
         ZU/w==
X-Forwarded-Encrypted: i=1; AJvYcCUt8LMxlROAIvnfOa0fYn2ZTalH9SC6XAeeORpIo2jbfPymLNyP5//W60Q/yw6D34DfC10QBry1yMDOn80WNC2VObdq+WUm3Wm+rclA
X-Gm-Message-State: AOJu0YyzQZF+4hVSZqqTfbYmeNEmIDab6CIO/ue/0yS/kC3JiTYERrfH
	CS94SJPbISgAfMFJUEx35aftdzDdAOYvEb5/U2letdA+NMZwFviv9scikkAGLAk4q2h20Gzzpjr
	ry7BayLKkx5WLAAqCztj+vJ6mItkFv/8Sq5je
X-Google-Smtp-Source: AGHT+IFRheMB1JX4C3nOS5cWFzeoNd2uuovpqIFb3L8pxJPZAaYrzJBEw63ZBZYqsASkGhEl0MxTaaKQrIOJs3DVsdo=
X-Received: by 2002:a17:902:ef8d:b0:1dc:adad:f54b with SMTP id
 iz13-20020a170902ef8d00b001dcadadf54bmr8379096plb.44.1710236134159; Tue, 12
 Mar 2024 02:35:34 -0700 (PDT)
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
 <dfdc6a65-3ccf-463c-95df-093f3c2fefd3@collabora.com> <CAEXTbpcPfWQr4iuD2U0zgJUi+BF-rLfyF4iDDiQYBrrv9U=6Xg@mail.gmail.com>
 <90f3f4e2-ced5-4fae-b765-5b802f4895c8@collabora.com>
In-Reply-To: <90f3f4e2-ced5-4fae-b765-5b802f4895c8@collabora.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Tue, 12 Mar 2024 17:35:23 +0800
Message-ID: <CAEXTbpeSyh1YfKsM8cqRjOFA7Ww4ooRxgCxMwXw2F4uCyX=OBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Weiyi Lu <weiyi.lu@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo

On Thu, Mar 7, 2024 at 7:22=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/03/24 12:10, Pin-yen Lin ha scritto:
> > Hi Angelo and Chen-yu,
> >
> > I tried enabling the runtime PM regardless of the .need_pm_runtime
> > flag, and my MT8183 device works well with that with no obvious boot
> > regression.
> >
> > Should I send out another patch that always enables runtime PM in
> > __mtk_clk_simple_probe()? Or is there anything I should test?
> >
>
> Hello Pin-yen,
>
> as I discussed with Chen-Yu - yes, we must make sure that this does not
> create any regression on machines running on other SoC models.
>
> I think it's unlikely that it does, but since the HW is available, being
> extremely careful with validating this change is a good idea :-)
>
> If you can/want to test before we do, sure, please send the new patch and=
,
> when you do, please say that you tested it and on which SoCs; as long as
> it's not just one SoC, that'll be good enough for me.
>
> P.S.: Please don't top-post!
>
> Cheers,
> Angelo

I just tried this on MT8192 and the system looks healthy as well. I'll
send out a patch to enable the runtime PM for all mediatek clock
controllers.

Thanks for your time on reviewing this, and sorry for the top-posting.

Regards,
Pin-yen

>
> > Regards,
> > Pin-yen
> >
> > On Thu, Feb 29, 2024 at 6:36=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 29/02/24 11:34, Chen-Yu Tsai ha scritto:
> >>> On Thu, Feb 29, 2024 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 29/02/24 08:17, Chen-Yu Tsai ha scritto:
> >>>>> On Mon, Feb 26, 2024 at 7:16=E2=80=AFPM AngeloGioacchino Del Regno
> >>>>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>>>
> >>>>>> Il 23/02/24 05:27, Chen-Yu Tsai ha scritto:
> >>>>>>> On Mon, Jan 8, 2024 at 4:18=E2=80=AFPM Pin-yen Lin <treapking@chr=
omium.org> wrote:
> >>>>>>>>
> >>>>>>>> Introduce a new need_pm_runtime variable to mtk_clk_desc to indi=
cate
> >>>>>>>> this clock controller needs runtime PM for its operations.
> >>>>>>>> Also do a runtime PM get on the clock controller during the
> >>>>>>>> probing stage to workaround a possible deadlock.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >>>>>>>
> >>>>>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>>>>>
> >>>>>>> The patch itself looks fine.
> >>>>>>>
> >>>>>>> Besides the MT8183 MFG clock issues, we do actually need this for=
 the
> >>>>>>> MT8192 ADSP clock. Its power domain is not enabled by default.
> >>>>>>>
> >>>>>>
> >>>>>> ...but on MT8195 the ADSP clock works - because the ADSP node exis=
ts.
> >>>>>
> >>>>> That's an indirect dependency that should not be relied on. Say the=
 clock
> >>>>> driver probed but the ADSP hasn't, and you try to read out the curr=
ent
> >>>>> status. What would happen?
> >>>>>
> >>>>> - Read out works fine, because the power domain is default on, and =
hasn't
> >>>>>      been turned off by late cleanup
> >>>>> - Read out is bogus (but you can't tell)
> >>>>> - Read out hangs.
> >>>>>
> >>>>> The third is what happens on MT8192. There's still some issues on t=
hat
> >>>>> front, as even after I applied the ADSP power domain patches from M=
ediaTek,
> >>>>> the readout was still hanging.
> >>>>>
> >>>>
> >>>> That MT8192 lockup story is getting crazy in my head... anyway, besi=
des that,
> >>>> I get the point - I was somehow ignoring the fact that kernel module=
s do exist.
> >>>>
> >>>> Eh, sorry about that :-)
> >>>>
> >>>>>> This poses a question: should we make clock controllers depend on =
power domains,
> >>>>>> or should we keep everything powered off (hence clocks down - no p=
ower consumption)
> >>>>>> *unless* the user exists?
> >>>>>
> >>>>> That's a policy discussion separate from actual hardware dependenci=
es.
> >>>>> *If* the clock controller needs the power domain to be active for t=
he
> >>>>> registers to be accessed, the clock controller *must* have a direct
> >>>>> dependency on the power domain.
> >>>>>
> >>>>
> >>>> I admit I should've worded that better.
> >>>>
> >>>> "should we make clock controllers depend on power domains" was actua=
lly implying
> >>>> "IF those need one" :-)
> >>>>
> >>>> I really wonder if - at this point - it's simply a better idea to no=
t restrict
> >>>> the call to devm_pm_runtime_enable/resume_and_get to `need_runtime_p=
m =3D=3D true`.
> >>>>
> >>>> Do we really need to exclude that on other clock controllers that do=
n't have
> >>>> any power domain dependency? Any side effect?
> >>>>
> >>>> Saying this because if we can avoid yet another per-SoC flag I'm rea=
lly happy,
> >>>> as readability is also impacted and besides - if we ever find out th=
at one of
> >>>> those need a power domain in the future, we'll need just one commit =
and just
> >>>> only in the devicetree, instead of enabling a flag in driver X as we=
ll as that,
> >>>> avoiding some (potentially unnecessary) noise... I guess.
> >>>>
> >>>> P.S.: I just noticed that the return value for the devm_pm_runtime_e=
nable() call
> >>>>          is not being checked!
> >>>>
> >>>> .......
> >>>>
> >>>> In short....
> >>>>
> >>>> Chen-Yu, at this point, do you have any reason why we wouldn't be ab=
le and/or it
> >>>> wouldn't be a good idea to just avoid adding the `need_runtime_pm` f=
lag (meaning
> >>>> that we perform pm_runtime calls for all clock drivers unconditional=
ly)?
> >>>>
> >>>> If this is about longer boot time, I don't think that it's going to =
be more than
> >>>> a millisecond or two, so that should be completely ignorable.
> >>>
> >>> I think it's just more of a "don't enable features you don't need" th=
ing.
> >>> We already ran into a weird deadlock, which is why the devm_pm_runtim=
e_enable()
> >>> call has that comment.
> >>>
> >>> I don't think anyone has actually looked at it. As you said it should=
n't be
> >>> much, at least during boot time. It's one call per clock controller.
> >>>
> >>>> Can you please do a test for that, or should I?
> >>>
> >>> The earliest I can work on it would be some time next week. Does that=
 work
> >>> for you?
> >>>
> >>
> >> The earliest I'd be able to work on this myself would be at the end of=
 next
> >> week if not later.. so yes, please take your time, no worries.
> >>
> >> Thank you!
> >>
> >>> ChenYu
> >>>
> >>>> Cheers
> >>>> Angelo
> >>>>
> >>>>>> For the second one, this means that the *device* gets the power do=
main (adsp), and
> >>>>>> not the clock controller (which clocks are effectively useless if =
there's no user).
> >>>>>
> >>>>> No. See my previous paragraph.
> >>>>>
> >>>>> ChenYu
> >>>>>
> >>>>>> Angelo
> >>>>>>
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>> Changes in v3:
> >>>>>>>> - Update the commit message and the comments before runtime PM c=
all
> >>>>>>>>
> >>>>>>>> Changes in v2:
> >>>>>>>> - Fix the order of error handling
> >>>>>>>> - Update the commit message and add a comment before the runtime=
 PM call
> >>>>>>>>
> >>>>>>>>      drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
> >>>>>>>>      drivers/clk/mediatek/clk-mtk.h |  2 ++
> >>>>>>>>      2 files changed, 21 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediat=
ek/clk-mtk.c
> >>>>>>>> index 2e55368dc4d8..ba1d1c495bc2 100644
> >>>>>>>> --- a/drivers/clk/mediatek/clk-mtk.c
> >>>>>>>> +++ b/drivers/clk/mediatek/clk-mtk.c
> >>>>>>>> @@ -13,6 +13,7 @@
> >>>>>>>>      #include <linux/of.h>
> >>>>>>>>      #include <linux/of_address.h>
> >>>>>>>>      #include <linux/platform_device.h>
> >>>>>>>> +#include <linux/pm_runtime.h>
> >>>>>>>>      #include <linux/slab.h>
> >>>>>>>>
> >>>>>>>>      #include "clk-mtk.h"
> >>>>>>>> @@ -494,6 +495,18 @@ static int __mtk_clk_simple_probe(struct pl=
atform_device *pdev,
> >>>>>>>>                             return IS_ERR(base) ? PTR_ERR(base) =
: -ENOMEM;
> >>>>>>>>             }
> >>>>>>>>
> >>>>>>>> +
> >>>>>>>> +       if (mcd->need_runtime_pm) {
> >>>>>>>> +               devm_pm_runtime_enable(&pdev->dev);
> >>>>>>>> +               /*
> >>>>>>>> +                * Do a pm_runtime_resume_and_get() to workaroun=
d a possible
> >>>>>>>> +                * deadlock between clk_register() and the genpd=
 framework.
> >>>>>>>> +                */
> >>>>>>>> +               r =3D pm_runtime_resume_and_get(&pdev->dev);
> >>>>>>>> +               if (r)
> >>>>>>>> +                       return r;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>>             /* Calculate how many clk_hw_onecell_data entries to=
 allocate */
> >>>>>>>>             num_clks =3D mcd->num_clks + mcd->num_composite_clks=
;
> >>>>>>>>             num_clks +=3D mcd->num_fixed_clks + mcd->num_factor_=
clks;
> >>>>>>>> @@ -574,6 +587,9 @@ static int __mtk_clk_simple_probe(struct pla=
tform_device *pdev,
> >>>>>>>>                             goto unregister_clks;
> >>>>>>>>             }
> >>>>>>>>
> >>>>>>>> +       if (mcd->need_runtime_pm)
> >>>>>>>> +               pm_runtime_put(&pdev->dev);
> >>>>>>>> +
> >>>>>>>>             return r;
> >>>>>>>>
> >>>>>>>>      unregister_clks:
> >>>>>>>> @@ -604,6 +620,9 @@ static int __mtk_clk_simple_probe(struct pla=
tform_device *pdev,
> >>>>>>>>      free_base:
> >>>>>>>>             if (mcd->shared_io && base)
> >>>>>>>>                     iounmap(base);
> >>>>>>>> +
> >>>>>>>> +       if (mcd->need_runtime_pm)
> >>>>>>>> +               pm_runtime_put(&pdev->dev);
> >>>>>>>>             return r;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediat=
ek/clk-mtk.h
> >>>>>>>> index 22096501a60a..c17fe1c2d732 100644
> >>>>>>>> --- a/drivers/clk/mediatek/clk-mtk.h
> >>>>>>>> +++ b/drivers/clk/mediatek/clk-mtk.h
> >>>>>>>> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
> >>>>>>>>
> >>>>>>>>             int (*clk_notifier_func)(struct device *dev, struct =
clk *clk);
> >>>>>>>>             unsigned int mfg_clk_idx;
> >>>>>>>> +
> >>>>>>>> +       bool need_runtime_pm;
> >>>>>>>>      };
> >>>>>>>>
> >>>>>>>>      int mtk_clk_pdev_probe(struct platform_device *pdev);
> >>>>>>>> --
> >>>>>>>> 2.43.0.472.g3155946c3a-goog
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>>>
> >>>>
> >>
>
>
>

