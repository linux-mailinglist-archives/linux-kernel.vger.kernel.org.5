Return-Path: <linux-kernel+bounces-165518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0008B8D80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EC9B2116C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCC12FB09;
	Wed,  1 May 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTIHg8ih"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F244F898
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578924; cv=none; b=FREhtx/OQRsC/cNmYeERDa8F9C+AF7XhvYLdYfIHSNNjLjDKfS+xRJjXwd3TGGZZKzRbsWh/waLYLFjD1eIYfXsnCM4z7AZesCxlCTUmrTzeKpImwW3rUOIGdZf72H9mINFpBEWdmkgI0npQMaOdEslHhVUqP7U/dViOne017a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578924; c=relaxed/simple;
	bh=6c0ffKKB7xWFV1lWREMe9851jShL7RHPMX7gzZKaIfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/WhSHg6J59NeGBjqUzU3pvAhGxDCSLDyeT1olia2wal/LjdMxZKg7SojDI56V8V6HRIZGOTHtAYekJk6NYwJuZ3Ws4IMNRbGvlJVe4yFLZ/Bh7TUf0apS5T9Aysa5HBQa1YF7L9u2BThbj2XJCF1W63tE0KT0pgH9asqYc837o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WTIHg8ih; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-790c7785ddbso321660385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714578921; x=1715183721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkEs8J1ffdIWhMMglu+CsW3L9Q3EHJqY0I8USedJfzM=;
        b=WTIHg8ihK8oj5puVVsAIlB8AfxhRuQiUINS0zfU7CPv1CBYV+CzKGB9UTjQnZvFFLs
         YiQ06bgf/4uDj0NoMBkUj4duKmRXNLS1ONtcqF50hxEJNuvq8ZHKGt68tamPjVt/85E6
         w7m3l4VbkB9OstjWiiTrGeyNam+XtYBTQyQEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578921; x=1715183721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkEs8J1ffdIWhMMglu+CsW3L9Q3EHJqY0I8USedJfzM=;
        b=HIWQLCFnUGU5zfszDSIOThsvbR/wlQRvMICqYY191zSNzGeOC0T5dC/uHf1Asgi9my
         TeiUl6hwIhqtAgMwqSQ92hXFFh+RtSuPgQ4xa7genoMZEA5nkfZSTJqAsYYn05HdccYU
         GLH8Bjy00yJL0ECdbVii0DX9h/rl1+wP2OwbgzGLPHFWHOGqcxR+2KV1YV+pNpqIuitl
         Jh9LpX/D45RAmqOygtyiWh+ELwIjtE64zwmUyr2+szjs5XSHDugOOwgc0GpDpJ5gI0jq
         Od7MIQnUVaLRem0hH3r1kfQ6xQWl8Y+f1LNL/wA0nQvgnHEjz91NNWyfLf7RUL+0Vk3/
         FvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI9pgk4Au74m6PEXlv8XdZ/2lf2aaWQAbljx4EsIuxuNC3xc0I4V9eNrX0YsORGgZwSesMMNQHbMyTvfypAPt6kb3l4kPD+YtcZ5m3
X-Gm-Message-State: AOJu0YwDU1HvxWIKaV2RATRbLtuqxRXNWhr3oXabWBe7mw8CPx1wW72+
	TmAnyr5Mhb279BX2q+5g328FbVIZplc0yJwQP34GoDVBkip1MtYeD5c5Uxip4lIEeCO3GFCYTxs
	=
X-Google-Smtp-Source: AGHT+IGyFNLPRR13c9S7fb1iRbDl87UIoxvwZ9gL2IEU2tzUlZX3guHw5WTSpqSSRcW6hicx+0H7og==
X-Received: by 2002:a05:620a:564e:b0:790:f6bf:3b1 with SMTP id vw14-20020a05620a564e00b00790f6bf03b1mr2647569qkn.26.1714578921239;
        Wed, 01 May 2024 08:55:21 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id b20-20020a05620a119400b00790c2b14a5fsm4280726qkk.12.2024.05.01.08.55.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 08:55:21 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439b1c72676so70271cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:55:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFOQaj0YP/HfUmzs71/X7Ttt1cmpsu2vcfIp0aGQcq4hZlEdZLdognF8tok3cSTCDrasJ/CZVnuFg7b6Uqk7RSL/r9bqzgp50zMLqR
