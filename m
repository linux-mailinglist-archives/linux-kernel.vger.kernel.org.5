Return-Path: <linux-kernel+bounces-161560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15038B4DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC22B20E51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40954745FD;
	Sun, 28 Apr 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NAbcl/g2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F777172B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714334502; cv=none; b=eSbWLx79JQy5DP1zryW5KfUcl9rRs9SM1eB71m6+5wLcrNayrcnd8OlpK0dYPD8oi8LDBYMWL6uIYCTHPqKhw0NnDRKc6PV90KoMnCSQKDNcpA7DyfVz4aG7weV9eVncr6ZL3MCBNZ/Sdj0yZUqubJ9IOWfWc9rIUHuMc2p9iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714334502; c=relaxed/simple;
	bh=/Q+bDcW8FGbBSw2YCBIscaZoTZy5JAddruxkYSnGwj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaH/xu18fAuzPQ237xFeQZKKmV4IcT84Qr/ZsVW3ycddvgXA9GUqdrY3eIGfyx7k3Kej2abq9jyDPfjEXk3q98eCPkD05CoULm6EL0jsx0eVz5cPj+0fqe5Z8+lmesIiv+cT4Ys7DpAxkV5qNRUIIRR3hjKswdJ63SufRiJ3SQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NAbcl/g2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51c077cfc09so4410995e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714334498; x=1714939298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAlWMFpu06lOa2HCRJcPKhFggZdYhuIIy04Pcfhn4Io=;
        b=NAbcl/g2vi8Ka51B1vsuUciX7tTbQQyj5e6joMpnQ7aLvqRA33y4a/zCz38l1cox4F
         yXah57HQfnauETg56EE4ORorycdj4o8u3SZtcz6yHjUZ0WfbhP+ygMvkvsJcb7qbHIH8
         je0L3wd37n+VMZg7nIxo4NinojPlJvdSwRyU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714334498; x=1714939298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAlWMFpu06lOa2HCRJcPKhFggZdYhuIIy04Pcfhn4Io=;
        b=osgueEW2bfKWNiEteTGw9RyJqZtZLnYJD2IBtIqyryHv0XcU6k+cAxekUJeiQpK68u
         lmlmviB4E+DOqrsi6Ew9S7S1vNi6vou5DaFod/gKv1DhWtKwkLHyaIwXPA1yFPvYINj7
         Iz79qGY6L/1q/ylnslzr0EtRvbJ2o0Phz9NY0+Sgu5D4O5XsqMjYsnVzoLuDA0rGvLVe
         d7X+9RKGuU40vAHSx+OuOgREp2hZ6KpB0FmEMtFebNpplIz9DH06y/RT1xkx2fqXvpYW
         RDnwl6Sl2CNLrYw9exGl8TTD8X//7m6cE2DaDrCxu16fHLM+ydGfCGaqIdvBruc/9ZLG
         X5OA==
X-Forwarded-Encrypted: i=1; AJvYcCVXUFk08JrCySRgMyz+eZraO3GKIrm94odwttfAkTa2I3UqQqbXNIrKKvVch4fHeWtNjneLU0k1b0FGZp0z5lgweDvnP50rHKUALuRN
X-Gm-Message-State: AOJu0YzQGXtQV/4u/XdEdlSO/v+tNYZPjuUo4ir/m9l4e+bz9INgzbIR
	pXT6Ij+0Mc7VuC+JQuOgQ2KpLvejFkOF1a4Xm4E/QSrLCw95BAq2FSr4sFZfHAHU674xbTZyal+
	6GlBJgQ==
X-Google-Smtp-Source: AGHT+IF5931WE17TsXYA7Cbrbu4P5d/NXv6MJ2tO8dpzBvFqY5TKa/yC3AZYzmWFvSgkzF/Gi0FEsw==
X-Received: by 2002:a05:6512:48d2:b0:515:a6dd:9657 with SMTP id er18-20020a05651248d200b00515a6dd9657mr4576980lfb.16.1714334498124;
        Sun, 28 Apr 2024 13:01:38 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25e29000000b0051b4c96c311sm2334588lfg.193.2024.04.28.13.01.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 13:01:37 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5194cebd6caso4223564e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvG85TlI+BGXWZBB8XPgPKig4GOC0Dx2TpYDduEDbLKOItcEF1grG6adhnfwdGQtW9fb8sBRd0HVP7hg7iMnkLcO52SPid4t4WrHXt
