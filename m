Return-Path: <linux-kernel+bounces-33168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C7D83658B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E69F28157E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B93D54C;
	Mon, 22 Jan 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml/CNM8Z"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455F3D544;
	Mon, 22 Jan 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934105; cv=none; b=tEA4QVlE7oEghfMT62vBdme+3wAchylzGIuLzrvFrwypA8W5ZRWfYSmjT+yAEpvOCl2qjQN/FJuGw1cf+4oX9Id3v0uV7YlRGK0UvgPkw/6tQ62m9t0bNc4hYDcF5deOBj1bHhUaW65e1CxkgNks7TsRi6ihakpwR4Yp1PtCo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934105; c=relaxed/simple;
	bh=Og27EideGjz/YmHYDhgkpc8f4ToRAK905gCq976BynM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyLD3nV/Hz8v1sPaWIPwswOixJsJeBrN6G/5vqffGS7YIJYnCG1vdtEGW8MVVgz2yMY8WsJGbenZZDEReSd4AXvjDaMMOqQDAo3COXmhsMZFJZXCgHJatcuBFYrO/3IFuXR4RFkbl8dfzC0rxP2txvGA58L67+BM4D7y5USePtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml/CNM8Z; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1892946276.1;
        Mon, 22 Jan 2024 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705934103; x=1706538903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og27EideGjz/YmHYDhgkpc8f4ToRAK905gCq976BynM=;
        b=Ml/CNM8ZE7rLoRqUJHGVrQcv1bQmof6YzHypIJhmERAPojJvfuE8bB26d53dkOyRBI
         XinfoLTdmR4k/1Re+p3lNZbaFPTQV3Y4pa6R69/dJMaX8YiOk2WwHbTVNbpxzWyplW1H
         Avi3lpLoVzPLdd4V+tRVimIzZzV3IqLYPLqmQC+fRhlGoJxDh5mW1yGCxIIbhgJbVaRm
         UyjKa/gfQQpbFEP/qjaVgdK6Ia733EqeZjLRHeWupvf6vJB0lEIUi0ZXO2Izo2GIB9SR
         waTslOVyjdvJlT+8Dwv0XkyqMRFHK1hXZYzWWAghzTnluQ90NkffgVCZ+hELm6hlXiWX
         WVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705934103; x=1706538903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og27EideGjz/YmHYDhgkpc8f4ToRAK905gCq976BynM=;
        b=eXCvxpAFNFY5sfe86geUCDRe1yxC+qlN84mmq4c76BtD/ZlpNtTZhcPBENvbpW+pTG
         8l8An91qkoT+8Q27vE2fQpD7aBCzFUsiAJK3TtC5X4+YCngkTexOsY2RFnH7Ayv/RKoX
         7zdKZEEmmSjXYLcjvIgaaMflUnpHFsmQz4l/5cPhs8JHyntXIAGIxjh2MCCj3sRu+lIO
         mftkB5Egq9EU8ZqK7/yCUigJFV1yWpmsDKts8fxchqFBNsx+IgMBUsM1o7ieSm8hyKLU
         ArKYmY/J4f06X8xt1cjXFypmaSU9/Tdg7vGBzgsQU7etoE4EaDoESjbpc4D7lPz/opII
         P3QA==
X-Gm-Message-State: AOJu0Yyc75gq+todhHcyttED1yvVI2F8UQFiclXTMjRsE1KdhOL7Hi//
	XOVDP/W2d8Mqwc2Zo6kt95/Hm7xBw3i7Z7KvUzw7CgIUZ1WNT30mN+8eitD2/PUXpJXxDJaM4Qr
	hjBaFBlcGdhflc0FzUUbhGvabK1w=
X-Google-Smtp-Source: AGHT+IHGy6dZdzctqaV679FADtGawvC9dVXq0p2eDZEE2ghSmn6+nUX4Fc4rP8ATsdF/htsN4JuKsXhYtzBjrflrQRU=
X-Received: by 2002:a25:aa4a:0:b0:dc2:2e4e:d36c with SMTP id
 s68-20020a25aa4a000000b00dc22e4ed36cmr1393429ybi.37.1705934103029; Mon, 22
 Jan 2024 06:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
 <ZapwWuVTIDeI3W8A@tiehlicka> <CAK1f24m9oxciHsAht4-cCWo_NT7x+bkoXUO2HOwgMCr0OnwpcA@mail.gmail.com>
 <Za5yvjZWVyYjgyfh@tiehlicka> <CAK1f24n+pTw=7atKGAbgBh8qKOTBPq-BEV7ZkLcgN3P0n3h3ug@mail.gmail.com>
In-Reply-To: <CAK1f24n+pTw=7atKGAbgBh8qKOTBPq-BEV7ZkLcgN3P0n3h3ug@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 22 Jan 2024 22:34:51 +0800
Message-ID: <CAK1f24=7fKU-+xRSOhrJrZ56=YoVfnkONZwNOJRS4yY4SzhANA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Michal Hocko <mhocko@suse.com>, "Zach O'Keefe" <zokeefe@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, songmuchun@bytedance.com, 
	shy828301@gmail.com, peterx@redhat.com, mknyszek@google.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zach,

What do you think about the semantic?

Thanks,
Lance

On Mon, Jan 22, 2024 at 10:14=E2=80=AFPM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> On Mon, Jan 22, 2024 at 9:50=E2=80=AFPM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Sat 20-01-24 10:09:32, Lance Yang wrote:
> > [...]
> > > Hey Michal,
> > >
> > > Thanks for your suggestion!
> > >
> > > It seems that the implementation should try but not too hard aligns w=
ell
> > > with my desired behavior.
> >
> > The problem I have with this semantic is that it is really hard to
> > define and then stick with. Our implementation might change over time
> > and what somebody considers good ATM might turn int "trying harder than
> > I wanted" later on.
> >
> > > Non-blocking in general is also a great idea.
> > > Perhaps in the future, we can add a MADV_F_COLLAPSE_NOBLOCK
> > > flag for scenarios where latency is extremely critical.
> >
> > Non blocking semantic is much easier to define and maintain. The actual
> > allocation/compaction implementation might change as well over time but
> > the userspace at least knows that the request will not block waiting fo=
r
> > any required resources.
>
> I appreciate your insights!
>
> It makes sense that a non-blocking semantic is easier to define and maint=
ain,
> providing userspace with the certainty that requests won=E2=80=99t be blo=
cked.
>
> Thanks,
> Lance
>
> >
> > --
> > Michal Hocko
> > SUSE Labs

