Return-Path: <linux-kernel+bounces-108527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710D880BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C391F22669
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09CA22F14;
	Wed, 20 Mar 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djw/hfap"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744622338;
	Wed, 20 Mar 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918754; cv=none; b=LxsGh4bj0BPYCAr3qsj6oEsT/yTtm+065UuznGaV/YvGYPen7xab9GY4LMP96Y4XJDvVla7eTUXvr6lHrsfP7oPhG5ea8ZNfkN4RpzcoOpn3HZzBMsFpk4ryKryk/+XPC+NklFNT9xcxdrk4c7aglXm3YW83FCSAGeRfU6PQtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918754; c=relaxed/simple;
	bh=u+vwlIL+BjXnieQaL//3T118BuiOTfwN6PA5EB6CqpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gaegap56J+lwtGFgLI9E1ufJN67c8I8fBgUTQxCi/vHKDKyXc828nmH08vGQ+Ij91chZwQWprefpcQSKu2qtijdldVnPOpP41LcaShmGdks+7YN5odhI/s14QWtXMoE/TxmkRDLo+IccqQ/xQw/7xSMUP59UoEX5kF/6okVAvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djw/hfap; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34169f28460so1853107f8f.2;
        Wed, 20 Mar 2024 00:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710918751; x=1711523551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b72yw6/Y3U1dEMZ408V4yz17v8cgFxh5ATyHQeyOS3U=;
        b=djw/hfapgkIEE65XN8ayxDI6IJiHHXOl+/Q1QEa2Ex9l9MCf93OKkPjysC+oS7niQM
         0UIhPJuuWx770F98X7rNDel6Az4vaykws9B4nj9YKduwuZhZVk/SE53xJ3HW92BOuL3y
         v1gw71/SR8kK6eH0g2K9hjcErhkIoBM3DJTxDQG/c4Al5v/I2BavJ/6aldxZThiDnv2F
         DxWbji2kzTctowPKDuzJFpGtYrP25CG3H17lMXwrwZzOlgCjtP4FXJwCvMoCdtQe0cIx
         NvcT6TcEnBgvbdd2iCwd4TlFZ2xDY6zvgT+ahqN7yuRXH8roBF0tQicreubvXifLqjfj
         /1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710918751; x=1711523551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b72yw6/Y3U1dEMZ408V4yz17v8cgFxh5ATyHQeyOS3U=;
        b=fua/VS2dhijJAaqLayF+ew8mllfp1/qRe6tCiFRMLp109N1aoUvNks/DMvQ6exlAWU
         hGHc/4DySIY00LjvVglXXAlYeCaXOGx80P/rwILIGDRlJcp0t0hHFQMKCsgP6Ez45CdR
         7LAXcf4xD+07agtFHvi866d07FH5J/96KOfIUSZwVCNP+4DmZ+E0S8A8FIFr8vXYJr2s
         4SSah+aqoi2+z8FlXZo5ArbfUkoTy7PyUS2IXbBoNT+qq18ztSh3VTKG8xUjJqh6tjXg
         b8pdK/EV2c+wxPC6pB0IP+/VxkCGI5k/B5JRYBR1ms3WdPKCddT3mvTYdlnZJvC5Gh8U
         fv9w==
X-Forwarded-Encrypted: i=1; AJvYcCVwppbVjWLEUBLos1afFleLtCW1li7qKyoSkwRKvDfkD9mj1QlrIvmTl4DFe/jWoFVfpgAhet5MJkLjdVIICwla5ppYRzMagTMF73sOXV5LSskcd87rFQjhO6FaH/MBcTpK
X-Gm-Message-State: AOJu0YylSaW3WFDeHJXQv6ra+IcPMpXYYF2bXP2TIqXOUeWW0SDJysfn
	J571PPFffhx3wNXj+zRdfoQusOcwEBfp9u+3r7u9BjLx/Qd1nrgrX7SIsjKWGzg+d8dlKlnA5/G
	xf5exTI+3ij33HZUoRSs7baRQp50=
X-Google-Smtp-Source: AGHT+IFCLSaYWtIMWvB56vjO8jKQktH7CFnTJ7RxadECHs78As9eHz2d/wqGOT3MrQUf5Kqq8istXXclSG/82hNqJHU=
X-Received: by 2002:a05:6000:711:b0:33d:2f2f:b135 with SMTP id
 bs17-20020a056000071100b0033d2f2fb135mr3951989wrb.46.1710918750544; Wed, 20
 Mar 2024 00:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e40a2906072e9567@google.com> <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
 <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com> <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
In-Reply-To: <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Mar 2024 00:12:19 -0700
Message-ID: <CAADnVQL6Q3k0+-5X3Xjov7W_xESxkmVXcsCxQRWitQvhTBsf7A@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:05=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/03/20 15:56, Alexei Starovoitov wrote:
> > This has nothing to do with bpf.
> > bpf never calls printk().
>
> Please see the Sample crash report in the dashboard.
> bpf program is hitting printk() via report_bug().

Exactly. local_bh_neable is simply asking for a splat.
_this_ bug is in printk.
It's a generic issue.

sockmap bug is orthogonal.
It's already being looked at.

> -> #0 (console_owner){....}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
>        console_emit_next_record kernel/printk/printk.c:2901 [inline]
>        console_flush_all+0x810/0xfd0 kernel/printk/printk.c:2973
>        console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
>        vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
>        _printk+0xd5/0x120 kernel/printk/printk.c:2367
>        __report_bug lib/bug.c:195 [inline]
>        report_bug+0x346/0x500 lib/bug.c:219
>        handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
>        exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
>        asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
>        __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
>        spin_unlock_bh include/linux/spinlock.h:396 [inline]
>        __sock_map_delete net/core/sock_map.c:424 [inline]
>        sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
>        bpf_prog_2c29ac5cdc6b1842+0x42/0x46
>        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>        __bpf_prog_run include/linux/filter.h:657 [inline]
>        bpf_prog_run include/linux/filter.h:664 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>        bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
>        trace_sched_switch include/trace/events/sched.h:222 [inline]
>        __schedule+0x250b/0x49d0 kernel/sched/core.c:6733
>        __schedule_loop kernel/sched/core.c:6813 [inline]
>        schedule+0x14b/0x320 kernel/sched/core.c:6828
>        ptrace_stop+0x5b4/0x940 kernel/signal.c:2358
>        ptrace_do_notify kernel/signal.c:2395 [inline]
>        ptrace_notify+0x255/0x380 kernel/signal.c:2407
>        ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>        ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>        syscall_exit_work+0xbd/0x170 kernel/entry/common.c:167
>        syscall_exit_to_user_mode_prepare kernel/entry/common.c:194 [inlin=
e]
>        __syscall_exit_to_user_mode_work kernel/entry/common.c:199 [inline=
]
>        syscall_exit_to_user_mode+0x273/0x360 kernel/entry/common.c:212
>        do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
>

