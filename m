Return-Path: <linux-kernel+bounces-157772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4FD8B15FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B8B1F23966
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72916131C;
	Wed, 24 Apr 2024 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrLaSbT8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C7815687F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996950; cv=none; b=PmnwRG2Y+WOUqPANXWyZv5QlwojYiIW8YCnA8PlbFi3WfCvIKBOgS5rEKg+h1xmkil3fnlBwPMwnHUbDJzd0jHquJOW+IXyNweRuUQBgKWWFQKCuKGzHaNQpFn6zoB7RqhI0wiTBHMCvNSG4bi5eATok9VPsvEMJPkrGvdYixeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996950; c=relaxed/simple;
	bh=BTzlFaaUWyBZ/0avVLQeurEPKx5+Gs28mKWdbs+QSVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpSP38LuX3u/YmPJNWEQJ6F68uWboz0N9KQbPC88rZW9yznCnh8Q/nWQzEArEigeyqj+Kj6vii0i4VARYHX0n0v0PGAcA5ows7WYXZie9iabb0DmaplSNkDtCuMjgECLTK/jVCD/P4K2O8v9LzdR1EsmBAgbRoC5GcXGm8jr1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrLaSbT8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso2566365e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713996946; x=1714601746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PwX26yDrbphgPlomUbRviwGBYrIb66VEMHKXPwN1t8=;
        b=QrLaSbT8hi2hSaeSsk8f45Mqln3omSoq7Gb1Wxe4TrOA+WLE1vFyy+jS6/osf3LxOJ
         1jP30i59pwj1VpxqLWOXbP2W7OUeUbaxYYxyZKhb0DZQhFeivkFMAkoZD9zdH54DW0rm
         DBVQ94I1EsTcxOPScku/vKaqgblRqSuW0nfoTuV+BqFZzbrGH5Rx1T9urTEou5jgZCbP
         Y2gxM9IkdFhlAzZUiPlm7SFzKsFi6k75djKMzAjjSeI8WrZjZRYapYmQ1U+/aDp1xdxx
         HLj71v62pHYo1Odd2Du3a7R6kBWOVP+rKI21wq6Ojc2qtmGdGu7nJLFojPrgTary+cf2
         gH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713996946; x=1714601746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PwX26yDrbphgPlomUbRviwGBYrIb66VEMHKXPwN1t8=;
        b=ahCAdSeY3hCxzeP/TFPGZx2Av2EMNGyNOJr9iJEcecoXHT9ce7Qjp7oiLtQFZRv/Oq
         hrSVEIDS0qVVZskV9z7hlPdEWDbJe0pTAZNrVjF3tBlmQgxfGj3f+9smOtQswaF5yJl4
         fmzVcDAmSoK0OboDK86s/MSxoZwFoZAN8OJFLTmys61KtMQwW+iSq29+dNNyC3L7Eod7
         YxVgslUfCeaoGgLHt0DbYzlRxtT3b7y3B9Y7k/lCFb2sZt+Jt4nsI3i2PEHI25jVX9u0
         WP9F0acyW3q3oN7XUnLjU6QxFUL8hyHbtcCKnVwEiRD/2dCr2OmKULsRBHwgtOgXDU23
         ygFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpNKA7kx5lUQwqD44JRkaoOJSdvA0C32+laMk0rv7WRRT5wpDhldu2XqfquEkv2TuXxBvlk22K1VDujOLzpBk7MAZl3yVvvpI+ET6p
X-Gm-Message-State: AOJu0YwvMBkusM6e+O9crTZDWLsOYF2O9rPdDpFSg8xHadGW0z+aW3c4
	5xjTVyS11n/bcCsDHDyWq1cKaYb1iSW68RlZltU36EA1LIyKRsiPgVc9OS4Silp7hJIRvGns1eo
	SlMIZakCXUBT57y4pFG13Ba9qYlt3OxTK2L1K
