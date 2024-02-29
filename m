Return-Path: <linux-kernel+bounces-85918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B286BCCD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035E9B25A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B242A95;
	Thu, 29 Feb 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L448iUXz"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DB42A91
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166115; cv=none; b=MCn65FhtwMSOpG1kNHg+MsBDulYH4aN4OgrVtsjJF7GlGstkbhqHlODTb0PVP0/Vfgp9wKCGo1hD/ojsI8tSY/shymQ7CwnDenj12DtQ34/iQ6hsBCXz9OpeVkcxSghmNhiVA+uhkqjsrbId0hrJiuwqs/9WE+sx4NiakLC9iNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166115; c=relaxed/simple;
	bh=jnbaXeKEcIMuxfK7VlclBYCfRD5gXqxZ/dfcvxij9Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjqRjJYEWKny+21jN0jJ3pBuzU28GkHeivnE6FfXo8ynGjuw0lJffMoTGQDi5qXomw0TR3ES7hpCRrbsziAv/JMdjtdru4tSmzkP9Z4+2+sMEbH8BdDzH3DRDASUEr4OTvmkOrcaQHKwCr+xGTcPz4AU2qzPrxAJsmxcS6J1bsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L448iUXz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso630740a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709166110; x=1709770910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMYd+3PehQzWrhjo72mtYlH8CA55wcaPeIXXwpZd4Nk=;
        b=L448iUXzbyiBBTYdQ4Rj1b33RefF51J4dhDF3YdXyRm4MRR6ePvhkVUybzwLbOpIUB
         2/no+JCzlD8SJwAzX1Cir8LIDP7JiSqzix1QNpEcPCgXwmABtjITxalK6iR8Oelm+Df/
         OBU/X0764ZJ4F/bxgU63gvik5aYBFYvW1t/h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166110; x=1709770910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMYd+3PehQzWrhjo72mtYlH8CA55wcaPeIXXwpZd4Nk=;
        b=Klb886YTtE+u1DNm7x/Mlx8If+bcw0OA8CrSEwNVhf9Kp99nITmwO/68DP1HHFmjcT
         E47jt/cNrQ4kD8ZXvKevWT8CbZ0LvOI/I3D2z90jyZgwO+pzjCGfVz1DpdQiwSImNufS
         OgNqy9FOlFRZtgS8qD1WEFOX+a6rwCnqp+WzzU+od/mhFjE4Js1sJI9lOWNTer5GhEmX
         3LfoqiIQvP+qxxVw9i7cdkNac46bsPmMQROrfs8cBIVSBCbIgkWk86v1FVXdk5S0Hfov
         lqBZp+f2H3KjLrpBQCEJkI/RBrmuVVA+cqzDyD7I+FXpXlCpCt4alKodfRO1WyQsZjVB
         I4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKWtKXsV2ITC1aQQxCYjI5fjSl6ZCsJWZsV67vB4YXllBklNTHoOB7WESU8D9vNtAo7U2wRndXSk5F8TLEbAUbFxkHWtC53nSYIMuS
X-Gm-Message-State: AOJu0Ywv1f72Mym3QXOqdkLjhBB5GaNd2cUBuSMQS0aKERDppMoN11S5
	j85RLC1qa/bMWf3XZfMVjU8cDXktXdWA01uIGrcR151/Ziukbgx5doLc4VqO5hpncwIUEYF/iEz
	CKQCJ
X-Google-Smtp-Source: AGHT+IGXnecfcmrPBNns+SRGDNE7cxKCztPxIWmTBQ/LdxqQ3zhfjOndd9PS7ggRGr56ju+pqqMVlA==
X-Received: by 2002:a17:906:2bd4:b0:a3d:482f:3fc4 with SMTP id n20-20020a1709062bd400b00a3d482f3fc4mr277664ejg.70.1709166110239;
        Wed, 28 Feb 2024 16:21:50 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id qb33-20020a1709077ea100b00a4410598eebsm71804ejc.67.2024.02.28.16.21.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:21:50 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4129a748420so34605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:21:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrrYRWst2oQrjlWzHo9huf40pEjJidq/Mgkr8MOs32KJCvvLnBD5W4KiArnrTdG2VlLErpfiEINW0UMxLgGL4X2fj4UgMHLP3sjAvs
