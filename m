Return-Path: <linux-kernel+bounces-109457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C7788197D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39F7283C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8AE54FAD;
	Wed, 20 Mar 2024 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eV/obVnn"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747A381AA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974142; cv=none; b=dCxZARgu1nqh1NIScFarHbMxVYBk6OQRDECyg9UpgoWAOF8Q1KpCyL8jQsyMJ/QJ5c1DhWw/gHOhg85AfUrtxXUXJ/yY58ijiAFVBBjA3ttoY6hRMQL06odmUasNtE0phB/3BJIOBhdHggAf5Vu8ohLATYWJvMofUGBHoZyRJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974142; c=relaxed/simple;
	bh=NMlbaJEt7YuPuHyd8puVAOBb7ZGjFfwrKm2bJ1oJU84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnjE9WS/JBYz7q+GgGRsB1UIfcY/zDSI2SY8O2IgewXLqiJlW7xRdC4YUr4rxqWg9Ci+q8frBUMeCXL9LLMdEvuSoZ5ABLjuyAAfc8iFbCPdSM3rBMZ5O4pJjNhOaeZYi26KsaB4haPeRvvF3u3amFx7wgZHQZgwiHIwqpf8izA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV/obVnn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso4974891fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710974139; x=1711578939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Eqc8JOcHZY7IXZvTiJ/8bJTfQGWaXx+KUSs3MCDdw=;
        b=eV/obVnn+pkRFC3DIHtOu5DiaFg9XNthy/K/L8aCgvXkkVDNtcfuWph3MLxuKV98UX
         M0JYxVfXuG+JJokGK4wic7VpBuTRAZOWTbXrsPtAKPSUtBcw8TBRijyUyponujSD3QS2
         +Z2nqUTZmEvsKLFJyNZoig9Vr/F5mxjH3UqxHkK+w0MUE5HqWbGoWGmVjZWB8gyKoLCi
         lTXr6JXgp1RRCl7og/nEiCyZXQbkHWWGQvvUavvB5FvqthlhPN7NcPPCIL0oLeCvqx81
         VsqJtBQXQE0v88j4tshpdM8NspKjyTVDY7oIIRJHurS42m2GpMGgXR8mx/Ry+Y+TpaZ/
         XoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710974139; x=1711578939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/Eqc8JOcHZY7IXZvTiJ/8bJTfQGWaXx+KUSs3MCDdw=;
        b=k7KRWzKR8TxlH1n1sZjr7aY4JLOumY0ZIq5k5kleezUfPJd9yXzVFRC7oZd2DunfX2
         FzutCP6n7SuYc5cckrmzVO0ifXpsEtxPt8uEkLUkIlJI+YBxARHLVKbvKLX7zLCbV6B2
         ZjuL7yqJGWYchZru/F/IFkLSU1fEmo1SvXtMzWslHVwTIBwd4wUR3AjyPWkBvwt3jA0D
         bsqGgG99LZUX6jypj5JcvZDzh4gQszATE/k4vAckHI0wsJmRMqyXJIHv55Rbgmq+PQFG
         /ufBLVmuONpHL5Bjmb1IkXTRu6e6xn6+qdKzh0FF3vHo39cG4ooc8H0zcz7UvUDYpBPb
         o0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWZVmi727X9FCpNGvegv6zRFogVk5BK0dzknhbo50/OzJA/2DVgvZhkHiDpB/W618G0fO0CwHkew/xWZcV1bkUDcXnBStkJlwVNnznj
X-Gm-Message-State: AOJu0YyocdM9gMoU9WKfEbNy1957B15nHU19zDZB6hxKpIAU6+ABV1NP
	3Rc/A3cHWV4tjbyveDtFdBXSRUpa1xTq1YvaRsuxkqNKeVTNgzFFXOd78XK8u6cUVpeNaXcVe2A
	4Qo/P39UstvOqZxfsnK7LYEEUoDB4qTvsCNk+
X-Google-Smtp-Source: AGHT+IEn5Owi2sPtfaUxycTRYFwNeKA+Pm2rq41oCVa8/UT2ciC5oEejXaO971X27DHZCT9SSJ+kpz2ClHcFLTEpRno=
X-Received: by 2002:a19:431c:0:b0:513:e17d:cf3c with SMTP id
 q28-20020a19431c000000b00513e17dcf3cmr8896729lfa.1.1710974138867; Wed, 20 Mar
 2024 15:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>
 <53670007-edbc-4762-9e57-0b3c29220d9e@gmx.de>
In-Reply-To: <53670007-edbc-4762-9e57-0b3c29220d9e@gmx.de>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 20 Mar 2024 15:35:26 -0700
Message-ID: <CAFhGd8ppVq9aGbfFLeL30jQ15KHS=FoLh0c1udXo=Z+pCfXL1g@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: au1200fb: replace deprecated strncpy with strscpy
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 20, 2024 at 12:56=E2=80=AFAM Helge Deller <deller@gmx.de> wrote=
:
>
> On 3/19/24 00:46, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > Let's use the new 2-argument strscpy() which guarantees NUL-termination
> > on the destination buffer while also simplifying the syntax. Note that
> > strscpy() will not NUL-pad the destination buffer like strncpy() does.
> >
> > However, the NUL-padding behavior of strncpy() is not required since
> > fbdev is already NUL-allocated from au1200fb_drv_probe() ->
> > frameuffer_alloc(), rendering any additional NUL-padding redundant.
> > |     p =3D kzalloc(fb_info_size + size, GFP_KERNEL);
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >   drivers/video/fbdev/au1200fb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au120=
0fb.c
> > index 6f20efc663d7..e718fea63662 100644
> > --- a/drivers/video/fbdev/au1200fb.c
> > +++ b/drivers/video/fbdev/au1200fb.c
> > @@ -1557,7 +1557,7 @@ static int au1200fb_init_fbinfo(struct au1200fb_d=
evice *fbdev)
> >               return ret;
> >       }
> >
> > -     strncpy(fbi->fix.id, "AU1200", sizeof(fbi->fix.id));
> > +     strscpy(fbi->fix.id, "AU1200");
>
> I wonder if you really build-tested this, as this driver is for the mips =
architecture...
> And I don't see a strscpy() function which takes just 2 arguments.
> But I might be wrong....

I did build successfully :thumbs_up:

Commit e6584c3964f2f ("string: Allow 2-argument strscpy()") introduced
this new strscpy() form; it is present in string.h on Linus' tree.

>
> Helge

Thanks
Justin

