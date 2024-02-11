Return-Path: <linux-kernel+bounces-60669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD0585083C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19CB1F219BB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE895915F;
	Sun, 11 Feb 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dATkH9CM"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9636102
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707641554; cv=none; b=isDuZYTro7/KwbuKRDOQkMjKgGsAqz/FBak6aDOQnGGXW6ndM0vwO9m36U1sjNk3lsn1b/XMJc1KHVadxPR3l4eZ2tKQ829a1FdhFGLdhyK/yPY3yB01m4deTcwPJBuThVUIRGnXSNCSztONLtbEzPyxEMgj3d99mQa+ri7+3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707641554; c=relaxed/simple;
	bh=8artP/TApEldtwBPGtbWZ5bG6juyp+Nno5U5w89q+Bw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXmhWXycgcXF/ZfbYqZv/OmmIJc3yKVW5xH4V8O4TbaER5gEjQV/gB9h7A50x9btXkESRr4kre2U/HyU8MKYVNGWA1TyBOVlDQ6E6Mld/51n3KrU8Ac+830trco47nxOtuEOPcVBetXyyEr1UxhJflOkUkjrgbrCM2a+ZnYWtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dATkH9CM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so31700241fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 00:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707641550; x=1708246350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLizHpyv/f+DbolOV42ApsVVXm0Dg0xdAa06w8qDvks=;
        b=dATkH9CMfh1+IqH8rXZkSRL4Zi2we1WcG69zvAmuUtlHPw1bQgT8pboXvg2dewDwxp
         bujEh2C5aIKpLkaZixEmw9Nud9ZHfp6NjV/BfOOBN2dCQlm717g7ebS9Xx1oOzoEEXRs
         4yDi4IBAIfyXJt0/cGbMD/tHPggOAg0yPybEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707641550; x=1708246350;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLizHpyv/f+DbolOV42ApsVVXm0Dg0xdAa06w8qDvks=;
        b=dwDxlDDzVIF5SqNL25kFoBucehcjjxbFsyYHsXOGdMMYjCT0yahJBz7yQxAtmzS+17
         pcB8sGmFw6M+ca2/pnaq43jyql6srl3hnt6Y9vokFOWUytLpYrj6kE4ch9hZq6nKKPBg
         wQbI6DvY3ilS339nMkK1KU5iEaKNaRfX00+7sTK6XHNCZc8fw8peJaUntN29tnH3tphH
         Uqb+5cYlA2Jy7/wWV4UNUGZBOSXlVh2Rse31mvVvp1dkZh5IQrs4K1O1XB4yT1uTaiNX
         YLjjGvYcAK6YFVwOGddd7kJFaB8M3SVOqP4TVMhTOeU/oK+LzC72NoOzqeGlrgFgsJpF
         gNPw==
X-Gm-Message-State: AOJu0YzH5lH3Jb0gipVYkfjX0sTyDOyogcFxA2EOu+MTgJS/dEVL8YSW
	EZJprXcPdqCCXXj7HfxaPpu+J3F943DZULtA76lAnEdL0Ujt+mXP1+qRdDKQd4Ch+FlNQytTdfF
	Mk/qMcvANwIb9/BjfCC2nVqr5huaRNQM7mhxA
X-Google-Smtp-Source: AGHT+IHu/AGsCNFvoS5rSkn2rcab3CL0eH8KJbrh21hRNc1eAtuTTEdGTiVu8+aUJynphjEZq0QVTIz4VjEp3nNrSpQ=
X-Received: by 2002:a05:6512:21c7:b0:511:8cb2:2f80 with SMTP id
 d7-20020a05651221c700b005118cb22f80mr267458lft.43.1707641549800; Sun, 11 Feb
 2024 00:52:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Feb 2024 03:52:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAA8EJpo1g9QKq1skibqSj9yc3mNSfkcts9oVf_vGjVjDzVZwiA@mail.gmail.com>
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-15-swboyd@chromium.org>
 <CAA8EJpo1g9QKq1skibqSj9yc3mNSfkcts9oVf_vGjVjDzVZwiA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Sun, 11 Feb 2024 03:52:28 -0500
Message-ID: <CAE-0n50xu83yYoXoFYEDrkuMw_exS=UGqsU+EwtTOGZyNW+k=Q@mail.gmail.com>
Subject: Re: [PATCH 14/22] platform/chrome: cros_typec_switch: Add support for
 signaling HPD to drm_bridge
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Prashant Malani <pmalani@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-02-10 06:10:31)
> On Sat, 10 Feb 2024 at 09:14, Stephen Boyd <swboyd@chromium.org> wrote:
> > diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
> > index 769de2889f2f..d8fb6662cf8d 100644
> > --- a/drivers/platform/chrome/cros_typec_switch.c
> > +++ b/drivers/platform/chrome/cros_typec_switch.c
> > @@ -18,6 +19,15 @@
> >  #include <linux/usb/typec_mux.h>
> >  #include <linux/usb/typec_retimer.h>
> >
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_print.h>
> > +
> > +struct cros_typec_dp_bridge {
> > +       struct cros_typec_switch_data *sdata;
> > +       bool hpd_enabled;
> > +       struct drm_bridge bridge;
> > +};
>
> Is there any chance that you can use drm_dp_hpd_bridge_register() /
> drm_aux_hpd_bridge_notify() instead of implementing another
> drm_bridge?
> If something is missing from the existing implementation we can
> probably work that out.

Yeah I think that can work. I had put the drm_bridge in this driver
because I needed a 'struct device' per DP phy, but I think that problem
goes away with an auxiliary device, so that is nicely solved.

I'll have to add logic about typec ports to that auxiliary driver
though, like mapping data-lanes and handling lane assignments. And then
I'll move this code from the cros_typec_switch driver to the
cros_ec_typec driver so it can be called outside of the typec mux set
path. That's probably better because it's sort of bolted on to the
cros_typec_switch driver. We'll need to know if the DP phy needs to
handle orientation or if the EC is doing that somehow, so probably I'll
need to add a DT property to the google,cros-ec-typec binding to
indicate that orientation control is needed.

It looks like I should add a new auxiliary device, like
'dp_typec_bridge', and have some other function like
drm_dp_typec_bridge_register() for that. I can wrap the 'struct
drm_aux_hpd_bridge_data' with a 'struct drm_aux_typec_bridge_data' and
then the typec port information can live there. HPD can still be
signaled with drm_aux_hpd_bridge_notify() but other functions can be
used to set the active typec port, e.g.
drm_aux_typec_bridge_set_active_port(), and then get orientation with
typec_get_orientation() in the atomic_check().

