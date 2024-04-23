Return-Path: <linux-kernel+bounces-154671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DE8ADF93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAD31C22224
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1F51C5F;
	Tue, 23 Apr 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTMekrbI"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3A51016
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860331; cv=none; b=qhjIvTJS+g+2bw8yqcl1xVzDwp4D88o0gksAj4lo/s4fVkKiOPwE+aWUSWX4Yvk7Zy4FgeTTGk/tpvMIumChLt+1DBBFoPV4qNrYdcbft1xaZZx9vFYXRW1lvJ68h1hb+fZ/fEJ/g86XugoeXqQUzqdnb4gB0MN0bO3AywC5p4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860331; c=relaxed/simple;
	bh=YLnSUjYzjfndyEA7FAEed9C3Kwh2TNACksizXt/G1XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYfHV6i02n9+orq9gpri4Sq+JqdAWhsWQk8ePX2Br/s6hUzfZU4fu//G7p72jkIkkJ2GgZCThbEttkfTXBfCHi2tMLjiz4T8yYKnxsVL4gBuwgUGYIosZCqtBH5uPYqvJ2qYArqcb0bI4ILTohFRKVca1cdo5oCPNvwt2kLICgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTMekrbI; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7eb7f34f36dso1865060241.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713860328; x=1714465128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ziGjh9kZ42yJ4vHITCOOKK6aWeW2/ZPsEJRhfAu7FI=;
        b=rTMekrbIZi9PCmKD1dFM/Yn9/jv96MY46Ybxs2kGgW9bjSB7yAM5Q42NLKmEaUNGho
         SLxX6l5DwP9v+iKkaMiXP9qORd12c7xn9w2ju4u5r0B2ojYCPz5X5yoax/UxMesGSHrq
         aUQ2c+DvFmtFD3X7w+pmeh1Ish/glf0r3g/UZUUSAn91gcXmwr1yVapfQAE75TVhX+oH
         CjraJkWOM4Rd22jBaRdMSCjEz4fqcC8Vb8amWKJiXHzgVmq8iG3TgeBLAcZyrU7fQqlq
         2hu1AFaM+9rGLDhk/7BGTmE4GObMZptbSKTTyfM6FgSI1iGqvf3odu4GyE8PuSdzc0in
         1rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860328; x=1714465128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ziGjh9kZ42yJ4vHITCOOKK6aWeW2/ZPsEJRhfAu7FI=;
        b=lARy83MsF5pX1SHUFA3v1PLRtYmfh03HHlIXL0pUG3ndUu+Bux887DXDSYqwiAICgf
         vikTisMCCsbqlKgjWoSsU77sjVZ9HBfJQKB2CAHgEsoIXtq6tOwFiJUeVDTXZjr4itd1
         37STHl6l3d7ZS62crhk7sre9NfHql1ilGq92+wT1D4aGE0w2+k6X/8NkgvGL2oo7tEcO
         NFqOax1HiwoN14biK1qsP8UDmIkcKwiI1dWtq7SX1z7VIwNkDnLPjah7vVGW3sFXYdDc
         rc82+evf7lCXgFIJ9deg6CANn1BCe2+qlIiBLwOVQgL90gWrcnmaTW+4RC2PPxXW28NJ
         RCkw==
X-Forwarded-Encrypted: i=1; AJvYcCW59Hgs6NJdieNHGH1+V9uBw952RpTWB7EbohN5jtFsPRwT7cRYS4o6JLwTePj9J7lJaFPtoCQzhzPIrto1m82qch5+5eyBHnIvGh5O
X-Gm-Message-State: AOJu0Yw8adF5XT3n/fYZwWdQEeFgG/LnJWRY6wNYf8X4/YylLzCTllGe
	xZqahc2eh2IkPFd1D33W0RyBoBMwzCGGAg53Mt0cw+C3GwTs/wCecLfnl6D45lvmQ4oeLDwrGwn
	qNCFlDynoNL0frnt8zZVvCODUX70yO53ZjfG6
X-Google-Smtp-Source: AGHT+IGlgZgM5ohAKXjCTKCVa6esHSw5n5ZlYQZtSeGRIRZvRxXvFf9xRMBS6AhfCnJf4x1/7swllKTPAveV/JKuL3M=
X-Received: by 2002:a67:eb89:0:b0:47b:ca6a:c5d9 with SMTP id
 e9-20020a67eb89000000b0047bca6ac5d9mr11530019vso.28.1713860328053; Tue, 23
 Apr 2024 01:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417191418.1341988-2-cmllamas@google.com> <20240418083447.3877366-1-aliceryhl@google.com>
 <ZiRSPXSuSMyUO0Cw@google.com> <CAH5fLgjCmzOXWa7VFg6yCjnTDfu2pcJr9=FngeGg28zCvV49eQ@mail.gmail.com>
 <ZibpNNp2pH_UJISG@google.com>
In-Reply-To: <ZibpNNp2pH_UJISG@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 23 Apr 2024 10:18:36 +0200
Message-ID: <CAH5fLgjuK2M_iDQdxT7f_CJHZN9S5u0p7raBwhV8tNCYnCN8Jg@mail.gmail.com>
Subject: Re: [PATCH 1/4] binder: introduce BINDER_SET_PROC_FLAGS ioctl
To: Carlos Llamas <cmllamas@google.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	maco@android.com, surenb@google.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 12:48=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> On Mon, Apr 22, 2024 at 10:56:31AM +0200, Alice Ryhl wrote:
> > On Sun, Apr 21, 2024 at 1:39=E2=80=AFAM Carlos Llamas <cmllamas@google.=
com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 08:34:47AM +0000, Alice Ryhl wrote:
> > > > Carlos Llamas <cmllamas@google.com> writes:
> > > > > This new ioctl enables userspace to control the individual behavi=
or of
> > > > > the 'struct binder_proc' instance via flags. The driver validates=
 and
