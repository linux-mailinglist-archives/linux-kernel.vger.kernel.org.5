Return-Path: <linux-kernel+bounces-87148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C186D03C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1516E1C20F10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4F6CBE8;
	Thu, 29 Feb 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0AT39zM"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B35E082
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226723; cv=none; b=l1oAnMzkV0RKCC2eoVzS59NJZwaN1yL84kVH2yc7i4MrJFsMlIvOy1/dY46BkxPODzkRi3WFQ4W3L60n+Z6BHY8kym5degNtFTfMiwQyso+n7mYiV7Rtko1zdXdQSivNhWpOSbia65ouNRXjyBtoTXpDoqBEFZdby0svZYoEnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226723; c=relaxed/simple;
	bh=VIuCCvZZ9FOhzJyANoVcQ+CZ2yWXYAjQ8Qce1JkZpzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvihmO2axd1YhD4LD98NGTQH4XdhzhTkcTHhKvzs74HlEwRat14WzsHuLAkYbnkVSdySRoxcrlQusOEtfg1Hd6uNyHmBAv0ELvEe+tZhS/h7fJuiYlbTDOabLjVi3/LdrZ/4rdyAxJ08ToYrLGPLMWO1fN4DYgXJkVBjXs71+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d0AT39zM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so1818161a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709226717; x=1709831517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxpSjfrVdVSOexvPvV+MdNfT9diBzg4rPMFPF1MyWmU=;
        b=d0AT39zMhmCk7qbDMkteTm8fTfxfAMwHEjDrSLHLS8FMfPpCqdWLcpIPDWCwmEtZz/
         WsUyAQH4AUWbIhAcEPDkMd7a89w9ctvJ/+F1knNAhoNobBeK2CypNiyPTlj/9aNAxOuV
         neA8nG13a29AH1G+UTxLVAPtJ4vzYTflC/abg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226717; x=1709831517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxpSjfrVdVSOexvPvV+MdNfT9diBzg4rPMFPF1MyWmU=;
        b=pB0WMWZatkbTl5Ph/wVGRzHjKvwqIujwzYeUd8ZC+6+2YIfvaS6ZshE9cCy6ufKE3g
         fKYTcwdzKsmULCf/FZJLg3FdM8+bFzsya4X3edYtyH/uZKo96jCgFdATvcgDCih+4k1U
         nBA26gh9/gMaTph4HB+bDkeKt/HQvV9i7gg7niw47do0EMuRpBNCOz4O8j77vMqYMZpf
         1n8JFKZZxXYKkawLCBfbQTa4LA2Vs4WpJksE3kU0H+0vq/YOOTto9qv47s6qFVPGPhND
         RtXt1fNQtxwd9xobD3Vv8qg0nT6x+nPDt0vuKVSYdhJ0O0Hzod6RVw+YVs40M8AtuHn0
         kVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTRduJiI2mTm3U+LU3TnmOBihuuUI84tRt38yfVkTqtZAL7tgS/pG8EVcQg7jGZIwptydGH/2xKrGfQsSnz3XuQH+3kfM4o20BTYit
X-Gm-Message-State: AOJu0YwP6dLo/LLQUp4VTtkv7XgQVgHNuiKsT0Nb+yhM40Z5/XGTFGoF
	QCauQFY6brSCbKQPuBdzWUwPp6zDfRtCUgCpu/+/AsAtgrLkmSRTX2aV7W5z94TUmLQUB7BDEjq
	exSCk
X-Google-Smtp-Source: AGHT+IFQgbXfR7i50fhIM7kpJPqDAxOHwzGcFeugdr3bjqUOKVnu1X3kzyZ5mHdyI3MVrxBVXaFwBA==
X-Received: by 2002:a17:906:b7cd:b0:a44:4f9f:1271 with SMTP id fy13-20020a170906b7cd00b00a444f9f1271mr1373600ejb.39.1709226716900;
        Thu, 29 Feb 2024 09:11:56 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090640cf00b00a4354b9893csm864274ejk.74.2024.02.29.09.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:11:56 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so82975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:11:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdX0sR1444LbSo2+7d/fUHeL19A3tOb3TqTD+3rut9AEjhySYhZwy4wb2VQg/0UBMnY8LVe0zfsvedfch79m2oUa40IbPLqarJLoqU
X-Received: by 2002:a05:600c:5194:b0:412:c353:cefc with SMTP id
 fa20-20020a05600c519400b00412c353cefcmr45032wmb.0.1709226714821; Thu, 29 Feb
 2024 09:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
 <87wmqqjmt9.fsf@intel.com> <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
 <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com> <87bk7z6x1w.fsf@intel.com>
