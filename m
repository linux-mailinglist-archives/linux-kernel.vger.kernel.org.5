Return-Path: <linux-kernel+bounces-153037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27698AC82A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3311F21B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145195337F;
	Mon, 22 Apr 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VR5pH6i"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2D5101A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776205; cv=none; b=Go82RjWa1BFGrLl4bdk7cxEkBwk0Jbh80TYBC7uc4HAkfIUy7ulPAn5yzVcFJxqxnQUzQvoNKHc6sPHiBCK7Tobkh1y4LKL4c5ZY6Hs/HMc3Yc/k4pj4CD5vfr02je6vkBkzAEADZpCGjNM5UGhI4UQgl6RqcU3kOQbXPCNniIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776205; c=relaxed/simple;
	bh=s63bfMNRnWOoQ8PsqUvwNueqIvBGGmyYN29WSdA4kjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdCIRnA15k4JWyp/xHPlIy6cwGsx5cnb2t/GiSnKnw8EwZlKqaHkZw32wLiRkqHYJ9El46KdVCgj08OE5ualf45V0IbssULeHaKcrLpapJp2blUpWAVbz3g3n7KMlazOkNlnLInMXl90wGzpRfd83czLyeMSAGYRfZWbdBcLGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VR5pH6i; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dcc7c1055bso1260762e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713776202; x=1714381002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpIgAMGo6c2XVGupDF/MT9xzTdOTd8R0qRCe2KTK2Vs=;
        b=0VR5pH6i+TvEFNwSsoDjoAgDtq+f5n2HxytZHSBftu/Ab8rZDbNpDs7H1zvMqcqrzs
         lv/11QLk5N0UnTCL8o0U6C7KdP6eqrEs3eNYmk2MVr1Qlcm5cy/OZuI0eoNX0TVQwdrz
         DqzeI+uVJfipifhHYLri/X3TMojcDJu5ofblagpe4Ye+HFj59VECsWlEKEjlDRFd8bkd
         V4gMUhyBbS7MYUxGzbRugAgCsHD32RlOYJd4gio6Y4OmoKtGHRwR3ZNzYnsTnvUnz292
         5XlvTIDSM+lHSZr8Ze3ZT23xxX0UBHJ1hb8c2Ps+o5L0Q3RmgoRno0mrOcgMcy0Z0h3H
         aoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776202; x=1714381002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpIgAMGo6c2XVGupDF/MT9xzTdOTd8R0qRCe2KTK2Vs=;
        b=lcoRWtK0Jskq3RnGvC5b871A1MuphnuryHbj0OT3uVx0Wq+BpBbYW5Qm6wu/crdU/R
         vfBQ3hG9Rn/xLF0NxDfPeTn0hq2PsByQYJ0oMRosc47ZhM23higO7o18TNaODIwnzFBA
         OJByxnNIvoeG5oKjOTJJM2c8Bn75XrfhtnL8sjJ5ATLX1hdDGj5VFl1KUtWBWjxwJL3q
         t33gLgR5dQPmSiwjWSvF1ATXnIuQMAYsgoMRsnkPRyvSGXS09xwMRnF449M4TSOYUVFf
         /V/mUPfBMebhTyHEAWiYyqnVuufSIzX73ZjzUD4TwVOX6/5zGU5gKVvB277+sE+0Adkq
         SVWA==
X-Forwarded-Encrypted: i=1; AJvYcCXq1qIFAqtePsTVDMpobkl8RzjzVI6EixXoTn78Ldf8OEH+uQeDzY5QaO+D9cAor0eIeFMIKM2bqjdekxWCQkZc4QCCWgo+bEzLaO4N
X-Gm-Message-State: AOJu0Yxk5KhE6bDamZOD1h8umaL9/MuroxaYs+X/fnxItOvuINXPePdm
	8CkVG+aMpOCRmmqMPOrrSKA9CtzCfspWGRdfp1vuaoTxh4BfZf9f2EsVZ31bMf3agjhatL0hQFO
	DwzGBmUi/zgOeIuWlnuC++hQk9UP9lVDHrncT
X-Google-Smtp-Source: AGHT+IH/laI9GguSW62J3PNRJ21xb+bRU3Yns1VkRR44Zb71wlhIZf7zThOSlThYrlE212OBCFbNNwWd5yPNF4vBmcY=
X-Received: by 2002:a05:6122:3286:b0:4d3:4aad:1b9c with SMTP id
 cj6-20020a056122328600b004d34aad1b9cmr10297855vkb.0.1713776202499; Mon, 22
 Apr 2024 01:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417191418.1341988-2-cmllamas@google.com> <20240418083447.3877366-1-aliceryhl@google.com>
 <ZiRSPXSuSMyUO0Cw@google.com>
