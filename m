Return-Path: <linux-kernel+bounces-133981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798D889ABB1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63EE1C20DAC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8783BBDC;
	Sat,  6 Apr 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RYbExPCD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9F3BBC1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418010; cv=none; b=iwztenyjOlLMgzpxPNzFMevVPNESr5TSrQG5400Qwt/KkzTL0SFqY5JSnefvOsFZIrB3+WCoqzHVRvWTsbMumE2Q0ATlipYe+WjnuyOibzNpmy+taW+2362tqkLLtXVDp8Q6lYSHCUHjGvz0F90Xu7TdmrPmLzmXWfaKsezL89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418010; c=relaxed/simple;
	bh=g4WUAhon2OZw1+PQFctQN5UzkWQs6940GrC8r15MZCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY6BZ8Tbd5+Y9GVQVCA+HXL4uev3RV2qxQo2Qj2HEjS+ZLeVSYMgV1xr+lRx+ylEucyVGDdkY8h8lx/0ZfHamWgbqP/DzoCIlcvP22P8jFXEWQPZehPo6L/9nq+ogsXaKcpGDeukAtqOlrJnRk1Zk7FdRAjN4ymMn47i1WpM6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RYbExPCD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2b41187aso3041947a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712418006; x=1713022806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5uKe1Oc3INaUQyL3mPJmBXZ1VVEoPKZ2R4vtagmXnyE=;
        b=RYbExPCD0Ssmzgl6YUAkeo4emb2VHVCRCyN7WsZsM1VFBRvrDi16RWm2AgTzeSHx2M
         OF93MmIFgN0QpG525Zo7Hb9i7x/K+vdRjhelMf/GV/V3BRGMucHalecGKNl+uSLP3N1N
         a4EvC4dNfBDNtZq1Pmu8ALPNslhpcKkLsnJg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712418006; x=1713022806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uKe1Oc3INaUQyL3mPJmBXZ1VVEoPKZ2R4vtagmXnyE=;
        b=Ybbaq6w1LhRlaZ50shha2HtLaEA1OWT9wPQaJfmUhPcgnY4wQ8Ao8T1OK4284Fsks3
         UeDxFjvBNv7jE9Md02V/YszJBeM6+tijDBIdC0+8mkBo51fbiIlX7thfjkC5xlSp6k3W
         GV03VBVNR2CwtlpYcHDbRFpqjLsmeJnj4tZ5fcTOhyEWHcPvLA4hZmgs+1Ac9DE6zQHu
         /eEbj5MTSUg1aDz8sObP9+M/kyeiql9ECVAsfxRbLEIAX5EdqblOigL/T2133skMhIPu
         hqZ080/0ZqcVFeNQzQJkqIwcpbjeKR7SgXeJxEHNbHgqx4MKaQwKCaE5YTzQa75OPDnh
         lWLw==
X-Forwarded-Encrypted: i=1; AJvYcCW7J4dSEJ1uGotFkoEKBmt26NSwv87q3BiHUIK9ZakOqcPlWd5Ir6fCswsCGRhKVQ3juPfXjPtcWXi09GEu7x32QydZTF6RbX8bWoYV
X-Gm-Message-State: AOJu0YwxsJvnpXMhVHnOI620qJ8RrDFvfOU+9qBaO06k0sOJ20tydJpy
	9jXZqNhdoThhu6sgi2RToYAWS61GXDxUgni2YAYydYJsakjwL1M9NX0gHl8ZrBkIiSKMZY04QyN
	ILCaHFg==
X-Google-Smtp-Source: AGHT+IFjRyn9c0TY0ChIQZd5Dj5RiMH9abX6zHe1gNv0zht4hQ99feYQwcaS81iyxv29HWPDrN+ESQ==
X-Received: by 2002:a50:9e44:0:b0:56e:2a6a:8d3a with SMTP id z62-20020a509e44000000b0056e2a6a8d3amr4416449ede.15.1712418006693;
        Sat, 06 Apr 2024 08:40:06 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0056b8dcdaca5sm1983145edb.73.2024.04.06.08.40.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 08:40:06 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51be56961bso58833166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 08:40:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdA4vZIl6fytYgvE3zXyEKXfSaK2wxHcdUr66ndGQdOxOzVq4NIk028AIJ34pdyRsL/CwAdKsu3NBlZpl6v7QsSjZA8Y3kqGyL93pW
X-Received: by 2002:a17:906:6a17:b0:a51:c1f7:93 with SMTP id
 qw23-20020a1709066a1700b00a51c1f70093mr1161774ejc.13.1712418005170; Sat, 06
 Apr 2024 08:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <ZhEqW748nht2M4Si@gmail.com> <CAFULd4bcnEf6MCa1L=hYHHMOP=jB4Bc0Uugugg8xgNogQAU+YA@mail.gmail.com>
In-Reply-To: <CAFULd4bcnEf6MCa1L=hYHHMOP=jB4Bc0Uugugg8xgNogQAU+YA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Apr 2024 08:39:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicV7y1wnZ0God6HLA-4YSVtEevuVf09t+t=bU4yQFfXg@mail.gmail.com>
Message-ID: <CAHk-=wicV7y1wnZ0God6HLA-4YSVtEevuVf09t+t=bU4yQFfXg@mail.gmail.com>
Subject: Re: More annoying code generation by clang
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Apr 2024 at 05:30, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> FYI, please note that gcc-12 is able to synthesize carry-flag compares
> on its own:

Oh, gcc has been able to do that for much longer than that. It's a
idiomatic i386 pattern, and gcc has generated it for as long as I can
remember.

HOWEVER.

There's a big difference between "able to" and "GUARANTEED to".

Because this code actually requires a data-depencency and not a
control dependency as a correctness issue because of Spectre-v1.

So while I know very well that gcc _can_ do it, I also know very well
that there are absolutely no guarantees that gcc won't use a
conditional branch instead.

So this code is needs to generate good code because it's actually
important code that shows up in benchmarks, but this code also needs
to generate a very _particular_ pattern of code, and it's not good
enough that gcc may "happen" to generate that pattern of code.

Thus the inline asm.

               Linus

