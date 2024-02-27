Return-Path: <linux-kernel+bounces-82511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58196868593
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D88E28723D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A14A29;
	Tue, 27 Feb 2024 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jiMpAJF5"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7C46AF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996223; cv=none; b=Hbii4OEiJQucmitVAZrXC+1NiH+Q/d+NZg3rHSMFEFr8Fy9IbkXCxOAer7TckJ8Vh1ycPgKv3DV7AGLSZcMaQODobF9xr18eoYBs/IJkseqnk7OvUrLkkrkLhwntO3W2zxdAFESuGQZQrRspCvX7ysXYKHndJh4Vl/v7RJbOWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996223; c=relaxed/simple;
	bh=Ytyl4TVZNmNqQ43ehwWTlsuZ6vB1tt0Eh7x5v7/DaBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nATz5LOf835qTZIXpSaqlvpjDBpnSQiHK2StFL9087fgfpWeQec1wJbVmyoBAwr+EIfOGGAcbn64MHc5uMFcjXG3C07eFALGAUm2b5lmCrQWudOmGdqN2PzZwqcyqLFy9LfOk2WSvTLWp0Ta+1KloiK32CVxunqanedynXjhdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jiMpAJF5; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e432514155so1853007a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708996221; x=1709601021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nONMEgiFSJu48ujRsgQ7k5P30oEYUyNKo29jK5bJDE=;
        b=jiMpAJF5w3TG+sa2o8ZDGtJayg7f3xq13iwKIS44hO7F+SQbmyoKjLAGpIEW7YAtXz
         lGEnDXoULkF52IezwuzMmX0yoN/86rl68dW3ymelCiqs1+0c3A4+9VWPnpK7a54JlwYh
         glI34MzWvLbBClOeMuSTfHRd3Zwh2V/y4L6o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708996221; x=1709601021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nONMEgiFSJu48ujRsgQ7k5P30oEYUyNKo29jK5bJDE=;
        b=exaWioayMM2wBk6AQJDpHMBNXD/AYVIHQfZkQnwbFllFJkmDEjLha+kYZSXBb3w0fp
         WmMjaZZaWBysWcJeLMGAGQG4SmyWlEkFLv0i4gQnPG706wCsrHhU0AcgPuVl7EyHT4hv
         jIpli4UnTv4ZkJ9kdsDem7sDHYELbgxPrq03OM4z3LgmGG+RKqWjbgLKXjw4Xhd4XGU9
         MAVN+4Eo6mY4WLl68acVWpT5Bt5l9+D97Xe75Co/8lxOPKpFP5dFG+Q4zg0yekvEPyhk
         OZoA853WptXAUrj2TmnvQlAx3jshPWTg2N3ytWLlsnpV1qDuSGCMtn0LvWOU9v/LgCMB
         l7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDuLlmwHStFhuOVvE+3g+fXyHCshEBfGSubrQBNM9gNkEOC7r4Og+/2IyCEcmHczVkHmJ8/ppnKKorUTsnVB328lwMR285DzCBKvJn
X-Gm-Message-State: AOJu0Yx6SxK922+G+S0J1UnLjxRrxdhN2QtJqOv+XNdmJ6PPFoiarZLG
	/GrahQ2lJaqyxny2w/DxeDAcKhzTkSMvXjHVDfahx/kYg9hBUkuoYifzvbUcEXrrSY/Jt3byKYt
	ERCnqnHJtn6Fa9HBxt9nXbjIXrZN89v1qEHJs
X-Google-Smtp-Source: AGHT+IFws5Kxdb14MQ1Ej+HyXspa2sh+2n9Wu72IIuj/Ruv+O9s0INJzZGTh7MdiL1GKFOMwujxIFZOuAcC7yoIIv08=
X-Received: by 2002:a9d:6c43:0:b0:6e4:8086:571 with SMTP id
 g3-20020a9d6c43000000b006e480860571mr8748620otq.26.1708996221486; Mon, 26 Feb
 2024 17:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <CAA8EJpre_HOY1xzOZPv5gPiJ-kEZEJiEm8oyYzXTiPj66vY8aw@mail.gmail.com>
In-Reply-To: <CAA8EJpre_HOY1xzOZPv5gPiJ-kEZEJiEm8oyYzXTiPj66vY8aw@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 26 Feb 2024 17:09:55 -0800
Message-ID: <CAJMQK-gfKbdPhYJeCJ5UX0dNrx3y-EmLsTiv9nj+U3Rmej38pw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Match panel hash for overridden mode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:37=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 24 Feb 2024 at 00:40, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > This series is a follow up for 1a5e81de180e ("Revert "drm/panel-edp: Ad=
d
> > auo_b116xa3_mode""). It's found that 2 different AUO panels use the sam=
e
> > product id. One of them requires an overridden mode, while the other sh=
ould
> > use the mode directly from edid.
> >
> > Since product id match is no longer sufficient, EDP_PANEL_ENTRY2 is ext=
ended
> > to check the crc hash of the entire edid base block.
>
> Do you have these EDIDs posted somewhere? Can we use something less
> cryptic than hash for matching the panel, e.g. strings from Monitor
> Descriptors?
>

