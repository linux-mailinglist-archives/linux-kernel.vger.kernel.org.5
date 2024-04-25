Return-Path: <linux-kernel+bounces-159203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997108B2A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218F12881CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC8E155727;
	Thu, 25 Apr 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+Nkbu5j"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B126153812
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080116; cv=none; b=bP1LczdnglgT1P4j/0VfQkuNeqoNog4CkTmjLTkGBGXks3enkKhYkJVQKPVJIDftWxqLRgWy8TOyezgcMPC3fVQGI4UnB3raZa1RTGKzIiSfX4g94pf+ttaToNhL0evX4E0dcMX1V60gzLjfXOfDVD/rxKC1nruWCn8PEm2optk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080116; c=relaxed/simple;
	bh=EtyD5p99BjrJVApkdHs/OLSBEw2UhzUQPdUV6pMX96A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUJdKmpsfROGdT7huOU1qLGm4GtGeZps1oNs5pwst3JPKNA06r89akOq4H6nJ2rEg9iSv/b4P5VCKJwJW4yStl4SyHU8Lv2ea7LfKEYUfaWDqWnvZOYRGVzdJ7nVDGYEU7ErQ+/5i9K4oz4S5y1iGu+dGBNl5ZlMHCK1AtUQ1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+Nkbu5j; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de596c078c2so1040394276.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714080113; x=1714684913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtyD5p99BjrJVApkdHs/OLSBEw2UhzUQPdUV6pMX96A=;
        b=F+Nkbu5jzLtxQh5LXBTgmBP/y15qUeT3AaBpM7Ior41a80quLB2bUKC7vlhI6iVQ8p
         G3LYGQkKWHvUP+7Ea1A92SLf+Yu5raisfuGUisESiII1QjvLqoBK3zjBa/rjLmo1eJT4
         X6nXT6VP/RjrBH+4XmHxvmFKZ7AeBslB3qSorVtBKlTyOfA9Fyb7dCp4KJExgRXL0eao
         PHhOw7oL6GjdP0qdmDI9/v4vxr/X2z/6EX/MxXz4VjT0AiW1tomOmLTeemTn+IlYQUbU
         2CuZfPiILWyNQFHorkCVDsF9LUHFxRLyAXZTuoTru0Yhzz0Q2sXy/oW1iLJIA0z6xP2Z
         ATXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080113; x=1714684913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtyD5p99BjrJVApkdHs/OLSBEw2UhzUQPdUV6pMX96A=;
        b=PRKInVog+EuOunhrDp2aOwxW1TSIOHf1hajZduRI4WzOn/b8pse+9uCTSRo98ZTqxx
         o9YJfQMb6tZ2OWIpc5d2YzBm9+ItwIxFn15h4fNioYkwge/UKxWFlrf/Ed5A5ZVwGRTF
         HEQ+f/tyrcA5gJX8AVoedtGa9PjR34MeFKnHQmTDoHwe+OcMJIb6NiDAnSkEW6n1Arj/
         c9zPA6kI5PnpKDyRTnJaSYbxa4IBTfv6nfNeek+lXkfhsUcd74PTt1h0DqlV6vZkbGpv
         6dUcav9NgcwWEPZwO2t58FZ/M7rd2L56G5pBynbLWHhAW00Fdp66x1jaMQBAwwgeacPO
         uSAA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ppkfU1VX0PBw+wZ1/NISApB6c1LIZe78NzbpICNDSFLzNtvJ8JG8bSCBD3AXKTab2sYciIkwqtN4gKjmPNoy72ZGoKiJbhc136/n
X-Gm-Message-State: AOJu0YxJ2apzW7tkxS9K6LyVCrFi/wFCgilkMiiGTf1bcu9uOJ0DfDlv
	Jgb5fSXucZRjHabVU6w6RkV5rg1m/UwqZ25j2ggG0Zfgt4WfDGnntSk30OG1fdTgIBPSQUdFNM6
	ZLpHoFHkyH7QM1IfMUCJEP6l1YJKaqEzAsyn4
X-Google-Smtp-Source: AGHT+IGgCMvL26KqQgwefwP8N/EfjWTlXm02yahkb/MjrhIhNHaqD5Cu7Uq//LTHtb9KBj8fMiXuAXpow+tVDMKdSG8=
X-Received: by 2002:a5b:8d:0:b0:dcc:56b6:6606 with SMTP id b13-20020a5b008d000000b00dcc56b66606mr905731ybp.40.1714080113218;
 Thu, 25 Apr 2024 14:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425200844.work.184-kees@kernel.org> <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org> <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
In-Reply-To: <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Apr 2024 14:21:39 -0700
Message-ID: <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:04=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Apr 25, 2024 at 09:51:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> > > On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > > > The /proc/allocinfo file exposes a tremendous about of information =
about
> > > > kernel build details, memory allocations (obviously), and potential=
ly
> > > > even image layout (due to ordering). As this is intended to be cons=
umed
> > > > by system owners (like /proc/slabinfo), use the same file permissio=
ns as
> > > > there: 0400.
> > >
> > > Err...
> > >
> > > The side effect of locking down more and more reporting interfaces is
> > > that programs that consume those interfaces now have to run as root.
> >
> > sudo cat /proc/allocinfo | analyse-that-fie
>
> Even that is still an annoyance, but I'm thinking more about a future
> daemon to collect this every n seconds - that really shouldn't need to
> be root.

Yeah, that would preclude some nice usecases. Could we maybe use
CAP_SYS_ADMIN checks instead? That way we can still use it from a
non-root process?

>
> And the "lock everything down" approach really feels like paranoia gone
> too far - what's next, /proc/cpuinfo? Do we really want to go the
> Windows approach of UAC pop ups for everything? I'd rather be going the
> opposite direction, of making it as easy as possible for users to see
> what's going on with their machine.
>
> Instead, why not a sysctl, like we already have for perf?
>
> The concern about leaking image layout could be addressed by sorting the
> output before returning to userspace.

