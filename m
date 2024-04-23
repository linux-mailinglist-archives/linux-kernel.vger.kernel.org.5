Return-Path: <linux-kernel+bounces-155408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2228AE9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDBA1C22134
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730F13BADD;
	Tue, 23 Apr 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5IH/c+A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC47D408
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884379; cv=none; b=cT5Talaz115nal62u7iBN0UTm3Oyk+CNJtnHjEriXSpovCt7r8kiisTNhC+tLdldieA4bJz+sZwj+lr9hrE4dyumkLEptI4h+vAPa5QLNvVAYY7jSHIwlfGADyhh+XA2019CH2I9JEPw2uSg1ey6lJ164uhDSqG7sZPiaOvCpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884379; c=relaxed/simple;
	bh=olfSGTsFnuztaBe/6TGLSCfwwp+edxO3rygKLxl5HZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZS2RUUfd7lwiF2HuJpF5RclZw5agNVyjtIogsUUNgkvMUSdc38+hwez6aOY1EOEi2Ww415aBqgIl5vELhO/oNyMEwpF8yQ4yXA4cxy1Ir9xZDBReOrCw06bx8Z4JTkSW6vneXzdfwTuPQQs+tBkJ5Lfx97o37/6t+2dkkdAkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5IH/c+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713884376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ie+FYpj1GJEe+9FkFNy/6w/kFm+u4y5scRjGEyrOJXw=;
	b=V5IH/c+AVgHlDpkHW7clK278FeGKHXWzB7RfNCi+iZhlmpCY2nyLETYXdirRoCs2SP7i2S
	OH1bH+1qk1B2m9uhmyBko0a6Ly6ZRKnjbDZ3r7MLb3U1FVuF6cNW78BX6Mx6vsKgRh5W7r
	uachMeYUlUyX0CjJJElFOGwb06WgRpI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-EZAkr8dRO22DzJbf_RHEBg-1; Tue, 23 Apr 2024 10:59:35 -0400
X-MC-Unique: EZAkr8dRO22DzJbf_RHEBg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56865619070so1931680a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884373; x=1714489173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie+FYpj1GJEe+9FkFNy/6w/kFm+u4y5scRjGEyrOJXw=;
        b=Ve78Bglev4f5JIRMln7CNbOIIGfemVsKJ5RY6cGboSsRG5FplBlIJjEZeru87VG53p
         bghbtP+P/DCMApvCkbrYnkmD6cJFdG2vbDCozZLOHohH42/VzQFhxCTvRddKJMnFuLZg
         HxQWGUUATPXrlyLHR9VMBkksY00Y67EyZAzNBKvjmnuOa4hsTox/td1blLK08E4eLLOQ
         sN6WzwztZzBcl8m/h0hcJ2TgakBhCX1UneFglr4v/1cOgtbRVCeG5ohuttDXPqIskHiR
         U2cQzivVRnn4zwtHUDMC+yMOTx84Mpxtw9A0zyrRSBxgYLDB5Snu1Wg8AL1wcHELVYph
         DWvw==
X-Forwarded-Encrypted: i=1; AJvYcCUNAPcNnJYVlbgOBXryJrt9GIctfzt230piqSy8hKPKVniR+oy+M1Tophw8nRh+4t+YpNZbAf0m3EydQXbctU9u9/fjRYd2R/xruojZ
X-Gm-Message-State: AOJu0YzsyajNzGJ0W2tCXw2CaQ/frfYw/2INMaCof5ZBm7dhyHDg00V4
	vymBAJ3EKIRuHISKeUb4IAC7Ry3xq07NzeY6shFH3GLYslO16jYr0i0262gvbSEU3X4ItrNhHyf
	dlD26raL0hO70spq+WlmiOL1wh8yn2gwJgvXs+FO/PtXHa5HI+Q7lP7hgr8x8Wqp9M2zM59zrsr
	XizrSbLL0tXXImubp4MC7+Naq6UkJFxq+/y2OZx3bd+QKf
X-Received: by 2002:a50:d5cc:0:b0:570:5b72:164 with SMTP id g12-20020a50d5cc000000b005705b720164mr8847178edj.37.1713884373127;
        Tue, 23 Apr 2024 07:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx+SFJ52iA64fGz8cP56CJid1VLQQ91ZyiKP07BwcaJus+buR5U7snRiTmt/sE1JslZDX0L1Um1xd3XyxBORk=
