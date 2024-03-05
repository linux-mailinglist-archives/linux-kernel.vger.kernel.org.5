Return-Path: <linux-kernel+bounces-92280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F1871DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7A41C236E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741056B65;
	Tue,  5 Mar 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4U/Q4yy5"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724F10A1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638295; cv=none; b=N+5Ge8waPZC8n79ugWE0O3BhRYby7JkQTBX8/8RbIg7c3BLgkPNnExsFdeHOc8WEXp8jN6LbxzT1jjGegl8prlLw0bSSZZRqQgfRrWw4FxW6yznDisenGO2kCrzd0oUHEsjkp1fK/v+qMFJfSVLWUi/z1mDEep9tXY47HsyyTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638295; c=relaxed/simple;
	bh=5Zj1cHjqoRSTv3wpW/vBf0JVKBwvW9Fvm4eCS+H0mCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAyRfjgkRxEqRiI1dOL1HYbjtIsYZoQTmi8Wj25f5Qo9GB+lLaHEGYXM4Pz2KvfmuoFS4sNH1QHkdGQVvd8I2KNk/HFI95Y4c8j6J92UdmX5+H/cyV2BvB1c+LJccBg3Rbp+++KyKnwTjXyFdZrUUESeMSLkp8p9TJvev0+VnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4U/Q4yy5; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d36196a7f7so910634e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709638293; x=1710243093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhnMDUA+SM/I153+o1QN9n9YimDuXxyDMythbZKsjIc=;
        b=4U/Q4yy5LU2Kv4YG2/s0VMZV51Ls6JURgJFOk0fUKyd97jkFAV4SvlE0BQg0QhmNV3
         Zcd3MiLBfo96/Al4ppgHMql/nE3TC8ZEKf8MsHr1O+cqi6ZFx1UQI1JD/jXlRhpQv1MZ
         VtN/fI/zqsoO6u+pOblk5NFMNIevhNmLasScJr0w8oB61ry9Aq3jL3hcUR7Ve8I4V9/z
         keYa3a2fCNs/ydmTwfx6ziTb7CL5PH8HPg/1aXoEpB+5t40C7F0yVaIZqGP4nbmghZbr
         TMgOlJaLCBePuimhPcIy1MGgMnQ25bVBKW7saImW6/V8+mjtoj7TbLDOMn0bs0BYKd2z
         gaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638293; x=1710243093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhnMDUA+SM/I153+o1QN9n9YimDuXxyDMythbZKsjIc=;
        b=vCJgagGtz3p1Gdh2utvN+bJlYGlMYgXxwt/+JkZ4RYdtkiTcaXltZ+N6RKN2J6j3jt
         +rcK60PnmTU++P9IFhpVNnfrIWe3tXdX1kGUE0Zqkk7exy0y09kNStd1zHSOlKFp1QxD
         qAIr8HgzM/00d+CSAJM5l7AimRm8bUAerQv6jtk0GPjOum/dKvPU4FoHlHDCqywytvk2
         OxBhgh6PUa/yfBmO6glN7DgoxQmx5wLQioUPJ/DxjfRYkpAfDJsg7lTxkd/mdsnKN2fz
         9t9Fw1WWXd72XG24PuW4kYtLe3xl2shYxSRMTuoNgaArjGyg2BIUjDoAtMdoSIj43Af9
         FCMg==
X-Forwarded-Encrypted: i=1; AJvYcCWUk7g/DqLtQLHpQTd4ksUTk7hLDTEJqnU+v8/d+gFKjXhxbKf1rTcsglfX60z+DVTGWpV8aVREF0yXtK89OIeapCsSwfwlome07Uqt
X-Gm-Message-State: AOJu0YyyUhPFLmLfmB2cL4Xdqo/BvHqcXl0ylK6+2m0rA7wDUIXVtwqp
	brlLme4eOihxLnWmhhSBLNd27QeYAGZYi/UnXX0wrfI4Ljqf8DYSmm9NHiL9HbKd6ZFUrcNmEql
	5/W3Xzk8N/wtXIR15XesB+yK1EorrEg3se9Ov
X-Google-Smtp-Source: AGHT+IGaOEvWlQFESzWxdD8NjcuJeJMN74Ew0v7JqtHNHijwrN/HapW66Fiw7VfQvayzfRCfTo8TU44zbWbn9v1ig08=
X-Received: by 2002:a67:e3b9:0:b0:471:e2ca:4023 with SMTP id
 j25-20020a67e3b9000000b00471e2ca4023mr1133906vsm.25.1709638292994; Tue, 05
 Mar 2024 03:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgg0yGbuHnMbMB103Zssg4KSfXUR3kvhr0kuqTSah=6kWg@mail.gmail.com>
 <20240305112017.125061-1-kernel@valentinobst.de> <CAH5fLgis7Usg_cfWM5rBKjRKsB4857PkyuCMrCU6PmEqTOMFiw@mail.gmail.com>
