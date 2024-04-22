Return-Path: <linux-kernel+bounces-154116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF038AD784
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059031F21647
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266C521105;
	Mon, 22 Apr 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+mqOX1T"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2531F922
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826106; cv=none; b=g19qtzcUu5C4aDmg9O/QnwJm9UW6f1tXmHpVSvdufoilaGM+5dVBJilunnVjK+IledOh5K878P9cJ9LhZKTYEl/fTKJ0Sb1qpTzKf+58wc7P8l7IdIuKGyvuMUb8EKWAVUo6ebUlvwimOnkbzBnS1dDjS7VstXITweHyfGKAYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826106; c=relaxed/simple;
	bh=fWP8RCl/Y0bgltY1sVo9wNBmMVI4PNYA6XWtk6eH1fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9jQcklCS7xtlY/qYgYnpKBBL6Tl4QXvm05fMZNg/QVRyBzVUYR6ApZ49gOd5lOfn5v2+ZkdrDKoqZQ9VOFPGFVbaLJv+MZo5U169WXFesNkmckFj4ptHNdWT3d/Xgl/nnYqwOqtZV67E6Qby7SH3o6doFMOtC2F0ncw3TIbFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+mqOX1T; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso4716479b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713826104; x=1714430904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmlW0MljqguexkzhzTdZql1fdKXK699efxFdlsUjtxE=;
        b=c+mqOX1TZL714X7jge6N1Y3Xb00YN9SW1GJlcx0pBcZtjZVcPyGnb0CSAP04QhoS7E
         OV85Uyt6kxANN6DwuJmy83Opzrg8t87qvdeFl4pGiU8G31KJqXL6ceo0BOv8aObav0+9
         mv6hbxerpPwOrvCyUL85Bxmvybf0POMJQUXV9C2sZ4TasjMgMmn4xeow8T+x68DaBACa
         tmOiC/kfC4NicuzSZbvAR/MVEIfgtuA6geJ+g/FgsO5wvK5SXrM/h2vlHFP/tRYJPw7B
         Ag9RFHb8vC4KpV+7bQBzgkNyQp9FXRjm+tGmJI6r7YRhsgDqjL+piq3ie2pXjITd2WC9
         CjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826104; x=1714430904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmlW0MljqguexkzhzTdZql1fdKXK699efxFdlsUjtxE=;
        b=PCrGbU3Ih5VI+ZTwgM+cjlA+6u66T8V2nGHa0ner67P+o08eWqqk6W9WNhIH8H1u1c
         3xkMNxS3tq7WxSU8FwAbgk4RCSXb9Q43dfVvY4JZuBk/Q/KgPGaj7gehuah6zsZaJ5J6
         KRnwFjXchMrPF81a+A0K8YnecE6/jCPPwcbfY0niOH3980xMdnptPiO2U4LInpDpB1L4
         b3Xn+TBs3/ldFRiYtPLhK0AXNeX4qKyKi3BXrskeb1LWXzfBnUgfXbN6kuNkfEWt1XAr
         pHNo0ANr2FaEa60Fca6EwNIkQ9XS8GCZuPUe1TRTBQZQeuIfk5zl95xxA2eOgP20cgGP
         jOng==
X-Forwarded-Encrypted: i=1; AJvYcCVi9gKEZesoH9uu8/VAqrsgOmqsAiKJspKvg6MuxRAeQ89RR5ZY3VlqfqTHZHkgHVkCConLiYCsABOXaaftpTNcMXhcN8A2ZfVTQDp4
X-Gm-Message-State: AOJu0YxJ5P7zzGpLTUz120XHRPD9WWzv/YhaCbDQ8ZUuuHPSy2UfqPtG
	uWbAAsby9wIap3HC6qVEtgl7CSxnbOLEdUOBaIAgcti4KbwPhUPS9I6jvJWhHw==
X-Google-Smtp-Source: AGHT+IHIQgSfGDkaDSt/s2ARlG2UTnEAMh2m2ZxWg/IZbSlzMnEiP6/lbyyNXZR4okqFPH1mtgFODw==
X-Received: by 2002:a05:6a00:2e0f:b0:6eb:1d5:6e43 with SMTP id fc15-20020a056a002e0f00b006eb01d56e43mr14497784pfb.11.1713826103741;
        Mon, 22 Apr 2024 15:48:23 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id r13-20020aa79ecd000000b006ed045af796sm8342442pfq.88.2024.04.22.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:48:23 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:48:20 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
	tkjos@android.com
Subject: Re: [PATCH 1/4] binder: introduce BINDER_SET_PROC_FLAGS ioctl
Message-ID: <ZibpNNp2pH_UJISG@google.com>
References: <20240417191418.1341988-2-cmllamas@google.com>
 <20240418083447.3877366-1-aliceryhl@google.com>
 <ZiRSPXSuSMyUO0Cw@google.com>
 <CAH5fLgjCmzOXWa7VFg6yCjnTDfu2pcJr9=FngeGg28zCvV49eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjCmzOXWa7VFg6yCjnTDfu2pcJr9=FngeGg28zCvV49eQ@mail.gmail.com>

