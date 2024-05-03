Return-Path: <linux-kernel+bounces-167911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560F8BB0F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B952128644B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA874AEFE;
	Fri,  3 May 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ST5tr9oZ"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C37C134B1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753990; cv=none; b=AR4QvonXrugQTXhjBvHL/XjqY7xEpOwXLIq6241V+KXrxQx90iP2JldX3HTQBmTjb4/XJ5nzYtr8nKjZ8ANC9+RhwGT1J6xbpniB41xjpO3SuYiqpSvrxkV3maimzNkrpy/90/DqWrmKgiss9gpw5MgQPTCPzhcws9x38wGK4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753990; c=relaxed/simple;
	bh=Wb/E/ZBmghIgft2E8B2VLHz6uP/QIkfTrbqbKxU75Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXfOMeMmQg/7J+qHhVyEprzg55IOWdUlgSOAa5XLp2LkGWr6Wrc3VIgCnrkF/GrICwmyb6DNaij23mbS33Gx30wnNlH1ka4HwiY9epCXeJrTvsEOf1J3t61GYwh0fgAA680+ZF0B9C0UAMAaB/Tgnz2Fi+Rxlz1rwHducSNCG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ST5tr9oZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4376e3fd7e4so52106951cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714753987; x=1715358787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjSWzAvI8127nFCBAhRj+G6Ozr2Q97LS17/PxW+N9NU=;
        b=ST5tr9oZmUlezeA9AXz5plzmzXQozHrVZvwrFrhrH+WcXBrpsX/aFMa2tS8yRSAofs
         WoJ9FafvBw6yY2/bvfTibfHfO5afvsGv8UzCqT8fzK54BlqTAdVA+UBGw5uc9+DxpyOe
         zsMz3teQYXBiiMpgBm+ZTho8wGrEmyp0QiHRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753987; x=1715358787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjSWzAvI8127nFCBAhRj+G6Ozr2Q97LS17/PxW+N9NU=;
        b=fgKJY3UZhXrNGEPZeR6ZFjMkX1uZ3dQILiV48OZAA9bzvO/uF+9Rn6FBAFW9ouaXm5
         XyVwZx/txaxBemXpQM2W4p626ofIIamc49srakLVV7jWdqMOHw4SB3bcVqRFlim0Slld
         8XJQuABpXKLICyOZ5npIe40qzMteS55/mdhrLSEB+GBNcYpAMqC06KZVAzWv+Z7L+lMd
         YgkgR00RydbYpFw2Z2kIO+KcPMy4g2+6+qAfW6VSJH/hLqwNbP9ReX5FUzKdTV0Xoqdi
         0XDNJMwhRJcVEkedNGKw8BlAKQbu8MlKlUXu2Ga434bFMGYy3doZK57oQdm0O955hjU1
         lEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3LBjAclZgWRbi3ksVVQjY2UuUHy4fWoJIbgq14ChuCMJj8YWBtGKoY/NiGoAZp+peneolBO0398c+tpQWq2DUpZnrcFwjAQMhVTBv
X-Gm-Message-State: AOJu0YwpaxgcqsctA+7y8i52QLS5Wwc5zuDluE0tSggwqH5U8q+JIWUM
	vUH3H5ylbkgSvBDK4z4/ZGLlhz/8X5mjoCti7kQTf+E23VmPx5K5c9e1JEo63v4V69+X/NnwPBK
	/Gw==
X-Google-Smtp-Source: AGHT+IEaM0qW8keyK9VInx0gz9SE9XeC7LpbOFIo91u9cJGQa+SbZp1/rf+wtUPLk7JZGyrfRT4adw==
X-Received: by 2002:ac8:5dca:0:b0:43a:be0b:4761 with SMTP id e10-20020ac85dca000000b0043abe0b4761mr3496215qtx.1.1714753986952;
        Fri, 03 May 2024 09:33:06 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id fv14-20020a05622a4a0e00b0043936ed09bfsm1732978qtb.27.2024.05.03.09.33.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 09:33:05 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-436ed871225so420671cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:33:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz/0mYmEpjekQC2wSqD6bgE3sfhY/4hKn+cFOUlifN1KQozxymh6NfRmKpTZZlCbFjPfTPPxZpzb/UIVlQVntIiAmXY0r/fo/nZv/X
X-Received: by 2002:ac8:580b:0:b0:43a:2e2b:eec with SMTP id
 d75a77b69052e-43cd6f1d31amr3382801cf.2.1714753984705; Fri, 03 May 2024
 09:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.9.I947e28c81f9ef7dcd3add6e193be72d6f8ea086f@changeid>
In-Reply-To: <20240501084109.v3.9.I947e28c81f9ef7dcd3add6e193be72d6f8ea086f@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 3 May 2024 09:32:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U51FTOV2nnTbqkqUuaHFqib7-ua03O9tZN21EoX2dMsg@mail.gmail.com>
Message-ID: <CAD=FV=U51FTOV2nnTbqkqUuaHFqib7-ua03O9tZN21EoX2dMsg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] drm/panel: innolux-p079zca: Don't use a table for
 initting panels
To: dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Joel Selvaraj <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 1, 2024 at 8:43=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> @@ -132,33 +125,9 @@ static int innolux_panel_prepare(struct drm_panel *p=
anel)
>         /* p079zca: t4, p097pfg: t5 */
>         usleep_range(20000, 21000);
>
> -       if (innolux->desc->init_cmds) {
> -               const struct panel_init_cmd *cmds =3D
> -                                       innolux->desc->init_cmds;
> -               unsigned int i;
> -
> -               for (i =3D 0; cmds[i].len !=3D 0; i++) {
> -                       const struct panel_init_cmd *cmd =3D &cmds[i];
> -
> -                       err =3D mipi_dsi_generic_write(innolux->link, cmd=
->data,
> -                                                    cmd->len);
> -                       if (err < 0) {
> -                               dev_err(panel->dev, "failed to write comm=
and %u\n", i);
> -                               goto poweroff;
> -                       }
> -
> -                       /*
> -                        * Included by random guessing, because without t=
his
> -                        * (or at least, some delay), the panel sometimes
> -                        * didn't appear to pick up the command sequence.
> -                        */
> -                       err =3D mipi_dsi_dcs_nop(innolux->link);
> -                       if (err < 0) {
> -                               dev_err(panel->dev, "failed to send DCS n=
op: %d\n", err);
> -                               goto poweroff;
> -                       }
> -               }
> -       }
> +       err =3D innolux->desc->init(innolux);
> +       if (err < 0)
> +               goto poweroff;

FWIW, I happened to notice a bug in the above by code inspection. The
old code checked "if (innolux->desc->init_cmds)" and thus handled
init_cmds being NULL. The new code doesn't handle the init function
being NULL. One of the two panels in this file (which seems to have no
users in mainline) doesn't specify an init sequence.

I'll spin this next week with the extra "if" test.

-Doug

