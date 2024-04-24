Return-Path: <linux-kernel+bounces-157839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF08B170A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482621C23AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFE16F0E0;
	Wed, 24 Apr 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLCey4c/"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DD156964
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001126; cv=none; b=LHMTq31jDHoPNTf/9OLgylomyJ+iMGEFyDDRtePgxkHDQvCi4jMsGIheA/VgG/GPXTg/qKn3nf/oX42ogD44nPvIJ3Ah1cooVlHgqeisNBFps2MIDiLu3ldo0Px+LZkDQl+EfgFLfkLFvDG62hsFkY4NG8qXmwg5AFSp3SM3fqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001126; c=relaxed/simple;
	bh=w82ER0IflDrSeOEkY+ItZ9K207uzmYQ+tSNVV9wr/sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB3u06sSxfuMHEE8+8lXkfrMBujTzhn5brpgsHPbYkX+vI6fadVciQiIa0O/i4Via9IZgTAkrX29YhAT1uCfjEhY+JhcOgplQziUPtNG5+CsmTrNpZxYiWankWVhzpT9yyNcZogfRRPjBBtEii9gxl0DImEJg1BTQGSFjNvHFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLCey4c/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-439b1c72676so105951cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714001124; x=1714605924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qmcwM8RwSJ8RvR8mUmf7ZCMdq1Mj/o54DavtjLG99s=;
        b=DLCey4c/ELKypx0LIOrQEJWfxb8iu6/gZ59KA1wKK0Q2KA32sxjjz8WXvAVa5PgShw
         ZHXadfG897dga0007ttbPgVVX/KKVCjQoYjHRheT3aeraTt/nssDx+Fb/U9DnBaXtQ6j
         urdBV3IHeCpy0l/Urp1B6vGPWWQW8YfZE9bUeW+rsV2vwV/UWERRJgjftOu9i4ZSNniX
         1V3AGthCSBeC6vWYnU6PYhEsClBbaxBfjivOm+0D/ya7s9t70weSy1zf8wG1Qqfdmr4j
         plEcUF2xDkeHP9f1XoWI0uCvsRbdmEO+L+aCVkm21TJS30rq8Lk9pULkhKhyusAtZ/0u
         hSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001124; x=1714605924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qmcwM8RwSJ8RvR8mUmf7ZCMdq1Mj/o54DavtjLG99s=;
        b=tZ5W+qQp7vY0tBenWPVoKROzqa9ckw1kzq0FW6MyBjnncf6JIbPRrHjvTtMpZW/tER
         okiumPSGFz37WAKa4oSQDtblgTubv2SR81BnQC3wsmsOeKOa2DZxJulrWffcwMBvzK6J
         lEVGDtigsbSjT9kVexqbk4+60k03ppoub5QAF2HVwHTSSS0D+JVosMaD4ibd1un5JKwK
         KBHs2FpRL0oWf39u8QLgqpzgzmGADDdYJj4fD9fn2nNqIOKDxbDXldjGibptT7Q9d3YP
         dYgryYHAU1teBZAOJmy2rqWHmj8tej+yU1DxHtrYUjdzj3bBohqZlVWBbbuP9uue2pw7
         ZqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Ih1/tl8dER2rc4GCi/WlIeu85O4z1qijuoiaJn0e2/5H+WHT86NOZ0fcBzGyCDh0mWeum6qd0Y7LpwA/A4G9VElPt6gh994FOK0G
X-Gm-Message-State: AOJu0YzdmyQUPpz5pMXCD0w1dmYBobju3U+kEMaYxMQCt9+w3hWYMYCx
	vUKHIOKq17s37mPGK4102+iJi2RGqjCV5QXtfwq5i8O4scqTBp4w8iPLrY/6TwWX8mNnsNS7Ttl
	wCcuaZrAdaQ4b4TpiG3Pkdir5Sz2AKV6/PQST