> > > > > returns the supported subset. Some existing ioctls are migrated t=
o use
> > > > > these flags in subsequent commits.
> > > > >
> > > > > Suggested-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > > ---
> > > > >  drivers/android/binder.c            | 25 +++++++++++++++++++++++=
++
> > > > >  drivers/android/binder_internal.h   |  4 +++-
> > > > >  include/uapi/linux/android/binder.h |  6 ++++++
> > > > >  3 files changed, 34 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index bad28cf42010..e0d193bfb237 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -5334,6 +5334,26 @@ static int binder_ioctl_get_extended_error=
(struct binder_thread *thread,
> > > > >     return 0;
> > > > >  }
> > > > >
> > > > > +static int binder_ioctl_set_proc_flags(struct binder_proc *proc,
> > > > > +                                  u32 __user *user)
> > > > > +{
> > > > > +   u32 flags;
> > > > > +
> > > > > +   if (get_user(flags, user))
> > > > > +           return -EFAULT;
> > > > > +
> > > > > +   binder_inner_proc_lock(proc);
> > > > > +   flags &=3D PF_SUPPORTED_FLAGS_MASK;
> > > > > +   proc->flags =3D flags;
> > > > > +   binder_inner_proc_unlock(proc);
> > > > > +
> > > > > +   /* confirm supported flags with user */
> > > > > +   if (put_user(flags, user))
> > > > > +           return -EFAULT;
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > >
> > > > I'm just thinking out loud here, but is this the best API for this
> > > > ioctl? Using this API, if I want to toggle the oneway-spam-detectio=
n
> > > > flag, then I can't do so without knowing the value of all other fla=
gs,
> > > > and I also need to synchronize all calls to this ioctl.
> > > >
> > > > That's fine for the current use-case where these flags are only set
> > > > during startup, but are we confident that no future flag will be to=
ggled
> > > > while a process is active?
> > >
> > > hmmm, this is a very good point. It would probably lead to userspace
> > > having to cache its flags for every binder instance. This is not a go=
od
> > > solution at all.
> > >
> > > >
> > > > How about these alternatives?
> > > >
> > > > 1. Userspace passes two masks, one containing bits to set, and anot=
her
> > > >    containing bits to unset. Userspace returns new value of flags. =
(If
> > > >    the same bit is set in both masks, we can fail with EINVAL.)
> >
> > To add to this one, one could also say that if a bit is set in both,
> > then the value is toggled.
> >
> > > > 2. Compare and swap. Userspace passes the expected previous value a=
nd
> > > >    the desired new value. The kernel returns the actual previous va=
lue
> > > >    and updates it only if userspace gave the right previous value.
> > > >
> > > > 3. Set or unset only. Userspace passes a boolean and a mask. Boolea=
n
> > > >    determines whether userspace wants to set or unset the bits set =
in
> > > >    the mask.
> > > >
> > > > I don't know what the usual kernel convention is for this kind of
> > > > ioctl, so I'm happy with whatever you all think is best.
> > >
> > > I've never come across these types of alternatives personally. What I=
've
> > > seen however, is the typical SET/GET ioctl pairs. This is a "simpler"
> > > interface I guess but it has the downside of an extra roundtrip. e.g.
> > >
> > >         ioctl(fd, BINDER_GET_PROC_FLAGS, &flags);
> > >         flags |=3D BF_LARGE_HANDLES;
> > >         ioctl(fd, BINDER_SET_PROC_FLAGS, &flags);
> > >
> > > What seems tempting about the SET/GET pair is that we could replace t=
he
> > > BINDER_ENABLE_ONEWAY_SPAM_DETECTION with the SET. Instead of maintain=
ing
> > > legacy code for the "deprecated" ioctl.
> > >
> > > wdyt?
> > >
> > > I'll have a second look at the alternatives you mentioned. Perhaps I =
can
> > > reference some other existing ioctl that does something similar.
> >
> > Hmm. I don't think a get/set pair improves the situation much.
> > Userspace still needs a global mutex for making changes to the flag in
> > that case. Otherwise, two threads changing two different flags in
> > parallel could result in a race condition where one of the changes is
> > lost.
>
> I'm not sure this would ever be a problem, libbinder currently has a
> mutex for this kind of things already and it seems unlikely that these
> process-wide flags would be toggled outside of initial config. However,
> it is worth discussing for sure as things can change.
>
> I'm mainly concern about overloading what should be a very simple ioctl.
> With that said, I think one more option that is fairly simple/common is
> a SET/CLEAR ioctl pair. A little adaption from your 3rd option I think?
> I would be fine with that.
>
> Unfortunately, this would require new ioctl IDs so we would still need
> to maintain the ONEWAY_SPAM thing. I suppose that's ok.

As long as your decision has taken the things I mentioned into
account, I'm happy with whatever you think is best. If you think a
GET/SET pair is reasonable because binder already has a mutex, then
that's fine with me.

Alice

