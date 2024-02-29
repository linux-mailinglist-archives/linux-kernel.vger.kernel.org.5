Return-Path: <linux-kernel+bounces-86219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A03786C1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4F01C20EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49B744C63;
	Thu, 29 Feb 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXKx++EX"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BB3C062
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191069; cv=none; b=obbjAAuRxFYWRVU/T8sUaHtnE6mZl03L9BLeS2mt2KCiyt97gxnpsuUuIOdmbusiCuDJK+jW580BHJqJKxaSegtdq9SbbSQpp3+jhJiElJAOObIWVueFMFqmbuSnkqxV3acpvq6WX+m8O/5bjwrXmBAheHpyKmf6WKpvxE6QYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191069; c=relaxed/simple;
	bh=i3sCAHbhn/NndzqgR8OKGIz5/kxR595y9PkLDAV9H00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDxebct7RJqQh7yAO+iNRy9jCPXhA1cDUk1ndooY1sQU6rlFzEmpOBuYGBeO0IqBSJKkYT7nszezKdu+9BHK9rQwUMnLH10TZsA1XJr/9mgLhNh2Etz2R1QJz9r5Tuj5RMR34ifb6nYNc0eQ31fzdtFIHBxGHaaQ8KFeBZfDn+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UXKx++EX; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d28387db09so5792791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709191065; x=1709795865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vsIc33sKeduHZUUC8l8uIRDY5GIY+lHtM3gIzAb8YQ=;
        b=UXKx++EXaaCY6i6DVSR+AQXPOaDZsv2OPFa4jKzt0WL2nKpGoG3xmZ11NPPPDe8m01
         EDa3XaBe6Pjl64lDsBqX/qFkjPorTI3TMd9wpiKy+2gOh3prpmqcbQx0T3fIQTSCz8bz
         2LsoZojpvlFWmDkQ8t4exEwGUoqmoIJcX8EcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709191065; x=1709795865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vsIc33sKeduHZUUC8l8uIRDY5GIY+lHtM3gIzAb8YQ=;
        b=jDVESr/NtRhmpJXu6Qi4bIe5IghSYz/1M/ePNiC3Fhvgkv79VLJYHjj86+T46G2Ffn
         o0clZ7MQo7rtO4S8X6MblUzy6iVogjCByWIdqS3a1ZUigTAS/8STnMkHOXmlQakqkBDA
         C1WT8t4rKKfG5N528oF5qVV3neG4R+HLOOM4fgjVe3No6YGa01Nds5TsKHqN8P8u+uc2
         phA2NL65WQPG6dBB8wyo92YGXk1GUpiys7YTtIr6wKVM87fvpTboOInLACXWwnYuXkpG
         ULkO4F/y0WE9CRtbEZw0wiJy5aFhLWbOkBBq8UVkOsp49Fw3CLgCFDfhoi8uKRwh9ACo
         qqcw==
X-Forwarded-Encrypted: i=1; AJvYcCWlu7huaqeJNppQ1tiK/paPnFTHC+I6U6kGYnC7cKFKoD4qxjY5uPCeRRD44yRTYUzLY9M/uNvsI0er00/yqBojCzCVz3C9UypsYpXz
X-Gm-Message-State: AOJu0Yz9ORP7yS+WR1t5ZaEs0z+XGOplX31nkPnITcmEa70tWqjlq0UM
	Q7gJ/juBkjYGfj5BTTHTXSte6jmWPruYdJ84rWeH8C2HdhbmqgFjQCOAxGCW/DriAuY/iVz0lZi
	ZIG4AWeOy2mDnhAqPLIy25eqNeV0mnu2ZFhjq
X-Google-Smtp-Source: AGHT+IFGnhfqo9wpMLbUOWT9xaaCwa78RftbvQ4WT4QBDMgmaFEdTyD2WRaCG81GIICXSZk9azfqp0otmo8BfGfqq8w=
X-Received: by 2002:a2e:98c6:0:b0:2d2:3b9e:dcff with SMTP id
 s6-20020a2e98c6000000b002d23b9edcffmr691931ljj.46.1709191065361; Wed, 28 Feb
 2024 23:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108081834.408403-1-treapking@chromium.org>
 <CAGXv+5EnBt+7WrNb-QyziEaCihvjhFVf2tpzk=XyAoeELqucaw@mail.gmail.com> <e0e6febf-1045-49f8-a200-8bc095b0fa50@collabora.com>
