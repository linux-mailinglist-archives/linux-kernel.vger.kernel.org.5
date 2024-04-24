Return-Path: <linux-kernel+bounces-157730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE58B1521
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5BB288934
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E1156C65;
	Wed, 24 Apr 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFPfBCc2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9813C9DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993545; cv=none; b=eOxYS35sASq9UwOEqdXVlgZn6zzrVMa3ak+vUk9I3r5tsUiEFwmKkxW8M+hBktD8+t+0arNMexOcSUMAy0dFkmA3sRQNSYMBmqOBJbXl/JM41tOQJxY9mO13fofcEjniYHpX6dki46Zbx6IoOk5sDm3lf+Kg4QGb6+1ZZ9148K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993545; c=relaxed/simple;
	bh=jnfyCRllDf9zMH/M3/VgN0aEc9vL2bQpZfaXRORwS6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSpvQbK+5h5J2vn//0BSWHRbU0mFIEAyflmpmp/foCHiDfeqgi/Q8+FJ9wckJByG99o4hQlsYChY+47Qqdo/j14tFgDNYz5K8BSlBDNfR9QRXlbhMqq1RbMOwOcgLpiE4espEbpKVdAvcA/jHpEK4TB/VLKWh92pw+S/NfxL6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFPfBCc2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso2374665e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713993542; x=1714598342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyqJICL/NhOtTQujLHLdII7xx3GTWReyFc8422FFAgY=;
        b=yFPfBCc2aeQWXQZN+RNTAnHF0k2mOX/BL1dzD+UReDza8bLzQru/SinypDnkr2liGW
         fvHsX8Th/ofwCFJO1sXeYZnAwy8ZLcOxTLUhXe3+gsdwQzGnjoyJW1DAixSxXPbDVPyb
         tVlfMFAmMXrAayvYMdbVab6mWiI5LOmEUOHUJeY0TIOcX+lVsp6vgpuMaF+7dXr3IOgM
         amZjHXl+tpzvPVl+qA/+839XIHZ6HxJTNKjSebvGsE+FGWQJ8ppsJfLpZmAKz6f9eXhr
         HftFPEtn8ZYRCMruv9+6RltroQ6O46t2mP7ubGJxPtu1H685Cce/Der89jJWjgZYxd4D
         RWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713993542; x=1714598342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyqJICL/NhOtTQujLHLdII7xx3GTWReyFc8422FFAgY=;
        b=iVVBPhpWbe9REvzUzSaFgbHMkzGzReBVJGZdP2d2LSt2G74trCqKxhdi7kPVkmGy34
         yEIBe17OIr9/VP2MhIMaYwxv+KwsQny9xbroKzdblfmXuw9EPlRw+8Tz1tvCU2QBGBtd
         gPvuHo18AeWgVrLoZ5nUpw9nx21sxJmw5WI0cmEQiFIDURh4eUc+t9xDXG0f4Zlsjngc
         Aqs7OkIBOVHhnFEmkLLV8fEfsFm+Mh2hIsDnOQgdyFf7iI9lkOAMRbFBr4apLjGp6mh5
         zdu9qzCoSHvUVPrC1M7AF9rktitcTcJwQePGYq4rXI63Pf5k6w0tDXLoN5EcRP9C89PM
         xZRw==
X-Forwarded-Encrypted: i=1; AJvYcCUVRTHS3vN9SvAiSH4VnUuj+W7sD7MaZW500PUDdmy1OJYuATL9CxWnnlR/i/x6+E8W6btAfB9yB1kgzrCDDPM6LKeyD+6Y9SNrEsNU
X-Gm-Message-State: AOJu0YyQGwuL8H15qWDR6SqNzjvosF3tQpFf7I3s6ra0CfuOblmbqiF7
	vKYb4ijmlVpdH8rFSPhy20p3qsfsJ4LZ0aotT3L6m/NkSd1fEUHu8MyHbOGjhcyNZ36DH4PE7GP
	RBIpQtlq9kq3xNF7prvhgFpuQ72SzzjWBL5eR
X-Google-Smtp-Source: AGHT+IHFLVEdHmBXKMfxFBhUa+Zc2CsiMjLGO0d6lOSPxNVBtuDy4JyH/ADS2yiPwrT9oxofdQYERqgoOGVg3wreJQY=
X-Received: by 2002:a05:600c:1d29:b0:418:676d:2a51 with SMTP id
 l41-20020a05600c1d2900b00418676d2a51mr2881642wms.15.1713993541979; Wed, 24
 Apr 2024 14:19:01 -0700 (PDT)
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
 <an2k3vgynq4as2sd5dy6ccmdiqedmo7qjsab5qyfhesd333i2a@235sqph3bze5> <CAD=FV=VQ8rbwKk4WpHRER9p4cZp7UrrHRpgnErqbQxyxp4sg5w@mail.gmail.com>
In-Reply-To: <CAD=FV=VQ8rbwKk4WpHRER9p4cZp7UrrHRpgnErqbQxyxp4sg5w@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@google.com>
Date: Wed, 24 Apr 2024 14:18:33 -0700
Message-ID: <CACb=7PXKTkpPA-cSwwoa3a2H5-iR7uNCWH9X0DHaFWmZd001Ow@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: kd101ne3: add new panel driver
To: Doug Anderson <dianders@google.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>, mripard@kernel.org, 
	airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	cong yang <yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:05=E2=80=AFPM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Tue, Apr 23, 2024 at 2:20=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, Apr 23, 2024 at 01:41:59PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Tue, Apr 23, 2024 at 11:10=E2=80=AFAM Hsin-Yi Wang <hsinyi@google.=
