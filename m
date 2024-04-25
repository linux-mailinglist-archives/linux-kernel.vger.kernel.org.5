Return-Path: <linux-kernel+bounces-158938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D68B2722
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7087228660F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB914D71B;
	Thu, 25 Apr 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jw5sKXkO"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAC149E0E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064713; cv=none; b=sVZs2xzHALpOw8w3FCC3/cJKe6kU1nyldRWVRok2yKVzRuZk9A0uyH7Au+ejkZcpRmMIU/V+bka8Dv4azZlIiaeC40tgy1Bn1kumFWLbSLHlgL1jG0trsjF+aVXHbKZJr4sP1yDpgNFtiH6dm0gzn0y9JX7Qt0n4LPIXwnTWwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064713; c=relaxed/simple;
	bh=bGGcYbStQ7ss1WrJRL1XIIjPhVR1czfsRYCWc4PkMIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huZE6yJNE2jKtSTLqPGjkzGEamtiW1gFnmhh0dWh6ecHNuTJUieGyqO+xuYbT3Yz15ilVOxKOL32is7WxgKckIIfPAUQLQmfiJvM9zkdyxcfscdpnT7ilHA9SaRH8O1Bs36M3Wmll0w9V99YkltIEXngIT+uHjdngq8ucP03fpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jw5sKXkO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78efd1a0022so84939785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714064708; x=1714669508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8rNWf+tVRhhxpwmfSTwyL/s0CV48BkTtOb2pzwR4zM=;
        b=jw5sKXkOaXu+SZyY4M/G9ITbqKWjunp/iDBHUmXs0gwHSpuuRyO0CU+pKq3xdGcSli
         4LQBg31bjhSPobB35dzYsE7NulL+lPXurcjNt2QnU/t8nTvtc90+cgYkEVlHnoBzLFyF
         UFswsvUfN4hcs0lSfMGJ1fZ/j/gud273O+UrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714064708; x=1714669508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8rNWf+tVRhhxpwmfSTwyL/s0CV48BkTtOb2pzwR4zM=;
        b=xTPzoWE5FLeqn9c0zhUATSLZWsOt2aQp83bDwH6La1CVr8FUGUFVdGac7JFXMfFcd+
         s5DBRjFGQfTr8A20dNj56t1DorZpftKQO+9DzIboUO2TZmAUo/If1dKn2wzdbl9Cz1BF
         SFz9VvCVYSSWSuZqV+w1iwyL8L43Ej2x8KKnxMRLcWPZHShDvbDhaPIkEWACJ0Rc97DG
         X14Prf9TcEqTQT8ELx40goYZdOAmL5YX3j8Y53uJOqbdvJhLNSR7ByVlx9WF533aAlKF
         6cl+VXnp/ki9lSkzOUGu0X4DJCzQkAAaHRWxaJVibjXUsU9R/sBR49tUEFl3+VNhscuq
         j/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVWNCv4Md99mjvJZFPrXXVBphxZNyfhilMc65GUeokkg5ptgBNyjdiRveh6K3Ytc0rIV15fjMBomsLUx9sbFaDg+XhR6mCAAUdojqwP
X-Gm-Message-State: AOJu0YyoGAkZKFs6k27LB5+OuQVAS5rrVZ0EuoA/LJXQy9nodTpKnsKv
	Aw6OI48+n7SWlV3bx7KMleM3dd43F5DbRXzHYJKg8YLK3IiUGU4XuPPM5RroJdSJ7Mvu/VEiglE
	=
X-Google-Smtp-Source: AGHT+IH8R1NWuJBv+CpcZHJ1CwBdddJRzR+ckc1V8CHL8sfdosfIJPU4FuAxRWfUYXoGVBhu2UTVqw==
X-Received: by 2002:a05:620a:4044:b0:78f:1a25:e341 with SMTP id i4-20020a05620a404400b0078f1a25e341mr296375qko.4.1714064708350;
        Thu, 25 Apr 2024 10:05:08 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id c13-20020ae9e20d000000b0078efd245e09sm7163539qkc.79.2024.04.25.10.05.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 10:05:08 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439b1c72676so16051cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:05:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVO4Cf+oF2oBmplB6VGkGOo+ByUbIXF5764cVHBS2FxMbtBzfdF/zAbrWPwwytcBYw7mo92B6vvGtjGSX1V0hoQbMcE/154o0izd1nD
X-Received: by 2002:a05:622a:30d:b0:43a:5c5e:2e49 with SMTP id
 q13-20020a05622a030d00b0043a5c5e2e49mr174171qtw.8.1714064706366; Thu, 25 Apr
 2024 10:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
 <87pludq2g0.fsf@intel.com>
In-Reply-To: <87pludq2g0.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 10:04:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
Message-ID: <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linus.walleij@linaro.org, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	lvzhaoxiong@huaqin.corp-partner.google.com, Hsin-Yi Wang <hsinyi@google.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 1:19=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> > @@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
> >
> >  ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
> >                                 const void *data, size_t len);
> > +ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
> > +                                      const void *data, size_t len);
> >  ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
> >                          const void *data, size_t len);
> >  ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *d=
ata,
> > @@ -317,14 +321,10 @@ int mipi_dsi_dcs_get_display_brightness_large(str=
uct mipi_dsi_device *dsi,
> >  #define mipi_dsi_generic_write_seq(dsi, seq...)                       =
         \
> >       do {                                                             =
      \
> >               static const u8 d[] =3D { seq };                         =
        \
> > -             struct device *dev =3D &dsi->dev;                        =
        \
> >               int ret;                                                 =
      \
> > -             ret =3D mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));   =
        \
