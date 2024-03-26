Return-Path: <linux-kernel+bounces-119418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22D88C88F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB55B2A070
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BB13C8F7;
	Tue, 26 Mar 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MBmzMMGs"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F013C66F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469014; cv=none; b=D02AUvKP5yBIzlQ85hd0opQYKPYU3Cnqd/JY7Whr8MQKuJdxb/yx35+rSkNbsJL2GzJa3cD46arkV8mWO7hM03VUBHxX3CtMv1fP5ZhFANNChKr3umcr40jiudwf21zE/AdYkGD9IQ7/CjrBhRuOllpOCHUk4XQfG/k72i8/Uw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469014; c=relaxed/simple;
	bh=F78xu2buOwEKxHIquyItfHRMF3G7JqzjmbMXkVCfm5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCP5JSbT566xXo8fTRN62l6OKxoa6y0Knsut7Vw5kfVqZ2r2iy0RC2aVO1JqmAMBvJPgFpRXQmzqJLX36PqzRdAWQ3YXRN3OmMGqxxpdjnTzimNsOKW3UpsAtbP11dtCBWH2H2A2/BMZlX8QhT+3eqwVgk1hf4dnvCNbTMr/CFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MBmzMMGs; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690c43c5b5aso32860996d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711469007; x=1712073807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W6aqq99DQNeE6Hy7b4PvjAgdtFfco4Dhwzml8Tueag=;
        b=MBmzMMGsFySRkkZabpLNY9UptSwIMQ/wOWop/70sPok6sldBeMVUYzrtpdrZaJAqQX
         9pH8GTjkYsqoXdnVla1eH/JzaDWe7MSRwjkzeFBaDJqEfvfkGof7No2EuPGKNSsTuFQf
         FGzVMtIxkhVL/Yl/hUpFBAexoBzhjKmauwv8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469007; x=1712073807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W6aqq99DQNeE6Hy7b4PvjAgdtFfco4Dhwzml8Tueag=;
        b=JDwL/TICkXsgdVxwOjZkydZWf3DfXivPt/2m8X/VrdFXr8Nt14kbbbBG3pImGEvggr
         +/t66eo4k9o6RLlQ5JuOgDyeoL/As12GC2Pm2yq/+2wRPjbQVDtKC4QRz0JY1bLCSEq7
         P9ZOOqFfJbyaw1myWstzgXZEY3/O1vSnTqigczmrjs9pz8KD5anUre5Z9WFhfeXR2d9i
         bqd3Z+9rqUK61/n20AcRU/KeJHbQ4v6MzaXTla9/nBopE8VTO+/y6NEMR2WoWqHiC6eR
         oPYpqsJA6w4r6k3AwO0bOEtgDKEI6qBjqDRWf2zdK+H1DvP0CL9e1DwPVzQk7z0Kusjh
         GVqA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ujpkii+kfEezBMD7qNAJigMzVL7Erm6CumZpya2XXWPUIQUhU9iRhxJcu1JDZZhSlh3VM0SePCiOy4gaDPEGNNqTp7bBJBafkiB6
X-Gm-Message-State: AOJu0YxZzbtwB7rvRdfTel/Vah2zAGm9+IvQoQhbN/WLvwYlHi3T2rj9
	Ohc5axQlEALw7Nty3QLM504id4vsa8xwWsOmONCidLMKgry7J34W5P6EQz0FMwIe7QSl8xLl19o
	=
X-Google-Smtp-Source: AGHT+IGyXpVZVxQwvSQIxaKRPORnTq+G2FFrt/16/o39+bpaQkWNEyVDrYZYQwlr4Hbm7KZZIzLnkw==
X-Received: by 2002:a0c:f2c4:0:b0:696:a22a:2c24 with SMTP id c4-20020a0cf2c4000000b00696a22a2c24mr1200003qvm.0.1711469007196;
        Tue, 26 Mar 2024 09:03:27 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id q15-20020a056214194f00b0069183f7fc99sm5290455qvk.144.2024.03.26.09.03.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:03:25 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so364411cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:03:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIyB3IaF6fnXpbAv6vncD8XjzjpuU/k5XgyVoIcVM9BPEhkaqS6YCVT0oylPhChevXopwnNaJcAwqJmvmgnY5YcCDHKW8YSCjC6Jvn
