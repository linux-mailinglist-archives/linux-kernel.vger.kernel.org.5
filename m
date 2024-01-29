Return-Path: <linux-kernel+bounces-43249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A111841169
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96784B24AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B26F06A;
	Mon, 29 Jan 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixPgB9fc"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825E3F9CF;
	Mon, 29 Jan 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550950; cv=none; b=Rlhr1oh52daYhA1wnD4KNOU7wNA08o5qyeRMaZQIRb86PGO6ibDJ4ekvEudH7ntHCs4bPwRkQauo6aZcLXjyT8gpl54bmprlu2LUsqrHU7QgPtb2wvHtsSLzl15icgPOQBH6h82r/mOfjYslpac6YXNXq5hB3mLxHfaWjgQO9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550950; c=relaxed/simple;
	bh=1me/PpJG5CGqj5DivSvX0k94LZp+ARr96HPPYbddOSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jO8WkyXfJCKa7F6bfTaXZlduYrudQJCCetzye010ZEqVSabxCjNIwHTDOwY1Vfy6qmF2Ro3QkvINzyrHaZs/SHCPZPyIvPksTm+2Gz9irYI1SyRzBaVH34iJABi49NEudsRTdRRMs55G2vS0JmqqC6IV1Ywh4bO9VB+iIPkqytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixPgB9fc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1124474a12.1;
        Mon, 29 Jan 2024 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550948; x=1707155748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZfrbhUJ1LpgFEfBncnmJlgOnc4pnvtYZeFhHY3AOew=;
        b=ixPgB9fcIi7F6hmcqucafotJtFOZL2fwr3OOjaPPO+SnD2fdeQAo+aUgIIhQVdhF+/
         HsdZCARCin3NU7oJPt0viHbX1lp+ztmGwVzmPaT6vVU0/EQBCzWNGPbamNszh4aesCKo
         od1zG6q6+2DQOExE3eDJ4E7j0ULuq865MxX/5MI9nXVDnu3sZ37zgQz+U9beAJFprhof
         GkDEvqW+Aij35KVTEiSl/gj38cURc9Qq3oOhLaRLfAYjqeFfaZyG0oqtNAwzRvBwS0s8
         xA2tmWPR7IofSsgiDCpcQCtmE0VG/ByoBr4c11felESgytaW7inPjATRc9hjATfYFGUA
         fbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550948; x=1707155748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZfrbhUJ1LpgFEfBncnmJlgOnc4pnvtYZeFhHY3AOew=;
        b=BHO7X9JAkBC7B/NX9mzHOO8RN+EGX5McA2RrXkuwRsUq2ViY0RZ4NPiCYXh94VfPoO
         +UagW6UcsuYgbgMIQY6oa0u2YJXjSv2VwY0EtwzIAqE81aUwlx3s1lmLWfRnXhVI/yhU
         X0ZA/JU6/wMEUUyKaBzkmGFSevBJwPz5Si0woYJGJkgY1xwJe/2WDnB81Ksg/vw42Uly
         quz8FNpQvwc/kPMAqGaKwb8A08mkdujnGksS38TvL7/4fK+A24/l3Ss+2Ht4MDt29sg0
         zKDqpZhCsG+uXZ29elt6/q9etmqJhgxnGuw3UTj0M9QK5j5gejBx9koX5POegwmPla9/
         2meQ==
X-Gm-Message-State: AOJu0Yxy+P+/Rbio1GBTs9X85UFqaJ4mFV+EqYdCsCLOQyK7Fjk3BLG2
	Dkm/hx4mLni5LLKjR9jUxueT6WOocIXXMMRE/UnbqCA7uOtwGzG0veGknCQteItprFx1qWyBp8E
	gAbZN+rB3g/ZT2SRrLCHmVFg/1N8=
X-Google-Smtp-Source: AGHT+IE0SKR3AHIHfCaFsxSHDL6dSBYf9JDSvhd6mfFNNMLbBxSeZG/64JTWhUMcuMius4a9CZXXBRQ499uoFNuoTqU=
X-Received: by 2002:a05:6a20:bc89:b0:19b:56f0:c880 with SMTP id
 fx9-20020a056a20bc8900b0019b56f0c880mr2347996pzb.39.1706550948383; Mon, 29
 Jan 2024 09:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106223951.387067-1-aford173@gmail.com> <20240106223951.387067-2-aford173@gmail.com>
 <CAHCN7x+=etco+xEELdf5AyR07sR6c9tTFtsA3K5Dy99qhAZQMg@mail.gmail.com> <DB9PR04MB9452DB580ACF844505F7AA2CF47E2@DB9PR04MB9452.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9452DB580ACF844505F7AA2CF47E2@DB9PR04MB9452.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 29 Jan 2024 11:55:37 -0600
Message-ID: <CAHCN7xLwSyGsyo5XigJroB8RftJNXeRDb8o+a-VRSFGSs5NW8A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add
 fdcc clock to hdmimix domain
