Return-Path: <linux-kernel+bounces-141328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F48A1E28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294B9B35D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA0127E19;
	Thu, 11 Apr 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nM/cVwu2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A903F9C0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853243; cv=none; b=T2ORt5ymwEmAFb8JKzMxND71pIHWwaJ5C0scTyajAceq9EaRXouwZ0ypxeAKrndiwGVtJ4YFjsqkw0GbnrhNieWqfg8hm18aQOdGkJDRsi6VYXjpEtDuQnnDTleucNHo3FCaPBgPVnBMY1zfQOO59blatRMb04Ao02ijBWiq2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853243; c=relaxed/simple;
	bh=pojFPo0N/mybezggVdUM4PcHL1faLBMT+lIJT7+zgXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjsRRBV401T0p+2yzYGRL9GBkS5v4RzmjRsZfjw/K2RRpOePIkUjjUr0TS4we8tYufY7T8sTv/8pJx+XS/DL17g5nGnTEqMEBwSEbKMJGpX7caTnDTSisERoLxvEgVK/c3IwCyFhNh73FnfIJN9rFGHDvb3naRV5ORD2s9mYesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nM/cVwu2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-416b5f6813cso672925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712853240; x=1713458040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhfpSE8tZzs61EVHkIgVUiczV3pVfcG5jjbnuwdJWKI=;
        b=nM/cVwu2zODXVwdPfk7iUFeVrIyYC79SAfEhmzLpw47uSc+i6a9pptUwH8EMBSTKIJ
         D7m5azdG6eYbintKtP6/f9aAyz63ue/Nu3z2LuYt2D6lCG+wJCFLQd3mgcow2gWLbkqc
         dktfaQWKmi/B7RsN868yqrVaC+iR3Y0++a6hdb+vvMsJLgX6mShLRHDziWYlZ4d1f0vr
         3a2oowjWMHFzhCX5m9LY8XdASLp3IaA8uVyRfQgQB+U92nuKiIc+1k4zZ3uAOR69S6SH
         bn0k/ExqCKwi19y1RwBljOiUjJG1BsR6/KxCd1XQ9ily1E4hT2MExmxjmOvi056HhYKN
         ZGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853240; x=1713458040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhfpSE8tZzs61EVHkIgVUiczV3pVfcG5jjbnuwdJWKI=;
        b=ciR2iiS1N8C2Dmw373KvDIOpcScLUhI9ops8tDeEbXraIXksfBz5TIdq/kD+YHP2/f
         tdsyiAwG+XB8HFKbW868gLUEDSjEWVfgW8Kek/3OhS6X2OXEnbe0shGDvE/9yS82eDau
         Td69cPRPnOMgKmnbdgXa03gBV5aZalh50aEvwtc5or4AmL4rQbpheFKGINEwqx2vrrGx
         xlr7JHWiMXk4exyzsKC6IyfXIDX9hA3c5f82QQMT17SVOI3ekPVlcA4R4z3s5RCq770n
         Lq2IbRavpU+ZH4vXOiIjNZ5JsukQeBh9crNYELcdPvLpWcFSr2DhRug9YVKidg/LwQcH
         9Nxw==
X-Forwarded-Encrypted: i=1; AJvYcCWvcfyNpmGa35f+k+WhUoexv1rCzecwbkiDOm0DwvdS89PnRfgq721PfA45EBSksaJ6ryBhHlY+3lIFIblhCfFBXlABjfL0j3lxDZUz
X-Gm-Message-State: AOJu0Yye5AoOnXyZLCxNr6awY+TvODiJ4HeofxIs29rUN+WykbzfEqfJ
	wt2DKPDzJd7/qblAvnHE1eAxGh8X7nVYla5UstvTgrila78yHfVd8XGVyUF+SyG5kRtC2xY5erL
	IKOewpChBJL5GaIMKVVWeMfbV46jSPc4VrAUX
