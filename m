Return-Path: <linux-kernel+bounces-167292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B88BA74D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E31C215E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D451465B5;
	Fri,  3 May 2024 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GO4Tu4c3"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780421465A9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719538; cv=none; b=arFGJifIlrGSVOQhUk76fEWXFUAIr66vtiGAP1xB30C88ZoUj3niUUl9fs+VBYHdocUImWfr0BXvHVUb6TCDMaAarRsOlV880d/eXo3wfRV/doSZyyGMi1dSDDW2L3bU0fK/6dRd2kJyguNv7/tjsRzqey87HZv3XuAMAfsmuuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719538; c=relaxed/simple;
	bh=uiquuqkMJF4ptltnUi63scVpSntF814sk4NepyC7uso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEZOc2YUiitXGd4X8XZ/+fliReyv5qCkX9ouB1qFDUoo2ZYxIhkeY834Zrf6ItbbNB+IQJK8hb9gWAlCYFHaVceqT3Uft/0msP24mjy8Gfi9LlrDNadeOQYVF2KpbOPyjYm7FJ2nzH2YFUWqOJFCD6upRBeiDfmENrvA53r5z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GO4Tu4c3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a599a298990so17670266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714719534; x=1715324334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXjaL+il8Ez+7d6ytrKawnux38fevS26j1EU1z2Rw38=;
        b=GO4Tu4c3L1KFtpt5IS1AqabL8SSjZmvgJJKuZgkawT3L7xnwzR/yu7OCgkDLf/IDLe
         KbG2C+0hVCbJNPf6D47jlihg0L0PnP2bqa1oOVOJLzs0T8TmuuHjJ5nqhuy4RebnyCX0
         zfp1d9slbsz7PhtdxcP7lqg0GdPshO3CGwoDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714719534; x=1715324334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXjaL+il8Ez+7d6ytrKawnux38fevS26j1EU1z2Rw38=;
        b=IafQem/YK62NFCXk5+kG34qtyjnuh5LhzFuqLdPEoqSCoTT4Ifm2FT6OSihzPTT+M4
         WfkDTbiK6ey0ZcWqB2X6HYUj5zdkCKwuWnsjadP3EWpLGfOW3zTS2Dz1dHvWvrC+oIyv
         uxH0grkaiEKQUHTqoqk7PLgAg1pZtY9w/NJxNKO9QkELnCbHpF7HCbyzMCfQxO9v+8mJ
         ATHIn7iEmRjf+bIidYAtD+5YLtqWVVEhYvzizlF1fxlfW+1zcn0nJYU/pMNAUPXGDRwc
         rc0cb6m56o62KopQbbTxj4/8sJ7KmO+4PPWNs1ULM88+cPW+lU5VNPWmIDKe2sWfhLC8
         JQcg==
X-Forwarded-Encrypted: i=1; AJvYcCWc54vBGU01fFYNm/hzBsK1N9nzZ2GWuAWv6tRWm69OI6Mkb5fc589e2glrVT8/ibd36bgoJO8GtPtYMKBfEAWBqDDW3DwbFg2oqi9S
X-Gm-Message-State: AOJu0YwoQNhGg5eJOYp6wDFlSeWQuswrQRqGTbgGM8DbR07/ox+XPeQo
	bgrqaG6v+MlX4QHxVQcvcA5/Y0yCiAkNs86ZLU/RgcP+Y9wKQ/joihygSH4ReMrLJ18KkKH045K
	2vA==
X-Google-Smtp-Source: AGHT+IH4DE4vUultqMz/jqF3t31DyCYVAbBfIOD/3w4Ojf2PiDA5XxlWf7rSapMP1WGoNQHSsOMBmQ==
X-Received: by 2002:a50:cc96:0:b0:572:32e4:daca with SMTP id q22-20020a50cc96000000b0057232e4dacamr824446edi.25.1714719533935;
        Thu, 02 May 2024 23:58:53 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id o5-20020aa7c7c5000000b00572c25023b1sm1365366eds.0.2024.05.02.23.58.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 23:58:53 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a595199cb9bso387502866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 23:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtOUTOB++mSjfCs3Djau1FHCaEqGSVPqcq1b1LaJkSMg9JnjX+iS4WTltVD205u8J1tO5mwev/MYqusV27ZemlDr6loNt/y9Aj4k0Y
X-Received: by 2002:a17:906:dc04:b0:a52:2d83:1483 with SMTP id
 yy4-20020a170906dc0400b00a522d831483mr990970ejb.53.1714719532753; Thu, 02 May
 2024 23:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
 <20240502-anx-tdm-v1-1-894a9f634f44@chromium.org> <20240502-sheath-share-eac9afc24da9@spud>
In-Reply-To: <20240502-sheath-share-eac9afc24da9@spud>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 3 May 2024 14:58:16 +0800
X-Gmail-Original-Message-ID: <CAHc4DN+mCbBuB3D9kB2x8HYj9iaX7t6Q4Qjj7hotH3u=eAHJSg@mail.gmail.com>
Message-ID: <CAHc4DN+mCbBuB3D9kB2x8HYj9iaX7t6Q4Qjj7hotH3u=eAHJSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add a perporty to
 change TDM setting
To: Conor Dooley <conor@kernel.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:47=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 02, 2024 at 09:03:31AM +0000, Hsin-Te Yuan wrote:
> > Add a perporty to indicate whether anx7625 should shift the first audio
> > data bit. The default TDM setting is to shift the first audio data bit.
> >
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> >  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml          =
| 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,=
anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,an=
x7625.yaml
> > index a1ed1004651b9..915d5d54a2160 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625=
yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625=
yaml
> > @@ -82,6 +82,10 @@ properties:
> >      type: boolean
> >      description: let the driver enable audio HDMI codec function or no=
t.
> >
> > +  no-shift-audio-data:
> > +    type: boolean
> > +    description: Disable the first audio data bit shift in the TDM set=
tings.
>
> This just looks like software policy, since there's no mention in the
> commit message or description as to what property of the hardware causes
> this to be required. Can you please explain why this property is needed?
>
> You're also missing a vendor prefix.
>
> Thanks,
> Conor.
>
> > +
> >    aux-bus:
> >      $ref: /schemas/display/dp-aux-bus.yaml#
> >
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >

Sorry, I found this feature in the datasheet originally, but after
deeper investigation, it seems that this feature should be used to
support i2s dsp mode b instead of being used this way. Note that the
difference between i2s dsp mode a and b is whether or not to shift the
audio data by 1 clock cycle.

Regards,
Hsin-Te

