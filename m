Return-Path: <linux-kernel+bounces-56242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2278784C7CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBB2285E90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1ED224CC;
	Wed,  7 Feb 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeO1YyL0"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E524422F0F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299073; cv=none; b=qEODDPGYamym6k/dzwZJ6ibMfnWP8bMaEfznwfp1vu0Ox0EKRZJ8HRpylT9EDGgHlaKxAE6nH7ayvlW5324wsgrKBxH5EjfM3RBa6oRCy/nqQ8MUeWJyP8YSb2o42Jy/a30d6RzSZJZ1mXQEj3m8IdLchNVwaBTIiy0P/heVp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299073; c=relaxed/simple;
	bh=FBAjgNF5XCNxFSaP7LR1wyzwtafQZnJqZCxxZPnoGWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otEo5z9ohmzDhQTtzCD3vgw2mKaQmsFzQ+Y9LM37czBLoRiPeU7cwr8gaJdlviQdLkLkolw5V+DLD4UXTavFUgBUXSu8l9R2QJ0NOqWn9EUow6Oe7ybjTbwSq8CQpnMqA73nHGcsuq+AOQ1IMJX39jWf/4rYZqfYh5z9XIUqZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PeO1YyL0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60495209415so2240127b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707299071; x=1707903871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Qq9fKE0PbbyCrGJIA20pSw+ym9q88uvFFEEL0mTROA=;
        b=PeO1YyL0eKxskjhs3AShrz99FyPJNyyid0uHYjcO9u+IDJ61NYucQ6Rnz6cctTXUAe
         oZeJNRRsYVQvdQVWbrUqdKszARaFr+ogUZ8KFSpI5Mi1PYleCI3GE40J2hxpPy5QQebV
         DHt3en9vkfM+Q689eQby8WYgCrBYjlqVclESHYTvzzQ0O11sPEWH9LGXfii7tSOJIWzM
         PUNkvvI4SOyzzphlbm7wFoihWuLGWB0VLt6jRYYBeJf7gHsRT22Q4owb8baqE+Emt3GH
         kQC/Dz7Y9f/8YE1Z/JVDY5ZE0c/WGvLqvfxTy32Q4mnL+epqoNBZIVW/+AkJH0VW3ngk
         zitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299071; x=1707903871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Qq9fKE0PbbyCrGJIA20pSw+ym9q88uvFFEEL0mTROA=;
        b=P6oTeLEiM/GeQFiFhoy9Bkdk13JD93Q7x7XhU4AZ7Bi8JhrprCnK4FF/u9zh0rzm/j
         ZhNmtcrLHuguRAb7K5f1zlrlCLPH/fnmBfYhfXF5hW7SNi2jf8DXauG09fhICr1vsxBo
         w+s3gnyVRjqbtGO8j8pk+s+MChS7uztfQEFDQ8cJ7gdyHfN4tevGe5o6N5KBqE2tkVAx
         cw0oDswB3/bGfANxbSXX77cfvCAdHRH0B3sjlKl0UR/HoMz9jyry/63xKx/ChRp4iCeg
         R1NZM1azsGE+D9y0X6sPh7eaXWjnF4v4sUwz5wlRJRclxngMO0RzRgDRu9irMzCqYfEr
         zIag==
X-Gm-Message-State: AOJu0YxkODzLlMfi6ZFjh9MfViOOqc1IyX2flu3CAQzXh8TFpKubSldv
	DFoz3Rztrirq0fHz4dZRPjftGNBunPLlsf1VQg1T/y25U/ymyM+ULoHLNQ3Twlt7uxWRL5wgbBR
	EmDcrw/9a3DQQ8tCHdIS8eM8tctIhBoJGIwkhEw==
X-Google-Smtp-Source: AGHT+IGnNsEbsmiOhjkKEnxryb14NGX6I9zOgtrEXZxh49eoiYIjEQ/Cu/1+CeZbgwi0SgrY+47qDSRAYACNAXYqpdQ=
X-Received: by 2002:a81:4893:0:b0:5ff:7cca:a434 with SMTP id
 v141-20020a814893000000b005ff7ccaa434mr3711732ywa.51.1707299070789; Wed, 07
 Feb 2024 01:44:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
 <20240207-spmi-multi-master-support-v1-1-ce57f301c7fd@linaro.org>
 <CAA8EJpqsJmv36=o1aTjVH6eMHXMg8BHNpiDvs+Q8YB23ezVGtQ@mail.gmail.com>
 <ZcMvFtAwQQjAZhk6@linaro.org> <CAA8EJprqWLX7_yWZzKp3FAKFGkSkk041f9hj1uXuRBrbH5APyQ@mail.gmail.com>
 <ZcNIddeG6VHxBEOQ@linaro.org>
In-Reply-To: <ZcNIddeG6VHxBEOQ@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 11:44:19 +0200
Message-ID: <CAA8EJprgkM9fO967Swrzjf4PYuVoSpmXLU-zadN4eKhjez30Gg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] spmi: Add support for multi-master
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 11:08, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-02-07 09:23:09, Dmitry Baryshkov wrote:
> > On Wed, 7 Feb 2024 at 09:19, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > On 24-02-07 01:55:39, Dmitry Baryshkov wrote:
> > > > On Wed, 7 Feb 2024 at 01:34, Abel Vesa <abel.vesa@linaro.org> wrote:
> > > > >
> > > > > Some newer SPMI controllers support multiple bus masters.
> > > > > Such a master can control multiple slave devices. The generic
> > > > > framework needs to be able to pass on the master id to the
> > > > > controller-specific driver. So do that. The framework will
> > > > > check if the devicetree child nodes are actually bus masters
> > > > > and will register the devices for each master. The legacy
> > > > > approach will still be supported for backwards compatibility.
> > > >
> > > > Please remind me, are those two actual bus musters driving a single
> > > > bus in parallel or two SPMI buses being handled by a single device? In
> > > > the latter case this implementation is incorrect. There should be
> > > > multiple spmi_controller instances, one for each bus. Allocate them in
> > > > a loop and set ctrl->dev.of_node after allocating.
> > >
> > > It's two SPMI buses (two sets of wires) handled by the same controller,
> > > HW-wise.
> > >
> > > If we register two spmi controllers with the kernel framework, it will
> > > be HW inaccurate, because there is just one controller which has
> > > multiple masters.
> >
> > struct spmi_controller is a controller for a single bus. Inside your
> > device you have two SPMI buses, each can be controlled by its own
> > struct spmi_controller. Just like devices that control multiple I2C,
> > SPI or USB busses register a separate instance of the bus controller.
>
> Well, this is what this patchset is trying to do in the generic part.
> The SPMI controller supports multiple buses (HW-wise) and therefore SW
> implementation shouldn't be tied to single bus requirement.

SPMI controller doesn't support multiple buses. You have a device
which has two SPMI controllers inside. Just like all multi-bus
controllers.

>
> >
> > >
> > > I'm not saying it might not work. But, to me, it looks more like a hack.
> > >
> > > Basically, we would be mapping HW bus masters to kernel controllers.
> >
> > Buses, not just masters.
> >
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > ---
> > > > >  drivers/spmi/spmi-mtk-pmif.c |  6 ++--
> > > > >  drivers/spmi/spmi-pmic-arb.c | 10 +++---
> > > > >  drivers/spmi/spmi.c          | 76 ++++++++++++++++++++++++++++++--------------
> > > > >  include/linux/spmi.h         | 10 +++---
> > > > >  4 files changed, 67 insertions(+), 35 deletions(-)
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

