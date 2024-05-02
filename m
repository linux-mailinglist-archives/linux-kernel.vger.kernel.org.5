Return-Path: <linux-kernel+bounces-166548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF68B9C24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E8A1C216D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741813C69D;
	Thu,  2 May 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSoaFphU"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878C13C692
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659307; cv=none; b=sHIHE8j5c9n9Hzw5WAD9n3hrVaCGDmqTNGfmEC3guE6JouaWy/smK+1zIHPxvvxI5N0fLJO7UsTB2ycpcJG32vErmmrYvtCi3B6kWnx/R9srAri7draWXVntr7+0/m3fMzArSKIVCSIQF3puKMeo2fcPB5K9VX6LPMgqzvuOtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659307; c=relaxed/simple;
	bh=X25at9+jpvUR/gjEBumSvhwcXP2ZqF5tD9Lgc/oVnvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV/0zp7Z+ddFoEJq7UP3aOiZv0xpC4LJ3UuGwvKsfwQx2bnOa/a6z6zvQ0pswvFYO1RmudN28iYRPT9FREEpFeUpO1oHTX0G7QUJRBpMPWHpDYZPw5cNeAMqBQPISn4RQlYrENbXTzV19Ryd1Cpt5+9Ff5Ruzll5lassTI/kyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSoaFphU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso79019871fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714659304; x=1715264104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3X7xru1omPYA6l4R3nqNUFsGsK7E2fsHc6EKFxBQBYc=;
        b=bSoaFphUiOer7DVUxk/yuIQjhhEbJsJrmTDQBbW56uIbS0WPbqCCM5a66AZCPiipYa
         IsM0eoPUzaCkpCDhilc63QX9bx8NvXO2rloEGHQ9EpSD7At2lnfljl19rJHY5Obsr8Sf
         Ua0Sx4ynwJlnnSfle/AH5mfUOAiU2s9KspRdXioPgEe/6vm2n/vUpK38k4tg5o8oc8ck
         rQ0Fbnn3bRaDqL5SY+PtltapJC6bEIE1G7z5+HMVRcJZZk+91EQPSCVpde/ihGzFi7U9
         MSfhsEXTPboQ6xKShYacfb8EjUZTFk4HwSEocpJpcvkBwKFddh/d6YHgv8UbVrmGx9dn
         z5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714659304; x=1715264104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3X7xru1omPYA6l4R3nqNUFsGsK7E2fsHc6EKFxBQBYc=;
        b=fuf8ehgETIsQdatSSnFGNDEFu6rpn0Ln2r0UG/xiMATRz/TsHIBdlyB2pFaI5mHuoE
         fQBHrNTOkERPFDOoMjaYDuG9Yb3eQT7QMS6ae51cdviqO7R3Z2Rdk2YY47uX+OTxMUYW
         Zsv4IEt2bqZ2vBWGFOGX0L9ufGeuR9EZsd8/HEE4sjW25RUvPlXZQ9/Tynfvl8qbrLpa
         g+aUwFj8MlteJs1jZ+NQznnxV3YCmkzqBD+0bTU/TAX8fDuxh2HhwFN4DNm+fPt4OQ+8
         MG3yrTViQoQ+chBdCfDI9xsP0ft2TyZPm/KN7zxAO7e3V8ufnuNRjrAOpIlK5qVZeJMK
         l7rg==
X-Forwarded-Encrypted: i=1; AJvYcCXLgin7EnkXJ1RXbsFc33c7HisVMR5prWilaHSpEhs/cECDZkuhe+NVWU8l43dWBKIrh6smBATVInuxHFA0joJvSgP0WjRhMAkuxu/R
X-Gm-Message-State: AOJu0Yzi6B7fNxqAHBwGaTqoGTt4Ow40T1XyMqjum/JIbf7IufU0ibn2
	8YHCooP2yE/CKQJ2lX4MEzLYtk6Rr5FbwVVZeaWPC6I+OXCXjFYiWIP+G4Ab6bLUKAJpFAAcYko
	honydXw+1nJV5FfE6GAHjxkMf1Hdh9Pz3VH2i
X-Google-Smtp-Source: AGHT+IGmYT47Aq+P7Z7pOJBuPGMYHYEZBKGe87dVBLPuZN9lSpBnQPkLAAOOiC+kHhw1GJbq/Wt9lNGN4YznMfTEWz0=
X-Received: by 2002:a2e:bc1c:0:b0:2d6:e295:e81f with SMTP id
 b28-20020a2ebc1c000000b002d6e295e81fmr2291285ljf.35.1714659303881; Thu, 02
 May 2024 07:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
In-Reply-To: <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 2 May 2024 16:14:23 +0200
Message-ID: <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: paulmck@kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 23:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 1 May 2024 at 13:15, Marco Elver <elver@google.com> wrote:
> >
> > This is relatively trivial:
> >
> > #ifdef __SANITIZE_THREAD__
> > #define __data_racy volatile
> > #endif
>
> I really wouldn't want to make a code generation difference, but I
> guess when the sanitizer is on, the compiler generating crap code
> isn't a huge deal.
>
> > In some cases it might cause the compiler to complain if converting a
> > volatile pointer to a non-volatile pointer
>
> No. Note that it's not the *pointer* that is volatile, it's the
> structure member.
>
> So it would be something like
>
>         const struct file_operations    * __data_racy f_op;
>
> and only the load of f_op would be volatile - not the pointer itself.
>
> Of course, if somebody then does "&file->f_op" to get a pointer to a
> pointer, *that* would now be a volatile pointer, but I don't see
> people doing that.

This is the case I thought of. I still think everything is working as
intended then, since passing a pointer to a __data_racy variable
should be done with pointers to __data_racy (just like other type
qualifiers - the rules are by virtue of implementation equivalent to
volatile). Not a problem, just an observation.

> So I guess this might be a way forward. Anybody want to verify?

I sent a patch to add the type qualifier - in a simple test I added it
does what we want:
https://lore.kernel.org/all/20240502141242.2765090-1-elver@google.com/T/#u

I'll leave it to Tetsuo to amend the original patch if __data_racy makes sense.

Thanks,
-- Marco

> Now, the "hung_up_tty_fops" *do* need to be expanded to have hung up
> ops for every op that is non-NULL in the normal tty ops. That was a
> real bug. We'd also want to add a big comment to the tty fops to make
> sure anybody who adds a new tty f_op member to make sure to populate
> the hung up version too.
>
>                 Linus