In-Reply-To: <ZiRSPXSuSMyUO0Cw@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Apr 2024 10:56:31 +0200
Message-ID: <CAH5fLgjCmzOXWa7VFg6yCjnTDfu2pcJr9=FngeGg28zCvV49eQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] binder: introduce BINDER_SET_PROC_FLAGS ioctl
To: Carlos Llamas <cmllamas@google.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	maco@android.com, surenb@google.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 1:39=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 08:34:47AM +0000, Alice Ryhl wrote:
> > Carlos Llamas <cmllamas@google.com> writes:
> > > This new ioctl enables userspace to control the individual behavior o=
f
> > > the 'struct binder_proc' instance via flags. The driver validates and
> > > returns the supported subset. Some existing ioctls are migrated to us=
e
> > > these flags in subsequent commits.
> > >
> > > Suggested-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > >  drivers/android/binder.c            | 25 +++++++++++++++++++++++++
> > >  drivers/android/binder_internal.h   |  4 +++-
> > >  include/uapi/linux/android/binder.h |  6 ++++++
> > >  3 files changed, 34 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index bad28cf42010..e0d193bfb237 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -5334,6 +5334,26 @@ static int binder_ioctl_get_extended_error(str=
uct binder_thread *thread,
> > >     return 0;
> > >  }
> > >
> > > +static int binder_ioctl_set_proc_flags(struct binder_proc *proc,
> > > +                                  u32 __user *user)
> > > +{
> > > +   u32 flags;
> > > +
> > > +   if (get_user(flags, user))
> > > +           return -EFAULT;
> > > +
> > > +   binder_inner_proc_lock(proc);
> > > +   flags &=3D PF_SUPPORTED_FLAGS_MASK;
> > > +   proc->flags =3D flags;
> > > +   binder_inner_proc_unlock(proc);
> > > +
> > > +   /* confirm supported flags with user */
> > > +   if (put_user(flags, user))
> > > +           return -EFAULT;
> > > +
> > > +   return 0;
> > > +}
> >
> > I'm just thinking out loud here, but is this the best API for this
> > ioctl? Using this API, if I want to toggle the oneway-spam-detection
> > flag, then I can't do so without knowing the value of all other flags,
> > and I also need to synchronize all calls to this ioctl.
> >
> > That's fine for the current use-case where these flags are only set
> > during startup, but are we confident that no future flag will be toggle=
d
> > while a process is active?
>
> hmmm, this is a very good point. It would probably lead to userspace
> having to cache its flags for every binder instance. This is not a good
> solution at all.
>
> >
> > How about these alternatives?
> >
> > 1. Userspace passes two masks, one containing bits to set, and another
> >    containing bits to unset. Userspace returns new value of flags. (If
> >    the same bit is set in both masks, we can fail with EINVAL.)

To add to this one, one could also say that if a bit is set in both,
then the value is toggled.

> > 2. Compare and swap. Userspace passes the expected previous value and
> >    the desired new value. The kernel returns the actual previous value
> >    and updates it only if userspace gave the right previous value.
> >
> > 3. Set or unset only. Userspace passes a boolean and a mask. Boolean
> >    determines whether userspace wants to set or unset the bits set in
> >    the mask.
> >
> > I don't know what the usual kernel convention is for this kind of
> > ioctl, so I'm happy with whatever you all think is best.
>
> I've never come across these types of alternatives personally. What I've
> seen however, is the typical SET/GET ioctl pairs. This is a "simpler"
> interface I guess but it has the downside of an extra roundtrip. e.g.
>
>         ioctl(fd, BINDER_GET_PROC_FLAGS, &flags);
>         flags |=3D BF_LARGE_HANDLES;
>         ioctl(fd, BINDER_SET_PROC_FLAGS, &flags);
>
> What seems tempting about the SET/GET pair is that we could replace the
> BINDER_ENABLE_ONEWAY_SPAM_DETECTION with the SET. Instead of maintaining
> legacy code for the "deprecated" ioctl.
>
> wdyt?
>
> I'll have a second look at the alternatives you mentioned. Perhaps I can
> reference some other existing ioctl that does something similar.

Hmm. I don't think a get/set pair improves the situation much.
Userspace still needs a global mutex for making changes to the flag in
that case. Otherwise, two threads changing two different flags in
parallel could result in a race condition where one of the changes is
lost.

Alice

