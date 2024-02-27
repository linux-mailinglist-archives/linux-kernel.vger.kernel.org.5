Return-Path: <linux-kernel+bounces-82607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F8868702
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174541C28142
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0FA107A9;
	Tue, 27 Feb 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibpIwTiF"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9CF4FC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000780; cv=none; b=FL5/G2PQ8Q9PbQFRqf9ptfleRcLl7Y419gWLoC6LJgdaihbmlOIVnqDWn8f4eq/dyB2jhoAqXiSQSC58WCpRPQUF5zPTpk7Jp1swU5LmBpIpr1ejsWVyn9PljKwVqoP10SmMEdTG//MlsjFfy/M24898o/P7tfilPbFpVWkUzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000780; c=relaxed/simple;
	bh=sgugdwOJThAT2iUguafr87yBlE89jkRo7TRpZkpBen0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8MNvI+wNttD3UWvOwpMFFsPk/FKjLvPTf0TZZIUHwH1ZvQht+ICTbWehE1t51phA/whtu/gzazRM0HmT3bWjS1gpUu5t5la71FkT+/U6rpcXwOyiIIuzxG8TuyKalCLdaA4fwQNeh/OcZxPGZIt2XAmxGT2690hUfyeCaducss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ibpIwTiF; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso3570895276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709000777; x=1709605577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCEqoEe8h2ncNZO/H1zt/NRD5p1KyWoUZuyGGRZfeIQ=;
        b=ibpIwTiFrbnIRDx0QLwWHTZFSLUqAYk8KDwfOIskN5IstGHV3qrYt5KSNK+WILtpBI
         q5ft/u+570bGsmUIJTJ0JZCuwJBgjPvtY2VeWs1ewrLpgIpLKWsWvj2noMY2/COqb9NG
         eG5gWSKTe6Pz2j3zX9jgjTQL/eIW4exosdG2M3af3cN3y98kuPBX+mfwsZ0Bo4bdXdnO
         /3E96sStNHs/oB00xUdSI/9T9OU1RwXeADfiT1j+N03lnQnRZpJXaJaKaF5Jj1+AMoxx
         syCxXwgA+5FrnPBa7rsk8pmiwgWEduS/ceNHTiDixehU7Z9jKbSLpsX7o+ppbNyzy322
         PLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000777; x=1709605577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCEqoEe8h2ncNZO/H1zt/NRD5p1KyWoUZuyGGRZfeIQ=;
        b=p/74WwpLZeSrVxNwDxuHdxfEDQ/F0NLJ9S+Nl5BN46Zt5rKd12/9Pu1cGG08+OLOI2
         DU5WOKSyYKQ6K0aA4p1uXx4I1rFfajSzJsOfczvobrhi6IfyKBp2Ak8at+d7C1xM1B7P
         nnZza14tdrV7UB4PT4EHb23lBy/gWkrwS5SwuARCcZoZvPsx6DvFXiNB21qs4KbA5P1+
         yZU/hD6IFHBfu3L+7vlhxZYfq8fcsEWzU413wxUTxxRCwMZHIM9/Ogi9GyaQ3v7LwNmG
         elNQbfry3sJZa6jNkw4AKRRMfJTuhaMnA/WC2dRsS4KuUJsdocCQpAGSPU+Bd0F1Q0/b
         MjzA==
X-Forwarded-Encrypted: i=1; AJvYcCX1MEULEDGRDgsLVxlNvfbrciNkyBxez1zm/k1Iz80HnII5MCo0uXImWZ00p3I7eE3S42gTnJN/Rzvj/Ppm4dVmBjwWDcjbf59RJOv0
X-Gm-Message-State: AOJu0YxYQV8rwyMbENU9Ws8Snw5/o5yX84F2m/KHff0CcpZfEhN0rB3q
	XVIerPt1G35hInmmPFDqfcAS7R91fbUChwfytYRbcDogiom+uVz77uGdWEiTpn9qWXhSqZrxKtp
	68RzqLLM9yAGN/SeuSiUeIo/P3A7rAYPJsvcggg==
X-Google-Smtp-Source: AGHT+IH7xRwpzcLY0VJJqoX5vz9MVun2OqKl3Bo8ij6NiJtw3EMXFXzcV8WP0eTVFD1ncy1UG4d/acOy4fmEpynDYbg=
X-Received: by 2002:a25:9d8a:0:b0:dcc:35ca:aac4 with SMTP id
 v10-20020a259d8a000000b00dcc35caaac4mr965543ybp.51.1709000777563; Mon, 26 Feb
 2024 18:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <CAA8EJpre_HOY1xzOZPv5gPiJ-kEZEJiEm8oyYzXTiPj66vY8aw@mail.gmail.com>
 <CAJMQK-gfKbdPhYJeCJ5UX0dNrx3y-EmLsTiv9nj+U3Rmej38pw@mail.gmail.com>
