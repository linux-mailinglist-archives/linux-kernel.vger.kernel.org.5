Return-Path: <linux-kernel+bounces-59692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBC84FA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9057F1C2238B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE7A7B3D2;
	Fri,  9 Feb 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM43FmHX"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C278693
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498222; cv=none; b=LqEyimtwCh30x6pEFZomerHHOyaBGeFBqGmCuIthMsjaNX4vZ7kG2geyLhDbC7hEZdowJIfgHM4j0KUULVdHd5D0zEF/BMD3rNRfr3x+ANl5AWI8RhEpfJHr9v5U8x1wSgj2kdDdv9EU5Ki129b8TfJ3Zw5mxhXa7K2yTGctZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498222; c=relaxed/simple;
	bh=o24d4mKDR3vggTFcW/wRBSGrkk5nNfwrmH+3ZFwE9RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1Ox3XOEkWKoLSI39NhVfFTWwIpL1FJmJ/ueIWybGpVCvG+n0Xg0JjcETTjxY7Veq+ICu6Rgcdkc5IjHjuYQwCrzRmUqw0cmV5cWDrjDGtCivgk42hQongoWEQ2n56ywY4VvDU1lStYMc6KqLJTzzA5CaZ9/3FevD+6Go/p+Wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM43FmHX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3392b045e0aso616795f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498217; x=1708103017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COfj+FIwYG87zb/D26QSbuaV/9maoynPp4ohvDdXH4E=;
        b=rM43FmHXb0AKIb1B1rQRyhcpEwG06sOdvoLuaB9Q5XudTWcnpyaau6IzIUqC48NL+m
         Agow3y0nzo2ojXrSDvp6zLg9U5wPIlwi2WDx/QfP/3vMMtZPX5U+cjaSHcHPi8hycaXJ
         Rwly3yG1+8I2+Oy4bj/UiWyGb0swERohJYsF7xSDK0YJ+DhtRxujVeXTMgn8SRql2hl0
         n3pb0nICfbzCq64nurIRx9x9nNPtWAFLKZP1q7g08oRkk67pmHh7JdH0mJkanwbPlNoy
         TqJNf310kRDZYCoszvwyY2ZRLK8Aw7zZB7SKDzY/DvecP+Knw+PF3Qd/EL1cW4chWll6
         L2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498217; x=1708103017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COfj+FIwYG87zb/D26QSbuaV/9maoynPp4ohvDdXH4E=;
        b=GCtTUUXzNrYx7hm9c+DgJnhpVZhs5kbqWkT8g9HZF9WhgGpK+x38EeM+PIJMJUDrQc
         NGKc86qmnSykT133mjKRushOublLu3Z+q0/s5G53GtxQRkoVmlQ/PVGE4cUwJBlA/L7n
         Nj126r02PoVeHq7YSAo0fBD1lDJZ1mwPlYGVH9hQxhtHEbLHGIKueGLb2dT4VVyvrXyM
         xUpTI2mPkAMDw1D/De1ieJNimCRbY4MsCqUBMfvLG4HxXNoVz2kFq+LQopmOMCjgBbbz
         6Unt4n87pWnRm5AblCEZTEbOn+Jv/6EXfvuqVaIm76Ef8IFW4UjL0irMFda5i4IWPuLC
         2hxQ==
X-Gm-Message-State: AOJu0YxoIjq0Nty1oBw1M6KjKWxGFiw/l8hSQ9T5gv75FLwkrxPg0j7l
	tLndUsiJ5RLtEboCZoggTwNem3soF+cnYcvIKw5TiJ+7NMi485FPMPQAvDH4jPQTw2AZhNUba8c
	bSbD+1lViGPXlBRTC0EWlCuXkUbz4WYLc7XyUXpY4hsjFOr1t0cK7
X-Google-Smtp-Source: AGHT+IHdTJxRqPbUQi0EeCgp3eJXw7oQ3Sm2lkH9cjrUvssz+6KzqkU0n9PtY3vFCw3VsOTdpKB8fSp2i3yuXcYptUA=
X-Received: by 2002:a5d:4e0b:0:b0:33b:68bc:6e73 with SMTP id
 p11-20020a5d4e0b000000b0033b68bc6e73mr515018wrt.42.1707498216983; Fri, 09 Feb
 2024 09:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com>
In-Reply-To: <20240208220604.140859-1-seanjc@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Feb 2024 09:03:22 -0800
Message-ID: <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Sean Christopherson <seanjc@google.com>, quic_apinski@quicinc.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Andrew

Andrew, here's the full thread, I cut most of it out:
https://lore.kernel.org/lkml/20240208220604.140859-1-seanjc@google.com/
.

On Thu, Feb 8, 2024 at 2:06=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Explicitly require gcc-12+ to enable asm goto with outputs on gcc to avoi=
d
> what is effectively a data corruption bug on gcc-11.  As per
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html, "asm goto" is
> *supposed* be implicitly volatile, but gcc-11 fails to treat it as such.
> When compiling with -O2, failure to treat the asm block as volatile can
> result in the entire block being discarded during optimization.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D103979

Shoot, I was cc'ed on that bug (I think I noticed it in testing as
well, and pointed it out to Andrew on IRC who then cc'ed me to it). I
probably should have asked if that would cause issues at some point
for the kernel.

I took a look at the test case added in that bug; it doesn't compile
until gcc-13 (specifically gcc 13.2, not gcc 13.1).  I'm curious since
the bug says the fix was backported to gcc-12 and gcc-13. Are there
specific versions of those that contain the fix? If so, should Sean
amend his version checks below? For instance, was the fix backported
to gcc 12.3, so users of gcc 12.2 would still have issues?  I can't
tell in godbolt since the added test case doesn't compile until gcc
13.2. https://godbolt.org/z/eqaa7dfo3

My implementation in clang still has some issues, too.  It's hard to
get new control flow right, and there are minimal users outside the
kernel to help us validate.

So as much of a fan of feature detection as I am, I admit some of
these edge cases aren't perfect, and we may need to result to version
detection when such bugs become observable to users.

I'm happy to ack this patch, but I would like to wait for feedback
from Andrew as to whether we can be even more precise with avoiding
more specific versions of gcc 12 and 13 (if necessary).

> Fixes: 587f17018a2c ("Kconfig: add config option for asm goto w/ outputs"=
)
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: kvm@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> Linus, I'm sending to you directly as this seems urgent enough to apply
> straightaway, and this obviously affects much more than the build system.
>
>  init/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index deda3d14135b..f4e46d64c1e7 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -82,6 +82,11 @@ config CC_CAN_LINK_STATIC
>         default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG=
_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
>
>  config CC_HAS_ASM_GOTO_OUTPUT
> +       # gcc-11 has a nasty bug where it doesn't treat asm goto as volat=
ile,
> +       # which can result in asm blocks being dropped when compiling wit=
h -02.
> +       # Note, explicitly forcing volatile doesn't entirely fix the bug!
> +       # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D103979
> +       depends on !CC_IS_GCC || GCC_VERSION >=3D 120000

LGTM; but we might need to be more specific about avoiding certain min
versions of gcc 13 and 12.

>         def_bool $(success,echo 'int foo(int x) { asm goto ("": "=3Dr"(x)=
 ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
>
>  config CC_HAS_ASM_GOTO_TIED_OUTPUT
>
> base-commit: 047371968ffc470769f541d6933e262dc7085456
> --
> 2.43.0.687.g38aa6559b0-goog
>


--=20
Thanks,
~Nick Desaulniers