> > -             if (ret < 0) {                                           =
      \
> > -                     dev_err_ratelimited(dev, "transmit data failed: %=
d\n", \
> > -                                         ret);                        =
      \
> > +             ret =3D mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(=
d));    \
> > +             if (ret < 0)                                             =
      \
> >                       return ret;                                      =
      \
> > -             }                                                        =
      \
> >       } while (0)
>
> The one thing that I've always disliked about these macros (even if I've
> never actually used them myself) is that they hide control flow from the
> caller, i.e. return directly. You don't see that in the code, it's not
> documented, and if you wanted to do better error handling yourself,
> you're out of luck.

Yeah, I agree that it's not the cleanest. That being said, it is
existing code and making the existing code less bloated seems worth
doing.

I'd also say that it feels worth it to have _some_ solution so that
the caller doesn't need to write error handling after every single cmd
sent. If we get rid of / discourage these macros that's either going
to end us up with ugly/verbose code or it's going to encourage people
to totally skip error handling. IMO neither of those are wonderful
solutions.

While thinking about this there were a few ideas I came up with. None
of them are amazing, but probably they are better than the hidden
"return" like this. Perhaps we could mark the current function as
"deprecated" and pick one of these depending on what others opinions
are:

1. Use "goto" and force the caller to give a goto target for error handling=
.

This is based on an idea that Dmitry came up with, but made a little
more explicit. Example usage:

int ret;

ret =3D 0;
mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETSPCCMD, 0xcd,
                            some_cmd_failed);
mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETMIPI, 0x84,
                            some_cmd_failed);
mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETSPCCMD, 0x3f,
                            some_cmd_failed);
mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETVDC, 0x1b, 0x04,
                            some_cmd_failed);

..

some_cmd_failed:
  pr_err("Commands failed to write: %d", ret);
  return ret;
}

One downside here is that you can't easily tell which command failed
to put it in the error message. A variant of this idea (1a?) could be
to hoist the print back into the write command. I'd want to pick one
or the other. I guess my preference would be to hoist the print into
the write command and if someone really doesn't want the print then
they call mipi_dsi_dcs_write_buffer() directly.

---

2. Accept that a slightly less efficient handling of the error case
and perhaps a less intuitive API, but avoid the goto.

Essentially you could pass in "ret" and have the function be a no-op
if an error is already present. Something like this:

void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_device *dsi,
const void *data, size_t len, int *accum_ret)
{
  if (*accum_ret)
    return;

  *accum_ret =3D mipi_dsi_dcs_write_buffer(dsi, data, len);
}

..and then the caller:

int ret;

ret =3D 0;
mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETSPCCMD, 0xcd, &ret);
mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETMIPI, 0x84, &ret);
mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETSPCCMD, 0x3f, &ret);
mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETVDC, 0x1b, 0x04, &ret);
if (ret)
  goto some_cmd_failed;

This has similar properties to solution #1.

---

3. Accept that callers don't want to error handling but just need a print.

I'm not 100% sure we want to encourage this. On the one hand it's
unlikely anyone is really going to be able to reliably recover super
properly from an error midway through a big long command sequence. On
the other hand, this means we can't pass the error back to the caller.
In theory the caller _could_ try to handle errors by resetting / power
cycling things, so that's a real downside.

Example usage:

mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETSPCCMD, 0xcd);
mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETMIPI, 0x84);
mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETSPCCMD, 0x3f);
mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETVDC, 0x1b, 0x04);

---

I think I'd lean towards #1a (user passes goto label and we include
the error print in the helper), but I'd personally be happy with any
of #1 or #2. I don't love #3.

> Be that as it may, the combo of ratelimited error printing and return on
> errors does not make much sense to me. If there's something to print,
> you bail out, that's it. I suspect we never hit the ratelimit.

Yeah, I'm in favor of removing the ratelimit.


> You might even want to try *only* changing the ratelimited printing to a
> regular error message, and see if the compiler can combine the logging
> to a single exit point in the callers. Ratelimited it obviously can't
> because every single one of them is unique.

It wasn't quite as good. Comparing the "after" solution (AKA applying
$SUBJECT patch) vs. _not_ taking $SUBJECT patch and instead changing
dev_err_ratelimited() to dev_err().

$ scripts/bloat-o-meter \
   .../after/panel-novatek-nt36672e.ko \
  .../noratelimit/panel-novatek-nt36672e.ko
add/remove: 0/0 grow/shrink: 1/0 up/down: 3404/0 (3404)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init                7260   10664   +3404
Total: Before=3D11669, After=3D15073, chg +29.17%

..so $SUBJECT patch is still better.

---

Where does that leave us? IMO:

a) If others agree, we should land $SUBJECT patch. It doesn't change
the behavior at all and gives big savings. It adds an extra function
hop, but presumably the fact that we have to fetch _a lot_ less stuff
from RAM might mean we still get better performance (likely it doesn't
matter anyway since this is not hotpath code).

b) Atop this patch, we should consider changing dev_err_ratelimited()
to dev_err(). It doesn't seem to make lots of sense to me to ratelimit
this error.

c) Atop this patch, we should consider making the two existing macros
"deprecated" in favor of a new macro that makes the control flow more
obvious.

How does that sound to folks?

-Doug