X-Received: by 2002:a05:6512:3a85:b0:51b:58c7:d04d with SMTP id
 q5-20020a0565123a8500b0051b58c7d04dmr6353661lfu.0.1714334496870; Sun, 28 Apr
 2024 13:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
In-Reply-To: <20240427231321.3978-1-hdanton@sina.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 13:01:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
Message-ID: <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 16:13, Hillf Danton <hdanton@sina.com> wrote:
>
> > -> #0 (&sighand->siglock){....}-{2:2}:
> >        check_prev_add kernel/locking/lockdep.c:3134 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> >        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
> >        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> >        force_sig_info_to_task+0x68/0x580 kernel/signal.c:1334
> >        force_sig_fault_to_task kernel/signal.c:1733 [inline]
> >        force_sig_fault+0x12c/0x1d0 kernel/signal.c:1738
> >        __bad_area_nosemaphore+0x127/0x780 arch/x86/mm/fault.c:814
> >        handle_page_fault arch/x86/mm/fault.c:1505 [inline]
>
> Given page fault with runqueue locked, bpf makes trouble instead of
> helping anything in this case.

That's not the odd thing here.

Look, the callchain is:

> >        exc_page_fault+0x612/0x8e0 arch/x86/mm/fault.c:1563
> >        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >        rep_movs_alternative+0x22/0x70 arch/x86/lib/copy_user_64.S:48
> >        copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
> >        raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
> >        __copy_from_user_inatomic include/linux/uaccess.h:87 [inline]
> >        copy_from_user_nofault+0xbc/0x150 mm/maccess.c:125

IOW, this is all doing a copy from user with page faults disabled, and
it shouldn't have caused a signal to be sent, so the whole
__bad_area_nosemaphore -> force_sig_fault path is bad.

The *problem* here is that the page fault doesn't actually happen on a
user access, it happens on the *ret* instruction in
rep_movs_alternative itself (which doesn't have a exception fixup,
obviously, because no exception is supposed to happen there!):

  RIP: 0010:rep_movs_alternative+0x22/0x70 arch/x86/lib/copy_user_64.S:50
  Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 83 f9 40 73 40 83 f9 08
73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 <c3> cc
cc cc cc 66 0f 1f 84 00 00 0$
  RSP: 0000:ffffc90004137468 EFLAGS: 00050002
  RAX: ffffffff8205ce4e RBX: dffffc0000000000 RCX: 0000000000000002
  RDX: 0000000000000000 RSI: 0000000000000900 RDI: ffffc900041374e8
  RBP: ffff88802d039784 R08: 0000000000000005 R09: ffffffff8205ce37
  R10: 0000000000000003 R11: ffff88802d038000 R12: 1ffff11005a072f0
  R13: 0000000000000900 R14: 0000000000000002 R15: ffffc900041374e8

where decoding that "Code:" line gives this:

   0: f3 0f 1e fa          endbr64
   4: 48 83 f9 40          cmp    $0x40,%rcx
   8: 73 40                jae    0x4a
   a: 83 f9 08              cmp    $0x8,%ecx
   d: 73 21                jae    0x30
   f: 85 c9                test   %ecx,%ecx
  11: 74 0f                je     0x22
  13: 8a 06                mov    (%rsi),%al
  15: 88 07                mov    %al,(%rdi)
  17: 48 ff c7              inc    %rdi
  1a: 48 ff c6              inc    %rsi
  1d: 48 ff c9              dec    %rcx
  20: 75 f1                jne    0x13
  22:* c3                    ret <-- trapping instruction

but I have no idea why the 'ret' instruction would take a page fault.
It really shouldn't.

Now, it's not like 'ret' instructions can't take page faults, but it
sure shouldn't happen in the *kernel*. The reasons for page faults on
'ret' instructions are:

 - the instruction itself takes a page fault

 - the stack pointer is bogus

 - possibly because the stack *contents* are bogus (at least some x86
instructions that jump will check the destination in the jump
instruction itself, although I didn't think 'ret' was one of them)

but for the kernel, none of these actually seem to be the case
normally. And even abnormally I don't see this being an issue, since
the exception backtrace is happily shown (ie the stack looks all
good).

So this dump is just *WEIRD*.

End result: the problem is not about any kind of deadlock on circular
locking. That's just the symptom of that odd page fault that shouldn't
have happened, and that I don't quite see how it happened.

               Linus