To: Sandor Yu <sandor.yu@nxp.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	dl-linux-imx <linux-imx@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Lucas Stach <l.stach@pengutronix.de>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 7:39=E2=80=AFPM Sandor Yu <sandor.yu@nxp.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: 2024=E5=B9=B41=E6=9C=8828=E6=97=A5 2:20
> > To: linux-pm@vger.kernel.org
> > Cc: Sandor Yu <sandor.yu@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>=
;
> > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > dl-linux-imx <linux-imx@nxp.com>; Ulf Hansson <ulf.hansson@linaro.org>;
> > Lucas Stach <l.stach@pengutronix.de>; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Mar=
ek
> > Vasut <marex@denx.de>; Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > Subject: [EXT] Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: A=
dd
> > fdcc clock to hdmimix domain
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t
> > this email' button
> >
> >
> > On Sat, Jan 6, 2024 at 4:40=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > According to i.MX8MP RM and HDMI ADD, the fdcc clock is part of hdmi
> > > rx verification IP that should not enable for HDMI TX.
> > > But actually if the clock is disabled before HDMI/LCDIF probe, LCDIF
> > > will not get pixel clock from HDMI PHY and print the error
> > > logs:
> > >
> > > [CRTC:39:crtc-2] vblank wait timed out
> > > WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:1634
> > > drm_atomic_helper_wait_for_vblanks.part.0+0x23c/0x260
> > >
> > > Add fdcc clock to LCDIF and HDMI TX power domains to fix the issue.
> >
> > Peng (or anyone from NXP),
> >
> > I borrowed this patch from the NXP down-stream kernel for two reasons:
> >  It's in NXP's branch to address an error & move the fdcc clock out of =
the
> > HDMI-tx driver due to questions/feedback that Lucas got on that driver.
> >
> > The FDCC clock isn't well documented, and it seems like it's necessary =
for the
> > HDMI-TX, but I'd like to make sure this is the proper solution, and I h=
aven't
> > received any additional feedback.
> > Can someone from NXP confirm that really is the proper solution?
> >
> > thank you,
> >
> > adam
>
> Hi Adam,
>

Sandor,

> In NXP internal document, the clock HDMI_FDCC_TST_CLK_ROOT was for intern=
al use only for future NXP development IP.
> It should not be exposed to customer in document but unfortunately it hav=
e to be enabled for HDMITX.
>
> I submitted a request ticket to the design team several months ago,
> Generally, tickets of this didn't get the priority in design team and I h=
aven=E2=80=99t received any valuable feedback.
> Once design team confirmed, I think the document will update to add the f=
dcc clock.

Thank you for your response.   Do you have any objections to having
the FDCC clock added to the power domain driver?  I know there are
several of us who would really like to see the HDMI-TX driver applied,
and I think this patch gets us one step closer.

thanks,

adam
>
> B.R
> Sandor
>
> >
> > >
> > > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > The original work was from Sandor on the NXP Down-stream kernel
> > >
> > > diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> > > b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> > > index e3203eb6a022..a56f7f92d091 100644
> > > --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> > > +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> > > @@ -55,7 +55,7 @@ struct imx8mp_blk_ctrl_domain_data {
> > >         const char *gpc_name;
> > >  };
> > >
> > > -#define DOMAIN_MAX_CLKS 2
> > > +#define DOMAIN_MAX_CLKS 3
> > >  #define DOMAIN_MAX_PATHS 3
> > >
> > >  struct imx8mp_blk_ctrl_domain {
> > > @@ -457,8 +457,8 @@ static const struct imx8mp_blk_ctrl_domain_data
> > imx8mp_hdmi_domain_data[] =3D {
> > >         },
> > >         [IMX8MP_HDMIBLK_PD_LCDIF] =3D {
> > >                 .name =3D "hdmiblk-lcdif",
> > > -               .clk_names =3D (const char *[]){ "axi", "apb" },
> > > -               .num_clks =3D 2,
> > > +               .clk_names =3D (const char *[]){ "axi", "apb", "fdcc"=
 },
> > > +               .num_clks =3D 3,
> > >                 .gpc_name =3D "lcdif",
> > >                 .path_names =3D (const char *[]){"lcdif-hdmi"},
> > >                 .num_paths =3D 1,
> > > @@ -483,8 +483,8 @@ static const struct imx8mp_blk_ctrl_domain_data
> > imx8mp_hdmi_domain_data[] =3D {
> > >         },
> > >         [IMX8MP_HDMIBLK_PD_HDMI_TX] =3D {
> > >                 .name =3D "hdmiblk-hdmi-tx",
> > > -               .clk_names =3D (const char *[]){ "apb", "ref_266m" },
> > > -               .num_clks =3D 2,
> > > +               .clk_names =3D (const char *[]){ "apb", "ref_266m",
> > "fdcc" },
> > > +               .num_clks =3D 3,
> > >                 .gpc_name =3D "hdmi-tx",
> > >         },
> > >         [IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] =3D {
> > > --
> > > 2.43.0
> > >