com> wrote:
> > > >
> > > > > > > > +#define _INIT_DCS_CMD(...) { \
> > > > > > > > +     .type =3D INIT_DCS_CMD, \
> > > > > > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > > > > > +     .data =3D (char[]){__VA_ARGS__} }
> > > > > > > > +
> > > > > > > > +#define _INIT_DELAY_CMD(...) { \
> > > > > > > > +     .type =3D DELAY_CMD,\
> > > > > > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > > > > > +     .data =3D (char[]){__VA_ARGS__} }
> > > > > > >
> > > > > > > This is the third panel driver using the same appoach. Can yo=
u use
> > > > > > > mipi_dsi_generic_write_seq() instead of the huge table? Or if=
 you prefer
> > > > > > > the table, we should extract this framework to a common helpe=
r.
> > > > > > > (my preference is shifted towards mipi_dsi_generic_write_seq(=
)).
> > > > > > >
> > > > > > The drawback of mipi_dsi_generic_write_seq() is that it can cau=
se the
> > > > > > kernel size grows a lot since every sequence will be expanded.
> > > > > >
> > > > > > Similar discussion in here:
> > > > > > https://lore.kernel.org/dri-devel/CAD=3DFV=3DWju3WS45=3DEpXMUg7=
FjYDh3-=3Dmvm_jS7TF1tsaAzbb4Uw@mail.gmail.com/
> > > > > >
> > > > > > This patch would increase the module size from 157K to 572K.
> > > > > > scripts/bloat-o-meter shows chg +235.95%.
> > > > > >
> > > > > > So maybe the common helper is better regarding the kernel modul=
e size?
> > > > >
> > > > > Yes, let's get a framework done in a useful way.
> > > > > I'd say, drop the _INIT_DELAY_CMD. msleep() and usleep_range() sh=
ould be
> > > > > used instead (and it's up to the developer to select correct dela=
y
> > > > > function).
> > > > >
> > > > > >
> > > > > > > > +
> > > > > > > > +static const struct panel_init_cmd kingdisplay_kd101ne3_in=
it_cmd[] =3D {
> > > > > > > > +     _INIT_DELAY_CMD(50),
> > > > > > > > +     _INIT_DCS_CMD(0xE0, 0x00),
> > > > >
> > > > > [skipped the body of the table]
> > > > >
> > > > > > > > +     _INIT_DCS_CMD(0x0E, 0x48),
> > > > > > > > +
> > > > > > > > +     _INIT_DCS_CMD(0xE0, 0x00),
> > > > >
> > > > > > > > +     _INIT_DCS_CMD(0X11),
> > > > >
> > > > > Also, at least this is mipi_dsi_dcs_exit_sleep_mode().
> > > > >
> > > > > > > > +     /* T6: 120ms */
> > > > > > > > +     _INIT_DELAY_CMD(120),
> > > > > > > > +     _INIT_DCS_CMD(0X29),
> > > > >
> > > > > And this is mipi_dsi_dcs_set_display_on().
> > > > >
> > > > > Having a single table enourages people to put known commands into=
 the
> > > > > table, the practice that must be frowned upon and forbidden.
> > > > >
> > > > > We have functions for some of the standard DCS commands. So, mayb=
e
> > > > > instead of adding a single-table based approach we can improve
> > > > > mipi_dsi_generic_write_seq() to reduce the bloat. E.g. by moving =
the
> > > > > error handling to a common part of enable() / prepare() function.
> > > > >
> > > >
> > > > For this panel, I think it can also refer to how
> > > > panel-kingdisplay-kd097d04.c does. Create the table for init cmd da=
ta,
> > > > not what operation to use, and use mipi_dsi_generic_write_seq() whe=
n
> > > > looping through the table.
> > >
> > > Even more similar discussion:
> > >
> > > https://lore.kernel.org/r/CAD=3DFV=3DUGDbNvAMjzWSOvxybGikQcvW9JsRtbxH=
Vg8_97YPEQCA@mail.gmail.com
> >
> > It seems I skipped that thread.
> >
> > I'd still suggest a code-based solution compared to table-based one, fo=
r
> > the reasons I've outlined before. Having a tables puts a pressure on th=
e
> > developer to put commands there for which we already have a
> > command-specific function.
>
> The problem is that with these panels that need big init sequences the
> code based solution is _a lot_ bigger. If it were a few bytes or a
> 1-2KB then fine, but when Hsin-Yi measured Linus W's attempt to move
> from a table to code it was 100K difference in code [1]. I would also
> say that having these long init sequences done as separate commands
> encourages people to skip checking the return values of each of the
> transfer functions and I don't love that idea.
>
> It would be ideal if these panels didn't need these long init
> sequences, but I don't have any inside knowledge here saying that they
> could be removed. So assume we can't get rid of the init sequences it
> feels like we have to find some way to make the tables work for at
> least the large chunks of init code and encourage people to make the
> tables readable...
>
For the init sequence of the panel from this patch, using the table
approach, we can still use mipi_dsi_generic_write_seq() and not invent
new macro or make the code complicated.

>
> [1] https://lore.kernel.org/r/CAD=3DFV=3DUFa_AoJQvUT3BTiRs19WCA2xLVeQOU=
=3D+nYu_HaE0_c6Q@mail.gmail.com

