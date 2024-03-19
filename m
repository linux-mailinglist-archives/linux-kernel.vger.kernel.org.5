Return-Path: <linux-kernel+bounces-107525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1087FDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA23DB22846
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386A57887;
	Tue, 19 Mar 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAmbwwFH"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166818EAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851967; cv=none; b=jdQ9o4/guxQyKikhFJNhs0NUbmz4SFg2pVkgT4ik7/VibRppJLFcv6v2H1FxpZ02oVZhIqRD2Ij7gbnlWNBOeflahRmXwxJYEBTNjuMrJu7vRbFAaTkG02zCZkfuvIUxmI0kDaxZywqtoVs7lAxTbXdgoN6XbqKzXxb1aZeHC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851967; c=relaxed/simple;
	bh=/IDzR9mNvqn3bvSm9E5ciFJnUziQVpyML6SIy7XyyP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEUgJTiBuWRIajQFl2fb7VIb5+oz/BjA7OXpQObxUOQSVFMn//i/ZYo4fNtDpufDHOOwtxry5T+9EIRvKhRKs+cAgboo4PcmLPYjlHCfJAL1Q+LmK5UdRyXITxxlZicpn99v265KU7IayETKI6A4HTht3YmNlaMGzqIc6gkY/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAmbwwFH; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbc649c275so2737961b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710851964; x=1711456764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB+hqT6GbC7x8e7B3kg2ZXAusMKqsBrFmJKSr64voZA=;
        b=BAmbwwFHDpgpbsgZlWSdSPLsMDh70XSxupgGmfoZxJ4dAwhNXrV6isf3/c9Khjh56j
         GVerkPSgoCsdTCi9WiBCpj5114x2Qne/s29NiEnwMut+72Hc1YSLNVf+qwW6n+wbFHUy
         JlqClKbk7U5EnzPS/y/qAOrgvEPpBfVa0Yms8o3z3oShTB1W8WIlCizAadd6PpHHupX9
         qUCj9kicZYUB6lyhCk2Cum1d0hAC7ahnJcfiIllrqFMcXOSTeac6iPNUfibIqjEOAOaQ
         9jikrgEvKqblktKqkoWFxuiM6mcn7jxvDgHidE64K9Ixav3NmnyGXt/qJITO5IxMgPSi
         3JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710851964; x=1711456764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB+hqT6GbC7x8e7B3kg2ZXAusMKqsBrFmJKSr64voZA=;
        b=sxMjFoFhzX85OodS0Cbxru5oBJJQ0Mtz+zTZXtvzCzrHmYNWkFcvFpqdHIyLZvdQg4
         41kOfxbBD3s778HtTk/k5wZ/XyIW/ERec7YcitsxVHXRJ/SLKjk7DbqbDzF2Kbj/7/K3
         lvp2kPhcQRhe4V+bF6ArXWsBXMSMd1X8zk3ZJpbdBhGW9DWrnXRWnO9bE/jW6XkZb8uc
         pZKutKRMhvOPUffj4LowPMwrUf3EFCKpJDooEehtW4MlMUC43gonVEcjqmcC86PaCwO6
         cMB6SifbsaJLcFhufZFENBwd8H/9oc4nW0qSwQLm+DjtGxQRYhy/xW5D/5G9Oz+45l+D
         C8cg==
X-Forwarded-Encrypted: i=1; AJvYcCVobLlJvOR3hKxEkcV/KlHxVvofG5FXNW4kPXtS60cGLQE8XBgdnBIhilljTRlefyO7ykwkXTNbwgDoM06ygBstQhXRER1lf9+1yLKG
X-Gm-Message-State: AOJu0Yw5y4eLvJd4dryTlu6LI0JAYm4y6oZRmSpUcl8xU7PhHCK+BA+E
	yYgIvwvk48nnM/1wsGOoAx9ohXRLpwtrcGr1lc/8e/6dsVIPzqL5VLdlm8aBHRdoUoYCm6dRWUi
	1MIKtGIX7DflEGwhM3fCAWSNeR7MadTwSlLbO
X-Google-Smtp-Source: AGHT+IHgVSUEp5voi+RejQcRn4ohspJtmUuIYf+01ZfCY16g0CQ0tH4UmKwFsggo+0n+2PgFBeapo31wNcoLFkmQzkw=
X-Received: by 2002:a05:6808:1284:b0:3c2:aaa4:a6f7 with SMTP id
 a4-20020a056808128400b003c2aaa4a6f7mr19008575oiw.24.1710851964392; Tue, 19
 Mar 2024 05:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
 <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
 <CAHk-=whGn2hDpHDrgHEzGdicXLZMTgFq8iaH8p+HnZVWj32_VQ@mail.gmail.com>
 <9692c93d-1482-4750-a8fc-0ff060028675@I-love.SAKURA.ne.jp> <CAHk-=wgA1N72WfT9knweT=p1jhHGV3N0C2Z+7zvGL+LgG-AwXA@mail.gmail.com>
In-Reply-To: <CAHk-=wgA1N72WfT9knweT=p1jhHGV3N0C2Z+7zvGL+LgG-AwXA@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 19 Mar 2024 13:38:45 +0100
Message-ID: <CAG_fn=X71NCOnqNrtU9rJ4eeGZsxLCxKT=Cq9J9dq9q+Re9syA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	LKML <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 1:09=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 6 Mar 2024 at 14:08, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Something like below one?
>
> I'd rather leave the regular fallbacks (to memcpy and copy_to_user())
> alone, and I'd just put the
>
>         kmsan_memmove(dst, src, len - ret);
>
> etc in the places that currently just call the MC copy functions.

(sorry for being late to the party)

We should probably use <linux/instrumented.h> here, as other tools
(KASAN and KCSAN) do not instrument copy_mc_to_kernel() either, and
might benefit from the same checks.

Something along the lines of:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
static __always_inline void
instrument_memcpy_before(const void *to, const void *from, unsigned long n)
{
        kasan_check_write(to, n);
        kasan_check_read(from, n);
        kcsan_check_write(to, n);
        kcsan_check_read(from, n);
}

static __always_inline void instrument_memcpy_after(const void *to,
                                                    const void *from,
                                                    unsigned long n,
                                                    unsigned long left)
{
        kmsan_memcpy(to, n - left);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

(with kmsan_memcpy() working as Tetsuo described).

We can also update copy_mc_fragile_handle_tail() and copy_mc_to_user()
to call the instrumentation hooks.
Let me send the patches.

