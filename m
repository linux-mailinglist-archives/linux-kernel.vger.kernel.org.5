Return-Path: <linux-kernel+bounces-82586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834C8686BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CCC1C22480
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BC1CAA4;
	Tue, 27 Feb 2024 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+9nkeUF"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B01B962
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000323; cv=none; b=WB+gIB7A3ET5OO2o3hIkFqUnb2ICEXnfya+BC50uLlfHOFVSP6pi00UDl4i9sMPPyBEcxWol5dn5c8SSz6eG3rcOJEMDZiom/zhB8PkRHJAWxXNiOQwjh339bRta8dfeqCvCJCSDZ2x59V91tR8pQC35yJ/S25f5Xl4oGDUp1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000323; c=relaxed/simple;
	bh=j/0cvRHoeBDj4WwAVW0/51nHWj3Sa52fkTHqCjmTzTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPqIkQ8P/WY9N6/LAPdtL/1d2k/LPpKVlIiroagR8timUJE4BVfCkXhhDw0vZYrA976gVN0hnyx+iKDGJGkLMMsVwSjYQ+pmOkWLE5lc+Stj9lmQU5m3yU/SvW2PQHmF+e336Axo/EnLoBbYt7ASQAoGCHDrM60S+QBOigxmD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H+9nkeUF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed179f0faso2213417276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709000320; x=1709605120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/0cvRHoeBDj4WwAVW0/51nHWj3Sa52fkTHqCjmTzTQ=;
        b=H+9nkeUFe6YGaQVdIIkOJYSMA6nrRlzcV9tD12aPokNpRb6v1XUs2RpNlRU+hf3Zcp
         vTrCHGdeC4l1H6GsmK5SPi64buNftgPZF48f/h1eqoAm1OvMRNFKXrqIva8JO2w6GvcI
         gmtC6KTOhqkdj3MRkR/6Uv6ITLmuP6Jg4J5Fj7rWNoljMrBTIaO2zaNuRZe61qMo/Hgf
         fTTZ/DorjfoQY20nvUPHWCUuhPXIhElA2LLs5YwmTsZ7WLHcUNpRBDVwxW0eeEOb77RX
         BgYH5lEsL51eUJ14hYIop64vKoufACRdl/enbTEvqwK0K/1bwWzFLcnf5Av6Pr2H4tqg
         JMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000320; x=1709605120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/0cvRHoeBDj4WwAVW0/51nHWj3Sa52fkTHqCjmTzTQ=;
        b=OM+UmsEdPU6c049U7AtST8GkzlCt7+f7zVG4C7HKngzmnuMgj7O2mm3Z2zUGp8exdC
         q4mwFW927abdjL+g4qOhAR52mMQA7cSOF9aGKrXAXHWQitck1QegXEb4Pdvy4thHUZpT
         HsqlGitDLsnnH0oZcidshzX0AptDsNrGRtkXlA7ymRDurLa5NM5yIaHjZWSpu0fU6Pns
         VDag90+BPBgnspupSvTNpSSJbC+GYK00GqU1Z24B6iH/qc7Ha45gIB74tnSWazMMlq/O
         FZeSbwmwSjQJh+hWSqQnUmsKX+043u5Qnmv2xBE0rHJMDQwc2wYGHTorIsZuWF3p34q6
         VtOw==
X-Forwarded-Encrypted: i=1; AJvYcCVwPSPMuJz1kVrGRuYhjFqNKmNjS207N/BP+if7O1HXeSR+j7DxDX8B51CCkZPz6HNpD0YNb8LoCP5BPeNZWP/ene8GNbLS43VMaUWb
X-Gm-Message-State: AOJu0YzwqyPKtHtdXThzrwUH1Vb3yPPdH7LonI/H01HVYAVP1s9l9LkP
	VyCeewQ4zpwHwYJl5TM/BSc6V+HCsgAqiSX9ZlSi0C7TSAS2biXG/i/yZN5U8FzvOaqkhG+QCZH
	47q519FtmLokiubp3lRhU39KYIqVMp3OPgJNhCw==
X-Google-Smtp-Source: AGHT+IEcmheK8V87a+vvv/FdIjCu0EFJdE0B0tDEQcJVpBAHV8SGp9so8ZQQFLEoUEmqaLeQ7wW8GoVhlVhZcXH7lh4=
X-Received: by 2002:a25:680a:0:b0:dc6:ab85:ba89 with SMTP id
 d10-20020a25680a000000b00dc6ab85ba89mr671508ybc.25.1709000320490; Mon, 26 Feb
 2024 18:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <CAA8EJpre_HOY1xzOZPv5gPiJ-kEZEJiEm8oyYzXTiPj66vY8aw@mail.gmail.com>
 <CAD=FV=WjZZfHBdMVG3R_iT9bskP3AyHrRsSK6Hfw9h4tEZBHFg@mail.gmail.com>
In-Reply-To: <CAD=FV=WjZZfHBdMVG3R_iT9bskP3AyHrRsSK6Hfw9h4tEZBHFg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 27 Feb 2024 04:18:29 +0200
Message-ID: <CAA8EJpoyahPpwYdS7rLFfwcwF9Bn4gcx1VssDcnZ+suUT-ua5Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Match panel hash for overridden mode
To: Doug Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 03:00, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 26, 2024 at 4:37=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Sat, 24 Feb 2024 at 00:40, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > This series is a follow up for 1a5e81de180e ("Revert "drm/panel-edp: =
Add
> > > auo_b116xa3_mode""). It's found that 2 different AUO panels use the s=
ame
> > > product id. One of them requires an overridden mode, while the other =
should
> > > use the mode directly from edid.
> > >
> > > Since product id match is no longer sufficient, EDP_PANEL_ENTRY2 is e=
xtended
> > > to check the crc hash of the entire edid base block.
> >
> > Do you have these EDIDs posted somewhere? Can we use something less
> > cryptic than hash for matching the panel, e.g. strings from Monitor
> > Descriptors?
>
> We could try it if need be. I guess I'm worried that if panel vendors
> ended up re-using the panel ID for two different panels that they
> might also re-use the name field too. Hashing the majority of the
> descriptor's base block makes us more likely not to mix two panels up.
> In general it feels like the goal is that if there is any doubt that
> we shouldn't override the mode and including more fields in the hash
> works towards that goal.

My main concern is that hash (or crc) is a non-obvious thing: even if
we have EDID in the commit message, it takes some effort to calculate
the value. If for any reason we decide to change the hashed bytes
(e.g. by dropping any of the fields) it will be an error-prone process
to update existing hash values. On the contrary, the 'strings' are
easy to check / compare without any additional tools.

>
> I guess one thing that might help would be to make it a policy that
> any time a panel is added to this list that a full EDID is included in
> the commit message. That would mean that if we ever needed to change
> things we could. What do you think?

Definitely, that sounds like a good idea.

> That being said, if everyone thinks that the "name" field is enough,
> we could do it. I think that in the one case that we ran into it would
> have been enough...

Yes, I'd suggest using the string unless at some point we see two
panels sharing both panel_id and names.

--=20
With best wishes
Dmitry

