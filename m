Return-Path: <linux-kernel+bounces-32318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26601835A00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9DD1C21894
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DB6139;
	Mon, 22 Jan 2024 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PLWbGf8D"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DA610C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896829; cv=none; b=Nsp8frD0+kIHcfrd6zOJ+Dlj6lacYopcfTQywMfYbU9G+dINdvsCpTwMhStqxcMkVXO3c/3DWwLfZUX90v+IYk04PzIGgBHZz6jwaQwyCe5qqGggk4+X5aHs/4m/os+9/KeM15Bl+d8T4gcl/n2Q0j3aiCG22L/Ze8DCF13Ibls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896829; c=relaxed/simple;
	bh=sFyv+jUWRXd/cynW/u9ytP1g1fYNXA9LJzShvHGdwP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2AcTHdZsk19UzLMb+8SJxEWFUQV+knffXpmdQwkU/dFZr7XM2uZ6xgkjKJmS9a6X7wPGXlviJtYa93D00AkDhBuukwlknV3YUqycQCteRRVRdFbIQNFls5chvLmFolO5+F7nbWVPsOTfYztYF9Auc8YkNGTe7i50j8eDgZPwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PLWbGf8D; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2e0be86878so688055166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705896826; x=1706501626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFyv+jUWRXd/cynW/u9ytP1g1fYNXA9LJzShvHGdwP4=;
        b=PLWbGf8DqqZRS4ebVQlJSYwWox8ZDlQyT7ITPMLl02ogjtg5nsiuz/Pu72c3d/CZTc
         m7LBh2ecbB+5deg4Tuax94+Az1YuTm3jWxNmAZbzkCSc7WX6jQWjfyUbofq0BBmH+QQH
         1ZknQhY5ls23SnTr4NG8HH5lZeV3rPL5BdxRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896826; x=1706501626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFyv+jUWRXd/cynW/u9ytP1g1fYNXA9LJzShvHGdwP4=;
        b=vrip6WnwLcGRGygT2zB9i3Tp5Wj2yS7MEZ2StgMMZe6jsCJ1FAy2/bgDFNgy6XsDvb
         h62gZqfBzXMbsuiqzdEo24CEAx9QlIEh2+GTGto5KTUn5ZLb3qUaHYkmznGE8MZji65c
         ilXvGoYIyd9oaKx1CqLwkS7htsRl7HsxRlgc/aVuSdPyGWjyRTxRGvRsB8F0xoehk+Vx
         Vn+oDyA2B22u4Cuvfd7MbDRjLZ/tpIVyWJ2DvRR6vpn8W6SxHhDQEAcxuyoNhXKEpTL+
         aeh1HUpyPlXYzLk2QqnT8PAYvoBhjJALWejC11+hflQF1u2MoFO/Kye47MFgyAL1caHJ
         Ex5A==
X-Gm-Message-State: AOJu0YwmbfS5mr9/fFSvsU4ToOMPN/nBzLVcV5uahhbZG6+/o+9OvojA
	3BAKlInd7u/Iib9AXvuicEDpZjXZMiYbXk52TQnsGuM5HiscrMTyyuIL6B20O+LYzu/ctskcraU
	=
X-Google-Smtp-Source: AGHT+IH8xW89+ydmroaFKMhuiR1Th5l7g/UM5ogg1jugn8TR5MK+xNOMEZ7ym7Isvvc0+aNgcC/WBA==
X-Received: by 2002:a17:906:d99:b0:a2e:9f2c:980c with SMTP id m25-20020a1709060d9900b00a2e9f2c980cmr3377775eji.72.1705896825793;
        Sun, 21 Jan 2024 20:13:45 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id d3-20020a170906544300b00a2693ce340csm12869214ejp.59.2024.01.21.20.13.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 20:13:45 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3392b15ca41so686896f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:13:44 -0800 (PST)
