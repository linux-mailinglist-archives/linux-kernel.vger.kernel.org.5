Return-Path: <linux-kernel+bounces-108893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F6881177
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BC21C2347C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3763FB21;
	Wed, 20 Mar 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e267a4zr"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD12628D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936439; cv=none; b=D9d84JY6ZhUNOrxP1+y2HrRyZybW9E+X70bvWV2yZqMibTmE1nbfpnHH6yKDw2z1CrwRSrHnKdOjQas7Ykkvnm3r3qu3CHSisaz5E0g0Ai9HiepMjq+v72YGHyHcx1WlTChdK/T3+ojBSsjn+/XgQ4Z5jlNXtjzmpOE1PQNfIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936439; c=relaxed/simple;
	bh=qQIyN94RcUxQGeM01O+NcNfg5sUN7Y8zbd8QRPJDgIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3eaZUP2TZFz525m6DejXzV/V/loz8e6IHnfwJ8bkMC3hFXdvqL1Tu1BlmbekkebdtaXmv6MA3hBXqHwtyxKVFQMmm93AnSPktZjPSoABJxWlteqattOlvorWKw1U/ENPttnmuCOgw3QSLiOP7+T992wItFUEuLarDzFXjx8CrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e267a4zr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6963cf14771so10787206d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710936436; x=1711541236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7DDAmZLzRu6HgzyxGlka/nEAH/Bp9s7j8g062J1qR0=;
        b=e267a4zrRwe7qaZX26PH25DXs81gD5QQAtAM80wvN7+JJpTQNnqT/WoD/qu/kC2Nzo
         bxilbraeIqkqzCVJBNcRGDO3k0eXFCv4PJpjTJkD5BXL7Qo9HgAJW5jdEAQfARYhJtpj
         eZwTpsIevDOzvELPqSD7aRIKnBePhw8J3NYaDvMK8XiQfbGBmFVjeb/3X0CcOHbcF8Z3
         L1501U6s7y22nrNfpoSH0D8aTo8TwKuDYUlu1IDo8ToSg5sUj66AeTa0964d88VywWXC
         P+HyffjcY412mUwn5SoWxjtzUKlccEeoIr4+JV85fmYudJjjEKjcrmCLEcoaSoJqKnnO
         ExUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710936436; x=1711541236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7DDAmZLzRu6HgzyxGlka/nEAH/Bp9s7j8g062J1qR0=;
        b=Cih94Sk+viZWqlNgs38yIEMftMz42RfiepV9SOwROLT59yEcccbFfuYGZsGCP9fUDr
         wPq4P083s6lAFpp541O+Usvuso1WiGE/A6/cvlTiJOl5YvGsnohUa/4uJuZoP/50XSZX
         Iv1wJW3IqStMb5306P/mVIKyEzTAy65LgKsO8Q5pRfQyFq6duQ6bf5AuAgUH9Fm5pO3U
         RcBaFlJ4480h8EVG8PPaegBKTe7dLELXvLg3rw4jKWvz+jm6w4gpsmtA1vE4/8aDs0C1
         1OHh3Ov79c8PzS3jywMbNtFwV2pePtjx0LvuyHPpFU7yl0G1VnZMt9kNeEgYBITtsLZV
         R4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4KaEKnbsdWt2l4W0yNENO0vmz19g9EcwSvOIrdA1xL5e9rZ2o95L3wr8i6s7RkkD1Be5HAPYThSxqS2vtgG1uoVhfWHJfoMcEUhvS
X-Gm-Message-State: AOJu0YwP2PlIh53RtgU+QFnNY2oQPUeaH9FNskvBGlDBg6pQJZ6m4eDc
	84bXdk8ltpbQ8rA4IWauAGzMJL3VbBViFjkWLxZpmvQD5AMGFE917d9A5Qq9xzyvbXoREeqdY2V
	BTSLhPElyL5Ag5DOGjYkZoHWeAxSt0USqm5PZ
X-Google-Smtp-Source: AGHT+IFsZ1Kl+nOzqPW0+FjUKUPnqIsgeV3Xy3EhYghtu8MFkZrVbUNy3Po7/qq/bRXKj3pCCJ8hWquQq+UKPzKOHh8=
X-Received: by 2002:a05:6214:2b97:b0:691:64e9:9a4a with SMTP id
 kr23-20020a0562142b9700b0069164e99a4amr25165795qvb.53.1710936436027; Wed, 20
 Mar 2024 05:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com> <20240319163656.2100766-3-glider@google.com>
 <f9a8a442-0ff2-4da9-af4d-3d0e2805c4a7@I-love.SAKURA.ne.jp>
 <CAG_fn=UAsTnuZb+p17X+_LN+wY7Anh3OzjHxMEw9Z-A=sJV0UQ@mail.gmail.com> <dce41a35-aa2a-4e34-944b-7a6879f07448@I-love.SAKURA.ne.jp>
