Return-Path: <linux-kernel+bounces-145656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08AD8A5910
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD111F218CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838F84055;
	Mon, 15 Apr 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bwFWhG1T"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0682C8E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201829; cv=none; b=oykWS4yEBKS07WdXNCmSnwwQnndJIu3Ai1URyrurhK/SiYTPkV7eR7TP7ARBhnG2KO10tXVX7berP4k3ztb6UJfOXJ48FuiyfUo5iCHsZAKtwCIEBH0p7nozncZBCAbaSjD6ZtnMHn4dlodAQa4BebgJuNEVWEQ6FQ2OUfanH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201829; c=relaxed/simple;
	bh=j8Ejk7XlN8U0gLFQ+w52S6Yoi2F5YcV3bmne30m1U5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdW22kRGS72+yAI7BlfaRASui+152ZdAIKGgyqxuLk9S1PZ5SR2k12w6d2+Jt3Nx2Q9HOlnZTFq/UjwMEsOPfggKYqj/GD45HIzvwTqT0iByUsfxgePqAlXn2M9JmSfVAXU/ulxyDgtlCPRks1V84s4BGGcZXIC82AZnA1lTA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwFWhG1T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso2699328f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713201826; x=1713806626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE1nSU8HKB2kPpF0hmGiIYOASbvx15IOwyQmsslpiPc=;
        b=bwFWhG1TchWH8jyyyKykDA9PLI4eCsju12tUOX6igme5XAKUR4SmiDXa8jDwfXEjxw
         nZEp2ozHki/c9GH1YxhgQLSl+vXmViJydy8VoJ0gaGJmFYh/vyhXYf1W+qCJjd1iww6p
         ORafROfGVlULIkj1wv5hDk/n6RLcU1Nsc9EVpY6OOB2aK5dcFF+oPKoOHz7EoWk7WodT
         CZ/O1ytgWnrVGXOLuY3CHeP5G8Hij9OPP14ip+qPIoQkdH8mul8BjvwlaLR+y7MEQGNo
         jXFWWJIaWk7F957hI7N37p/CS3u0yv1XFQiwqzHRbdsDjDY8UivQ81/5yhwUwevhvoUW
         5LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201826; x=1713806626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE1nSU8HKB2kPpF0hmGiIYOASbvx15IOwyQmsslpiPc=;
        b=TmmTTGDvuxQVs3PX3/EWMQtZfJe4wU3wdwuuMyKuLdHe6Tfo/dsE8pWvX+4Y/nI8x5
         EhnGp+f0Eo9p+Y7DKqdLf/Y319t56V66m+4oMxJ0ZryXeK0GLIgHYMMqhBYaZ4zONBdb
         ZMlnP4KoE+VzumBnY4GSs2jSUrXyl3wFrKEX85M13PYKrdYEjFQnUxdXmTfbp7HCRHoO
         36EFpYwZabPwAjOIXC9SXsGziteXWWnRdq+ZCde2KFvLBMGWdD5ntrkdiSoKxLWzrrJ3
         p5jFJmrp6WJLGNIHsmpZFbGEzsQX26ueX1b4bV2MXI8yCbfzufVwOC5CMnX1v0VrI59t
         VvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxyGHiec+hKsIbECdFp0CIgiN5UQ/QZvMvR/8yhA4ZykjGeAYsflxeJRJp8pM/40NKhVkHWJYQNU+VrMA096IHuWgcZEOaEmKJTuLp
X-Gm-Message-State: AOJu0Yyp47YdNlYVDYPJINX7lWUDTS8n4dykMTsdMpjC4gBNJcn05/Wn
	vOYfIje+LQytfwFKW5ilkM9byGT9eWV40RrYzDAx8U9cOdfiGCxBIKxxxH+6dFSeR7p7iVwpVw8
	z8upoXV1Sp5djsQndKDNe3pt5l7HWjTONtEQ5
X-Google-Smtp-Source: AGHT+IFu1DphvQ5XdgKRE8jIoGSzGoHMBn4Thm2CBrA3RTBYwGVlKoK1XPZOMza9XiN0iD2wW3sl5UOWFegP9uT3qfU=
X-Received: by 2002:a5d:58c2:0:b0:343:6704:93b7 with SMTP id
 o2-20020a5d58c2000000b00343670493b7mr7716459wrf.59.1713201825453; Mon, 15 Apr
 2024 10:23:45 -0700 (PDT)
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
 <CAF2d9jj-kwmP+LWBBmU41Yhpmc0zE1w9UAoRHj=j-wLBSOwU5Q@mail.gmail.com> <CAMuE1bFomKFTz+E9=4=F8r0DOoPdjZYt4ofubJgXGP0rpEjnqA@mail.gmail.com>
