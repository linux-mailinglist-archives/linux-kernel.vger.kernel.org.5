Return-Path: <linux-kernel+bounces-105219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F987DAA9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B953D1C214C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD71BC46;
	Sat, 16 Mar 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EcMGoG9R"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD91B977
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604929; cv=none; b=oM40ZIh92yXNbsfbdVy2d7cEnb6ma1sztM4XmkqdYp/Kp/t9Yb/tA6XWdLFu9ySZifONeySkdRTCEsCr9G+E9YkiUHXvAagTsBjddLWVpkr58krQGvEscayCP9kDy6hbxK2jNNZFhk+Sgwl/+ArR1zwEcRCWXc/YXIoZU7GgEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604929; c=relaxed/simple;
	bh=JWvf+6scSz8b3lyEfY7d1WQwOuAUyHiD02tQ1aUQaMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3mdEDPBDjDatlS820n9Iv5SxzTB7hnUPLJ27JyO9KCYVklA5QxYtVa5otkKrYYru4CwnE3TUfWzVg4NLOlcMwkAbffvrzQBtJ/wy5vG5/oOKK85cgCFagTqjIu+8/G73X98ewR6NMUoPBoueuR0egmZ9XVQ//SHjOZthV3Rl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EcMGoG9R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d27184197cso36450131fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710604926; x=1711209726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qHGim/EngLZSLM4Ipv2QHE/SK/rU5ZyyxCqSLK9WeiE=;
        b=EcMGoG9RARV3eGHBOk599BIkfWCsqhlKWkon/u8enB3N4mfvpofR6H9rPWPV4HhnNl
         pa41Mpj9kyvQCwMfQSe0gn2VhAf0rbYuPJ+pCrtl7gifIgUbJcyLSJyCcz2Dy3wTWhdY
         XRzoKpwA98Lz6jCJxxTq9qrD13HPjNVF1c04Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710604926; x=1711209726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHGim/EngLZSLM4Ipv2QHE/SK/rU5ZyyxCqSLK9WeiE=;
        b=WS1urePwIViNhLPxZcRnK4f3npoH5+OV9x4k3qPzh5c9rnlrXHEk0o4dYmaznHe94C
         PHBDxW5AI5v5D6ighqIBdywuhAu2/Wfju+WDO0CVxYSQxnABCPldX7wop5Li6NSpOmga
         +hmGxLRl93Cf9Wubi3gnZsjZRB1I4Rnlc3Nikh3dg1+nCEI5/R21s3iDd3dl5DonQR5E
         jodqAHDL/OPyhwt2eJP0wgxHQc/h5027YE/GW+3+5OXqu2Uvwi4Ln9PaLCDdVfHRI1ln
         /oTfLxyqeHK05qKX3+TTDn6KYeTupQ0mceaASa68vQCgEIJ61p81ePxUPDWA60q5gNoA
         rSuA==
X-Forwarded-Encrypted: i=1; AJvYcCVZK7z5u//cMMZuRUAd5RQKQgNCFc3TNO4klJ61cWXk3o3/q68nWt7ScpCQZzNQpL1WhXclRS0SnEn4SNKrASobwCVWODboat8FTkfg
X-Gm-Message-State: AOJu0YyK4urpIg0TsyHxqSUB9CYQx8bFt/4CprQTVuZbPiGDwCXBBkio
	pcil/LY6OvHUs3E63ek517KuhzrnCU4ZoFl0hAV/o0N171FiuW8X/PfRrT+cYnNyOx0XEGp0m2R
	vry6inQ==
X-Google-Smtp-Source: AGHT+IEyy/adJDcKnfuNXmUk9FlMhWCjJZBhnDJE9MpthSK747RkLYKCFfnDoCLB32x9WAuGoNrWTA==
X-Received: by 2002:a19:3808:0:b0:513:c85e:2848 with SMTP id f8-20020a193808000000b00513c85e2848mr5258343lfa.34.1710604925827;
        Sat, 16 Mar 2024 09:02:05 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id an14-20020a17090656ce00b00a465b72a1f3sm422172ejc.85.2024.03.16.09.02.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 09:02:05 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so4021623a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:02:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVv+24m6yzsmbZNHNEp59f0DMMY+J8JNCrvPANuY5Xfm5cH0czdSuTkwJXVYR8Jpn6aEbNmr5aVzj2P27yPMbGFdsRdjhr+/2l4SXC0
X-Received: by 2002:a17:906:7f0e:b0:a46:141d:bf62 with SMTP id
 d14-20020a1709067f0e00b00a46141dbf62mr4663522ejr.73.1710604924499; Sat, 16
 Mar 2024 09:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315174939.2530483-1-pbonzini@redhat.com> <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com>
 <ZfTadCKIL7Ujxw3f@linux.dev> <ZfTepXx_lsriEg5U@linux.dev> <CABgObfaLzspX-eMOw3Mn0KgFzYJ1+FhN0d58VNQ088SoXfsvAA@mail.gmail.com>
In-Reply-To: <CABgObfaLzspX-eMOw3Mn0KgFzYJ1+FhN0d58VNQ088SoXfsvAA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Mar 2024 09:01:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtnzTZ-9h6Su2aGDYUQJw2yyuZ04V0y_=V+=SBxkd38w@mail.gmail.com>
Message-ID: <CAHk-=whtnzTZ-9h6Su2aGDYUQJw2yyuZ04V0y_=V+=SBxkd38w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 6.9 merge window
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 01:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Linus, were you compiling with allyesconfig so that you got
> CONFIG_KVM_ARM64_RES_BITS_PARANOIA on?

Regular allmodconfig.

> You can also make CONFIG_KVM_ARM64_RES_BITS_PARANOIA depend on !COMPILE_TEST.

No.

WTF is wrong with you?

You're saying "let's turn off this compile-time sanity check when
we're doing compile testing".

That's insane.

The sanity check was WRONG. People hadn't tested it. Stephen points
out that it was reported to you almost a month ago in

    https://lore.kernel.org/linux-next/20240222220349.1889c728@canb.auug.org.au/

and you're still trying to just *HIDE* this garbage?

Stop it.

                    Linus

