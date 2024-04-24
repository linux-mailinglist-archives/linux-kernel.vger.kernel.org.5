Return-Path: <linux-kernel+bounces-156151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FF08AFE95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE50F1C21801
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A183CAF;
	Wed, 24 Apr 2024 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iPcKR/Z"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DF14277
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926563; cv=none; b=m3swus1VfakYapU8vXKni6/tTSH0XfV+iciW4lZoWeAMiUQIL8AMTak1wooWuvkD3FwFvDNNz54ZYN2rW5bVPnYnJfMaDtb49I0HHty75SlAY9x8A8I9kY5ULS+0FkTFroX2lP1oaSYPGuGTA2PpyW5oOxsZLxoVqTazPfvdH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926563; c=relaxed/simple;
	bh=ogCbGplbhHNv9C8dGA1okdki3982UGo1ELD1MXKy4qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe8zFSVDQlVKVU7f/9ucBeHcTGscay3wLzza8EUPb+CzV614yCPbFQ0RpLDbKJPLXaYgpmlgaYNzgrphweWtahldoYkXWbFXqxI+QU1mziMdi4GPwsqLo0x/ukVNmgHIDVDrH2VRlKYrONqdjsZXUNzDo7NsFL2KO87dQZ0kUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iPcKR/Z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so6316393b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713926561; x=1714531361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkCqwJWiEAX3FMBfwqJeI3Xr8P946IFkiTczMxqGyo8=;
        b=0iPcKR/ZNr9BZwdZBZm3pz1FbLKBbvi2fq87YOrpgSvp7sv6uQaBtKwM1gd/3/HybG
         lbnZH6XOOHXGWo4Wdl51K7IXXXoUXXjQeV1KKMHHbgMimOI7Emwe5KKL3FOdmmF3kdMe
         UwkdtYP5oNJpuJ7BiYPR2n0JCd/bKnLXOYBviza5axg0F/i/9yWxSa4IzwVH1soG80NI
         VMAhVyds7V7nggZ0CFs1EMfsXmJfjO/NkxdumnAVrbGsoHtatnUNdYuyoma6K8JnW+RP
         tziQjssHZKK17rQzuWjsZ5JbgVbSGBe5/FuihjMethsMtwsj1ZBBq9akXmuxzwJQwTAN
         92JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926561; x=1714531361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkCqwJWiEAX3FMBfwqJeI3Xr8P946IFkiTczMxqGyo8=;
        b=OvowvBEdelKCC7PMfXiVMYT5xSFXHtoC+yaME7ScvBqqHh1nZPYrpZxyZ/ip3vJsOu
         KsHtKicbeWi0pJMpak4yleumxLP32q1hWsf5h0TWV7icUtI40aMT3mr6NsoG30ChWh5q
         2XqHaEMk/qvZdb8JpFwNKDqxML1gBhdwb1z0ebeU/+Jlt6Lh1pDc1nmx6wk54iCW9u9W
         vUkJZoezeJHbSGyv/+Nx+SqY+AwR1D4lmz9TnFA4qBO0niQGGH1/hl5oXpwYQeygcGB+
         NI2MYw3zAr7WvIn+BbZiyiO4ZfxUGCP8x1gBlEJmY1JmC1KEJ4+0DQHop/Uw8lZF1cym
         uyhg==
X-Forwarded-Encrypted: i=1; AJvYcCUB24UV5YkJS6AKz+Ax9q+TuGURS8L7Q7lFJZ4vKEzHyp6074yk5iN3WTM4Qe4hgg5XmMLEE02GVsdOZZ2VWCpmbqG1csFD9gRhetGj
X-Gm-Message-State: AOJu0YzhiVp+s54CGH0gKbinwM2nkD+HBmZu5XNMe+k0exiEOS60c3ZK
	mmUnU6doTLNI1yHUPwSZwBisJKc0EFMKf+F8gH5HYMp7uDvSDmBYto2HkdtPPnUZShWqsvRlK4o
	9o+ENgCtbVxH8q8P1BFAYCmY3buCufktvJElFvg==
X-Google-Smtp-Source: AGHT+IH74nDoNFa5iMmMPDu728jHFY35gEg93BIU8/H41pE+RucmGd0/FeAbAgJ2TnX1eL0r7OPIO7IFrAnwd6lXrv8=
X-Received: by 2002:a05:6a20:2590:b0:1a3:aed1:4d50 with SMTP id
 k16-20020a056a20259000b001a3aed14d50mr1311331pzd.31.1713926561232; Tue, 23
 Apr 2024 19:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=V2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKouB2mDB+NZug@mail.gmail.com>
 <CAHwB_NJsDsTc=gjP8TJ+6ipo10uMYFLmuf+tKGVgxnznhuAcUQ@mail.gmail.com> <CAD=FV=UGDbNvAMjzWSOvxybGikQcvW9JsRtbxHVg8_97YPEQCA@mail.gmail.com>
