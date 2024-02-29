Return-Path: <linux-kernel+bounces-85941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD686BD09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DC31C23564
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DDF12B76;
	Thu, 29 Feb 2024 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZKVDXh5"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4E620
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168106; cv=none; b=NH0VPnvTaFuwdM9O4sAvv+1OhFvk0LJv1D0WrOAg4KONQxoh3+48GkcQOmyy+I0K/xmdWPqphPmoR9ru3Uiywz9l4p6nz/Tn1CuG+org4NIztlXBRXQ777IvBsoy8iUc06p0r+g7Wt9XGxWwpje/qJUjYalrssRhkalfcZTllAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168106; c=relaxed/simple;
	bh=Bj3A4yysWQKZKPbdkMrSTDRHI7hkFKP+ewm4tgfR7ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jimSvcc6HxWxjEOAAB+E4EBvjnPtbpSgkLRSzCZAJRtug11d7+Q/79YruJidOc5jw2EcYZxGm6u2lN35FGxLZLTLroDFv0a1oe/zvq/mYznnEE34e9yc8PMkjp02YYX7fsDaXHlDJ1eicPZoxJ3HXSp9jd1QWHmBCgFQ7+vUW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VZKVDXh5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e49a5b1bbfso168278a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709168103; x=1709772903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQy5G7oDQ9yO1ykBUcJTCy0oyYvjoo8NP1jXy9LgNWA=;
        b=VZKVDXh5ybYGB6TjdrS9FHpsVg3K3193iHLcLhu+MZy36I5tT+B6PKrdP+DJnEB4E0
         lkBbgeAqjik0mEAo/JUJWCQKb3PdB0VH7eFTBUMnaXMt1IBLC+qQocnEUiE9nfwfD6Ez
         eScrA9v5YgUnckE0s+eBAMTPzVyIYq9fbBKjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168103; x=1709772903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQy5G7oDQ9yO1ykBUcJTCy0oyYvjoo8NP1jXy9LgNWA=;
        b=fEpl9V17fviFUbo3wAsQdnLRr1cU3b14/qrfdvMPp6Q/HqO7qZtNW8QfVXhHmtqX24
         sAiGd5/uX1tUBVVzx0E4VqhVs//2coU+0hMQgyrCDCdRXO46nG4/kl7BVeGEZep9JOEv
         pgibM5nyszRPamp2pDl6dgT7oEHF9kdymRsckfN7bg8LtIsSK8HKQhABc3Rc2wDJM8oQ
         dwSI+GNwiKAGNCryYSICxDVbtmyMG58uB4iuFoovvBR/7SDAK/QlH+cT+kxqijLHjM5q
         9xmiPJ3vFIGqc7YJV6zf/isXV96AGy8PP+/GmOJATDFIij2FPy0b2B235sWPCRawYJSP
         bUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPX9NDMsU1xNZspnX5+TqkYgMUBd2ZrH1jsdNXb0V9OIEvAiJiVroHcbf4o11Tsq4Z1h1qiZ92pxucHjXedj2zDfoluSO2Xb890FWR
X-Gm-Message-State: AOJu0Ywjonbrss1sMR8hw+Y76QAnD/FfkLJPgXe8OsNk3BAM8ksEkiCp
	z3xsSknsRUjnPgESR8Jpitzss35NJnTPC7tCRJOPzpLjuG8E+UUMU/pbjxs7TVE5f4zF2/pgJUW
	e5COGANdNB4sEOA2dKR9eAGBk+mW1unzIznUq
X-Google-Smtp-Source: AGHT+IEzdFFPaPuH0qFsjov71+EByP7TBcyvnv3GYpOy0geZfzLmBF5kHnk9MV5f9WyC5cCYEJbpdi9YB+pCb62WEMk=
X-Received: by 2002:a9d:6a85:0:b0:6e4:2498:fa2e with SMTP id
 l5-20020a9d6a85000000b006e42498fa2emr649762otq.37.1709168103696; Wed, 28 Feb
 2024 16:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-2-hsinyi@chromium.org>
 <CAD=FV=XCGCpLmCQhfTXfrOON99KLbR5pR59jaiD_V14szn6qsA@mail.gmail.com>
In-Reply-To: <CAD=FV=XCGCpLmCQhfTXfrOON99KLbR5pR59jaiD_V14szn6qsA@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 28 Feb 2024 16:54:37 -0800
Message-ID: <CAJMQK-j5oDS1H=x2=tAcna1XK9JN8SdyHV-rHJvMgJX7S-3MHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm_edid: Support getting EDID through ddc without connector
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:21=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > Some panels are interested in the EDID during early probe when connecto=
r
> > is still unknown.
> >
> > Add a function drm_get_edid_no_connector() to get edid without connecto=
r.
> > No functional change for existing usage.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v1->v2:
> > add a function to return the entire edid without updating connector.
> > ---
> >  drivers/gpu/drm/drm_edid.c | 45 ++++++++++++++++++++++++++++----------
> >  include/drm/drm_edid.h     |  1 +
> >  2 files changed, 34 insertions(+), 12 deletions(-)
>
> I'll respond in the discussion in v1 too, but overall I'm not a fan of
> reading the whole EDID twice at bootup. Personally I'd love to see us
> to back to just reading the base block like in v1, but I guess we can
> see what Jani and others say.
>
>
> > @@ -2385,18 +2385,20 @@ static struct edid *_drm_do_get_edid(struct drm=
_connector *connector,
> >         if (status =3D=3D EDID_BLOCK_READ_FAIL)
> >                 goto fail;
> >
> > -       /* FIXME: Clarify what a corrupt EDID actually means. */
> > -       if (status =3D=3D EDID_BLOCK_OK || status =3D=3D EDID_BLOCK_VER=
SION)
> > -               connector->edid_corrupt =3D false;
> > -       else
> > -               connector->edid_corrupt =3D true;
> > +       if (connector) {
> > +               /* FIXME: Clarify what a corrupt EDID actually means. *=
/
> > +               if (status =3D=3D EDID_BLOCK_OK || status =3D=3D EDID_B=
LOCK_VERSION)
> > +                       connector->edid_corrupt =3D false;
> > +               else
> > +                       connector->edid_corrupt =3D true;
> >
> > -       if (!edid_block_status_valid(status, edid_block_tag(edid))) {
> > -               if (status =3D=3D EDID_BLOCK_ZERO)
> > -                       connector->null_edid_counter++;
> > +               if (!edid_block_status_valid(status, edid_block_tag(edi=
d))) {
> > +                       if (status =3D=3D EDID_BLOCK_ZERO)
> > +                               connector->null_edid_counter++;
> >
> > -               connector_bad_edid(connector, edid, 1);
> > -               goto fail;
> > +                       connector_bad_edid(connector, edid, 1);
> > +                       goto fail;
>
> This "goto fail" is now only run "if (connector)" which means that
> you're not properly checking if the EDID is valid when "connector =3D=3D
> NULL", right? That seems like a bug unless I missed something...

We can't check with connector_bad_edid() since there's no connector.
But we still check with edid_block_read() status, similar to what the
original drm_edid_get_panel_id() checks.