X-Google-Smtp-Source: AGHT+IGD2eL/2XghUpCHqUKEbkPnmcOJzf3BqPTz3ziPXvGq8g7VzLU8+BpHMAhrOyqeO+HO3dlX/r7RudeBS6FHuX8=
X-Received: by 2002:a5d:4e0a:0:b0:341:cd0d:b78a with SMTP id
 p10-20020a5d4e0a000000b00341cd0db78amr64663wrt.48.1712853240189; Thu, 11 Apr
 2024 09:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx> <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx> <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
 <87il10ce1g.ffs@tglx> <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
 <877chfcrx3.ffs@tglx> <CAF2d9jjg0PEgPorXdrBHVkvz-fmUV7UXUPqnpQGVEvgXTpHY0A@mail.gmail.com>
 <871q7md0ak.ffs@tglx> <CAF2d9jikELOQa_9Kk+oF_=_7NZTn9DuAw=s9KQR6-EfWTiW5RQ@mail.gmail.com>
 <CAMuE1bFkmj70DO66PfvBPjM1d_JDEwTkOyz6o6wO_C0uyJ_0zw@mail.gmail.com>
In-Reply-To: <CAMuE1bFkmj70DO66PfvBPjM1d_JDEwTkOyz6o6wO_C0uyJ_0zw@mail.gmail.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Thu, 11 Apr 2024 09:33:33 -0700
Message-ID: <CAF2d9jj-kwmP+LWBBmU41Yhpmc0zE1w9UAoRHj=j-wLBSOwU5Q@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, richardcochran@gmail.com, luto@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org, 
	hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com, 
	nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org, 
	legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com, 
	casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:11=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.com=
> wrote:
>
> Hi Mahesh
> What is the status of your patch?
> if your patch is upstreamed , then it will have all I need.
> But, If not , I will upstream my patch.
> BR,
>
Hi Sagi,

If you want to pursue the syscall option, then those are tangential
and please go ahead. (I cannot stop you!)
I'm interested in getting the "tight sandwich timestamps" that
gettimex64() ioctl offers and I would want enhancements to
gettimex64() done the way it was discussed in the later half of this
thread. If you want to sign-up for that please let me know.

thanks,
--mahesh..


> On Thu, Apr 11, 2024 at 5:56=E2=80=AFAM Mahesh Bandewar (=E0=A4=AE=E0=A4=
=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=
=BE=E0=A4=B0)
> <maheshb@google.com> wrote:
> >
> > On Wed, Apr 3, 2024 at 6:48=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
de> wrote:
> > >
> > > On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=
=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=
=A4=B0) wrote:
> > > > On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> > > > The modification that you have proposed (in a couple of posts back)
> > > > would work but it's still not ideal since the pre/post ts are not
> > > > close enough as they are currently  (properly implemented!)
> > > > gettimex64() would have. The only way to do that would be to have
> > > > another ioctl as I have proposed which is a superset of current
> > > > gettimex64 and pre-post collection is the closest possible.
> > >
> > > Errm. What I posted as sketch _is_ using gettimex64() with the extra
> > > twist of the flag vs. a clockid (which is an implementation detail) a=
nd
> > > the difference that I carry the information in ptp_system_timestamp
> > > instead of needing a new argument clockid to all existing callbacks
> > > because the modification to ptp_read_prets() and postts() will just b=
e
> > > sufficient, no?
> > >
> > OK, that makes sense.
> >
> > > For the case where the driver does not provide gettimex64() then the
> > > extension of the original offset ioctl is still providing a better
> > > mechanism than the proposed syscall.
> > >
> > > I also clearly said that all drivers should be converted over to
> > > gettimex64().
> > >
> > I agree. Honestly that should have been mandatory and
> > ptp_register_clock() should fail otherwise! Probably should have been
> > part of gettimex64 implementation :(
> >
> > I don't think we can do anything other than just hoping all driver
> > implementations include gettimex64 implementation.
> >
> > > > Having said that, the 'flag' modification proposal is a good backup
> > > > for the drivers that don't have good implementation (close enough b=
ut
> > > > not ideal). Also, you don't need a new ioctl-op. So if we really wa=
nt
> > > > precision, I believe, we need a new ioctl op (with supporting
> > > > implementation similar to the mlx4 code above). but we want to save
> > > > the new ioctl-op and have less precision then proposed modification
> > > > would work fine.
> > >
> > > I disagree. The existing gettimex64() is good enough if the driver
> > > implements it correctly today. If not then those drivers need to be
> > > fixed independent of this.
> > >
> > > So assumed that a driver does:
> > >
> > > gettimex64()
> > >    ptp_prets(sts);
> > >    read_clock();
> > >    ptp_postts(sts);
> > >
> > > today then having:
> > >
> > > static inline void ptp_read_system_prets(struct ptp_system_timestamp =
*sts)
> > > {
> > >         if (sts) {
> > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > >                         ktime_get_raw_ts64(&sts->pre_ts);
> > >                 else
> > >                         ktime_get_real_ts64(&sts->pre_ts);
> > >         }
> > > }
> > >
> > > static inline void ptp_read_system_postts(struct ptp_system_timestamp=
 *sts)
