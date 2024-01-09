Return-Path: <linux-kernel+bounces-21287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86301828D17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C561F260A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624BA3D0B4;
	Tue,  9 Jan 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pg1mqblB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7F03D0A8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2821884a09so262178966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704827164; x=1705431964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kchsDNvY+N1Y+L0STMRE2XwLjK0LDqCqr/Bo9NQy0c8=;
        b=Pg1mqblBSY0YxRY6cBgnp0pEMbCLiW5hI2QnBRxoHUnRLL9hwfomkPMsO1VtrL1kTV
         uDzD7dSAJ9r7aRIbODzFwNg9Qol6KLmS7T1yeOPRSWmgd7tMkOcW5MorsZ2Wnq5fIVbM
         2rT3YeR2OAAWQnogT+erjQgEinw1YMQeH8qqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827164; x=1705431964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kchsDNvY+N1Y+L0STMRE2XwLjK0LDqCqr/Bo9NQy0c8=;
        b=D3Tp2Qk4ioiyK56Kwb7AbwH7io/NSIjWkLDXMWgJFmAO5po8/XlyJTb0Nhy3k+G7tQ
         9fUGeROIIzWEvCqNqP2XF1JRTWKA9XM6d5e+2kZa22G3ELkkHiQHXD92XX7M8JG11zWU
         EGDjentFbj7g2bzGcb7+nBu8PxNkoZThvFyF//McyFWHHlUq4Mx5nGvUF6yjQ5ZIyvvY
         3HO8HBKlbtRfy5/i2+/V58uSvAP0FNzUqel4+/J9ziTANiqnOM7kAUsx1CaikwQl9aoA
         SPseH75rUAoS8/4gJSM3Gzg9/Gm4vojKRl+s4Z3Y/GXuUtUix4RrED82QJXMxC1heCo8
         LSdA==
X-Gm-Message-State: AOJu0Yw4/xH6Pn79tZzFtBKjq+6emHo6qTH87IUubf2QGpl7gRb0hKC9
	+vJM6PKLAcQELzsfnMSjc0jkeFOy7rEwGN/1J0EVH2LK9ClE2ptL
X-Google-Smtp-Source: AGHT+IFuHSOp0+SP/+pe9lKLT3C/C6uVTrUrExD4zFvYIqoYejNsV0ahD7RPUgDTUsk5/PDsbG4tsA==
X-Received: by 2002:a17:906:e94:b0:a28:b8b1:afbd with SMTP id p20-20020a1709060e9400b00a28b8b1afbdmr955283ejf.35.1704827163676;
        Tue, 09 Jan 2024 11:06:03 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id qq10-20020a17090720ca00b00a26f0f49dd2sm1338115ejb.11.2024.01.09.11.06.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 11:06:02 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2814fa68eeso264037766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:06:02 -0800 (PST)
X-Received: by 2002:a17:906:945:b0:a28:ddb2:1fb8 with SMTP id
 j5-20020a170906094500b00a28ddb21fb8mr991620ejd.61.1704827162252; Tue, 09 Jan
 2024 11:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a41b82060e875721@google.com>
In-Reply-To: <000000000000a41b82060e875721@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jan 2024 11:05:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgM=MmqrQC-qgXoSehW=itHaqOUiBfN8jRBGAHn1=D0tg@mail.gmail.com>
Message-ID: <CAHk-=wgM=MmqrQC-qgXoSehW=itHaqOUiBfN8jRBGAHn1=D0tg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in signal_wake_up_state
To: syzbot <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, michael.christie@oracle.com, 
	mst@redhat.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Oleg/Eric, can you make any sense of this?

On Tue, 9 Jan 2024 at 10:18, syzbot
<syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com> wrote:
>
> The issue was bisected to:
>
> commit f9010dbdce911ee1f1af1398a24b1f9f992e0080

Hmm. This smells more like a "that triggers the problem" than a cause.

Because the warning itself is

> WARNING: CPU: 1 PID: 5069 at kernel/signal.c:771 signal_wake_up_state+0xfa/0x120 kernel/signal.c:771

That's

        lockdep_assert_held(&t->sighand->siglock);

at the top of the function, with the call trace being

>  signal_wake_up include/linux/sched/signal.h:448 [inline]

just a wrapper setting 'state'.

>  zap_process fs/coredump.c:373 [inline]

That's zap_process() that does a

        for_each_thread(start, t) {

and then does a

                        signal_wake_up(t, 1);

on each thread.

>  zap_threads fs/coredump.c:392 [inline]

And this is zap_threads(), which does

        spin_lock_irq(&tsk->sighand->siglock);
        ...
                nr = zap_process(tsk, exit_code);

Strange. The sighand->siglock is definitely taken.

The for_each_thread() must be hitting a thread with a different
sighand, but it's basically a

        list_for_each_entry_rcu(..)

walking over the tsk->signal->thread_head list.

But if CLONE_THREAD is set (so that we share that 'tsk->signal', then
we always require that CLONE_SIGHAND is also set:

        if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
                return ERR_PTR(-EINVAL);

so we most definitely should have the same ->sighand if we have the
same ->signal. And that's true very much for that vhost_task_create()
case too.

So as far as I can see, that bisected commit does add a new case of
threaded signal handling, but in no way explains the problem.

Is there some odd exit race? The thread is removed with

        list_del_rcu(&p->thread_node);

in __exit_signal -> __unhash_process(), and despite the RCU
annotations, all these parts seem to hold the right locks too (ie
sighand->siglock is held by __exit_signal too), so I don't even see
any delayed de-allocation issue or anything like that.

Thus bringing in Eric/Oleg to see if they see something I miss.

Original email at

    https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/

for your pleasure.

            Linus

