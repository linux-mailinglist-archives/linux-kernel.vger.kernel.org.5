Return-Path: <linux-kernel+bounces-27280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD482ED3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3794A1F24467
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B81A58E;
	Tue, 16 Jan 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2siVRl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA031A581;
	Tue, 16 Jan 2024 10:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CAFC433C7;
	Tue, 16 Jan 2024 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402722;
	bh=iAKRNPzzMkaTQkY4UUCIX+B/X35A2Lg6XCS5p0fAERQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S2siVRl+vctesGO1xykrsDMvemjtVazOi5ory9HO/1W6mJzOwS5lNhB8WsMs16lTH
	 pEPaOtOc0OKgbzSyVHmizIg4oyake2jBh6eovJUtkngOphDznn6DyrWVf5WTWy90HO
	 5KpsFPvEbg1rWum4UA11KCnoXjVjZNefFwsQMvQDPR6sRkHn/ik15BrJGBd/CP8Z1G
	 LD3m52XX9PZKGyzblYSXSsiA3cJG/AVEKDL+4sOsors0xc3WrAABTij4dg+BDNDrXY
	 YeT1lJAolmV6wiX/J2m1RP+hK5HwCGPpVEoY2dXbWg1oYd4jNq28qAXL7AHADwe4DQ
	 pdG3xhN9hPYfA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-206b77b9f4bso3669228fac.1;
        Tue, 16 Jan 2024 02:58:42 -0800 (PST)
X-Gm-Message-State: AOJu0YzvlwAyh9bfUY2EdVob6lu+kt+2HScp/s+PUMLefSemsweOu/Ca
	IXnmpXb7+LAspEBVe3U4hgdEG3eTYvtnJOhaodg=
X-Google-Smtp-Source: AGHT+IHTV26VyjPT49vnSPWQYOiPUOJ4EtfCM+b7PBtuh3G/W0jPqrCIXX71sWXVDwCFpx9Zkk0vQcJFpGk0C6EV2lA=
X-Received: by 2002:a05:6870:521:b0:206:be6d:8287 with SMTP id
 j33-20020a056870052100b00206be6d8287mr10990288oao.25.1705402721967; Tue, 16
 Jan 2024 02:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228054630.3595093-1-tfiga@chromium.org> <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
 <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com>
 <CAK7LNAQcaDneE4rnjvV+GTSBBMozm5deu_q9+STTn60ervZJbA@mail.gmail.com> <CAAFQd5DcxL80cb8w9OZs0mpD=Y3K=LmM7exG7U_DaSsMkfni7Q@mail.gmail.com>
In-Reply-To: <CAAFQd5DcxL80cb8w9OZs0mpD=Y3K=LmM7exG7U_DaSsMkfni7Q@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jan 2024 19:58:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyiYasGa2_Ppp54nEq2m08q_Z_keViZDCavmNN0rBAzQ@mail.gmail.com>
Message-ID: <CAK7LNASyiYasGa2_Ppp54nEq2m08q_Z_keViZDCavmNN0rBAzQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: menuconfig: Make hidden options show as dim
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 2:04=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> On Sat, Jan 13, 2024 at 8:23=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Wed, Jan 10, 2024 at 10:05=E2=80=AFPM Tomasz Figa <tfiga@chromium.or=
g> wrote:
> > >
> > > On Fri, Dec 29, 2023 at 1:10=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Thu, Dec 28, 2023 at 2:46=E2=80=AFPM Tomasz Figa <tfiga@chromium=
org> wrote:
> > > > >
> > > > > When hidden options are toggled on (using 'z'), the number of opt=
ions
> > > > > on the screen can be overwhelming and may make it hard to disting=
uish
> > > > > between available and hidden ones. Make them easier to distinguis=
h by
> > > > > displaying the hidden one as dim (using the A_DIM curses attribut=
e).
> > > > >
> > > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > >
> > > >
> > > >
> > > > Do you think this is useful?
> > > >
> > > > This changes the color only when you select a hidden item.
> > > >
> > > >
> > > > For unselected items, you cannot distinguish hidden ones,
> > > > as A_DIM has no effect to black text.
> > > >
> > > >
> > >
> > > Hmm, are you sure about that? For me it seems to dim the text. it
> > > seems to be also used in the existing code for dlg.button_inactive.at=
r
> > > of the mono theme:
> > >
> > > https://elixir.bootlin.com/linux/latest/source/scripts/kconfig/lxdial=
og/util.c#L26
> >
> >
> >
> > Then, your code works only on the mono theme.
> > (when your terminal does not support color, or
> > "MENUCONFIG_COLOR=3Dmono make menuconfig")
> >
>
> No, that's not what I meant. It works for me for all themes, see the
> screenshot at https://postimg.cc/sBsM0twT . The terminal is tmux
> inside hterm (which in turn is supposed to be compatible with xterm).
> I guess I can test a couple of different terminals.
>
> In which terminal is it not working for you?


I use gnome-terminal.
The disto is Ubuntu 23.10










--=20
Best Regards
Masahiro Yamada

