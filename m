Return-Path: <linux-kernel+bounces-157785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A667C8B162C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDDB2355A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3B16D4CA;
	Wed, 24 Apr 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tc0XUlQ9"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B88157463
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997696; cv=none; b=Cmwy3M/qiCfYGG/+Lr6qLSSqDyx8hKNNXWR9SDxiaEdCVnoJ85xD77QsnU4xokFIrlP+yKDwq/+bqoFz/m5UTC7Li/d1yzk6hKUD3kBJ/hUaM+1seFeHMf+9Ld8GDfEQxsZaNIAD70IpC0ujzzq0iNi4HHuUfICjkCqLVnYgmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997696; c=relaxed/simple;
	bh=HDw8GF0DFOUJjF67ppt5NlR35N3FU7s6J0Xu9TDmfZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svXigVerWwjtV4UJOS+YQ/oMDPXD7a7F3wX+5gtk+R93jkR7z8inVosvySJixDJQXfmfX47Xaoihqf2rOvbBrvV4QXhWfvgmLx1hc0maQFnbR6Ftast1F8NA2HN7nS9wOPpKopm8zmQIrHI5uvn9C1+Th3ZDyD1c7HalZZH+s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tc0XUlQ9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43989e6ca42so118151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713997694; x=1714602494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJLLyGyNYSIJ2mqOOEmdvcNKVMG9G7qW3Ws/lvIO5iY=;
        b=Tc0XUlQ9kupfzVTaPHAMOUINprCbPAt7tD5I0buGc2/yEDz+1sF33W6kFC+2D9o4kK
         TajjSiC1VdEiCd1/iv1yjaa1u+7Qg/eK7ck87O7yfjf5wqAoFbZiw6Y3QTp0mrRBylOn
         ghr+4VkFyC2oV7xrg5AU87IMXhrFZPr/YTOcuaX/82zEH68hvtvd2NkrADU8qw2vqqXy
         8/cM7h6YLaM9/5qbS4Xfp16itFGJ+OIxuDttFXRBTkUnt2c3RL/WHTuuMCEpNWnQvbhD
         KMSwBY0oPPi1mpWYTV4SLHXR+s6XnMLnISBqhhfxkp+mh8L2mTNNAQAxV+39cmix7Mey
         F9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997694; x=1714602494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJLLyGyNYSIJ2mqOOEmdvcNKVMG9G7qW3Ws/lvIO5iY=;
        b=YLuzO1wsPzNyoCbrnJAM3jjuB8Xl4hlSd0qiiHLiXD1RYGWwAXNh+fjxTH0nvW3HOe
         Pb2TnWL7OB+mnvALW8RJlfyCkugVVzfn3vAbTATMeBa/g3Vk3FgFGbbVt0QrQCZiMXOF
         GdBIQpvoGLAGYW8fwFsP/SqvlNXOEyurYGCkBC+cnupYp3oschm6evghMqz1Ysy5DpAd
         DUtZTwjj6RFNKaIWU/I5ynaxXOkmZESUaj3pxEePv2sWgpfKsY7MsGNGsootFmPrsGMe
         hEweNko9uVBM1VD8y79cCL0sIfI6x0HIK2h4aWNLlKIXq94OGHEuIi9ErlE3yM6q5Pz+
         MVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhc+DZ0AQb4IWdFyQERAghvXnnKhI6lt+IvFqHNCSeu3eYbZZLeLqgBvRpA3JICcJy9F9UTgTxhpjA6Bna1YcbCoQIQXa0d33DkvuI
X-Gm-Message-State: AOJu0YydX6j0XsntBOFwPLL9fGHJDiR+JX6vRAnQyfuD3C6kuETh1AvM
	Yxabuk23pLCYrPGlZUbsCqIcRKe62VXs6d3JHrHSOekO6tnWKukbWk8zoeQayb7hTTDfjs93Tpr
	zutDqMXOtlRB1UBBSayjRxbi4BiM30IYU1fli
X-Google-Smtp-Source: AGHT+IHd7tmiOysDGaUNRDpOFNHo8FgH+ESPpffL4dbRJeqnASsPciIA15vaqfOd1oBkupDoEvg5mHMF7XcWnyQe91o=
X-Received: by 2002:a05:622a:44c3:b0:439:aa2d:40b1 with SMTP id
 kc3-20020a05622a44c300b00439aa2d40b1mr36136qtb.27.1713997693565; Wed, 24 Apr
 2024 15:28:13 -0700 (PDT)
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
From: Doug Anderson <dianders@google.com>
Date: Wed, 24 Apr 2024 15:27:59 -0700
Message-ID: <CAD=FV=U-1A4N5aMeRpx1sC6TsG_hdOOpstzirVrA-=oPoLeg3A@mail.gmail.com>
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

On Wed, Apr 24, 2024 at 2:49=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
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

Ah, so what you're saying is that the big bloat from using the
existing mipi_dsi_dcs_write_seq() is the error printing. That makes
sense. ...and by relying on the caller to provide an error handling
label we can get rid of the overhead and still get the error prints.

Yes, that seems pretty reasonable to me. I guess I'd perhaps make the
error label a parameter to the macro (so it's obvious that the caller
needs to define it) and maybe name it in such a way to make it obvious
the difference between this macro and mipi_dsi_dcs_write_seq().

With that and your measurements then this seems perfectly reasonable
to me and I'm good with fully moving away from the table-based
approach. I'd be happy if you sent a patch for it and happy to review
it.

-Doug

