Return-Path: <linux-kernel+bounces-166160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACB8B96ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23862B23689
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4947A7A;
	Thu,  2 May 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T27ZpsYG"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C353362;
	Thu,  2 May 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640127; cv=none; b=Tcx+8xBk8Tf0qR412AxVfMvt1Ib8vm6QWi72hX4bWCQLyer+6G3mIzIXil9qZCFF7IkbW7gZz/4fqbqqNcZdH3WUFRVJb2b/F2UDpcKF9vIJ03//l2TMEOAJg5rOx2EI+Bzaq8crco7VUtfbLrDjQXJ4nl1jx08JxgpZxYho9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640127; c=relaxed/simple;
	bh=Yg56ikL/SLLyAKrOTSpxjb8Cuea3ldNSUoH4sMs7lUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj2kvHKi+SH8JZFvEePmJAl9fFjJljKLjl7zyWuCf8NlSkb+knt5/T0T0JODx6xRebYZrnjt3voZ76GB2uxWyiL3sk3bG1YbEsyQ1D/AG3+qvwf83KGx1E6n7RL24+6CP8HuH0rIw/YJYAaq4v8Tjx1FMkyqLEzzFp91ZaE+duY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T27ZpsYG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b2769f017aso2137171a91.3;
        Thu, 02 May 2024 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714640125; x=1715244925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1qq9S2aGRtwilUT9y/lJAq9N983piKfJAV7Zk6wN1M=;
        b=T27ZpsYGSC7AbRT+wZE/mkfPjogsK6azZcYHQPSVZKANx6/oKrXKY+ciWtjhu5Nj7P
         o5Y/N46pZAaxK2KAiByFLMsvFIWDjyt7a/tkqg7ofoW0GqSXN4l0bKhwK0+x3URbURuw
         9SarYhRl6QaV066W1juPTjleDk0EHG9bGvb0wjLufx5o75suZnRm2KLq8+xnaakHKxNb
         EDIR7dBGnPJI1nsvFSbCzSDv1jWITySGTtp6/JV7PmLNY0U0DdQUwEnpL0lMARc3czaE
         DTRtiWV2IXDfGaLOgmFqq+bY3dwvJXmkoLxXjAw9NJDM8+P0n/3yZKvH+mvaXkSH1CTn
         9Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714640125; x=1715244925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1qq9S2aGRtwilUT9y/lJAq9N983piKfJAV7Zk6wN1M=;
        b=ResGPgoYyEIOCP/KivnxakmQAiydH79flPtqRxn5niNqs/JivK/CnuDp+olgXYT1XF
         6Vpx5WI+lqTgt9aX10hadRHLAwt0GVLImh39mMe6N3oFTZ+Y0wKJsdvo4WbJAVobE1F4
         G/S+C/TRg0j/XpkZMJ5utc2XDJ4uGBzYLrG2EN30zLBX0edCmsHNu6X3IAIIybXCGkbl
         WAWOkJRyBaeqvg6qcitx/IorQkVyrNynAv16hDMQgqQmcXUW6K9Q0H3lx1vXje1Rh4Uv
         YmtQXf7sYtLtCDCgJmIX7nbbuMfChZhUr9kGqqYmHNXrPlf3SB8vxfJtzHiufkc+MYTc
         D41Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+JLEC6UwcoRlSXyc0YATCtm4tN/1llRHi8Ohlu79ReX9nMn8VuKQxdCoNB4JWzJI8jJSCEkcLoDJbX+5SHXT8KF7d5ylJOAVEA2L2nvK3CIYms1W5V2iUIDFPTScnk7agVqL/9xWy3JBtHo+W7XdgkjASSl9dY4LVDsIj3/3lnfvci4a52g==
X-Gm-Message-State: AOJu0Ywzntgfqq0UjMpQg9bHcKK0ivoGDL/0qy6JTyyg5n5EueoGfftQ
	D+jViVQNWGUn9dpAbYWcrsNg5BRJKyG1DNet0F6KdzkAzZV1LmkUIE9yqp4Pe4UMV4KqF1iOJne
	HedyzM/HNBrZSNwec8klCWI4ds/8=
X-Google-Smtp-Source: AGHT+IEWHFfdPOAuzI1wYhBzIMGfNagBvY1J9P+TQuJFavD+2hsjIBw0Rk4R/Vs2x7OpvMNZ1kKU7tqxZIW8TeHH/vE=
X-Received: by 2002:a17:90a:e68b:b0:2b0:8497:1c57 with SMTP id
 s11-20020a17090ae68b00b002b084971c57mr4710346pjy.27.1714640125591; Thu, 02
 May 2024 01:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501084110.4165-2-shresthprasad7@gmail.com> <01cbcdf5-8a7a-4b47-a2aa-05c041e3cab2@kernel.org>
In-Reply-To: <01cbcdf5-8a7a-4b47-a2aa-05c041e3cab2@kernel.org>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Thu, 2 May 2024 14:25:14 +0530
Message-ID: <CAE8VWiKqnM0BGnSDxT5+ZjD67UXxjY3PZAyNwsxbD0nZs3cJ4A@mail.gmail.com>
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
To: Jiri Slaby <jirislaby@kernel.org>
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
	skhan@linuxfoundation.org, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 1:26=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
>
> On 01. 05. 24, 10:41, Shresth Prasad wrote:
> > Add `__free` function attribute to `ap` and `match` pointer
> > initialisations which ensure that the pointers are freed as soon as the=
y
> > go out of scope, thus removing the need to manually free them using
> > `of_node_put`.
> >
> > This also removes the need for the `goto` statement and the `rc`
> > variable.
> >
> > Tested using a qemu x86_64 virtual machine.
> >
> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> > ---
> > Changes in v2:
> >      - Specify how the patch was tested
> >
> >   drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
> >   1 file changed, 11 insertions(+), 26 deletions(-)
>
> Nice cleanup.

Thanks :)

>
> > --- a/drivers/tty/serial/sunsu.c
> > +++ b/drivers/tty/serial/sunsu.c
> > @@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(voi=
d)
> >
> >   static enum su_type su_get_type(struct device_node *dp)
> >   {
> > -     struct device_node *ap =3D of_find_node_by_path("/aliases");
> > -     enum su_type rc =3D SU_PORT_PORT;
> > +     struct device_node *ap __free(device_node) =3D
> > +                         of_find_node_by_path("/aliases");
>
> If we used c++, that would be even nicer; like:
> Destroyer ap(of_find_node_by_path("/aliases"));
>
> But we don't :P. OTOH. can't we achieve that with macro-fu and typeof()
> magic? Perhaps not really exactly the above, but something like
>    Destroyer(ap, of_find_node_by_path("/aliases"));
> maybe?

Hmm, a macro like that could probably be written but it's more convenient
to use the GCC attribute like in the current implementation, IMO.

Jonathan Corbert, who introduced this, wrote about it here:
https://lwn.net/Articles/934679/

Regards,
Shresth