In-Reply-To: <CAJMQK-gfKbdPhYJeCJ5UX0dNrx3y-EmLsTiv9nj+U3Rmej38pw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 27 Feb 2024 04:26:06 +0200
Message-ID: <CAA8EJprvk-MMrYhG0baT0OyOAGwOTVeHQvKmrvJPrc+KdbJaDw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Match panel hash for overridden mode
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 03:10, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
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
> >
>
> Panel 1:
>
> 00 ff ff ff ff ff ff 00 06 af 5c 40 00 00 00 00
> 00 1a 01 04 95 1a 0e 78 02 99 85 95 55 56 92 28
> 22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 12 1b 56 5a 50 00 19 30 30 20
> 46 00 00 90 10 00 00 18 00 00 00 0f 00 00 00 00
> 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 42 31 31 36 58 41 4b 30 31 2e 30 20 0a 00 cc
>
> ----------------
>
> Block 0, Base EDID:
>   EDID Structure Version & Revision: 1.4
>   Vendor & Product Identification:
>     Manufacturer: AUO
>     Model: 16476
>     Made in: 2016
>   Basic Display Parameters & Features:
>     Digital display
>     Bits per primary color channel: 6
>     DisplayPort interface
>     Maximum image size: 26 cm x 14 cm
>     Gamma: 2.20
>     Supported color formats: RGB 4:4:4
>     First detailed timing includes the native pixel format and
> preferred refresh rate
>   Color Characteristics:
>     Red  : 0.5839, 0.3330
>     Green: 0.3378, 0.5712
>     Blue : 0.1582, 0.1328
>     White: 0.3134, 0.3291
>   Established Timings I & II: none
>   Standard Timings: none
>   Detailed Timing Descriptors:
>     DTD 1:  1366x768    60.020 Hz 683:384  47.596 kHz   69.300 MHz
> (256 mm x 144 mm)
>                  Hfront   48 Hsync  32 Hback  10 Hpol N
>                  Vfront    4 Vsync   6 Vback  15 Vpol N
>     Manufacturer-Specified Display Descriptor (0x0f): 00 0f 00 00 00
> 00 00 00 00 00 00 00 00 00 00 20 '............... '
>     Alphanumeric Data String: 'AUO'
>     Alphanumeric Data String: 'B116XAK01.0 '
> Checksum: 0xcc
>
>
> Panel 2:
>
> 00 ff ff ff ff ff ff 00 06 af 5c 40 00 00 00 00
> 00 19 01 04 95 1a 0e 78 02 99 85 95 55 56 92 28
> 22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
> 46 00 00 90 10 00 00 18 d4 17 56 ea 50 00 1a 30
> 30 20 46 00 00 90 10 00 00 18 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 42 31 31 36 58 41 4e 30 34 2e 30 20 0a 00 94
>
> ----------------
>
> Block 0, Base EDID:
>   EDID Structure Version & Revision: 1.4
>   Vendor & Product Identification:
>     Manufacturer: AUO
>     Model: 16476
>     Made in: 2015
>   Basic Display Parameters & Features:
>     Digital display
>     Bits per primary color channel: 6
>     DisplayPort interface
>     Maximum image size: 26 cm x 14 cm
>     Gamma: 2.20
>     Supported color formats: RGB 4:4:4
>     First detailed timing includes the native pixel format and
> preferred refresh rate
>   Color Characteristics:
>     Red  : 0.5839, 0.3330
>     Green: 0.3378, 0.5712
>     Blue : 0.1582, 0.1328
>     White: 0.3134, 0.3291
>   Established Timings I & II: none
>   Standard Timings: none
>   Detailed Timing Descriptors:
>     DTD 1:  1366x768    60.059824 Hz 683:384   47.688 kHz
> 76.300000 MHz (256 mm x 144 mm)
>                  Hfront   48 Hsync  32 Hback  154 Hpol N
>                  Vfront    4 Vsync   6 Vback   16 Vpol N
>     DTD 2:  1366x768    48.016373 Hz 683:384   38.125 kHz
> 61.000000 MHz (256 mm x 144 mm)
>                  Hfront   48 Hsync  32 Hback  154 Hpol N
>                  Vfront    4 Vsync   6 Vback   16 Vpol N
>     Alphanumeric Data String: 'AUO'
>     Alphanumeric Data String: 'B116XAN04.0 '
> Checksum: 0x94
>
> In this example, Descriptors can also be used to distinguish. But it's
> possible that the name field is also reused by mistake, for the same
> reason as model id is reused.

Thank you! Let's settle the discussion at the cover letter.

>
>
> > >
> > > Hsin-Yi Wang (2):
> > >   drm_edid: Add a function to get EDID base block
> > >   drm/panel: panel-edp: Match with panel hash for overridden modes
> > >
> > >  drivers/gpu/drm/drm_edid.c        | 55 +++++++++++++++-------------
> > >  drivers/gpu/drm/panel/panel-edp.c | 60 ++++++++++++++++++++++++++---=
--
> > >  include/drm/drm_edid.h            |  3 +-
> > >  3 files changed, 84 insertions(+), 34 deletions(-)
> > >
> > > --
> > > 2.44.0.rc0.258.g7320e95886-goog
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