X-Received: by 2002:a05:600c:a386:b0:412:aa80:bdd9 with SMTP id
 hn6-20020a05600ca38600b00412aa80bdd9mr37037wmb.2.1709166108715; Wed, 28 Feb
 2024 16:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-3-hsinyi@chromium.org>
In-Reply-To: <20240228011133.1238439-3-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 16:21:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMVr+eJ7eyuLGa671fMgH6ZX9zPOkbKzYJ0H79MZ2k9A@mail.gmail.com>
Message-ID: <CAD=FV=VMVr+eJ7eyuLGa671fMgH6ZX9zPOkbKzYJ0H79MZ2k9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/panel: panel-edp: Match edp_panels with panel name
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> @@ -2107,13 +2113,41 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         { /* sentinal */ }
>  };
>
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
> +static bool edid_has_name(struct edid *edid, const char *panel_name)
> +{
> +       int i, j;
> +       char buf[13];
> +

Should have some comment about why this can't use
drm_edid_get_monitor_name(). AKA because panels seem to be storing the
monitor name tagged as raw strings instead of as the name. Should
probably also have some of the other checks from
is_display_descriptor() like checking for clock of 0 and pad1 of 0.


> +       for (i =3D 0; i < 4; i++) {

Instead of 4, I think this can be ARRAY_SIZE(edid->detailed_timings), right=
?


> +               strncpy(buf, edid->detailed_timings[i].data.other_data.da=
ta.str.str,
> +                       sizeof(buf));

I can never quite remember which of the strXcpy() routines are frowned
upon and which are the golden children at the moment. ...but I don't
think we really need the copy nor the local buffer anyway, right?
You're already going through this thing 1 byte at a time so just
compare it straight away.


> +               for (j =3D 0; j < 13; j++) {
> +                       if (buf[j] =3D=3D 0x0a) {

Instead of hardcoding 0x0a, I think you want '\n', no?


> +                               buf[j] =3D '\0';
> +                               break;
> +                       }
> +               }
> +               buf[12] =3D '\0';
> +               if (strncmp(panel_name, buf, strlen(panel_name)) =3D=3D 0=
)
> +                       return true;

Untested, but I think with my suggestions above the function becomes this:

static bool edid_has_name(struct edid *edid, const char *panel_name)
{
    int i, j;

    /*
     * We can't use drm_edid_get_monitor_name() since many eDP panels store
     * their name as a raw string. We'll accept either a string or name
     * match as long as the panel ID also matches.
     */
    for (i =3D 0; i < ARRAY_SIZE(edid->detailed_timings); i++) {
        struct detailed_timing *timing =3D &edid->detailed_timings[i];

        if (timing->pixel_clock !=3D 0 ||
            timing->data.other_data.pad1 !=3D 0 ||
            (timing->data.other_data.type !=3D EDID_DETAIL_MONITOR_NAME &&
             timing->data.other_data.type !=3D EDID_DETAIL_MONITOR_STRING))
                continue;

        for (j =3D 0; j < ARRAY_SIZE(timing->data.other_data.data.str.str);=
 j++) {
            const char *str =3D timing->data.other_data.data.str.str;

            if (panel_name[j] =3D=3D '\0') {
                if (str[j] =3D=3D '\0' || str[j] =3D=3D '\n')
                    return true;
                break;
            }
        }
        if (j =3D=3D ARRAY_SIZE(timing->data.other_data.data.str.str) &&
            panel_name[j] =3D=3D '\0')
            return true;
    }

    return false;
}