X-Received: by 2002:adf:f641:0:b0:337:b36d:72a4 with SMTP id
 x1-20020adff641000000b00337b36d72a4mr1723451wrp.36.1705896824443; Sun, 21 Jan
 2024 20:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228054630.3595093-1-tfiga@chromium.org> <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
 <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com>
 <CAK7LNAQcaDneE4rnjvV+GTSBBMozm5deu_q9+STTn60ervZJbA@mail.gmail.com>
 <CAAFQd5DcxL80cb8w9OZs0mpD=Y3K=LmM7exG7U_DaSsMkfni7Q@mail.gmail.com>
 <CAK7LNASyiYasGa2_Ppp54nEq2m08q_Z_keViZDCavmNN0rBAzQ@mail.gmail.com> <ZaZv_TNR5_1zOCji@reykjavik.ads.avm.de>
In-Reply-To: <ZaZv_TNR5_1zOCji@reykjavik.ads.avm.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 22 Jan 2024 13:13:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BUBnCcg5nBfL-McdkR3dVEjqxFgz+amkhURxBpdRGaSA@mail.gmail.com>
Message-ID: <CAAFQd5BUBnCcg5nBfL-McdkR3dVEjqxFgz+amkhURxBpdRGaSA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: menuconfig: Make hidden options show as dim
To: Nicolas Schier <n.schier@avm.de>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 9:01=E2=80=AFPM Nicolas Schier <n.schier@avm.de> wr=
ote:
>
> On Tue, Jan 16, 2024 at 07:58:05PM +0900, Masahiro Yamada wrote:
> > On Mon, Jan 15, 2024 at 2:04=E2=80=AFPM Tomasz Figa <tfiga@chromium.org=
> wrote:
> > >
> > > On Sat, Jan 13, 2024 at 8:23=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Wed, Jan 10, 2024 at 10:05=E2=80=AFPM Tomasz Figa <tfiga@chromiu=
m.org> wrote:
> > > > >
> > > > > On Fri, Dec 29, 2023 at 1:10=E2=80=AFAM Masahiro Yamada <masahiro=
y@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 2:46=E2=80=AFPM Tomasz Figa <tfiga@chro=
mium.org> wrote:
> > > > > > >
> > > > > > > When hidden options are toggled on (using 'z'), the number of=
 options
> > > > > > > on the screen can be overwhelming and may make it hard to dis=
tinguish
> > > > > > > between available and hidden ones. Make them easier to distin=
guish by
> > > > > > > displaying the hidden one as dim (using the A_DIM curses attr=
ibute).
> > > > > > >
> > > > > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > > > >
> > > > > >
> > > > > >
> > > > > > Do you think this is useful?
> > > > > >
> > > > > > This changes the color only when you select a hidden item.
> > > > > >
> > > > > >
> > > > > > For unselected items, you cannot distinguish hidden ones,
> > > > > > as A_DIM has no effect to black text.
> > > > > >
> > > > > >
> > > > >
> > > > > Hmm, are you sure about that? For me it seems to dim the text. it
> > > > > seems to be also used in the existing code for dlg.button_inactiv=
e.atr
> > > > > of the mono theme:
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/scripts/kconfig/lx=
dialog/util.c#L26
> > > >
> > > >
> > > >
> > > > Then, your code works only on the mono theme.
> > > > (when your terminal does not support color, or
> > > > "MENUCONFIG_COLOR=3Dmono make menuconfig")
> > > >
> > >
> > > No, that's not what I meant. It works for me for all themes, see the
> > > screenshot at https://postimg.cc/sBsM0twT . The terminal is tmux
> > > inside hterm (which in turn is supposed to be compatible with xterm).
> > > I guess I can test a couple of different terminals.
> > >
> > > In which terminal is it not working for you?
> >
> >
> > I use gnome-terminal.
> > The disto is Ubuntu 23.10
>
> I see the same behaviour as Masahiro described with foot 1.13.1 on
> Debian 12.

Thanks for testing! I'll use the two for my testing as well and try to
figure out something more portable.

Best regards,
Tomasz