X-Google-Smtp-Source: AGHT+IHkboif/00IgRcoNKYbKyjHQwpzFRhV06M+te63W8KYhcpbAeVE+PqnNH2rpK8rFGBlds+W+jojcHREsdyxFyE=
X-Received: by 2002:a05:600c:5247:b0:414:273:67d4 with SMTP id
 fc7-20020a05600c524700b00414027367d4mr2632403wmb.30.1713996946437; Wed, 24
 Apr 2024 15:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240418081548.12160-3-lvzhaoxiong@huaqin.corp-partner.google.com>
 <zanx5y3obqmewnbooovf52hx6vh7tpi4zsbse2dyzcqzddmzhw@kewxoa6n3mja>
 <CACb=7PURWtS8bwT5EcAFHhu7deHd2Y8cNOattfdwyEYpOUcbnQ@mail.gmail.com>
 <vbt2nxddw2dc7hkreq4iybv5zv5xyp32oajybeqsphgfrhzmn7@tskvckljmxpe>
 <CACb=7PVTvV9nsFu1ZAXu7YTjSOAGZka+c__EJq3J3qgSJGEShw@mail.gmail.com>
 <CAD=FV=VYAzqsGEBJai9b9n+HxHiG59L1vF73AEWcTwLS_ryjWw@mail.gmail.com>
 <an2k3vgynq4as2sd5dy6ccmdiqedmo7qjsab5qyfhesd333i2a@235sqph3bze5>
 <CAD=FV=VQ8rbwKk4WpHRER9p4cZp7UrrHRpgnErqbQxyxp4sg5w@mail.gmail.com> <CAA8EJprv3qBd1hfdWHrfhY=S0w2O70dZnYb6TVsS6AGRPxsYdw@mail.gmail.com>
In-Reply-To: <CAA8EJprv3qBd1hfdWHrfhY=S0w2O70dZnYb6TVsS6AGRPxsYdw@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@google.com>
Date: Wed, 24 Apr 2024 15:15:18 -0700
Message-ID: <CACb=7PVEpCFWf_aysRkeR0yWAXR5sTaXhNbi3TV3ffKj866+EQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: kd101ne3: add new panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Doug Anderson <dianders@google.com>, 
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>, mripard@kernel.org, 
	airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	cong yang <yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:49=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 25 Apr 2024 at 00:04, Doug Anderson <dianders@google.com> wrote:
> >
> > Hi,
> >
> > On Tue, Apr 23, 2024 at 2:20=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Tue, Apr 23, 2024 at 01:41:59PM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Tue, Apr 23, 2024 at 11:10=E2=80=AFAM Hsin-Yi Wang <hsinyi@googl=
e.com> wrote:
> > > > >
> > > > > > > > > +#define _INIT_DCS_CMD(...) { \
> > > > > > > > > +     .type =3D INIT_DCS_CMD, \
> > > > > > > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > > > > > > +     .data =3D (char[]){__VA_ARGS__} }
> > > > > > > > > +
> > > > > > > > > +#define _INIT_DELAY_CMD(...) { \
> > > > > > > > > +     .type =3D DELAY_CMD,\
> > > > > > > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > > > > > > +     .data =3D (char[]){__VA_ARGS__} }
> > > > > > > >
> > > > > > > > This is the third panel driver using the same appoach. Can =
you use
> > > > > > > > mipi_dsi_generic_write_seq() instead of the huge table? Or =
if you prefer
> > > > > > > > the table, we should extract this framework to a common hel=
per.
> > > > > > > > (my preference is shifted towards mipi_dsi_generic_write_se=
q()).
> > > > > > > >
> > > > > > > The drawback of mipi_dsi_generic_write_seq() is that it can c=
ause the
> > > > > > > kernel size grows a lot since every sequence will be expanded=
.
> > > > > > >
> > > > > > > Similar discussion in here:
> > > > > > > https://lore.kernel.org/dri-devel/CAD=3DFV=3DWju3WS45=3DEpXMU=
g7FjYDh3-=3Dmvm_jS7TF1tsaAzbb4Uw@mail.gmail.com/
> > > > > > >
> > > > > > > This patch would increase the module size from 157K to 572K.
> > > > > > > scripts/bloat-o-meter shows chg +235.95%.
> > > > > > >
> > > > > > > So maybe the common helper is better regarding the kernel mod=
ule size?
> > > > > >
> > > > > > Yes, let's get a framework done in a useful way.
> > > > > > I'd say, drop the _INIT_DELAY_CMD. msleep() and usleep_range() =
should be
> > > > > > used instead (and it's up to the developer to select correct de=
lay
> > > > > > function).
> > > > > >
> > > > > > >
> > > > > > > > > +
> > > > > > > > > +static const struct panel_init_cmd kingdisplay_kd101ne3_=
init_cmd[] =3D {
> > > > > > > > > +     _INIT_DELAY_CMD(50),
> > > > > > > > > +     _INIT_DCS_CMD(0xE0, 0x00),
> > > > > >
> > > > > > [skipped the body of the table]
> > > > > >
> > > > > > > > > +     _INIT_DCS_CMD(0x0E, 0x48),
> > > > > > > > > +
> > > > > > > > > +     _INIT_DCS_CMD(0xE0, 0x00),
> > > > > >
> > > > > > > > > +     _INIT_DCS_CMD(0X11),
> > > > > >
> > > > > > Also, at least this is mipi_dsi_dcs_exit_sleep_mode().
> > > > > >
> > > > > > > > > +     /* T6: 120ms */
> > > > > > > > > +     _INIT_DELAY_CMD(120),
> > > > > > > > > +     _INIT_DCS_CMD(0X29),
> > > > > >
> > > > > > And this is mipi_dsi_dcs_set_display_on().
> > > > > >
> > > > > > Having a single table enourages people to put known commands in=
to the
> > > > > > table, the practice that must be frowned upon and forbidden.
> > > > > >
> > > > > > We have functions for some of the standard DCS commands. So, ma=
ybe
> > > > > > instead of adding a single-table based approach we can improve
> > > > > > mipi_dsi_generic_write_seq() to reduce the bloat. E.g. by movin=
g the
> > > > > > error handling to a common part of enable() / prepare() functio=
n.
> > > > > >
> > > > >
> > > > > For this panel, I think it can also refer to how
> > > > > panel-kingdisplay-kd097d04.c does. Create the table for init cmd =
data,
> > > > > not what operation to use, and use mipi_dsi_generic_write_seq() w=
hen
> > > > > looping through the table.
> > > >
> > > > Even more similar discussion:
> > > >
> > > > https://lore.kernel.org/r/CAD=3DFV=3DUGDbNvAMjzWSOvxybGikQcvW9JsRtb=
xHVg8_97YPEQCA@mail.gmail.com
> > >
> > > It seems I skipped that thread.
> > >
> > > I'd still suggest a code-based solution compared to table-based one, =
for
> > > the reasons I've outlined before. Having a tables puts a pressure on =
the
> > > developer to put commands there for which we already have a
> > > command-specific function.
> >
> > The problem is that with these panels that need big init sequences the
> > code based solution is _a lot_ bigger. If it were a few bytes or a
> > 1-2KB then fine, but when Hsin-Yi measured Linus W's attempt to move
> > from a table to code it was 100K difference in code [1]. I would also
> > say that having these long init sequences done as separate commands
> > encourages people to skip checking the return values of each of the
> > transfer functions and I don't love that idea.
> >
> > It would be ideal if these panels didn't need these long init
> > sequences, but I don't have any inside knowledge here saying that they
> > could be removed. So assume we can't get rid of the init sequences it
> > feels like we have to find some way to make the tables work for at
> > least the large chunks of init code and encourage people to make the
> > tables readable...
>
>
> I did a quick check on the boe-tv101wum-nl6 driver by converting the
> writes to use the following macro:
>
> #define mipi_dsi_dcs_write_cmd_seq(dsi, cmd, seq...)
>              \
>         do {                                                             =
      \
>                 static const u8 d[] =3D { cmd, seq };                    =
    \
>                 ret =3D mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));=
    \
>                 if (ret < 0)                                             =
      \
>                         goto err;                                        =
      \
>         } while (0)
>
> And then at the end of the init funciton having
>
> err:
>         dev_err(panel->dev,
>                 "failed to write command %d\n", ret);
>         return ret;
> }
>

I'm not sure about the coding style rule here, would it be considered
unclear that caller of mipi_dsi_dcs_write_cmd_seq() needs to have err
block, but the block may not be directly used in that caller and is
only jumped from the macro?


> Size comparison:
>    text    data     bss     dec     hex filename
> before
>   34109   10410      18   44537    adf9
> ../build-64/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.o
> making init data const
>   44359     184       0   44543    adff
> ../build-64/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.o
> with new macros
>   44353     184       0   44537    adf9
> ../build-64/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.o
>
> As you can see, there is literally no size difference with this macro in =
place.
> The only drawback is that the init stops on the first write rather
> than going through the sequence.
>
> WDYT? I can turn this into a proper patch if you think this makes sense.
>
> >
> >
> > [1] https://lore.kernel.org/r/CAD=3DFV=3DUFa_AoJQvUT3BTiRs19WCA2xLVeQOU=
=3D+nYu_HaE0_c6Q@mail.gmail.com
>
>
>
> --
> With best wishes
> Dmitry