X-Received: by 2002:ac8:5a0c:0:b0:43a:fa0d:69b5 with SMTP id
 n12-20020ac85a0c000000b0043afa0d69b5mr214045qta.7.1714578588051; Wed, 01 May
 2024 08:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426235857.3870424-1-dianders@chromium.org>
 <20240426165839.v2.4.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid>
 <2af446d3-7834-4a6b-897b-b14c6bccff65@linaro.org> <CAD=FV=V=EvEGp4tGDd-UQ1R=XkAwDn04ftd8oWU=UE=3Gi7SLQ@mail.gmail.com>
 <87y18w2n6h.fsf@intel.com>
In-Reply-To: <87y18w2n6h.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 May 2024 08:49:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X5jBqBgOqtm8nYtEKNHcnJgQDWj+ynS5U7KXuQgHLySg@mail.gmail.com>
Message-ID: <CAD=FV=X5jBqBgOqtm8nYtEKNHcnJgQDWj+ynS5U7KXuQgHLySg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org, 
	Linus Walleij <linus.walleij@linaro.org>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Hsin-Yi Wang <hsinyi@google.com>, Javier Martinez Canillas <javierm@redhat.com>, Joel Selvaraj <jo@jsfamily.in>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 8:39=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Mon, 29 Apr 2024, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Mon, Apr 29, 2024 at 2:38=E2=80=AFAM Neil Armstrong
> > <neil.armstrong@linaro.org> wrote:
> >>
> >> > +/**
> >> > + * struct mipi_dsi_multi_context - Context to call multiple MIPI DS=
I funcs in a row
> >> > + * @dsi: Pointer to the MIPI DSI device
> >> > + * @accum_err: Storage for the accumulated error over the multiple =
calls. Init
> >> > + *   to 0. If a function encounters an error then the error code wi=
ll be
> >> > + *   stored here. If you call a function and this points to a non-z=
ero
> >> > + *   value then the function will be a noop. This allows calling a =
function
> >> > + *   many times in a row and just checking the error at the end to =
see if
> >> > + *   any of them failed.
> >> > + */
> >> > +
> >> > +struct mipi_dsi_multi_context {
> >> > +     struct mipi_dsi_device *dsi;
> >> > +     int accum_err;
> >> > +};
> >>
> >> I like the design, but having a context struct seems over-engineered w=
hile we could pass
> >> a single int over without encapsulating it with mipi_dsi_multi_context=
.
> >>
> >> void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ct=
x,
> >>                                      const void *data, size_t len);
> >> vs
> >> void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_device *dsi, int =
*accum_err,
> >>                                      const void *data, size_t len);
> >>
> >> is the same, and it avoids having to declare a mipi_dsi_multi_context =
and set ctx->dsi,
> >> and I'll find it much easier to migrate, just add a &ret and make sure=
 ret is initialized to 0.
> >
> > Yeah, I had the same reaction when Jani suggested the context style
> > [1] and I actually coded it up exactly as you suggest above. I then
> > changed my mind and went with the context. My motivation was that when
> > I tested it I found that using the context produced smaller code.
> > Specifically, from the description of this patch we see we end up
> > with:
> >
> > Total: Before=3D10651, After=3D9663, chg -9.28%
> >
> > ...when I didn't have the context and I had the accum_err then instead
> > of getting ~9% smaller I believe it actually got ~0.5% bigger. This
> > makes some sense as the caller has to pass 4 parameters to each call
> > instead of 3.
> >
> > It's not a giant size difference but it was at least some motivation
> > that helped push me in this direction. I'd also say that when I looked
> > at the code in the end the style grew on me. It's really not too
> > terrible to have one line in your functions that looks like:
> >
> > struct mipi_dsi_multi_context ctx =3D { .dsi =3D boe->dsi };
> >
> > ...and if that becomes the canonical way to do it then it's really
> > hard to accidentally forget to initialize the error value. With the
> > other API it's _very_ easy to forget to initialize the error value and
> > the compiler won't yell at you. It also makes it very obvious to the
> > caller that this function is doing something a little different than
> > most Linux APIs with that error return.
> >
> > So I guess I'd say that I ended up being pretty happy with the
> > "context" even if it does feel a little over engineered and I'd argue
> > to keep it that way. That being said, if you feel strongly about it
> > then we can perhaps get others to chime in to see which style they
> > prefer? Let me know what you think.
> >
> >
> > [1] https://lore.kernel.org/r/8734r85tcf.fsf@intel.com
>
> FWIW, I don't feel strongly about this, and I could be persuaded either
> way, but I've got this gut feeling that an extensible context parameter
> might be benefitial future proofing in this case.

I've gone ahead and sent out a v3 where I still leave it as taking
`struct mipi_dsi_multi_context`. Neil: if you feel strongly about it,
I have no problem sending out a v4. I still think that the size
savings of using the context are a good "tiebreaking" factor in
choosing between the two styles... ;-)

-Doug