X-Received: by 2002:a05:622a:4c89:b0:431:6352:80fb with SMTP id
 ez9-20020a05622a4c8900b00431635280fbmr253080qtb.16.1711469005170; Tue, 26 Mar
 2024 09:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319135836.v2.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
 <CAA8EJpoCu5+KPJEeCSRLCgSQmTNxNsVCfP=9e4mtFaqADuuKBg@mail.gmail.com>
In-Reply-To: <CAA8EJpoCu5+KPJEeCSRLCgSQmTNxNsVCfP=9e4mtFaqADuuKBg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 26 Mar 2024 09:03:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4YGNUBRs2yTuEHKswsZs8TQdF8huRhCvtuvqc0R=P+Q@mail.gmail.com>
Message-ID: <CAD=FV=V4YGNUBRs2yTuEHKswsZs8TQdF8huRhCvtuvqc0R=P+Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: Clarify that wait_hpd_asserted() is not
 optional for panels
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Imre Deak <imre.deak@intel.com>, 
	Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 3:45=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 19 Mar 2024 at 22:58, Douglas Anderson <dianders@chromium.org> wr=
ote:
> >
> > In response to my patch removing the "wait for HPD" logic at the
> > beginning of the MSM DP transfer() callback [1], we had some debate
> > about what the "This is an optional function" meant in the
> > documentation of the wait_hpd_asserted() callback. Let's clarify.
> >
> > As talked about in the MSM DP patch [1], before wait_hpd_asserted()
> > was introduced there was no great way for panel drivers to wait for
> > HPD in the case that the "built-in" HPD signal was used. Panel drivers
> > could only wait for HPD if a GPIO was used. At the time, we ended up
> > just saying that if we were using the "built-in" HPD signal that DP
> > AUX controllers needed to wait for HPD themselves at the beginning of
> > their transfer() callback. The fact that the wait for HPD at the
> > beginning of transfer() was awkward/problematic was the whole reason
> > wait_hpd_asserted() was added.
> >
> > Let's make it obvious that if a DP AUX controller implements
> > wait_hpd_asserted() that they don't need a loop waiting for HPD at the
> > start of their transfer() function. We'll still allow DP controllers
> > to work the old way but mark it as deprecated.
> >
> > [1] https://lore.kernel.org/r/20240315143621.v2.3.I535606f6d4f7e3e5588b=
b75c55996f61980183cd@changeid
> >
> > Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I would consider changing the docs to say that implementing
> > wait_hpd_asserted() is actually _required_ for any DP controllers that
> > want to support eDP panels parented on the DP AUX bus. The issue is
> > that one DP controller (tegra/dpaux.c, found by looking for those that
> > include display/drm_dp_aux_bus.h) does populate the DP AUX bus but
> > doesn't implement wait_hpd_asserted(). I'm actually not sure how/if
> > this work on tegra since I also don't see any delay loop for HPD in
> > tegra's transfer() callback. For now, I've left wait_hpd_asserted() as
> > optional and described the old/deprecated way things used to work
> > before wait_hpd_asserted().
> >
> > Changes in v2:
> > - Make it clear that panels don't need to call if HPD is a GPIO.
> >
> >  include/drm/display/drm_dp_helper.h | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I don't think this is controversial and I've been involved / written
most of the code for eDP panel interactions, so I think I can land
this myself with Dmitry and Abhinav's review (thanks!). If someone
later comes back with additional thoughts I'm happy to update things
more.

Pushed to drm-misc-next:

6376eb8b9115 drm/dp: Clarify that wait_hpd_asserted() is not optional for p=
anels