On Mon, Apr 22, 2024 at 10:56:31AM +0200, Alice Ryhl wrote:
> On Sun, Apr 21, 2024 at 1:39 AM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 08:34:47AM +0000, Alice Ryhl wrote:
> > > Carlos Llamas <cmllamas@google.com> writes:
> > > > This new ioctl enables userspace to control the individual behavior of
> > > > the 'struct binder_proc' instance via flags. The driver validates and
> > > > returns the supported subset. Some existing ioctls are migrated to use
> > > > these flags in subsequent commits.
> > > >
> > > > Suggested-by: Arve Hjønnevåg <arve@android.com>
> > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > ---
> > > >  drivers/android/binder.c            | 25 +++++++++++++++++++++++++
> > > >  drivers/android/binder_internal.h   |  4 +++-
> > > >  include/uapi/linux/android/binder.h |  6 ++++++
> > > >  3 files changed, 34 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index bad28cf42010..e0d193bfb237 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -5334,6 +5334,26 @@ static int binder_ioctl_get_extended_error(struct binder_thread *thread,
> > > >     return 0;
> > > >  }
> > > >
> > > > +static int binder_ioctl_set_proc_flags(struct binder_proc *proc,
> > > > +                                  u32 __user *user)
> > > > +{
> > > > +   u32 flags;
> > > > +
> > > > +   if (get_user(flags, user))
> > > > +           return -EFAULT;
> > > > +
> > > > +   binder_inner_proc_lock(proc);
> > > > +   flags &= PF_SUPPORTED_FLAGS_MASK;
> > > > +   proc->flags = flags;
> > > > +   binder_inner_proc_unlock(proc);
> > > > +
> > > > +   /* confirm supported flags with user */
> > > > +   if (put_user(flags, user))
> > > > +           return -EFAULT;
> > > > +
> > > > +   return 0;
> > > > +}
> > >
> > > I'm just thinking out loud here, but is this the best API for this
> > > ioctl? Using this API, if I want to toggle the oneway-spam-detection
> > > flag, then I can't do so without knowing the value of all other flags,
> > > and I also need to synchronize all calls to this ioctl.
> > >
> > > That's fine for the current use-case where these flags are only set
> > > during startup, but are we confident that no future flag will be toggled
> > > while a process is active?
> >
> > hmmm, this is a very good point. It would probably lead to userspace
> > having to cache its flags for every binder instance. This is not a good
> > solution at all.
> >
> > >
> > > How about these alternatives?
> > >
> > > 1. Userspace passes two masks, one containing bits to set, and another
> > >    containing bits to unset. Userspace returns new value of flags. (If
> > >    the same bit is set in both masks, we can fail with EINVAL.)
> 
> To add to this one, one could also say that if a bit is set in both,
> then the value is toggled.
> 
> > > 2. Compare and swap. Userspace passes the expected previous value and
> > >    the desired new value. The kernel returns the actual previous value
> > >    and updates it only if userspace gave the right previous value.
> > >
> > > 3. Set or unset only. Userspace passes a boolean and a mask. Boolean
> > >    determines whether userspace wants to set or unset the bits set in
> > >    the mask.
> > >
> > > I don't know what the usual kernel convention is for this kind of
> > > ioctl, so I'm happy with whatever you all think is best.
> >
> > I've never come across these types of alternatives personally. What I've
> > seen however, is the typical SET/GET ioctl pairs. This is a "simpler"
> > interface I guess but it has the downside of an extra roundtrip. e.g.
> >
> >         ioctl(fd, BINDER_GET_PROC_FLAGS, &flags);
> >         flags |= BF_LARGE_HANDLES;
> >         ioctl(fd, BINDER_SET_PROC_FLAGS, &flags);
> >
> > What seems tempting about the SET/GET pair is that we could replace the
> > BINDER_ENABLE_ONEWAY_SPAM_DETECTION with the SET. Instead of maintaining
> > legacy code for the "deprecated" ioctl.
> >
> > wdyt?
> >
> > I'll have a second look at the alternatives you mentioned. Perhaps I can
> > reference some other existing ioctl that does something similar.
> 
> Hmm. I don't think a get/set pair improves the situation much.
> Userspace still needs a global mutex for making changes to the flag in
> that case. Otherwise, two threads changing two different flags in
> parallel could result in a race condition where one of the changes is
> lost.

I'm not sure this would ever be a problem, libbinder currently has a
mutex for this kind of things already and it seems unlikely that these
process-wide flags would be toggled outside of initial config. However,
it is worth discussing for sure as things can change.

I'm mainly concern about overloading what should be a very simple ioctl.
With that said, I think one more option that is fairly simple/common is
a SET/CLEAR ioctl pair. A little adaption from your 3rd option I think?
I would be fine with that.

Unfortunately, this would require new ioctl IDs so we would still need
to maintain the ONEWAY_SPAM thing. I suppose that's ok.

Sounds good?

--
Carlos Llamas

