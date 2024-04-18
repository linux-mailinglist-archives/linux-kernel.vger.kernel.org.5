Return-Path: <linux-kernel+bounces-149498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491AD8A920A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C975A1F22001
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE254907;
	Thu, 18 Apr 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViesA7FU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44986548EB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713414342; cv=none; b=K2VLAmk9RItxY/HUcvWfCjEVvKRt9zC0FPDH0c8Q5vtQjbKfW+R+iZqJ20FfxNZmg4xLLcP+9LzgHN2KhfmA5F0+NM/0SumBK2pDzSOj2vM96+KQxKrWspGYYMwsb0zDPWRvx1wFIfLxYECiepSyykD7NrGwNcR5O9KKNYNh/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713414342; c=relaxed/simple;
	bh=THbMGK9P2oPzJ9E0BRQPUuazGongGuwBG3/yrkSm96g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgODqeXq9QUKxpyFEDA7CSe6cPwHyHaIzA+WsEsoyIa9aa5X8yJezxSpwBLf68fp0v/lx7/bbhzc8JRDZSfd8DnWYDqeRex+pc8Kplm405O6TBoQon3lN68ceZ6d+nzllXes8zkrFvDgmuqfUu/jKQdWGYjmnoYvuxlOvbfwePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViesA7FU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4155819f710so3830485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713414339; x=1714019139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9shqtdqpe+dRcUSjcq/hM/+Uwh4voklkCak0dJ3AdkI=;
        b=ViesA7FUcrPgk61CiNcfFSDxcuPjPrnX+mmLOevb1S/9T89cDzGvk3LG4nWqdAduts
         flFonI0BzFw00fktlrdNA4wtPgapMIj+NZjW/Vh+PulO0Bl3f4Vff3+GKoFuMijESsJF
         fScxK8zt+JoZ9LMOZO6hTP3933X5S1fU0yuOgZ7G2P9DaOWUUeJWCoibF0BPW3XRWpVh
         61bJ1IUF0AYFapf+GYS2R1AZs/dET8aD1/VuvDJsPsTgvv5mYji/uzmydyUkbgavjtu9
         XK+IsBPP6Z7K+ahdeK8SgLy91RwxP8FZCSCbrZPyjlaTySbr+/P5JDe7W+tO4vV8LHUh
         k2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713414339; x=1714019139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9shqtdqpe+dRcUSjcq/hM/+Uwh4voklkCak0dJ3AdkI=;
        b=f9gNg76MP3/5sSRRdftGGXNDwNw22PNRxUeWJ8nrIXU3Zb1lwe42NsR9DaW8nwS+jq
         D/hXcqteP2mEXIB2xWTKKE3tstNNtZrI08LczcMnqZ8lfyluvxpTDzqq+co3OMoN00YI
         xXhjg+jsVHWdq+Valow0rLH2apsHjjtt3HlGWRBzEEIH01IX25S7JUBjGTyzYKpsOgww
         vktfifPikiGST25yG257evB5b09mLJchFUYyhKtsWJ+PPOVJcE3jkywn3gVNWxV10W2T
         7JN9rISRspHMwcD0ufoaT6ABQlEi3rc8IwhciBg28feLDFVk6DRYNIbb1NAbE1q4WePc
         8OrA==
X-Forwarded-Encrypted: i=1; AJvYcCWpouobQKa6DJFN66AZPDFTGpkEA6DDiLQ3Y5jnPXzZa4FohpHkM9CsfpkgLNolkb3u4ZSnHyYIVFnDNekh7vB6djjNrLFkzw/YpIWJ
X-Gm-Message-State: AOJu0YxElXPxmKYnnfmsMj/vCrhSnLFxJQvjkvNLbV8rrx82zhLZt9Gw
	Ku7t0yPmDrICmd+cqxI9KZjGjc3p3K0YsTPOKB/ifdvQpKqjEJGHjfkcL16jsoA/Y68dBokHZUq
	EKHvcmuL8pRGDfAcFoZfzgurd7HV7Yq0ILHe/
X-Google-Smtp-Source: AGHT+IEfCDME9/9wEydSsKDx7ebiinSMAuD0OtuiciDlDArvMmbu8U2Gd5E0EQVeWqrXHeAxuGHYczPeE/v8cIsx4wY=
X-Received: by 2002:a05:600c:1914:b0:416:605b:584d with SMTP id
 j20-20020a05600c191400b00416605b584dmr1072378wmq.3.1713414339448; Wed, 17 Apr
 2024 21:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416215942.150202-1-maheshb@google.com> <20240417182445.019fb351@kernel.org>
In-Reply-To: <20240417182445.019fb351@kernel.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Wed, 17 Apr 2024 21:25:12 -0700
Message-ID: <CAF2d9jgWb8-HqEBkN4qUCsUA9zGJo4q36L=8WqLYG0eHSiVpaw@mail.gmail.com>
Subject: Re: [PATCHv1 next] ptp: update gettimex64 to provide ts optionally in
 mono-raw base.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 6:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 16 Apr 2024 14:59:42 -0700 Mahesh Bandewar wrote:
> >               if (extoff->n_samples > PTP_MAX_SAMPLES
> > -                 || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]=
) {
> > +                 || extoff->rsv[0] || extoff->rsv[1]
> > +                 || (extoff->clockid !=3D CLOCK_REALTIME
> > +                     && extoff->clockid !=3D CLOCK_MONOTONIC_RAW)) {
>
> Since you're touching this condition it's probably a good opportunity
> to fox the coding style.
will do! I was just matching the existing style.

