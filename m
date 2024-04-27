Return-Path: <linux-kernel+bounces-160799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B88B42FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080B21C21FB8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18FDA945;
	Sat, 27 Apr 2024 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RoFKTmWG"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E9A932
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176103; cv=none; b=GEzny4izUWLkZMhPmx4tHFxbUG7We+muGGd4Lh6SS3YuTJGaDw3EeyRnODZLY0XsUfzlBUtjDDIbomCanAHnJPz5prKGLyHGGJp2g+1VMgYiqKxhRNfExwJXij7wNVfSIlM+XmWIAHVW5zH66nVb6+s/L/y7Pp32EFXljyAyKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176103; c=relaxed/simple;
	bh=SJmbE3eXeLvztipjrT54XQtMBojunhusAaRnAI/OrPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtBW/FP6lzEJTSI6a6e3YIvJQsloA1hgqaqqr/wux114bvir4MuzqU5KCljrB0qiXSxGS9Beaxv76DNwQlXtcs987494AcBp2GaanEiGvGqarBXp3AevYsDzhoh/PrXBQwIEAhKY01ACowTEyHRU5TJ65DpaYx24bA/SnHAfcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RoFKTmWG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-439656c1b3eso16436291cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714176099; x=1714780899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qkev+9t48kVKKfN+OMtp3Q7S6ESNoKoLQUe43MCWOA=;
        b=RoFKTmWGWDGhkgYPQDxiH+1tkXzhUZ3EekALw3HEl5hDtiEyprF78xBjn3x717Na94
         Ni3Dpt+k3u1u38UP8WL5dIWPv7MsIw5Sl1bzjmVvEGJm8x60XIgk4ayKTrmbVetI/EN4
         fbZldo15vKigBOIZBBG+BBJ5Y/IxIHpFNx9Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176099; x=1714780899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qkev+9t48kVKKfN+OMtp3Q7S6ESNoKoLQUe43MCWOA=;
        b=VEzMpwAqFUWvjRCq2HWEc9HlfggZTrVpWq3edqLvMW7MzAWo6R8+UlitXInKFBPbaD
         xGNYlvOzHWM9UKl3blXUxej1c+aRslLt/l+1wvKVvvJxnRuKhc+gWHw9jUducNwu/T+i
         PQ6cPgf8rD7GjgY2ZCTLaEkTKLOVN9cuQIo1HysBrOHt13tZMQo4sHOmFTtMGZl4yGlb
         dnJO61StyIz6T++PmDLYpLT9m8xR5EC0Yinks2+qmaXA2SzRF7R6kpqvi6rPuJien1SI
         x7ESUkOLy5J8+0pBkykG+c10RUBsPAvxY/9V0gaMlwgD/y5iimzPUdvKiUJpLP2CUeSX
         1dxA==
X-Forwarded-Encrypted: i=1; AJvYcCWzHtbEb8zQvzECyU7CKXnbb8VMMKeZL0C6RHxwYfkWA4rlStbfshOVFtk9ybafG+cd+4BLxel9PvVGwmwj7nT84hqAUW1WfCNcWbCW
X-Gm-Message-State: AOJu0Yx12/sKxwjPbBLIAaqc128HuoPj+oJp/Ni1mV7Vbzg2XIkz2Ts7
	ipsbQKUNtKBbAvOSfkQaYqI50h5oGHT9NNDY1b/VfOEGB37fJlj1eZIqrEkz5UF7MKVUWz6ljM0
	=
X-Google-Smtp-Source: AGHT+IFuqZM7JwZVXVTroojABSybE8+8RRyuNc05NKOl1wz0zH3pMH5U6g2bGetxDiEIgn42ymuycQ==
X-Received: by 2002:ac8:7f83:0:b0:43a:357b:4682 with SMTP id z3-20020ac87f83000000b0043a357b4682mr1392354qtj.55.1714176098738;
        Fri, 26 Apr 2024 17:01:38 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id kg25-20020a05622a761900b00436eacea78fsm8342035qtb.65.2024.04.26.17.01.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 17:01:37 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43989e6ca42so69341cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlpHLRNcIn5Cp87sblX6m4MrL4ij/Ul6kf0QRq7mI/aluXRS5vH0yRP6zBL8Ks3+nCVT5rPvuB0KPTpm8h/BpSejs+GF+3a9EOFT3f
X-Received: by 2002:ac8:5a92:0:b0:43a:5f02:bbe2 with SMTP id
 c18-20020ac85a92000000b0043a5f02bbe2mr116908qtc.24.1714176097206; Fri, 26 Apr
 2024 17:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
 <87pludq2g0.fsf@intel.com> <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
 <8734r85tcf.fsf@intel.com> <CAD=FV=XNbRauayNFNOODm-aaaLy2_vJk8OW-mR_XmLv505RtGA@mail.gmail.com>
In-Reply-To: <CAD=FV=XNbRauayNFNOODm-aaaLy2_vJk8OW-mR_XmLv505RtGA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Apr 2024 17:01:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4DAUGEapnre1C0HJ80ooHJU=7fy+JESbRtnJEiL3gCA@mail.gmail.com>
Message-ID: <CAD=FV=V4DAUGEapnre1C0HJ80ooHJU=7fy+JESbRtnJEiL3gCA@mail.gmail.com>
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

On Fri, Apr 26, 2024 at 8:28=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> > I don't find this unintuitive, but if it helps, you could conceivably
> > add a context parameter:
> >
> >         struct mipi_dsi_seq_context context =3D {
> >                 .dsi =3D dsi,
> >         };
> >
> >         mipi_dsi_dcs_write_seq(&context, HX83102_SETSPCCMD, 0xcd);
> >         ...
> >
> >         if (context.ret)
> >                 ...
> >
> > And even have further control in the context whether to log or keep
> > going or whatever.
>
> I agree there are some benefits of adding the extra "context"
> abstraction and we can go that way if you want, but I lean towards the
> simplicity of just passing in the accumulated return value like I did
> in my example.
>
>
> I'll try to write up patches and see if I can post them later today.

FWIW, I went with your "context" idea. In the end, I liked how it
looked and the icing on the cake was that it generated even smaller
code! :-)

My v2 series (now 8 patches long) is at:

https://lore.kernel.org/r/20240426235857.3870424-1-dianders@chromium.org


-Doug

