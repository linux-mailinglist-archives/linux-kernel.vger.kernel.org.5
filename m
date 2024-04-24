Return-Path: <linux-kernel+bounces-157750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF48B1550
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B730285E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DB157463;
	Wed, 24 Apr 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8gbfxPs"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D915698F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995362; cv=none; b=SLNtZ1yUYfWmavA2byf8gdqoEGpuH9hB3+8Lf4e6oLO/VStt2nSWOOsKjaE5FAmdKEejVk/ndEaxsd1e5XuVXAG/KrXy7woF0i6brCuC4UFmnM4JC2qNDLSyYUtOJlEPRzN5+w3J9V0rM5XdSZnD7IQniDK7SthX3eoPQg2uCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995362; c=relaxed/simple;
	bh=oOGtmmc0wluy1zlbGPDGnsrebgCgwpm55s/a/4tsisk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=litcswHRomGR+d/qUNvVUgp/AN3p/jq3GfQE/z2gJkSaQs5d7/VUjCNFemNTgubGzBmZXupE4NMQ2LVND3KKHthQftfeqw8B6e5JM5SknEKUhFlTUOZsVSkiJlrFIvdQ8fwZtNInjOwLmVmrGBGKsnwQD7TjG14PNORT9LA6m7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V8gbfxPs; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso466530276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713995359; x=1714600159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz25l3F5HcKxLgpA7vc1PtsFYUkFX5bYRy1HzlOHmSw=;
        b=V8gbfxPslkH6GUg5DqyNsdG3K4riLOfG9mgtC4r7AmToEh3ilaGUnKnHGNo3fP20lJ
         h5g8iNyNaovUrZd9Q/LR7YDri9/wf9CnNtILWuitzVJGVkApBHE3y+jZLmEp42DCeznv
         9kwrL0WE4q0NxNK1dzoOHXoyhCmJJ9kpNDsqtvl0ail9/wK6aW4x47VHFDZZ6fSROh0f
         Qp30DyYPHKglcyXhD8uPEzRX62cacWy0cBlGXPEOPa7QuL3ranCcETpHZX0ME5QqJOZC
         1thx1hJnIIN/5lx99tNLA0GS6JC6ZMOgZ2u6S7w2TdJM1asaLoQCtgXS84Y9Wto+aGYj
         SSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713995359; x=1714600159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz25l3F5HcKxLgpA7vc1PtsFYUkFX5bYRy1HzlOHmSw=;
        b=bhs0PtOeew/o39DMXAOppb974718jX6xsHXUE0fylDMK4zxUFfEF4+xJy0pRDLyLum
         hom0Saq2p0csXXddi97ZmfB/Z/ksy5PMjRr1/TAAdrVeYeJqpkrpGw0kb9o2ig6hSZRg
         w6zuls6DGtsA1uDW5v8CMvaAPky54rwNVDOS8pClAqE/N1B5V5sjXnWfB6mu5z2pAJ/e
         aqiewBNjTptNWs19LBYbUb4KkiWj4oysR9hhSzKmumBWudWBtVAAp3ErACAiAQh5XkUo
         tVmP4LpyqDnSLu74Uu6XXZy5DRs1LPD2eK7EddJAKuK3wAGEzbmwZQOitey2EmyUkoKG
         qRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIUarQuzVKK0t6uXnni8vl0g1nPncaf378ySlZSgMmyUpmIx8XDfGoEMEV5R/yiSCXGAAI8jjKseztixqZpThMeH1BV6mvEknv34tR
X-Gm-Message-State: AOJu0YyfIDoak2qLNOROd3F2UViXqWxyx6VapLA4C6nDtrQOSw+dR+15
	e0ZkRZ+61Oj9DWcbGEdvEDrc1sZLHpYwQrei0RFEC5YrwjdpIazbEhUXF2keBEtsFSrDAHLxhTw
	cBC9uLdc7KnfWwb7IWPF+i0XRvKk/zjj0nI+XWCk3wnylwcYhX40=
X-Google-Smtp-Source: AGHT+IE11zcbo6fpNyRFrIw1yEm9BOp6i/pOaMdr/aR/e8wqmXQ7Qx/Ston/56y/x1b6yMmQ7+X5n7xQDvcR6E4wAoE=
X-Received: by 2002:a25:8104:0:b0:de5:852f:6afe with SMTP id
 o4-20020a258104000000b00de5852f6afemr1262062ybk.30.1713995359592; Wed, 24 Apr
 2024 14:49:19 -0700 (PDT)
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
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Apr 2024 00:49:08 +0300
Message-ID: <CAA8EJprv3qBd1hfdWHrfhY=S0w2O70dZnYb6TVsS6AGRPxsYdw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: kd101ne3: add new panel driver
To: Doug Anderson <dianders@google.com>
Cc: Hsin-Yi Wang <hsinyi@google.com>, 
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>, mripard@kernel.org, 
	airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	cong yang <yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Apr 2024 at 00:04, Doug Anderson <dianders@google.com> wrote:
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


I did a quick check on the boe-tv101wum-nl6 driver by converting the
writes to use the following macro:

#define mipi_dsi_dcs_write_cmd_seq(dsi, cmd, seq...)
             \
        do {                                                               =
    \
                static const u8 d[] =3D { cmd, seq };                      =
  \
                ret =3D mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));  =
  \
                if (ret < 0)                                               =
    \
                        goto err;                                          =
    \
        } while (0)

And then at the end of the init funciton having

err:
        dev_err(panel->dev,
                "failed to write command %d\n", ret);
        return ret;
}

Size comparison:
   text    data     bss     dec     hex filename
before
  34109   10410      18   44537    adf9
./build-64/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.o
making init data const
  44359     184       0   44543    adff
./build-64/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.o
with new macros
  44353     184       0   44537    adf9
./build-64/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.o

As you can see, there is literally no size difference with this macro in pl=
ace.
The only drawback is that the init stops on the first write rather
than going through the sequence.

WDYT? I can turn this into a proper patch if you think this makes sense.

>
>
> [1] https://lore.kernel.org/r/CAD=3DFV=3DUFa_AoJQvUT3BTiRs19WCA2xLVeQOU=
=3D+nYu_HaE0_c6Q@mail.gmail.com



--=20
With best wishes
Dmitry

