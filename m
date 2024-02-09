Return-Path: <linux-kernel+bounces-59824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD7084FC47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79554B25F7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8688287A;
	Fri,  9 Feb 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQN7rdaX"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493A80C01
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504228; cv=none; b=DX027Q2xPIYNiNjC3SG8CijleY6AjbbSmWkHRVOZYAktsSiaaeKnSUanADEEuwamTjUHjYDuTrS3QChx9GgajlM93q5Fo3RwX0LOr0Ljt22KzK2SzzF2F/F9gKYatHF4YKZuj6uR2R8E8PBxrVBZE3R9+zTCRkDjUUqPtNfy3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504228; c=relaxed/simple;
	bh=8f8p/4a7/2aRl6Xq3Fz9FLEi1kviN9smwP5Pb7REtWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oxW1kWeqhtuYQS0h6+jJaw67m/ly5yjibtyweDd96ovpB83TvC9qclqC6j6kcq2KRfa5TJzGPneTmOUxm2dmo8EGNFGfwX5QwEyEIWHZ7VfADVYa6HmQrHLztFgVZPH2Z7N+PgqE9UIVX1UqVeAEWR3THttHz8WaC+BeCdzgo5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQN7rdaX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e0519304b2so1328595b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707504226; x=1708109026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufX7CAN2cDiflmlLv7odBke7PHHs4jGzCMX4P5h7RHE=;
        b=TQN7rdaXIUdlqBLlemPe/7Hhzp13EmSBtbVNCmGhr2Ki1mu/DdIxwUH3O1CvhRhgOg
         lPgOzlTFWLXtVFJOai+BVFuuQLAJEUV4oVUqDSR9KbUfNLheBQ6yXHxES7rndLfa3G5i
         MC6rW98KNkGmIsNOhlrxy03+5r3LiwlANURWSTgDN2RT8oyEp1WO+yFtEdQKWB/mjB54
         uVJUWXGcW3dLnAIT623gzYJB1tOmS+2ManFVku/5fLtb6Zq0YFKTUup/pkq8LnW+Y+Rn
         i8uMi60cwfTvz9HWf5eTB+2ECKZCq3JfCGO8R+VFgAn0rD5njIUSs7DnYnuUBAL/c/Rz
         qs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504226; x=1708109026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufX7CAN2cDiflmlLv7odBke7PHHs4jGzCMX4P5h7RHE=;
        b=NvEWP5TTI8RjyWHSyFX3mCRS+SKZfOhA4slVcMqNRuiBSknQx8fMg7K3bEMoRmfzVJ
         7flLBzcaz/zhnunRI+DcAPcYOobZpbirp9vvbnG3ziKC9s3reO126J2GcKV2f18H5585
         dnAjiWdIFcpUYMxsBoEFinnkS0LxX9w6nVawy/8WfAYEl17gnYMZSIReb5f4XPGcI9zU
         Xs7fA6ClRPNX4PtAMW8MApu8PgcFbk6lXqwUAW39b4yWz5RZKKRuoyWoAED21nbYWGHK
         VAUKxco1AtE6eExzLNYZO7eSxRszEpzTRDTUH7D2WjOS8IJRQm1+cDWHpj1Shud8NwiI
         RzGA==
X-Forwarded-Encrypted: i=1; AJvYcCXWsn64XUKrbTU55mGVUuDPcFecnMzl3PnjkbQuGJ91s4nmu7ucMQsoxxpYYz6quCirbIQ9RhR+sxSVIBkYvWuU8EMRaGshA8jQNLLI
X-Gm-Message-State: AOJu0Yx9xYaX5/hHV0lEdcw55Y2G+3CZ0lxmOL2qWNJSQS2sK4e3Dyv0
	XS9vDHqPiWbI7O7g/gbX5QaqkXE9QFJsjpFOJwwmlZqXwh4MW825ZSSRXX7ksmXIpt8Tuc8Gbr+
	xaQ==
X-Google-Smtp-Source: AGHT+IG0MOn0HaITlgCYjNEXj8a8UrT4z56YsyeBOMLYCb0WjQj45vzVFkaMlYS4lzhGv7NviTO75JYfAGU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a91:b0:6e0:3211:657 with SMTP id
 e17-20020a056a001a9100b006e032110657mr2539pfv.0.1707504226316; Fri, 09 Feb
 2024 10:43:46 -0800 (PST)
Date: Fri, 9 Feb 2024 10:43:38 -0800
In-Reply-To: <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
Message-ID: <ZcZyWrawr1NUCiQZ@google.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
From: Sean Christopherson <seanjc@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 09, 2024, Linus Torvalds wrote:
> On Fri, 9 Feb 2024 at 09:14, Andrew Pinski (QUIC)
> <quic_apinski@quicinc.com> wrote:
> >
> > So the exact versions of GCC where this is/was fixed are:
> > 12.4.0 (not released yet)
> > 13.2.0
> > 14.1.0 (not released yet)
> 
> Looking at the patch that the bugzilla says is the fix, it *looks*
> like it's just the "mark volatile" that is missing.
> 
> But Sean says that  even if we mark "asm goto" as volatile manually,
> it still fails.
> 
> So there seems to be something else going on in addition to just the volatile.

Aha!  Yeah, there's a second bug that set things up so that the "not implicitly
volatile" bug could rear its head.  (And now I feel less bad for not suspecting
the compiler sooner, because it didn't occur to me that gcc could possibly think
the asm blob had no used outputs).

With "volatile" forced, gcc generates code for the asm blob, but doesn't actually
consume the output of the VMREAD.  As a result, the optimization pass sees the
unused output and throws it away because the blob isn't treated as volatile.

   vmread %rax,%rax       <= output register is unused
   jbe    0xffffffff8109994a <sync_vmcs02_to_vmcs12+1898>
   xor    %r12d,%r12d     <= one of the "return 0" statements
   mov    %r12,0xf0(%rbx) <= store the output

> Side note: the reason we have that "asm_volatile_goto()" define in the
> kernel is that we *used* to have a _different_ workaround for a gcc
> bug in this area:
> 
>  /*
>   * GCC 'asm goto' miscompiles certain code sequences:
>   *
>   *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
>   *
>   * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
>   *
>   * (asm goto is automatically volatile - the naming reflects this.)
>   */
>  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
> 
> and looking at that (old) bugzilla there seems to be a lot of "seems
> to be fixed", but it's not entirely clear.
> 
> We've removed that workaround in commit 43c249ea0b1e ("compiler-gcc.h:
> remove ancient workaround for gcc PR 58670"), I'm wondering if maybe
> that removal was a bit optimistic.

FWIW, reverting that does restore correct behavior on gcc-11.

Note, this is 100% reproducible across multiple systems, though AFAICT it's
somewhat dependent on the .config.  Holler if anyone wants the .config.