In-Reply-To: <dce41a35-aa2a-4e34-944b-7a6879f07448@I-love.SAKURA.ne.jp>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Mar 2024 13:06:33 +0100
Message-ID: <CAG_fn=UuC=d+jJOor1qMYjP48=mhSf7y=s=gwj6APaFroGqQdA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] x86: call instrumentation hooks from copy_mc.c
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:40=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/03/20 18:29, Alexander Potapenko wrote:
> > But for KASAN/KCSAN we can afford more aggressive checks.
> > First, if we postpone them after the actual memory accesses happen,
> > the kernel may panic on the invalid access without a decent error
> > report.
> > Second, even if in a particular case only `len-ret` bytes were copied,
> > the caller probably expected both `src` and `dst` to have `len`
> > addressable bytes.
> > Checking for the whole length in this case is more likely to detect a
> > real error than produce a false positive.
>
> KASAN/KCSAN care about whether the requested address range is accessible =
but
> do not care about whether the requested address range was actually access=
ed?

I am not exactly sure under which circumstances a copy_mc may fail,
but let's consider how copy_to_user() is handled.
In instrument_copy_to_user()
(https://elixir.bootlin.com/linux/latest/source/include/linux/instrumented.=
h#L110)
we check the whole ranges before the copy is performed.
Assume there is buggy code in the kernel that allocates N bytes for
some buffer and then copies N+1 bytes from that buffer to the
userspace.
If we are (un)lucky enough, the userspace code may be always
allocating the destination buffer in a way that prevents
copy_to_user() from copying more than N bytes.
Yet it is possible to provide a userspace buffer that is big enough to
trigger an OOB read in the kernel, and reporting this issue is usually
the right thing to do, even if it does not occur during testing.
Moreover, if dst can receive N+1 bytes, but the OOB read happens to
crash the kernel, we'll get a simple panic report instead of a KASAN
report, if we decide to perform the check after copying the data.

>
> By the way, we have the same problem for copy_page() and I was thinking a=
bout
> https://lkml.kernel.org/r/1a817eb5-7cd8-44d6-b409-b3bc3f377cb9@I-love.SAK=
URA.ne.jp .
> But given that instrument_memcpy_{before,after} are added,
> how do we want to use instrument_memcpy_{before,after} for copy_page() ?
> Should we rename assembly version of copy_page() so that we don't need to=
 use
> tricky wrapping like below?

I think renaming the assembly version and providing a `static inline
void copy_page()` in arch/x86/include/asm/page_64.h should be cleaner,
but it is up to x86 people to decide.
The patch below seems to work:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.=
h
index cc6b8e087192e..70ee3da32397e 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -8,6 +8,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>

+#include <linux/instrumented.h>
 #include <linux/kmsan-checks.h>

 /* duplicated to the one in bootmem.h */
@@ -58,7 +59,14 @@ static inline void clear_page(void *page)
                           : "cc", "memory", "rax", "rcx");
 }

-void copy_page(void *to, void *from);
+void copy_page_asm(void *to, void *from);
+
+static inline void copy_page(void *to, void *from)
+{
+       instrument_memcpy_before(to, from, PAGE_SIZE);
+       copy_page_asm(to, from);
+       instrument_memcpy_after(to, from, PAGE_SIZE, 0);
+}

 #ifdef CONFIG_X86_5LEVEL
 /*
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index d6ae793d08faf..e65b70406d48a 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -13,13 +13,13 @@
  * prefetch distance based on SMP/UP.
  */
        ALIGN
-SYM_FUNC_START(copy_page)
+SYM_FUNC_START(copy_page_asm)
        ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
        movl    $4096/8, %ecx
        rep     movsq
        RET
-SYM_FUNC_END(copy_page)
-EXPORT_SYMBOL(copy_page)
+SYM_FUNC_END(copy_page_asm)
+EXPORT_SYMBOL(copy_page_asm)

 SYM_FUNC_START_LOCAL(copy_page_regs)
        subq    $2*8,   %rsp

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

