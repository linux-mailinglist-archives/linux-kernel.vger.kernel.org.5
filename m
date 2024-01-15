Return-Path: <linux-kernel+bounces-25629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714F082D3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB831C20FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C063C5;
	Mon, 15 Jan 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YGuD+MFI"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF963AA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e760e5b49so7898615e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 21:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705295087; x=1705899887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYKhFg53vuL9N15IX+5EquLWs1jwGTmvz1VwrsyukZI=;
        b=YGuD+MFICnODSXC8t459+Wsjv1qZntrm9pctwDfV3hYHPaVHOUKEugY999RqkYZt2M
         npFi5gQ/uc7Dz/hNd3x1idMKaccT8o1x4VlSa/S8AQMxfYEGFF5c7lRmRiK4yuIxCxoe
         ICPzVNgf8Q/7C4AeYns/9w36DPxKiYIrXIps0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705295087; x=1705899887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYKhFg53vuL9N15IX+5EquLWs1jwGTmvz1VwrsyukZI=;
        b=n239nGQ20wfBSqTQfyb/wVkSsD9fZ6yduW2idIZ+tE7FDDb2UKpIUBX/fvHl1fwObT
         5l1XNIimcBaXT0sT5oEy2KKdT3Fh1xg2KMcENVEKi20kDdb+iPK0wMeYAMm/GS30SL4v
         Xn4nfzXqa7G+FHaNsPqCQNkTKnqrKg7eRW/FNxX8HwoXpjWl7zsPYZVWsTcuHWuwQo5l
         hGqDaPyNf8kcy3Yir5WIPcRhaUSJM9mqf0k7KtyG9ad1RgFVqnblMaduoQJW3I6vk9zM
         z94lHa60NjGJM+J0+toa+wc33FodyG0VM2lRB77CuXwWSYbkVSSy6FATUjYMh2pEMSQf
         8nfg==
X-Gm-Message-State: AOJu0YwiJ9WagbINs4ESYy9Hgl7pRZjEHKlx7ihmz/VIOo2QfUVe59Sl
	PbpDMqEgVSljfPde+PTmRvhr0bJ7LK1cjZ+EqwRxa8WrSQ==
X-Google-Smtp-Source: AGHT+IFAvX8s6xJhVVW8au0ypbHCysZnytiUfYG2RffIttIX8Nc0BuvuqnVOBptX0mtbUVDD0LFMSg==
X-Received: by 2002:a05:600c:3646:b0:40e:44af:8b26 with SMTP id y6-20020a05600c364600b0040e44af8b26mr1855976wmq.63.1705295087333;
        Sun, 14 Jan 2024 21:04:47 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7cfc7000000b00557075b4499sm5032448edy.58.2024.01.14.21.04.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 21:04:46 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3367a304091so7257748f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 21:04:46 -0800 (PST)
X-Received: by 2002:adf:e584:0:b0:337:a43e:c3d4 with SMTP id
 l4-20020adfe584000000b00337a43ec3d4mr658744wrm.170.1705295086160; Sun, 14 Jan
 2024 21:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228054630.3595093-1-tfiga@chromium.org> <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
 <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com> <CAK7LNAQcaDneE4rnjvV+GTSBBMozm5deu_q9+STTn60ervZJbA@mail.gmail.com>
In-Reply-To: <CAK7LNAQcaDneE4rnjvV+GTSBBMozm5deu_q9+STTn60ervZJbA@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 15 Jan 2024 14:04:26 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DcxL80cb8w9OZs0mpD=Y3K=LmM7exG7U_DaSsMkfni7Q@mail.gmail.com>
Message-ID: <CAAFQd5DcxL80cb8w9OZs0mpD=Y3K=LmM7exG7U_DaSsMkfni7Q@mail.gmail.com>
Subject: Re: [PATCH] kconfig: menuconfig: Make hidden options show as dim
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 8:23=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Jan 10, 2024 at 10:05=E2=80=AFPM Tomasz Figa <tfiga@chromium.org>=
 wrote:
> >
> > On Fri, Dec 29, 2023 at 1:10=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Thu, Dec 28, 2023 at 2:46=E2=80=AFPM Tomasz Figa <tfiga@chromium.o=
rg> wrote:
> > > >
> > > > When hidden options are toggled on (using 'z'), the number of optio=
ns
> > > > on the screen can be overwhelming and may make it hard to distingui=
sh
> > > > between available and hidden ones. Make them easier to distinguish =
by
> > > > displaying the hidden one as dim (using the A_DIM curses attribute)=
.
> > > >
> > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > >
> > >
> > >
> > > Do you think this is useful?
> > >
> > > This changes the color only when you select a hidden item.
> > >
> > >
> > > For unselected items, you cannot distinguish hidden ones,
> > > as A_DIM has no effect to black text.
> > >
> > >
> >
> > Hmm, are you sure about that? For me it seems to dim the text. it
> > seems to be also used in the existing code for dlg.button_inactive.atr
> > of the mono theme:
> >
> > https://elixir.bootlin.com/linux/latest/source/scripts/kconfig/lxdialog=
/util.c#L26
>
>
>
> Then, your code works only on the mono theme.
> (when your terminal does not support color, or
> "MENUCONFIG_COLOR=3Dmono make menuconfig")
>

No, that's not what I meant. It works for me for all themes, see the
screenshot at https://postimg.cc/sBsM0twT . The terminal is tmux
inside hterm (which in turn is supposed to be compatible with xterm).
I guess I can test a couple of different terminals.

In which terminal is it not working for you?

>
> In the normal color mode, the foreground text is black.
> (Just like a picture in https://en.wikipedia.org/wiki/Menuconfig)
> A_DIM does nothing for black.
>
>
>
> --
> Best Regards
> Masahiro Yamada

