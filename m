Return-Path: <linux-kernel+bounces-127408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B4894AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D294C282C8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B941863C;
	Tue,  2 Apr 2024 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdF17KqP"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8411803A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036597; cv=none; b=KJp4LvBqV5AQ7cAXeJu3vchgk0GsdEYb0j2Cg8IC08uW7drUgZmL1nmnYWDN4OXO+QVtvBhzb9bvjSkO+TIoq7mVv86RXASiG8qt+VdxCqZo08SEeUNn59IVkVu6vbUM0LoPcjF8HyQViVp5EJzR5Ja8rmY45bn/ePRPtitdLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036597; c=relaxed/simple;
	bh=TUTob1DnNgGtqXSzjC4an0vYfwqKWZaOUgtv0d79Qg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX5VGvdcpHsYy0XuqupP71LzwOR9I4TVG4J4amT+tl9V8qheyaoK9yAoaqg0o/46aLz9LNbBQq7nivSPPprfon7d9Q66MGQVm68YorQ19un+BaewvyQ6/z1zigdc21jLDFmpQyf/s5myZoP+o8BlAhyJAEotIwHmIYXU48D3StQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdF17KqP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34373f95c27so3392f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712036593; x=1712641393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElrucjJAh1FRwBd0ssTMvr49phQYXRtbH2c4ZoKFETc=;
        b=mdF17KqPWzUXi44pvLWiCXHsxC4lgDW4fYhIGlK41QvC0UkbKU7vLQ1Kqz9eo3sc79
         8+GicARFNnhQnzCJQIVTy23JXkEFhHDFUKrng6oJuuMqd2XyBhJvoy2gWZvXufKYhZQm
         Cs5HHYs2mB3z0gRVTl6het1PY0idC7nSnpGoCQDz4Z/4Z4Uj77ey2c7ZaP/iTvSzSMlH
         U8QY8VqwvPL34njBwvFbeP+WEFCfozc1xywKFLRtV/6fcbqvFzVN8HK648UhOIAsVVJh
         /tk7FsfNoitJMOYqEh3DR261aMdgYxMMI3mJlPtBD9Z47PHakAEGndtBSNqgKXJRzolp
         XWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712036593; x=1712641393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElrucjJAh1FRwBd0ssTMvr49phQYXRtbH2c4ZoKFETc=;
        b=XT5gQKym2kZ6EcDFe6vnfWf2D1PLyW8R0+lezH0vJQR4npuUlKyJSNd8KgdZ1BJGBg
         oL0uPq0aC5BaWiftL8Ihr/72hTVM4oq5eDEjy3yMeY3RyyOtUK+FGy1IruZvesb2hvOO
         wVyp1fYNaJIPkJ+Yto0ON1qo/j1oby/m3pG9F78dEbV2ZBKkAq2zhRAeEUu5sOTlmG3/
         tMMKUtNPC+1PzqMcm5oJ6sq6odHqD6rAGsZ6KXITu/odWrhx0y7y7nM7wurk5gIeDw6b
         PtEzeX9rMG7KdzhS7CKGKoRG/V+8VqrV4/XW93G40SRyIMPKAhj7R8m1YFyp2NCFLEtJ
         HRHA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1UDfPumXozFZWaEZ1WAnm8dNuwkp0bs72pXf6awN/uLJ9j1DcKYq/5aHHVrZjfDjAPquqgJ9mu2u4AtZWxBMOGifdt4aWtLY95TJ
X-Gm-Message-State: AOJu0Yy1B5rfz6A2oE3VN+Nn9pR2oKVTS3iA30a0iRL2Zbnc4VeYGXzk
	7VMZXRxjbGx653r0bGoKOq8A/3X1k/1i23XxDpn0FSIW7c3REWscVODHwLmORch+yb6lCuUTr5J
	W86uRbH4o4DpqqGeFDkRf7XFhSPUX9DEBrRav
X-Google-Smtp-Source: AGHT+IFiBqJRjrw72zSUpiTWSfBG18M5uU9g2uQeWa4ZYJfGErQRY1gN3b2iLLy53yu4DnLzCKNFKFKedUna4nqcdtw=
X-Received: by 2002:adf:eb82:0:b0:341:a13d:4f73 with SMTP id
 t2-20020adfeb82000000b00341a13d4f73mr8208252wrn.0.1712036593542; Mon, 01 Apr
 2024 22:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx> <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx>
In-Reply-To: <87o7asdd65.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 1 Apr 2024 22:42:47 -0700
Message-ID: <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com, luto@kernel.org, 
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

On Mon, Apr 1, 2024 at 1:46=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> Sagi!
>
> On Thu, Mar 28 2024 at 17:40, Sagi Maimon wrote:
> > On Sat, Mar 23, 2024 at 2:38=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> On top this needs an analyis whether any of the gettimex64()
> >> implementations does something special instead of invoking the
> >> ptp_read_system_prets() and ptp_read_system_postts() helpers as close =
as
> >> possible to the PCH readout, but that's not rocket science either. It'=
s
> >> just 21 callbacks to look at.
> >>
> > I like your suggestion, thanks!
> > it is what our user space needs from the kernel and with minimum kernel=
 changes.
> > I will write it, test it and upload it with your permission (it is you
> > idea after all).
>
> You don't need permission. I made a suggestion and when you are doing the
> work I'm not in a position to veto posting it. We have an explicit tag
> for that 'Suggested-by:', which only says that someone suggested it to
> you, but then you went and implemented it, made sure it works etc.
>
> >> It might also require a new set of variant '3' IOTCLS to make that fla=
g
> >> field work, but that's not going to make the change more complex and
> >> it's an exercise left to the experts of that IOCTL interface.
> >>
> > I think that I understand your meaning.
> > There is a backward compatibility problem here.
> >
> > Existing user space application using PTP_SYS_OFFSET_EXTENDED ioctl
> > won't have any problems because of the "extoff->rsv[0] ||
> > extoff->rsv[1] || extoff->rsv[2]" test, but what about all old user
> > space applications using: PTP_SYS_OFFSET ?
>
> So if there is a backwards compability issue with PTP_SYS_OFFSET2, then
> you need to introduce PTP_SYS_OFFSET3. The PTP_SYS_*2 variants were
> introduced to avoid backwards compatibility issues as well, but
> unfortunately that did not address the reserved fields problem for
> PTP_SYS_OFFSET2. PTP_SYS_OFFSET_EXTENDED2 should just work, but maybe
> the PTP maintainers want a full extension to '3'. Either way is fine.
>
https://patchwork.kernel.org/project/netdevbpf/patch/20240104212436.3276057=
-1-maheshb@google.com/

This was my attempt to solve a similar issue with the new ioctl op to
avoid backward compatibility issues.  Instead of flags I used the
clockid_t in a similar fashion.

Thanks,

> Thanks,
>
>         tglx
>
>

