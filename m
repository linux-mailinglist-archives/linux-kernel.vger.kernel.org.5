Return-Path: <linux-kernel+bounces-99611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA4878ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A95E1F22114
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390675788F;
	Mon, 11 Mar 2024 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cueJJ8Kv"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3057306
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196124; cv=none; b=VljNUy4JmzcvOx+Ai/CtoPl/dDgc3GpqdugoeiWVDr6tiL71wSb5YF08BMRgkRqHErfzsiEfbjFxd8uSoj6IRV0v6YQA9ipTRtatCnUvyorFF1+Qf+4jmaB4qG5B9Vqu1OTtc8LKGaYjdpfC388Rg0+miU+Tsy6aOVPg5qhkzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196124; c=relaxed/simple;
	bh=asVmqVidTEc9OS2n8SyaaS+W2FyZ4fww08wr2TcpZ0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ4VcVmcsMgajlqLua4EPLb4jMvDZla5Gut3RkxGxDQ4bucTkVKjEpKA7+5zGsdzAHvlz6NhzyKutU6Wr+8xslYXrTvxVfVeZggJH25SOqXwcx+mPcm0dO+JEFDLKagzEL3ceK7XvoCdt0VMAQpeeBPXjqbvwMT1htrxcSTxqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cueJJ8Kv; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a046c5262so31439567b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710196122; x=1710800922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0Txb94OJ7hs7tfFRmMyIrRYkzaZsNZOSHys/hiIups=;
        b=cueJJ8KvhD8VUbXWy0KB1jVBuwp939q/R8CFowGt9YhMSxxvt2XXXkFm73xOjywiKp
         V0f+NQbZYetaQ/0ZAI53BpxQQKQjJaMKOqTZ/V+iI1ftuDOyzuKoMa8fEe1uhZwIwK6U
         RjRC+ODvTVpB/TsDP3o0j2DVu1pQazXaox+lp01kdGJjG5o6GgLxCPj5oo1rxNSekDjz
         HYBoom5Bi7fX0Bl87NC3QcGWucbe0gpTw4aSROicflGuq5dk1utkCDxXDbeEF2F44J4m
         +oV6UcLPxB8hPpbBJqGKa6XyoJ6s6YDlIResPIuFBWo/FrbzGyJ03wfVU1K1CuGcv/rT
         AAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196122; x=1710800922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0Txb94OJ7hs7tfFRmMyIrRYkzaZsNZOSHys/hiIups=;
        b=w1munPwINjnO7KpwUMno8jXDcmKlz+wcdOb9+jsMVF/A9pF2GBCgrCRU6Qi6+5oElu
         dCm5MxQUDCVFm8lSEHjtSr9XyGH025EbX8eVDfX5fFHTLXcqg0g83YkZJiNFiSVDtfqK
         LgyMjnBrg11du6lS0/p4Dc2SnipcQKgf7NWLdth+EVB07wXpzTBtgNwjecjZ0rSiqhGZ
         Wjr8BAsoHlevhSmqLpS9Hm2aGCiHt0sF+2PjiJZrOUdkf7PGiEn3sNA/LB6M7OvatO+9
         4/Kw9q14YqIt8HTxL+d+A86XCmY7hSp4KFVjtxSIoYE344MHmkMTcYIWjydS9h07NWdV
         jrCg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRvmO9SS9Fh5VZsw2UO+gDVfywiYngsb+AXZcAyGujNiNYweMTQe4EiMc/42mPgt1Ao7UABfXD1j1oUzXayh3gL76t0zVDB9jBKdF
X-Gm-Message-State: AOJu0YwYjjrIwJk0dOjHiUsxK2Hs0d+nVVclmgmzKda39Pw7XaVwgQaS
	DXFPgEs4DeeV3RImDY4wRrFFQ4owS/lSXisj8iKNDnfx3rKz0V3GxT+ps8P8aOrlHrfGsKBhIPl
	FKs1Yu5U8BTFPwh4YTZb9BaZT7iieewV+Aoyi
X-Google-Smtp-Source: AGHT+IFkjV1f8hMHRyB1TAhaJ/A2QrLDjirsohIM262dKP47DUGZkxQitfL2dcRKha3oni1+rS4cbxLejs71fpkTj4g=
X-Received: by 2002:a0d:ca84:0:b0:60a:2143:1b0e with SMTP id
 m126-20020a0dca84000000b0060a21431b0emr6505096ywd.13.1710196121755; Mon, 11
 Mar 2024 15:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com> <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com> <Ze8fYF5I4mlUGHd9@x1n>
 <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com>
 <Ze9bWkrD6UBZ2ErV@x1n> <CADrL8HW59nt4ztY3x5G3VgpmaXQbXoXZeAjvzMp7SpsqxgDCxw@mail.gmail.com>