X-Google-Smtp-Source: AGHT+IGngb+doAaU+bl0yImCLvQlYT3JWd2Y1NtDuZR6IHeqS9NEm1m+Z/ararXJJXOEKKR3n7VPR7GvvCDu+nBXR4w=
X-Received: by 2002:ac8:6604:0:b0:437:816e:48e5 with SMTP id
 c4-20020ac86604000000b00437816e48e5mr47052qtp.29.1714001123922; Wed, 24 Apr
 2024 16:25:23 -0700 (PDT)
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
 <CAD=FV=VQ8rbwKk4WpHRER9p4cZp7UrrHRpgnErqbQxyxp4sg5w@mail.gmail.com>
 <CAA8EJprv3qBd1hfdWHrfhY=S0w2O70dZnYb6TVsS6AGRPxsYdw@mail.gmail.com>
 <CACb=7PVEpCFWf_aysRkeR0yWAXR5sTaXhNbi3TV3ffKj866+EQ@mail.gmail.com> <CAA8EJprLvEt_pt4XzACQG7pU8KYagKbQ71xwtRF9KrLygTT3ow@mail.gmail.com>
In-Reply-To: <CAA8EJprLvEt_pt4XzACQG7pU8KYagKbQ71xwtRF9KrLygTT3ow@mail.gmail.com>
From: Doug Anderson <dianders@google.com>
Date: Wed, 24 Apr 2024 16:25:07 -0700
Message-ID: <CAD=FV=V+jBvkKj1vvAsXuC5dSn0u_SQBQZHTrDZKoSG2V4fp3g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: kd101ne3: add new panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Hsin-Yi Wang <hsinyi@google.com>, 
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>, mripard@kernel.org, 
	airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	cong yang <yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 24, 2024 at 3:51=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 25 Apr 2024 at 01:15, Hsin-Yi Wang <hsinyi@google.com> wrote:
> >
> > On Wed, Apr 24, 2024 at 2:49=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, 25 Apr 2024 at 00:04, Doug Anderson <dianders@google.com> wro=
te:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Apr 23, 2024 at 2:20=E2=80=AFPM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > On Tue, Apr 23, 2024 at 01:41:59PM -0700, Doug Anderson wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Tue, Apr 23, 2024 at 11:10=E2=80=AFAM Hsin-Yi Wang <hsinyi@g=
oogle.com> wrote:
> > > > > > >
> > > > > > > > > > > +#define _INIT_DCS_CMD(...) { \
> > > > > > > > > > > +     .type =3D INIT_DCS_CMD, \
> > > > > > > > > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > > > > > > > > +     .data =3D (char[]){__VA_ARGS__} }
> > > > > > > > > > > +
> > > > > > > > > > > +#define _INIT_DELAY_CMD(...) { \
> > > > > > > > > > > +     .type =3D DELAY_CMD,\
> > > > > > > > > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > > > > > > > > +     .data =3D (char[]){__VA_ARGS__} }
> > > > > > > > > >
> > > > > > > > > > This is the third panel driver using the same appoach. =
Can you use
> > > > > > > > > > mipi_dsi_generic_write_seq() instead of the huge table?=
 Or if you prefer
> > > > > > > > > > the table, we should extract this framework to a common=
 helper.
> > > > > > > > > > (my preference is shifted towards mipi_dsi_generic_writ=
e_seq()).
> > > > > > > > > >
> > > > > > > > > The drawback of mipi_dsi_generic_write_seq() is that it c=
an cause the
> > > > > > > > > kernel size grows a lot since every sequence will be expa=
nded.
> > > > > > > > >
> > > > > > > > > Similar discussion in here:
> > > > > > > > > https://lore.kernel.org/dri-devel/CAD=3DFV=3DWju3WS45=3DE=
pXMUg7FjYDh3-=3Dmvm_jS7TF1tsaAzbb4Uw@mail.gmail.com/
> > > > > > > > >
> > > > > > > > > This patch would increase the module size from 157K to 57=
2K.
> > > > > > > > > scripts/bloat-o-meter shows chg +235.95%.
> > > > > > > > >
> > > > > > > > > So maybe the common helper is better regarding the kernel=
 module size?