In-Reply-To: <CAMuE1bFomKFTz+E9=4=F8r0DOoPdjZYt4ofubJgXGP0rpEjnqA@mail.gmail.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 15 Apr 2024 10:23:17 -0700
Message-ID: <CAF2d9jg0X_HKSZbiwPTEXdmrhY49D1zfT3Q4xzNAqv1z+TYXtA@mail.gmail.com>
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

On Sun, Apr 14, 2024 at 5:22=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.com>=
 wrote:
>
> On Thu, Apr 11, 2024 at 7:34=E2=80=AFPM Mahesh Bandewar (=E0=A4=AE=E0=A4=
=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=
=BE=E0=A4=B0)
> <maheshb@google.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 12:11=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail=
com> wrote:
> > >
> > > Hi Mahesh
> > > What is the status of your patch?
> > > if your patch is upstreamed , then it will have all I need.
> > > But, If not , I will upstream my patch.
> > > BR,
> > >
> > Hi Sagi,
> >
> > If you want to pursue the syscall option, then those are tangential
> > and please go ahead. (I cannot stop you!)
> > I'm interested in getting the "tight sandwich timestamps" that
> > gettimex64() ioctl offers and I would want enhancements to
> > gettimex64() done the way it was discussed in the later half of this
> > thread. If you want to sign-up for that please let me know.
> Hi Mahesh
> I do need to modify the  PTP_SYS_OFFSET_EXTENDED ioctl for cases which
> gettimex64
> not supported by the driver (look at Thomas suggestion), but I need
> your changes in ptp_read_system_prets.
> I like to add my changes above your changes, so we won't do duplicate wor=
k.
> please show me your latest patch and the status of it
> Once you have upstream yours , I will add my changes on the next patch.

OK, in that case let me post the patch since your changes would need
pieces from it.

thanks,
--mahesh..