Panel 1:

00 ff ff ff ff ff ff 00 06 af 5c 40 00 00 00 00
00 1a 01 04 95 1a 0e 78 02 99 85 95 55 56 92 28
22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 12 1b 56 5a 50 00 19 30 30 20
46 00 00 90 10 00 00 18 00 00 00 0f 00 00 00 00
00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 42 31 31 36 58 41 4b 30 31 2e 30 20 0a 00 cc

----------------

Block 0, Base EDID:
  EDID Structure Version & Revision: 1.4
  Vendor & Product Identification:
    Manufacturer: AUO
    Model: 16476
    Made in: 2016
  Basic Display Parameters & Features:
    Digital display
    Bits per primary color channel: 6
    DisplayPort interface
    Maximum image size: 26 cm x 14 cm
    Gamma: 2.20
    Supported color formats: RGB 4:4:4
    First detailed timing includes the native pixel format and
preferred refresh rate
  Color Characteristics:
    Red  : 0.5839, 0.3330
    Green: 0.3378, 0.5712
    Blue : 0.1582, 0.1328
    White: 0.3134, 0.3291
  Established Timings I & II: none
  Standard Timings: none
  Detailed Timing Descriptors:
    DTD 1:  1366x768    60.020 Hz 683:384  47.596 kHz   69.300 MHz
(256 mm x 144 mm)
                 Hfront   48 Hsync  32 Hback  10 Hpol N
                 Vfront    4 Vsync   6 Vback  15 Vpol N
    Manufacturer-Specified Display Descriptor (0x0f): 00 0f 00 00 00
00 00 00 00 00 00 00 00 00 00 20 '............... '
    Alphanumeric Data String: 'AUO'
    Alphanumeric Data String: 'B116XAK01.0 '
Checksum: 0xcc


Panel 2:

00 ff ff ff ff ff ff 00 06 af 5c 40 00 00 00 00
00 19 01 04 95 1a 0e 78 02 99 85 95 55 56 92 28
22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ce 1d 56 ea 50 00 1a 30 30 20
46 00 00 90 10 00 00 18 d4 17 56 ea 50 00 1a 30
30 20 46 00 00 90 10 00 00 18 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 42 31 31 36 58 41 4e 30 34 2e 30 20 0a 00 94

----------------

Block 0, Base EDID:
  EDID Structure Version & Revision: 1.4
  Vendor & Product Identification:
    Manufacturer: AUO
    Model: 16476
    Made in: 2015
  Basic Display Parameters & Features:
    Digital display
    Bits per primary color channel: 6
    DisplayPort interface
    Maximum image size: 26 cm x 14 cm
    Gamma: 2.20
    Supported color formats: RGB 4:4:4
    First detailed timing includes the native pixel format and
preferred refresh rate
  Color Characteristics:
    Red  : 0.5839, 0.3330
    Green: 0.3378, 0.5712
    Blue : 0.1582, 0.1328
    White: 0.3134, 0.3291
  Established Timings I & II: none
  Standard Timings: none
  Detailed Timing Descriptors:
    DTD 1:  1366x768    60.059824 Hz 683:384   47.688 kHz
76.300000 MHz (256 mm x 144 mm)
                 Hfront   48 Hsync  32 Hback  154 Hpol N
                 Vfront    4 Vsync   6 Vback   16 Vpol N
    DTD 2:  1366x768    48.016373 Hz 683:384   38.125 kHz
61.000000 MHz (256 mm x 144 mm)
                 Hfront   48 Hsync  32 Hback  154 Hpol N
                 Vfront    4 Vsync   6 Vback   16 Vpol N
    Alphanumeric Data String: 'AUO'
    Alphanumeric Data String: 'B116XAN04.0 '
Checksum: 0x94

In this example, Descriptors can also be used to distinguish. But it's
possible that the name field is also reused by mistake, for the same
reason as model id is reused.


> >
> > Hsin-Yi Wang (2):
> >   drm_edid: Add a function to get EDID base block
> >   drm/panel: panel-edp: Match with panel hash for overridden modes
> >
> >  drivers/gpu/drm/drm_edid.c        | 55 +++++++++++++++-------------
> >  drivers/gpu/drm/panel/panel-edp.c | 60 ++++++++++++++++++++++++++-----
> >  include/drm/drm_edid.h            |  3 +-
> >  3 files changed, 84 insertions(+), 34 deletions(-)
> >
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
> >
>
>
> --
> With best wishes
> Dmitry