> > > > > > > >
> > > > > > > > Yes, let's get a framework done in a useful way.
> > > > > > > > I'd say, drop the _INIT_DELAY_CMD. msleep() and usleep_rang=
e() should be
> > > > > > > > used instead (and it's up to the developer to select correc=
t delay
> > > > > > > > function).
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > > +static const struct panel_init_cmd kingdisplay_kd101=
ne3_init_cmd[] =3D {
> > > > > > > > > > > +     _INIT_DELAY_CMD(50),
> > > > > > > > > > > +     _INIT_DCS_CMD(0xE0, 0x00),
> > > > > > > >
> > > > > > > > [skipped the body of the table]
> > > > > > > >
> > > > > > > > > > > +     _INIT_DCS_CMD(0x0E, 0x48),
> > > > > > > > > > > +
> > > > > > > > > > > +     _INIT_DCS_CMD(0xE0, 0x00),
> > > > > > > >
> > > > > > > > > > > +     _INIT_DCS_CMD(0X11),
> > > > > > > >
> > > > > > > > Also, at least this is mipi_dsi_dcs_exit_sleep_mode().
> > > > > > > >
> > > > > > > > > > > +     /* T6: 120ms */
> > > > > > > > > > > +     _INIT_DELAY_CMD(120),
> > > > > > > > > > > +     _INIT_DCS_CMD(0X29),
> > > > > > > >
> > > > > > > > And this is mipi_dsi_dcs_set_display_on().
> > > > > > > >
> > > > > > > > Having a single table enourages people to put known command=
s into the
> > > > > > > > table, the practice that must be frowned upon and forbidden=
.
> > > > > > > >
> > > > > > > > We have functions for some of the standard DCS commands. So=
, maybe
> > > > > > > > instead of adding a single-table based approach we can impr=
ove
> > > > > > > > mipi_dsi_generic_write_seq() to reduce the bloat. E.g. by m=
oving the
> > > > > > > > error handling to a common part of enable() / prepare() fun=
ction.
> > > > > > > >
> > > > > > >
> > > > > > > For this panel, I think it can also refer to how
> > > > > > > panel-kingdisplay-kd097d04.c does. Create the table for init =
cmd data,
> > > > > > > not what operation to use, and use mipi_dsi_generic_write_seq=
() when
> > > > > > > looping through the table.
> > > > > >
> > > > > > Even more similar discussion:
> > > > > >
> > > > > > https://lore.kernel.org/r/CAD=3DFV=3DUGDbNvAMjzWSOvxybGikQcvW9J=
sRtbxHVg8_97YPEQCA@mail.gmail.com
> > > > >
> > > > > It seems I skipped that thread.
> > > > >
> > > > > I'd still suggest a code-based solution compared to table-based o=
ne, for
> > > > > the reasons I've outlined before. Having a tables puts a pressure=
 on the
> > > > > developer to put commands there for which we already have a
> > > > > command-specific function.
> > > >
> > > > The problem is that with these panels that need big init sequences =
the
> > > > code based solution is _a lot_ bigger. If it were a few bytes or a
> > > > 1-2KB then fine, but when Hsin-Yi measured Linus W's attempt to mov=
e
> > > > from a table to code it was 100K difference in code [1]. I would al=
so
> > > > say that having these long init sequences done as separate commands
> > > > encourages people to skip checking the return values of each of the
> > > > transfer functions and I don't love that idea.
> > > >
> > > > It would be ideal if these panels didn't need these long init
> > > > sequences, but I don't have any inside knowledge here saying that t=
hey
> > > > could be removed. So assume we can't get rid of the init sequences =
it
> > > > feels like we have to find some way to make the tables work for at
> > > > least the large chunks of init code and encourage people to make th=
e
> > > > tables readable...
> > >
> > >
> > > I did a quick check on the boe-tv101wum-nl6 driver by converting the
> > > writes to use the following macro:
> > >
> > > #define mipi_dsi_dcs_write_cmd_seq(dsi, cmd, seq...)
> > >              \
> > >         do {                                                         =
          \
> > >                 static const u8 d[] =3D { cmd, seq };                =
        \
> > >                 ret =3D mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(=
d));    \
> > >                 if (ret < 0)                                         =
          \
> > >                         goto err;                                    =
          \
> > >         } while (0)
> > >
> > > And then at the end of the init funciton having
> > >
> > > err:
> > >         dev_err(panel->dev,
> > >                 "failed to write command %d\n", ret);
> > >         return ret;
> > > }
> > >
> >
> > I'm not sure about the coding style rule here, would it be considered
> > unclear that caller of mipi_dsi_dcs_write_cmd_seq() needs to have err
> > block, but the block may not be directly used in that caller and is
> > only jumped from the macro?
>
> I'm also not sure here. It was a quick and dirty test.
> We might as well do something like
>
> ret =3D mipi_dsi_dcs_write_cmd_seq(dsi, ...);
> if (ret)
>     goto err;
>
> all over the place.

Oh. This is actually very simple to fix and requires no code changes
to clients. :-P We just need to hoist the printing out of the macro
and into "drm_mipi_dsi.c". Let me double-confirm and then I'll post a
patch.

-Doug

