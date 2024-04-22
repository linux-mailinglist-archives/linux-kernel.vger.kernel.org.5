Return-Path: <linux-kernel+bounces-154068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19158AD714
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD501C211C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C01D55D;
	Mon, 22 Apr 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FK/5SU3"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09711CD2E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823498; cv=none; b=tBSgiIk+LmNrLhqkLd9IKQrwMH2EfxoY8pwG+PczyQBGVOebAVbgHBCcQjvPrlJMnO6nBL9rSv0oc0XO9gBuuMbaOcvvA53OEyvhQm0DK8RrXgpRJ/CB+gh2pf8bdLqyw/T6UYagisjL5rld5CREQ4bLzjKs2lV6ND/wTMXrJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823498; c=relaxed/simple;
	bh=+Z37/lFmCeJniiUkcufRy3ywF5csDMPyldhq63xkH0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRKHzn5Jh8PA8o4pUSH7AvHE7SPN0zxJ++Z8aEXb/onXifEsI2rpaoXjQqqWgY7tH1/sPMKjq4D5gRFyIsRYbSiKWHRlJKjZotVGp0X0UfzeGyhi/dPYcy21pMKeYS9CcbBhTdEJUw/bNFEg+0+AxJ5zDyf4S/Xhw0gfBqbAhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FK/5SU3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3455ff1339dso3790169f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713823495; x=1714428295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItsmCJ/szUyFtXjv4JyNROY+H+Dc4VfzcDQaqCbKztQ=;
        b=4FK/5SU3UXa1+ACs4w2ofZu83dcViOqR1gXQFvU5tWU2LHKPbyshoANL5WBGeTtSAZ
         FU1kDiTqSSAqTuY08Ns7kz0VDSfTeoDk5se+gUxB31QrxZ3COibToVLId0yg+yvMRmXw
         9fNwLQ4lmcjf01uzVX1dU4EV/JTbcIdOqoIz/s9J8jlD7F6uQb5x1lEq9NU3E6zdXXHR
         8XWqRULiXyqC6vCuSOc/6F1nYpMFAqS3WSB79LMX0b49w31gyLCvMekHkAfd5A9dhWoi
         T6TfykXhD9HS9n3AuCXLhOgAFsJAsINDWyJ0SLDme3F2H9TMNuiy41/QEInyQpZM7nRs
         P0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713823495; x=1714428295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItsmCJ/szUyFtXjv4JyNROY+H+Dc4VfzcDQaqCbKztQ=;
        b=rWpEX4F60CHHoPlj9wpQ5Mt4Yuyx0zpYLHIr146fX4zcQ0PF6Jz72h8HsHl6XY0x97
         NDjPB2zwBNqElmFr8AVu7HKCYdK3bTCens+2/LHujl2kIv5AZ128mVXmDGAl76Jd0lRm
         gc24O+yAOzPqb54dnI5IDm6Qua/gzB4mNSuLSHdzUwBAQImRS5s4ojmbnqhyzth8z3y5
         u+Sa8TLAtuyFBf2olokYaRz1p5ZIh1e8eGDKdSPUA4pHwomj3FZncTAYZDK4CpGu+Ybe
         SUJgEjt4RcnOad3K8LOiJj7AaJlnY8OWQ8VVnHTAe1N/PzGQTa+ZCLqJt7ShGGL2sudN
         RLSg==
X-Forwarded-Encrypted: i=1; AJvYcCVu0sEO9naaGTMYUn4w5Sr2nhfisFxssaUM0wrZXOs33MIC6PdokiW+UoP0dj0UV+g4i9NFjiDl2cMvu34tXb++bJkUo/noLKZkN4SR
X-Gm-Message-State: AOJu0YwP3yxF78/c3VT+2XIsGUkzPCz4lIW8PTX55I/7yvtZuxjJjTwX
	oum2VMZ7Tymk1uOiSDGP0+3T7hT++yeSF8aW9bBtdkw2gZK0yDvSbvjX+h243rgDO1XOxWSqa/3
	BJ4FoxrDImM6p0iTYiefRn/JFddRPO334YolS
X-Google-Smtp-Source: AGHT+IFHR6M6TUjNBshn0Rr8EONioGqDgijzOjqTJOyrpQ2pfIL8J80OEon12MsujtK8CkK7Rbk/bO4UDoc3w0/2ZdQ=
X-Received: by 2002:a05:6000:120e:b0:34a:5c6d:4605 with SMTP id
 e14-20020a056000120e00b0034a5c6d4605mr8976953wrx.0.1713823495164; Mon, 22 Apr
 2024 15:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418042706.1261473-1-maheshb@google.com> <163538a0495840eca34f6fbd09533ae1@AcuMS.aculab.com>
In-Reply-To: <163538a0495840eca34f6fbd09533ae1@AcuMS.aculab.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 22 Apr 2024 15:04:27 -0700
Message-ID: <CAF2d9jj6H+jOfUbbw1ZEHmgqroXmn+oFV8NwTyKJ_P_T4G_5xg@mail.gmail.com>
Subject: Re: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally in
 mono-raw base.
To: David Laight <David.Laight@aculab.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	John Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 11:27=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> From: Mahesh Bandewar
> > Sent: 18 April 2024 05:27
> >
> > The current implementation of PTP_SYS_OFFSET_EXTENDED provides
> > PHC reads in the form of [pre-TS, PHC, post-TS]. These pre and
> > post timestamps are useful to measure the width of the PHC read.
> > However, the current implementation provides these timestamps in
> > CLOCK_REALTIME only. Since CLOCK_REALTIME is disciplined by NTP
> > or NTP-like service(s), the value is subjected to change. This
> > makes some applications that are very sensitive to time change
> > have these timestamps delivered in different time-base.
> ...
>
> Isn't using CLOCK_REALTIME just a big bug?
> As well as minor 'corrections' done by NTP it suffers from
> major time-warps that can jump in either direction by arbitrary amounts.
>
Yes, this arbitrary jump in either direction is a problem and hence
the proposed update. However, since it's a UAPI and there could be use
cases that are happy with the current implementation, we can't break
them. Of course the use case that I'm bringing in (and probably what
you have in mind) differs but backward compatibility needs to be
maintained.

> If I understand the intent of the UAPI, a possibly solution is
> to get the offset between CLOCK_REALTIME and CLOCK_MONATONIC and
> ensure the same offset is added CLOCK_MONATONIC for the pre- and
> post- timestamps.
>
As I understand, the UAPI is to read the PHC and also use the pre/post
timestamps to see the latency of that PHC read as well. CLOCK_REALTIME
is disciplined by NTP and to certain extents CLOCK_MONOTONIC as well
(only freq adjustments are applied). CLOCK_MONOTONIC_RAW is the only
unaffected time-base and hence this proposal / enhancement.

> This doesn't solve the problem of the NTP adjusted clock always
> running slightly slow or fast.
> The big NTP errors happen in the first (IIRC up to ~20 mins after boot)
> when the system clock is being synchronised.
Yes, a big step is a high possibility at the beginning (at boot) but
smaller steps as well as ppm adjustments are real possibilities
throughout and hence CLOCK_REALTIME and CLOCK_MONOTONIC are affected.
By adding the timestamps in CLOCK_MONOTONIC_RAW (as proposed in this
patch) should address this issue.

> It really would be nice if those big adjustments didn't affect
> CLOCK_MONATONIC.
> (as an example try sending RTP audio every 20ms)
>
Hmm, probably this is out of context for this patch and probably a
question for the time maintainers / experts?

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