In-Reply-To: <CAH5fLgis7Usg_cfWM5rBKjRKsB4857PkyuCMrCU6PmEqTOMFiw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 5 Mar 2024 12:31:22 +0100
Message-ID: <CAH5fLgj=iuWNWy9jGvaD0SCcZg6GSj9XBgB0vZwL8EokobUPMg@mail.gmail.com>
Subject: Re: [PATCH] rust: add flags for shadow call stack sanitizer
To: Valentin Obst <kernel@valentinobst.de>
Cc: Jamie.Cunliffe@arm.com, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	ardb@kernel.org, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, broonie@kernel.org, catalin.marinas@arm.com, 
	gary@garyguo.net, keescook@chromium.org, linux-arm-kernel@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, nicolas@fjasle.eu, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, samitolvanen@google.com, wedsonaf@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:28=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Mar 5, 2024 at 12:20=E2=80=AFPM Valentin Obst <kernel@valentinobs=
t.de> wrote:
> >
> > > >>> It's not 100% clear to me whether this patch is enough for full S=
CS
> > > >>> support in Rust. If there is some issue where this makes things c=
ompile
> > > >>> and work without actually applying SCS to the Rust code, please l=
et me
> > > >>> know. Is there some way to verify that it is actually working?
> > > >>
> > > >> Perhaps you could write a Rust version of the CFI_BACKWARD test in=
 LKDTM?
> > > >>
> > > >> Alternatively, the simplest way to verify this is to look at the
> > > >> disassembly and verify that shadow stack instructions are emitted =
to
> > > >> Rust functions too. In case of dynamic SCS, you might need to dump
> > > >> function memory in a debugger to verify that PAC instructions were
> > > >> patched correctly. If they're not, the code will just quietly cont=
inue
> > > >> working without using shadow stacks.
> > > >
> > > > Was just in the process of doing that:
> > > >
> > > > - `paciasp`/`autiasp` pairs are emitted for functions in Rust modul=
es.
> > > > - Rust modules have no `.init.eh_frame` section, which implies that
> > > >   `module_finalize` is _not_ rewriting the pac insns when SCS is dy=
namic.
> > > >   - Confirmed that behavior in the debugger (C modules and the C pa=
rt of the
> > > >     kernel are correctly rewritten, Rust modules execute with
> > > >     `paciasp`/`autiasp` still in place).
> > > > - Kernel boots just fine with Rust kunit tests, tested with and wit=
hout dynamic
> > > >   SCS, i.e., on a CPU that supports PAC/BTI and one that does not.
> > > > - Rust sample modules load and unload without problems as well.
> > > > - `x18` is indeed not used in the codegen.
> > > >
> > > > I guess we might be able to get this working when we tweak the buil=
d system
> > > > to emit the missing section for Rust modules.
> > >
> > > I suppose the -Cforce-unwind-tables=3Dy flag will most likely do it.
> >
> > Yes, enabling this means that `.eh_frame` sections, which are converted=
 to
> > `.init.eh_frame` sections for loadable modules, are generated for Rust
> > objects.
> >
> > Tested booting, kunit tests, sample modules (as builtin and loadable) f=
or
> > both, dynamic SCS active and inactive. Backtraces on Rust panicks also =
look
> > normal.
> >
> > Confirmed that in the debugger that builtin and external modules are
> > rewritten (or not rewritten if no dynamic SCS). Did not check that the
> > `eh_frame` sections are exhaustive, i.e., cover all `paciasp`/`autiasp`
> > pairs, only verified a few functions (in init text and normal text).
>
> Thank you for checking that!
>
> > > There's also an use_sync_unwind option, but it defaults to no, so it
> > > doesn't seem like we need to set it.
> >
> > Are those defaults stable or will we notice if they change? If not it m=
ight
> > make sense to set it explicitly anyways to avoid surprises in the futur=
e.
>
> The flag itself is unstable, so I imagine that nothing is promised about =
it.
>
> I tried it, but I wasn't actually able to find a way to set it. I can
> see the flag in the rustc source code, but passing -Zuse-sync-unwind=3Dn
> results in "error: unknown unstable option: `use-sync-unwind`". Not
> sure what the issue is.

Oh, I understand now. It's really recent and not in 1.73.0, which is
what I'm using in the Android build.

Alice