In-Reply-To: <CAD=FV=UGDbNvAMjzWSOvxybGikQcvW9JsRtbxHVg8_97YPEQCA@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Wed, 24 Apr 2024 10:42:29 +0800
Message-ID: <CAHwB_N+e4E8uZe3YpfNyemPyW-Rj1RLR5kKA3SDiBygOPYrmVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
 Thanks reply.

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=B8=89 00:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, Apr 23, 2024 at 2:37=E2=80=AFAM cong yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > > > +static int starry_init_cmd(struct hx83102 *ctx)
> > > > +{
> > > > +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> > > > +
> > > > +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x=
21, 0x55, 0x00);
> > > > +
> > > > +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2C, 0xB5, 0=
xB5, 0x31, 0xF1, 0x31, 0xD7, 0x2F,
> > > > +                                                 0x36, 0x36, 0x36,=
 0x36, 0x1A, 0x8B, 0x11, 0x65, 0x00, 0x88, 0xFA, 0xFF,
> > > > +                                                 0xFF, 0x8F, 0xFF,=
 0x08, 0x74, 0x33);
> > >
> > > I know this is a sticking point between Linus W. and me, but I'm
> > > really not a fan of all the hardcoded function calls since it bloats
> > > the code so much. I think we need to stick with something more table
> > > based at least for the majority of the commands. If I understand
> > > correctly, Linus was OK w/ something table based as long as it was in
> > > common code [1]. I think he also wanted the "delay" out of the table,
> > > but since those always seem to be at the beginning or the end it seem=
s
> > > like we could still have the majority of the code as table based. Do
> > > you want to make an attempt at that? If not I can try to find some
> > > time to write up a patch in the next week or so.
> >
> > Do you mean not add "delay" in the table?  However, the delay
> > required by each panel may be different. How should this be handled?
>
> In the case of the "himax-hx83102" driver, it looks as if all the
> delays are at the beginning or end of the init sequence. That means
> you could just make those extra parameters that are set per-panel and
> you're back to having a simple sequence without delays.

Do you mean add msleep  in hx83102_enable()?

@@ -612,12 +604,15 @@ static int hx83102_enable(struct drm_panel *panel)
        struct device *dev =3D &dsi->dev;
        int ret;

+       msleep(60);
        ret =3D ctx->desc->init_cmds(ctx);
        if (ret) {
                dev_err(dev, "Panel init cmds failed: %d\n", ret);
                return ret;
        }

+       msleep(60);
+
        ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);

>
> If you had panels that needed delays in a more complicated way, you
> could keep the per-panel functions but just make the bulk of the
> function calls apply a sequence. For instance:
>
> static int my_panel_init_cmd(...)
> {
>   ret =3D mipi_dsi_dcs_write_cmd_seq(dsi, my_panel_init_cmd_seq);
>   if (ret)
>     return ret;
>   mdelay(100);
>   ret =3D mipi_dsi_dcs_write(dsi, ...);
>   if (ret)
>     return ret;
>   mdelay(50);
>   ret =3D mipi_dsi_dcs_write_cmd_seq(dsi, ...);
>   if (ret)
>     return ret;
> }
>
> The vast majority of the work is still table driven so it doesn't
> bloat the code, but you don't have the "delay" in the command sequence
> since Linus didn't like it. I think something like the above would
> make Linus happy and I'd be OK w/ it as well. Ideally you should still
> make your command sequence as easy to understand as possible, kind of
> like how we did with _INIT_SWITCH_PAGE_CMD() in
> "panel-ilitek-ili9882t.c"
>
> As part of this, you'd have to add a patch to create
> mipi_dsi_dcs_write_cmd_seq(), but hopefully that shouldn't be too
> complicated?
>
>
> > It would be great if you could help provide a patch. Thank you so much.
>
> Sure, I can, though maybe you want to give it a shot with the above descr=
iption?

Sorry, I still don't seem to understand. How to encapsulate the parameters =
of
"HX83102_SETDISP, HX83102_SETCYC,....."? Different parameters for each pane=
l.
I have sent my V3 but it does not contain the patch you want.


>
> -Doug