In-Reply-To: <e0e6febf-1045-49f8-a200-8bc095b0fa50@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 29 Feb 2024 15:17:34 +0800
Message-ID: <CAGXv+5F5YFRKjaXu_XbXrUhqKL0NSRyt6tniQYfhRh+fsaxqmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pin-yen Lin <treapking@chromium.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Weiyi Lu <weiyi.lu@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:16=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/02/24 05:27, Chen-Yu Tsai ha scritto:
> > On Mon, Jan 8, 2024 at 4:18=E2=80=AFPM Pin-yen Lin <treapking@chromium.=
org> wrote:
> >>
> >> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
> >> this clock controller needs runtime PM for its operations.
> >> Also do a runtime PM get on the clock controller during the
> >> probing stage to workaround a possible deadlock.
> >>
> >> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > The patch itself looks fine.
> >
> > Besides the MT8183 MFG clock issues, we do actually need this for the
> > MT8192 ADSP clock. Its power domain is not enabled by default.
> >
>
> ...but on MT8195 the ADSP clock works - because the ADSP node exists.

That's an indirect dependency that should not be relied on. Say the clock
driver probed but the ADSP hasn't, and you try to read out the current
status. What would happen?

- Read out works fine, because the power domain is default on, and hasn't
  been turned off by late cleanup
- Read out is bogus (but you can't tell)
- Read out hangs.

The third is what happens on MT8192. There's still some issues on that
front, as even after I applied the ADSP power domain patches from MediaTek,
the readout was still hanging.

> This poses a question: should we make clock controllers depend on power d=
omains,
> or should we keep everything powered off (hence clocks down - no power co=
nsumption)
> *unless* the user exists?

That's a policy discussion separate from actual hardware dependencies.
*If* the clock controller needs the power domain to be active for the
registers to be accessed, the clock controller *must* have a direct
dependency on the power domain.

> For the second one, this means that the *device* gets the power domain (a=
dsp), and
> not the clock controller (which clocks are effectively useless if there's=
 no user).

No. See my previous paragraph.

ChenYu

> Angelo
>
> >> ---
> >>
> >> Changes in v3:
> >> - Update the commit message and the comments before runtime PM call
> >>
> >> Changes in v2:
> >> - Fix the order of error handling
> >> - Update the commit message and add a comment before the runtime PM ca=
ll
> >>
> >>   drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
> >>   drivers/clk/mediatek/clk-mtk.h |  2 ++
> >>   2 files changed, 21 insertions(+)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk=
-mtk.c
> >> index 2e55368dc4d8..ba1d1c495bc2 100644
> >> --- a/drivers/clk/mediatek/clk-mtk.c
> >> +++ b/drivers/clk/mediatek/clk-mtk.c
> >> @@ -13,6 +13,7 @@
> >>   #include <linux/of.h>
> >>   #include <linux/of_address.h>
> >>   #include <linux/platform_device.h>
> >> +#include <linux/pm_runtime.h>
> >>   #include <linux/slab.h>
> >>
> >>   #include "clk-mtk.h"
> >> @@ -494,6 +495,18 @@ static int __mtk_clk_simple_probe(struct platform=
_device *pdev,
> >>                          return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM=
;
> >>          }
> >>
> >> +
> >> +       if (mcd->need_runtime_pm) {
> >> +               devm_pm_runtime_enable(&pdev->dev);
> >> +               /*
> >> +                * Do a pm_runtime_resume_and_get() to workaround a po=
ssible
> >> +                * deadlock between clk_register() and the genpd frame=
work.
> >> +                */
> >> +               r =3D pm_runtime_resume_and_get(&pdev->dev);
> >> +               if (r)
> >> +                       return r;
> >> +       }
> >> +
> >>          /* Calculate how many clk_hw_onecell_data entries to allocate=
 */
> >>          num_clks =3D mcd->num_clks + mcd->num_composite_clks;
> >>          num_clks +=3D mcd->num_fixed_clks + mcd->num_factor_clks;
> >> @@ -574,6 +587,9 @@ static int __mtk_clk_simple_probe(struct platform_=
device *pdev,
> >>                          goto unregister_clks;
> >>          }
> >>
> >> +       if (mcd->need_runtime_pm)
> >> +               pm_runtime_put(&pdev->dev);
> >> +
> >>          return r;
> >>
> >>   unregister_clks:
> >> @@ -604,6 +620,9 @@ static int __mtk_clk_simple_probe(struct platform_=
device *pdev,
> >>   free_base:
> >>          if (mcd->shared_io && base)
> >>                  iounmap(base);
> >> +
> >> +       if (mcd->need_runtime_pm)
> >> +               pm_runtime_put(&pdev->dev);
> >>          return r;
> >>   }
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk=
-mtk.h
> >> index 22096501a60a..c17fe1c2d732 100644
> >> --- a/drivers/clk/mediatek/clk-mtk.h
> >> +++ b/drivers/clk/mediatek/clk-mtk.h
> >> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
> >>
> >>          int (*clk_notifier_func)(struct device *dev, struct clk *clk)=
;
> >>          unsigned int mfg_clk_idx;
> >> +
> >> +       bool need_runtime_pm;
> >>   };
> >>
> >>   int mtk_clk_pdev_probe(struct platform_device *pdev);
> >> --
> >> 2.43.0.472.g3155946c3a-goog
> >>
>
>
>