> BR
> Sagi
>
> >
> > thanks,
> > --mahesh..
> >
> >
> > > On Thu, Apr 11, 2024 at 5:56=E2=80=AFAM Mahesh Bandewar (=E0=A4=AE=E0=
=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=
=A4=BE=E0=A4=B0)
> > > <maheshb@google.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 6:48=E2=80=AFAM Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> > > > >
> > > > > On Tue, Apr 02 2024 at 16:37, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=
=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=
=E0=A4=B0) wrote:
> > > > > > On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@li=
nutronix.de> wrote:
> > > > > > The modification that you have proposed (in a couple of posts b=
ack)
> > > > > > would work but it's still not ideal since the pre/post ts are n=
ot
> > > > > > close enough as they are currently  (properly implemented!)
> > > > > > gettimex64() would have. The only way to do that would be to ha=
ve
> > > > > > another ioctl as I have proposed which is a superset of current
> > > > > > gettimex64 and pre-post collection is the closest possible.
> > > > >
> > > > > Errm. What I posted as sketch _is_ using gettimex64() with the ex=
tra
> > > > > twist of the flag vs. a clockid (which is an implementation detai=
l) and
> > > > > the difference that I carry the information in ptp_system_timesta=
mp
> > > > > instead of needing a new argument clockid to all existing callbac=
ks
> > > > > because the modification to ptp_read_prets() and postts() will ju=
st be
> > > > > sufficient, no?
> > > > >
> > > > OK, that makes sense.
> > > >
> > > > > For the case where the driver does not provide gettimex64() then =
the
> > > > > extension of the original offset ioctl is still providing a bette=
r
> > > > > mechanism than the proposed syscall.
> > > > >
> > > > > I also clearly said that all drivers should be converted over to
> > > > > gettimex64().
> > > > >
> > > > I agree. Honestly that should have been mandatory and
> > > > ptp_register_clock() should fail otherwise! Probably should have be=
en
> > > > part of gettimex64 implementation :(
> > > >
> > > > I don't think we can do anything other than just hoping all driver
> > > > implementations include gettimex64 implementation.
> > > >
> > > > > > Having said that, the 'flag' modification proposal is a good ba=
ckup
> > > > > > for the drivers that don't have good implementation (close enou=
gh but
> > > > > > not ideal). Also, you don't need a new ioctl-op. So if we reall=
y want
> > > > > > precision, I believe, we need a new ioctl op (with supporting
> > > > > > implementation similar to the mlx4 code above). but we want to =
save
> > > > > > the new ioctl-op and have less precision then proposed modifica=
tion
> > > > > > would work fine.
> > > > >
> > > > > I disagree. The existing gettimex64() is good enough if the drive=
r
> > > > > implements it correctly today. If not then those drivers need to =
be
> > > > > fixed independent of this.
> > > > >
> > > > > So assumed that a driver does:
> > > > >
> > > > > gettimex64()
> > > > >    ptp_prets(sts);
> > > > >    read_clock();
> > > > >    ptp_postts(sts);
> > > > >
> > > > > today then having:
> > > > >
> > > > > static inline void ptp_read_system_prets(struct ptp_system_timest=
amp *sts)
> > > > > {
> > > > >         if (sts) {
> > > > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > > > >                         ktime_get_raw_ts64(&sts->pre_ts);
> > > > >                 else
> > > > >                         ktime_get_real_ts64(&sts->pre_ts);
> > > > >         }
> > > > > }
> > > > >
> > > > > static inline void ptp_read_system_postts(struct ptp_system_times=
tamp *sts)
> > > > > {
> > > > >         if (sts) {
> > > > >                 if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
> > > > >                         ktime_get_raw_ts64(&sts->post_ts);
> > > > >                 else
> > > > >                         ktime_get_real_ts64(&sts->post_ts);
> > > > >         }
> > > > > }
> > > > >
> > > > > or
> > > > >
> > > > > static inline void ptp_read_system_prets(struct ptp_system_timest=
amp *sts)
> > > > > {
> > > > >         if (sts) {
> > > > >                 switch (sts->clockid) {
> > > > >                 case CLOCK_MONOTONIC_RAW:
> > > > >                         time_get_raw_ts64(&sts->pre_ts);
> > > > >                         break;
> > > > >                 case CLOCK_REALTIME:
> > > > >                         ktime_get_real_ts64(&sts->pre_ts);
> > > > >                         break;
> > > > >                 }
> > > > >         }
> > > > > }
> > > > >
> > > > > static inline void ptp_read_system_postts(struct ptp_system_times=
tamp *sts)
> > > > > {
> > > > >         if (sts) {
> > > > >                 switch (sts->clockid) {
> > > > >                 case CLOCK_MONOTONIC_RAW:
> > > > >                         time_get_raw_ts64(&sts->post_ts);
> > > > >                         break;
> > > > >                 case CLOCK_REALTIME:
> > > > >                         ktime_get_real_ts64(&sts->post_ts);
> > > > >                         break;
> > > > >                 }
> > > > >         }
> > > > > }
> > > > >
> > > > > is doing the exact same thing as your proposal but without touchi=
ng any
> > > > > driver which implements gettimex64() correctly at all.
> > > > >
> > > > I see. Yes, this makes sense.
> > > >
> > > > > While your proposal requires to touch every single driver for no =
reason,
> > > > > no?
> > > > >
> > > > > It is just an implementation detail whether you use a flag or a
> > > > > clockid. You can carry the clockid for the clocks which actually =
can be
> > > > > read in that context in a reserved field of PTP_SYS_OFFSET_EXTEND=
ED:
> > > > >
> > > > > struct ptp_sys_offset_extended {
> > > > >         unsigned int    n_samples; /* Desired number of measureme=
nts. */
> > > > >         clockid_t       clockid;
> > > > >         unsigned int    rsv[2];    /* Reserved for future use. */
> > > > > };
> > > > >
> > > > > and in the IOCTL:
> > > > >
> > > > >         if (extoff->clockid !=3D CLOCK_MONOTONIC_RAW)
> > > > >                 return -EINVAL;
> > > > >
> > > > >         sts.clockid =3D extoff->clockid;
> > > > >
> > > > > and it all just works, no?
> > > > >
> > > > Yes, this should work. However, I didn't check if struct
> > > > ptp_system_timestamp is used in some other context.
> > > >
> > > > > I have no problem to decide that PTP_SYS_OFFSET will not get this
> > > > > treatment and the drivers have to be converted over to
> > > > > PTP_SYS_OFFSET_EXTENDED.
> > > > >
> > > > > But adding yet another callback just to carry a clockid as argume=
nt is a
> > > > > more than pointless exercise as I demonstrated.
> > > > >
> > > > Agreed. As I said, I thought we cannot change the gettimex64() with=
out
> > > > breaking the compatibility but the fact that CLOCK_REALTIME is "0"
> > > > works well for the backward compatibility case.
> > > >
> > > > I can spin up an updated patch/series that updates gettimex64
> > > > implementation instead of adding a new ioctl-op If you all agree.
> > > >
> > > > thanks,
> > > > --mahesh..
> > > >
> > > > > Thanks,
> > > > >
> > > > >         tglx