In-Reply-To: <CADrL8HW59nt4ztY3x5G3VgpmaXQbXoXZeAjvzMp7SpsqxgDCxw@mail.gmail.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 11 Mar 2024 15:28:28 -0700
Message-ID: <CACw3F51vMqPBHmvj4ehSA8PadXw30s3MxCqph1op5dxtB-tV6Q@mail.gmail.com>
Subject: Re: BUG selftests/mm]
To: James Houghton <jthoughton@google.com>
Cc: Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Hildenbrand <david@redhat.com>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:27=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> On Mon, Mar 11, 2024 at 12:28=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > On Mon, Mar 11, 2024 at 11:59:59AM -0700, Axel Rasmussen wrote:
> > > I'd prefer not to require root or CAP_SYS_ADMIN or similar for
> > > UFFDIO_POISON, because those control access to lots more things
> > > besides, which we don't necessarily want the process using UFFD to be
> > > able to do. :/
>
> I agree; UFFDIO_POISON should not require CAP_SYS_ADMIN.

+1.


>
> > >
> > > Ratelimiting seems fairly reasonable to me. I do see the concern abou=
t
> > > dropping some addresses though.
> >
> > Do you know how much could an admin rely on such addresses?  How freque=
nt
> > would MCE generate normally in a sane system?
>
> I'm not sure about how much admins rely on the address themselves. +cc
> Jiaqi Yan

I think admins mostly care about MCEs from **real** hardware. For
example they may choose to perform some maintenance if the number of
hardware DIMM errors, keyed by PFN, exceeds some threshold. And I
think mcelog or /sys/devices/system/node/node${X}/memory_failure are
better tools than dmesg. In the case all memory errors are emulated by
hypervisor after a live migration, these dmesgs may confuse admins to
think there is dimm error on host but actually it is not the case. In
this sense, silencing these emulated by UFFDIO_POISON makes sense (if
not too complicated to do).

SIGBUS (and logged "MCE: Killing %s:%d due to hardware memory
corruption fault at %lx\n") emit by fault handler due to UFFDIO_POISON
are less useful to admins AFAIK. They are for sure crucial to
userspace / vmm / hypervisor, but the SIGBUS sent already contains the
poisoned address (in si_addr from force_sig_mceerr).

>
> It's possible for a sane hypervisor dealing with a buggy guest / guest
> userspace to trigger lots of these pr_errs. Consider the case where a
> guest userspace uses HugeTLB-1G, finds poison (which HugeTLB used to
> ignore), and then ignores SIGBUS. It will keep getting MCEs /
> SIGBUSes.
>
> The sane hypervisor will use UFFDIO_POISON to prevent the guest from
> re-accessing *real* poison, but we will still get the pr_err, and we
> still keep injecting MCEs into the guest. We have observed scenarios
> like this before.
>
> >
> > > Perhaps we can mitigate that concern by defining our own ratelimit
> > > interval/burst configuration?
> >
> > Any details?
> >
> > > Another idea would be to only ratelimit it if !CONFIG_DEBUG_VM or
> > > similar. Not sure if that's considered valid or not. :)
> >
> > This, OTOH, sounds like an overkill..
> >
> > I just checked again on the detail of ratelimit code, where we by defau=
lt
> > it has:
> >
> > #define DEFAULT_RATELIMIT_INTERVAL      (5 * HZ)
> > #define DEFAULT_RATELIMIT_BURST         10
> >
> > So it allows a 10 times burst rather than 2.. IIUC it means even if
> > there're continous 10 MCEs it won't get suppressed, until the 11th came=
, in
> > 5 seconds interval.  I think it means it's possibly even less of a conc=
ern
> > to directly use pr_err_ratelimited().
>
> I'm okay with any rate limiting everyone agrees on. IMO, silencing
> these pr_errs if they came from UFFDIO_POISON (or, perhaps, if they
> did not come from real hardware MCE events) sounds like the most
> correct thing to do, but I don't mind. Just don't make UFFDIO_POISON
> require CAP_SYS_ADMIN. :)
>
> Thanks.

