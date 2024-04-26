Return-Path: <linux-kernel+bounces-160286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D8B8B3B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1962843B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE29149C64;
	Fri, 26 Apr 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DM4OUv02"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10911DFFC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145331; cv=none; b=oSCxB9M56mx/QuhYN0mNLGWHliJIlBCwKu0tN/JqGdCB5vKZW/jrOAAZCnVNCNyKdwFdjUvpFly7zKWqZ8TPThgHh67oVPC1Hqntq3KyF51fUz1FV66EjCQo8s8p3hlE1tFJDqEM7rQU+MewsSR4btcOtZcCbj6+vxmU0snFd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145331; c=relaxed/simple;
	bh=z3wetYYdH8wk8Em0w+t39MUpCyxIrWZv9/n56pQWjAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/tfLWFnjxlrDuA6AkcAfQRqMs6uQ0BY6z+4rfkJASviED9t1GR2aEIxR89E31l20CZCZC7nFH6KGo5qCklVcVC6FbsisGFaHmFF0N2UL5F2Q/IIUQBIQjVXR9H8LD8qEzeICioeHmUPeU3u4tHPSkFbtmyWwoJN4PChZdjD/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DM4OUv02; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78ef9ce897bso144454485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714145327; x=1714750127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL2JVp5517IAZMpOsSFYe/avtgfEuaWIXQ+vHOFMkZg=;
        b=DM4OUv02f5NlrTrhb8EmBrbOEAJdFDev1vsmTJr01j3Rg1eRtD2ligx+FdLejLiB8V
         gsOvl7vaiqlW+Q29Z5hash7Zr1hDZimy3oR9dWUTml7arbYvQ/IAMF2Mq5QgQlghfWad
         csH1wSRx113nKTLV/Anek5gGeD+Lpp83Q2n+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145327; x=1714750127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VL2JVp5517IAZMpOsSFYe/avtgfEuaWIXQ+vHOFMkZg=;
        b=umLR9VGl/IloPEGQIL0N1z0ZzvYhWCz6CH/GDOY1SCAFyzwC9fUCQDIX7iSIlS8ELs
         S5xHBAGj5tU3Kp5AZgDm/K8A4abl+9ebYIv34Giig4/ZAvNFjO8TwLRBKbyisIeXqPLs
         ziFoOMbHBYLsXKlDw0vcyQLd0AQyp121MWrRVQZqChj36kW+ffOIQVEZkHxU7yGvs8LC
         WDIuQnLG84J03aOCPaEyusHucHEVNc2iBez5wc3B5q4/W2XsegrmzmVxVCSPERtUH/a9
         rIFEn8fOGQTMrET8qGxCWQgobSaN6twMvo3g3fTr1oLVKL0UZsz+eECisvVzYgbmAD9s
         ha0A==
X-Forwarded-Encrypted: i=1; AJvYcCXG5QVlM4pN/m39T2R4/6DKoPnQgnF0vCfueaJecm1hk6rMgNr4JCJGLQrFupbmOscbVf6jxKxXCL9AfFx2OGOFrFOo/ovgsN9PnoJm
X-Gm-Message-State: AOJu0Yy+vCvgzlF0jGBE8s/n+mp3AsbCjEnTgG8e+exeqh4NyAnuUih1
	IoPZG7zbZu9HqQQYFjrLZ149aFhEtH2RbBo8TUu7ZkAo+lzw8/fxWeUBD3fEF/SJPwGrVM4m5Wk
	=
X-Google-Smtp-Source: AGHT+IGjMAAiTTxwZT59QhDOHLYZcngYe6LVhnmMaJBeV1Wbp48UWzr/6rrOUyFGDBZvI9487foe8g==
X-Received: by 2002:a05:620a:11ae:b0:790:88d6:7982 with SMTP id c14-20020a05620a11ae00b0079088d67982mr2978918qkk.29.1714145327439;
        Fri, 26 Apr 2024 08:28:47 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id m6-20020ae9e006000000b0078efdcd9aa6sm8010659qkk.127.2024.04.26.08.28.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 08:28:46 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-439b1c72676so447831cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:28:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMUQho0g/THk0tWPEA8ZOsib9INcOoxoGBc/EToMeBnN8ThQrZgnlxgG0pL/qrRJJ0ZbYBVJpEpNAcTTM8LYWF8XZABkQEgKYkJd6I
X-Received: by 2002:ac8:72d8:0:b0:434:d055:5b00 with SMTP id
 o24-20020ac872d8000000b00434d0555b00mr280304qtp.20.1714145326083; Fri, 26 Apr
 2024 08:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
 <87pludq2g0.fsf@intel.com> <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
 <8734r85tcf.fsf@intel.com>
In-Reply-To: <8734r85tcf.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Apr 2024 08:28:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNbRauayNFNOODm-aaaLy2_vJk8OW-mR_XmLv505RtGA@mail.gmail.com>
Message-ID: <CAD=FV=XNbRauayNFNOODm-aaaLy2_vJk8OW-mR_XmLv505RtGA@mail.gmail.com>
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

On Fri, Apr 26, 2024 at 3:09=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> > 2. Accept that a slightly less efficient handling of the error case
> > and perhaps a less intuitive API, but avoid the goto.
> >
> > Essentially you could pass in "ret" and have the function be a no-op
> > if an error is already present. Something like this:
> >
> > void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_device *dsi,
> > const void *data, size_t len, int *accum_ret)
> > {
> >   if (*accum_ret)
> >     return;
> >
> >   *accum_ret =3D mipi_dsi_dcs_write_buffer(dsi, data, len);
>
> No reason you couldn't do error logging here
>
>         if (*accum_ret)
>                 dev_err(...)

Yup, exactly. This is probably best.


> > }
> >
> > ...and then the caller:
> >
> > int ret;
> >
> > ret =3D 0;
> > mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETSPCCMD, 0xcd, &ret);
> > mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETMIPI, 0x84, &ret);
> > mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETSPCCMD, 0x3f, &ret);
> > mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETVDC, 0x1b, 0x04, &ret);
> > if (ret)
> >   goto some_cmd_failed;
> >
> > This has similar properties to solution #1.
>
> I like this option the best, for the simple reason that the caller side
> is aware of what's going on, there's no magic control flow happening,
> and they can add error handling in the middle if they so choose.

Sounds good to me. I went back and forth a bit between solution #1 and
this and I see the benefits of both. If folks like this one I think we
should run with it. Certainly it's better than the current hidden
return.



> I don't find this unintuitive, but if it helps, you could conceivably
> add a context parameter:
>
>         struct mipi_dsi_seq_context context =3D {
>                 .dsi =3D dsi,
>         };
>
>         mipi_dsi_dcs_write_seq(&context, HX83102_SETSPCCMD, 0xcd);
>         ...
>
>         if (context.ret)
>                 ...
>
> And even have further control in the context whether to log or keep
> going or whatever.

I agree there are some benefits of adding the extra "context"
abstraction and we can go that way if you want, but I lean towards the
simplicity of just passing in the accumulated return value like I did
in my example.


I'll try to write up patches and see if I can post them later today.

-Doug