In-Reply-To: <87bk7z6x1w.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Feb 2024 09:11:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wzm9Y7m9Q6KqO7yWdnc1xToaRMb2f1s2TQMJqpqVYLOg@mail.gmail.com>
Message-ID: <CAD=FV=Wzm9Y7m9Q6KqO7yWdnc1xToaRMb2f1s2TQMJqpqVYLOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 29, 2024 at 8:43=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Wed, 28 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Tue, Feb 27, 2024 at 5:27=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.o=
rg> wrote:
> >>
> >> On Tue, Feb 27, 2024 at 1:09=E2=80=AFAM Jani Nikula <jani.nikula@linux=
intel.com> wrote:
> >> >
> >> > On Fri, 23 Feb 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >> > > It's found that some panels have variants that they share the same=
 panel id
> >> > > although their EDID and names are different. Besides panel id, now=
 we need
> >> > > the hash of entire EDID base block to distinguish these panel vari=
ants.
> >> > >
> >> > > Add drm_edid_get_base_block to returns the EDID base block, so cal=
ler can
> >> > > further use it to get panel id and/or the hash.
> >> >
> >> > Please reconsider the whole approach here.
> >> >
> >> > Please let's not add single-use special case functions to read an ED=
ID
> >> > base block.
> >> >
> >> > Please consider reading the whole EDID, using the regular EDID readi=
ng
> >> > functions, and use that instead.
> >> >
> >> > Most likely you'll only have 1-2 blocks anyway. And you might consid=
er
> >> > caching the EDID in struct panel_edp if reading the entire EDID is t=
oo
> >> > slow. (And if it is, this is probably sensible even if the EDID only
> >> > consists of one block.)
> >> >
> >> > Anyway, please do *not* merge this as-is.
> >> >
> >>
> >> hi Jani,
> >>
> >> I sent a v2 here implementing this method:
> >> https://lore.kernel.org/lkml/20240228011133.1238439-2-hsinyi@chromium.=
org/
> >>
> >> We still have to read edid twice due to:
> >> 1. The first caller is in panel probe, at that time, connector is
> >> still unknown, so we can't update connector status (eg. update
> >> edid_corrupt).
> >> 2. It's possible that the connector can have some override
> >> (drm_edid_override_get) to EDID, that is still unknown during the
> >> first read.
> >
> > I'll also comment in Hsin-Yi's v2, but given Hsin-Yi's digging and the
> > fact that we can't cache the EDID (because we don't yet have a
> > "drm_connector"), I'd much prefer Hsin-Yi's solution here from v1 that
> > allows reading just the first block. If we try to boot a device with a
> > multi-block EDID we're now wastefully reading all the blocks of the
> > EDID twice at bootup which will slow boot time.
> >
> > If you can see a good solution to avoid reading the EDID twice then
> > that would be amazing, but if not it seems like we should go back to
> > what's here in v1. What do you think? Anyone else have any opinions?
>
> I haven't replied so far, because I've been going back and forth with
> this. I'm afraid I don't really like either approach now. Handling the
> no connector case in v2 is a bit ugly too. :(
>
> Seems like you only need this to extend the panel ID with a hash. And
> panel-edp.c is the only user of drm_edid_get_panel_id(). And EDID quirks
> in drm_edid.c could theoretically hit the same problem you're solving.

Good point. That would imply that more of the logic could go into
"drm_edid.c" in case the EDID quirks code eventually needs it.


> So maybe something like:
>
>         u32 drm_edid_get_panel_id(struct i2c_adapter *adapter, u32 *hash)=
;
>
> or if you want to be fancy add a struct capturing both id and hash:
>
>         bool drm_edid_get_panel_id(struct i2c_adapter *adapter, struct dr=
m_edid_panel_id *id);
>
> And put the hash (or whatever mechanism you have) computation in
> drm_edid.c. Just hide it all in drm_edid.c, and keep the EDID interfaces
> neat.
>
> How would that work for you?

The problem is that Dmitry didn't like the idea of using a hash and in
v2 Hsin-Yi has moved to using the name of the display. ...except of
course that eDP panels don't always properly specify
"EDID_DETAIL_MONITOR_NAME". See the discussion [1]. If you want to see
some of the EDIDs involved, you can see Hsin-Yi's post [2]. The panels
included stuff like this:

    Alphanumeric Data String: 'AUO'
    Alphanumeric Data String: 'B116XAN04.0 '

The fact that there is more than one string in there makes it hard to
just "return" the display name in a generic way. The way Hsin-Yi's
code was doing it was that it would consider it a match if the panel
name was in any of the strings...

How about this as a solution: we change drm_edid_get_panel_id() to
return an opaque type (struct drm_edid_panel_id_blob) that's really
just the first block of the EDID but we can all pretend that it isn't.
Then we can add a function in drm_edid.c that takes this opaque blob,
a 32-bit integer (as per drm_edid_encode_panel_id()), and a string
name and it can tell us if the blob matches?


[1] https://lore.kernel.org/r/CAD=3DFV=3DVMVr+eJ7eyuLGa671fMgH6ZX9zPOkbKzYJ=
0H79MZ2k9A@mail.gmail.com
[2] https://lore.kernel.org/r/CAJMQK-gfKbdPhYJeCJ5UX0dNrx3y-EmLsTiv9nj+U3Rm=
ej38pw@mail.gmail.com

