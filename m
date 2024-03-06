Return-Path: <linux-kernel+bounces-93180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52627872BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D535328A926
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186FA63DF;
	Wed,  6 Mar 2024 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fyN/S4Dy"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6091FA4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686120; cv=none; b=DEmstxwZ28KjOgUm2UI1MrLkMuzjPYSmg2G0IJcBv7l24PLcxt/nO63/lxrh7wcO7CJR2Q92YxC6jdn8LVAiiyYaXjU3El3o0m63+2E9+iGbeZs0rZLZb+Uo9lHqXUOW7TFEoYWP5QyVlEdQj4oWoUOyyYXkb70G0pvNCM3qFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686120; c=relaxed/simple;
	bh=Txu0fS25vjnU8C2qLEXlcyuVcuXN+A7vHZsCxW2jq9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV7pK1O6o3pON+pD3Qc5HHc8eXjReAzGnZ4SAgBu39UkogqNrsK8nNKfKH61A5uzuH/L0iwYqLwre8uH4s+pH6oG7TL+ULDjf0p964zZL2ebE+ErlEd3yMe/y/UthnuA2i78Qn9naOFaWItS+zzsebqqVAAW35J3bXZvUkvd7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fyN/S4Dy; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59fc2d22cfaso2293328eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709686118; x=1710290918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8YUqfSxXbAYFGGNrVtx7LjoshPbACk3MhhzqeZBjss=;
        b=fyN/S4Dy6Yj1ywiL6JZjTsC0JsFVXDmdiKYOSXrLprtJtDHemhjJLZuPtvhRTBz5mI
         KCXaU8PFIkm+hPZQrVC6uDhBYwczDD5lJJT/v/Dugd88SJk0eyYS6Lcxt/ekXfkAC839
         W4qcKKmqYRxrIVGVpebacbgAP4VX3IrgCmrw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709686118; x=1710290918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8YUqfSxXbAYFGGNrVtx7LjoshPbACk3MhhzqeZBjss=;
        b=nQIVCitrKsywQ40BIcGgWaQk6ggtNYpQ6ddwiZIcLCsN2nVFyvdSoJViiSi+J9koEM
         a8ub1hmSmnMMT16S1tU/O+nT5bBUQqqXWF/JTU/Y/5/up+W3DeZOCqhcsP0/du8IpWod
         p6xBI5By5F4sMMqPrEE8UJEzi93EdUEwqAufdjdJp84PzpkCkOi9DLQKBp3b7BQ58rbH
         1Yiy9X29mEDCyflefeBeqsGMkOm85SfqvLegJZg6/W64phdD6V5pgxV5zKNkcI46Kutd
         1dx66KTk2jB257N2Up1tSFwM8RGRToDFfYIHBx4rH5Z7DgSJULohD5nouT7NoNO133P0
         CscQ==
X-Forwarded-Encrypted: i=1; AJvYcCXThWwBaR4FTSKBX4v6O67LVwNUjYadzKS4gaYQ4JBOD1waa85DZFWQR967sYIqpFAIsiYUSFJPhPG0kwKMbrBwwL6mEb/Ki2PjPc/t
X-Gm-Message-State: AOJu0YzoALa8UQFdvgydSqcQMuYNd497Ci/dWcdg5f8NnqF6tnahJT7m
	mzFoNHTASijz2TqFhvLuWaJMkM58f+BavEBhEwcuLXIz+76Vjft2jlSwcLFHW/KSHvkxYthfKUv
	FrywiUnlbv0lfBVTdAFcG/safUDyB6Qbh8IBz
X-Google-Smtp-Source: AGHT+IHThZOocFCZMmHlyA07NzSu/hUzk0+wRXvbdVZwsQ63Hxp4vmWebG9XV+3+bsLjN4hF9iqXD16nnPW8ixndG/0=
X-Received: by 2002:a4a:9b17:0:b0:5a0:e486:cbbc with SMTP id
 a23-20020a4a9b17000000b005a0e486cbbcmr3765020ook.6.1709686118132; Tue, 05 Mar
 2024 16:48:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304195214.14563-1-hsinyi@chromium.org> <20240304195214.14563-3-hsinyi@chromium.org>
 <87a5nd4tsg.fsf@intel.com> <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
 <874jdl4k01.fsf@intel.com> <CAJMQK-iWHoh6s-hkcNULzZLjMg9UnTuWfjaJ=YfnHU3sQ1NBEg@mail.gmail.com>
 <CAD=FV=UOhTGnhtc9gOQ5C_aAdgVcB+K7NL9RGm4umunF91Wkpg@mail.gmail.com>
 <87y1ax2iu1.fsf@intel.com> <CAD=FV=WzLLeEw-b0Kug-Pm-9EYm7eHvmukEUJ8VHnu-4YY3WNQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WzLLeEw-b0Kug-Pm-9EYm7eHvmukEUJ8VHnu-4YY3WNQ@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 5 Mar 2024 16:48:12 -0800
Message-ID: <CAJMQK-hE8sWL2rO-N2WZuyXzPhnXZJN4LUL_TwzKGhq_Ozz6Vw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
To: Doug Anderson <dianders@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 11:25=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Mar 5, 2024 at 12:17=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
> >
> > On Mon, 04 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
> > > Hi,
> > >
> > > On Mon, Mar 4, 2024 at 4:19=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.=
org> wrote:
> > >>
> > >> > > Probably change to u32 drm_edid_get_panel_id(const struct drm_ed=
id
> > >> > > *);? Given that we still need to parse id from
> > >> > > drm_edid_read_base_block().
> > >> >
> > >> > No, we no longer need to parse the id outside of drm_edid.c. You'l=
l have
> > >> > the id's in panel code in the form of struct drm_edid_ident (or
> > >> > whatever), and use the match function to see if the opaque drm_edi=
d
> > >> > matches.
> > >> >
> > >> drm_panel prints the panel_id info on whether the panel is detected =
or not.
> > >> https://elixir.bootlin.com/linux/v6.8-rc7/source/drivers/gpu/drm/pan=
el/panel-edp.c#L792
> > >>
> > >> Is it okay to remove this information?
> > >
> > > Hmmm, I guess it also is exported via debugfs, actually. See
> > > detected_panel_show() in panel-edp.c. We probably don't want to remov=
e
> > > that...
> >
> > You currently print the information via panel->detected_panel, which is
> > a struct edp_panel_entry *. That doesn't change. It'll be slightly
> > restructured to contain a struct drm_edid_ident, which will not be an
> > opaque type.
>
> Hmm. As Hsin-Yi pointed out to me offline. Somehow we'll need to get
> the actual panel ID out. Right now in panel-edp.c we have:
>
> dev_warn(dev,
>   "Unknown panel %s %#06x, using conservative timings\n",
>   vend, product_id);
>
> Where "vend" and "product_id" come from the panel ID of a panel that
> we didn't recognize. For instance:
>
>   Unknown panel BOE 0x0731, using conservative timings
>
> We need to still be able to print this message for unrecognized
> panels. Then when we see field reports including this message we know
> that somehow we ended up shipping an unrecognized panel.
>
> Any suggestions on what abstraction you'd like to see to enable us to
> print that message if everything is opaque?

Sent v4 here: https://lore.kernel.org/lkml/20240306004347.974304-1-hsinyi@c=
hromium.org/

Besides that it still keeps drm_edid_get_panel_id() to be used on the
kernel warning when no panel is matched, other parts I think are
following the comments.

Thanks.
>
> -Doug