> > > {
> > >         if (sts) {
> > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > >                         ktime_get_raw_ts64(&sts->post_ts);
> > >                 else
> > >                         ktime_get_real_ts64(&sts->post_ts);
> > >         }
> > > }
> > >
> > > or
> > >
> > > static inline void ptp_read_system_prets(struct ptp_system_timestamp =
*sts)
> > > {
> > >         if (sts) {
> > >                 switch (sts->clockid) {
> > >                 case CLOCK_MONOTONIC_RAW:
> > >                         time_get_raw_ts64(&sts->pre_ts);
> > >                         break;
> > >                 case CLOCK_REALTIME:
> > >                         ktime_get_real_ts64(&sts->pre_ts);
> > >                         break;
> > >                 }
> > >         }
> > > }
> > >
> > > static inline void ptp_read_system_postts(struct ptp_system_timestamp=
 *sts)
> > > {
> > >         if (sts) {
> > >                 switch (sts->clockid) {
> > >                 case CLOCK_MONOTONIC_RAW:
> > >                         time_get_raw_ts64(&sts->post_ts);
> > >                         break;
> > >                 case CLOCK_REALTIME:
> > >                         ktime_get_real_ts64(&sts->post_ts);
> > >                         break;
> > >                 }
> > >         }
> > > }
> > >
> > > is doing the exact same thing as your proposal but without touching a=
ny
> > > driver which implements gettimex64() correctly at all.
> > >
> > I see. Yes, this makes sense.
> >
> > > While your proposal requires to touch every single driver for no reas=
on,
> > > no?
> > >
> > > It is just an implementation detail whether you use a flag or a
> > > clockid. You can carry the clockid for the clocks which actually can =
be
> > > read in that context in a reserved field of PTP_SYS_OFFSET_EXTENDED:
> > >
> > > struct ptp_sys_offset_extended {
> > >         unsigned int    n_samples; /* Desired number of measurements.=
 */
> > >         clockid_t       clockid;
> > >         unsigned int    rsv[2];    /* Reserved for future use. */
> > > };
> > >
> > > and in the IOCTL:
> > >
> > >         if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
> > >                 return -EINVAL;
> > >
> > >         sts.clockid =3D extoff->clockid;
> > >
> > > and it all just works, no?
> > >
> > Yes, this should work. However, I didn't check if struct
> > ptp_system_timestamp is used in some other context.
> >
> > > I have no problem to decide that PTP_SYS_OFFSET will not get this
> > > treatment and the drivers have to be converted over to
> > > PTP_SYS_OFFSET_EXTENDED.
> > >
> > > But adding yet another callback just to carry a clockid as argument i=
s a
> > > more than pointless exercise as I demonstrated.
> > >
> > Agreed. As I said, I thought we cannot change the gettimex64() without
> > breaking the compatibility but the fact that CLOCK_REALTIME is "0"
> > works well for the backward compatibility case.
> >
> > I can spin up an updated patch/series that updates gettimex64
> > implementation instead of adding a new ioctl-op If you all agree.
> >
> > thanks,
> > --mahesh..
> >
> > > Thanks,
> > >
> > >         tglx