X-Received: by 2002:a50:d5cc:0:b0:570:5b72:164 with SMTP id
 g12-20020a50d5cc000000b005705b720164mr8847165edj.37.1713884372794; Tue, 23
 Apr 2024 07:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331182440.14477-1-kl@kl.wtf> <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
In-Reply-To: <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 23 Apr 2024 16:59:20 +0200
Message-ID: <CAO-hwJJtK2XRHK=HGaNUFb3mQhY5XbNGeCQwuAB0nmG2bjHX-Q@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Revert to await reset ACK before reading
 report descriptor
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Jiri Kosina <jikos@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kenny Levinsen <kl@kl.wtf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 7:11=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 31.03.24 20:24, Kenny Levinsen wrote:
> > In af93a167eda9, i2c_hid_parse was changed to continue with reading the
> > report descriptor before waiting for reset to be acknowledged.
> >
> > This has lead to two regressions:
>
> Lo! Jiri, Benjamin, quick question: is there a reason why this fix for a
> 6.8-rc1 regression after more than two and half weeks is not yet
> mainlined? Or is there some good reason why we should be should be extra
> cautious?

No special reasons I guess. Neither Jiri nor I have sent a HID update
for this rc cycle, so it's still there, waiting to be pushed.
I've been quite busy with BPF lately and dropped the ball slightly on
the HID maintainer side, but I'm sure we'll send the PR to Linus this
week or the next.

Cheers,
Benjamin


>
>
> Side note: I noticed this due to the tracking today, but I also saw a
> user that recently ran into the problem the quoted fix is supposed to
> resolve: https://social.lol/@major/112294923280815017
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> > 1. We fail to handle reset acknowledgement if it happens while reading
> >    the report descriptor. The transfer sets I2C_HID_READ_PENDING, which
> >    causes the IRQ handler to return without doing anything.
> >
> >    This affects both a Wacom touchscreen and a Sensel touchpad.
> >
> > 2. On a Sensel touchpad, reading the report descriptor this quickly
> >    after reset results in all zeroes or partial zeroes.
> >
> > The issues were observed on the Lenovo Thinkpad Z16 Gen 2.
> >
> > The change in question was made based on a Microsoft article[0] stating
> > that Windows 8 *may* read the report descriptor in parallel with
> > awaiting reset acknowledgement, intended as a slight reset performance
> > optimization. Perhaps they only do this if reset is not completing
> > quickly enough for their tastes?
> >
> > As the code is not currently ready to read registers in parallel with a
> > pending reset acknowledgement, and as reading quickly breaks the report
> > descriptor on the Sensel touchpad, revert to waiting for reset
> > acknowledgement before proceeding to read the report descriptor.
> >
> > [0]: https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/plu=
g-and-play-support-and-power-management
> >
> > Fixes: af93a167eda9 ("HID: i2c-hid: Move i2c_hid_finish_hwreset() to af=
ter reading the report-descriptor")
> > Signed-off-by: Kenny Levinsen <kl@kl.wtf>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-core.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i=
2c-hid-core.c
> > index 2df1ab3c31cc..72d2bccf5621 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -735,9 +735,12 @@ static int i2c_hid_parse(struct hid_device *hid)
> >       mutex_lock(&ihid->reset_lock);
> >       do {
> >               ret =3D i2c_hid_start_hwreset(ihid);
> > -             if (ret)
> > +             if (ret =3D=3D 0)
> > +                     ret =3D i2c_hid_finish_hwreset(ihid);
> > +             else
> >                       msleep(1000);
> >       } while (tries-- > 0 && ret);
> > +     mutex_unlock(&ihid->reset_lock);
> >
> >       if (ret)
> >               goto abort_reset;
> > @@ -767,16 +770,8 @@ static int i2c_hid_parse(struct hid_device *hid)
> >               }
> >       }
> >
> > -     /*
> > -      * Windows directly reads the report-descriptor after sending res=
et
> > -      * and then waits for resets completion afterwards. Some touchpad=
s
> > -      * actually wait for the report-descriptor to be read before sign=
alling
> > -      * reset completion.
> > -      */
> > -     ret =3D i2c_hid_finish_hwreset(ihid);
> >  abort_reset:
> >       clear_bit(I2C_HID_RESET_PENDING, &ihid->flags);
> > -     mutex_unlock(&ihid->reset_lock);
> >       if (ret)
> >               goto out;
> >
>


