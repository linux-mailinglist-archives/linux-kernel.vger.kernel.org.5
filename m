Return-Path: <linux-kernel+bounces-75323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40F85E684
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31870288B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D785276;
	Wed, 21 Feb 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3pUDBBh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1B85275
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540874; cv=none; b=IO90c78BUKaZNH+b8YQgD2jPmE+Rto3W4aoKvpg2uR4diAOTmcj78hxdVVsNw+OsApm/MxWjqjuW49AKpJ2g1pqrIBUU34AifVCV5/PRdfhOHx2lsL4ngdi95tMnP/4M+Gv6x7vwSnJ9J4/3y7iETm5kyr+j5fMVb9ltohZI70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540874; c=relaxed/simple;
	bh=qoRTyEELbWf2nDMxqqkDGPdA78HiotxsFiUP1rN/C7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDD8sFBWQpcNhXGGX7nmBvesJwYToN8t2K8MB+kjHejcsOp7TRLW+6YU7ca6cH5gLGJvK+tvPjevpBS5xP6bhp++pmtDZwzXBfg/hbYWLWEnOpSdlYT0vnTbByHhGsEZEHZvX7dg0o5pKgMm92k+ARF3edBG6sPtOWPTQ9+8B8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3pUDBBh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so1504a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708540871; x=1709145671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv9wNDwhY/zzzSGkgxd05pBE2QIgBpN8eK7x1JDY4VQ=;
        b=p3pUDBBh1iYee1IdYIHLIDnMhVNw+Z+WYqekHCye3dJyztDCVLWaOAoYUD2lb8KBrM
         sDQrxdZByzKI0W0gIpaqPp6H0RsqDB21aaSsnW1KrHDjUQHdOrzd2oFm0vbeY+TdbFmw
         fYXBZUvUAz7jOwStAM4VDVRVdQVd4RBw1lwi/nrOkeWcrMSOWzZchiW7vY4WtPwjKCFp
         ZdwaG1gfogBTLCn7fE1Iy3S9Eb7qo8I9PF4JvHOnXKos+ibLC/k3L2P+kbaupflfXP1u
         WHuBZPbfzgflf0dc25ckRXi6pDhlvUKrwD9f64YPPf9YC9qGAn3KvhGu7jOw9D2ISkKX
         HhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540871; x=1709145671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv9wNDwhY/zzzSGkgxd05pBE2QIgBpN8eK7x1JDY4VQ=;
        b=kKUcux6DnuQKfugli2KnHJbxpq3N/hbAPiHc9EJEu8cQLW/8lNxFxi9BDPWZBA5si1
         qvAP3U+uxgesEGBQ5rDGQsEwKOjkgA/ysLoZAYZDhzaeOem5p9D3/QLhjfYxvt6rJgJD
         /HmuumcoWpxL3L8NN/5IU/42nJWuE00WKlTLFkxfTQN0KiwdoFIU5fQMR6c1PjPnTgz3
         tthsyum43Yu9msFFgmOr3Z23a/zImy7Vun8rk0OD0NcHMKb5FjzoAmPseFQOyGUVnR7g
         jLU+VLDUnAixiXcD4VqQVLzsScoIjwU8NFmnyUPsjeIw9vZyzbzdEQaUcBzQbEXSw+rs
         gRQw==
X-Forwarded-Encrypted: i=1; AJvYcCVCd0nAX412CEoS42DGoxGRW0bnOtiakEpTOdTzLKkqO+Qkw4UE8S07Xx68BPfBKDUNfy4gsT7H1yr+tBeuqFSgnWyXV+2KaxoP5qUF
X-Gm-Message-State: AOJu0YxkzTQh9m8tTijQxiRX21Lfy4OuVo2TB7tsrUC1YpsPIW3j5SDn
	nV70ipiKimeZmAGLveMqbtJxXucFBG2Vvua/ew0ME/aijYzMw7Oft/vja4qdo5d/+Zk5/a/rvNS
	uMant6YjImmRoyC4sBRBmIbXYLpHkt/LKrfhV
X-Google-Smtp-Source: AGHT+IFlqvWCLYWfIXoOAqJEG+1uPRMx93XsoiRtMZd3ud54ukDSxyqCmg+oHcD9kh3xXJy/x3GBJSXA8DNg3jnrKac=
X-Received: by 2002:a50:f615:0:b0:564:e627:9e22 with SMTP id
 c21-20020a50f615000000b00564e6279e22mr253194edn.4.1708540870884; Wed, 21 Feb
 2024 10:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221164112.846409-1-vilasbhat@google.com> <20240221121420.2e32fd00@gandalf.local.home>
 <CAJNZHTTeFJvCjxUX_e_RVtJWcXW=1cjdF8EqvojnObm7jiyLKg@mail.gmail.com> <20240221133510.70b9c205@gandalf.local.home>
In-Reply-To: <20240221133510.70b9c205@gandalf.local.home>
From: Vilas Bhat <vilasbhat@google.com>
Date: Wed, 21 Feb 2024 10:40:58 -0800
Message-ID: <CAJNZHTRmxm-s=4ytRinS4pBxNsSkBqLMyXjRnwWfAm0HzRw43Q@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: add tracepoint for runtime_status changes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Saravana Kannan <saravanak@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:33=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 21 Feb 2024 09:57:03 -0800
> Vilas Bhat <vilasbhat@google.com> wrote:
>
> > > You could do what everyone else does:
> > >
> > > #define RPM_STATUS_STRINGS                      \
> > >         EM( RPM_INVALID, "RPM_INVALID" )        \
> > >         EM( RPM_ACTIVE, "RPM_ACTIVE" )          \
> > >         EM( RPM_RESUMING, "RPM_RESUMING" )      \
> > >         EM( RPM_SUSPENDED, "RPM_SUSPENDED" )    \
> > >         EMe( RPM_SUSPENDING, "RPM_SUSPENDING" )
> > >
> > > #undef EM
> > > #undef EMe
> > > #define EM(a, b)        TRACE_DEFINE_ENUM(a);
> > > #define EMe(a, b)       TRACE_DEFINE_ENUM(a);
> > >
> > > RPM_STATUS_STRINGS
> > >
> > > #undef EM
> > > #undef EMe
> > > #define EM(a, b)        { a, b },
> > > #define EMe(a, b)       { a, b }
> > >
> >
> > Thanks for the comment, Steven. I did notice both methods of defining
> > enum values for tracepoints and chose this method because it felt
> > clearer. Could you clarify on why the method you suggested is
> > preferred?
> >
>
> Sure. One big reason: It removes duplication.
>
> If you add another enum to the list, you only need to update it in one
> place. And it prevents the two from getting out of sync.
>
> -- Steve

That makes sense! Thanks. I will revise the patch and send a new version so=
on.

