Return-Path: <linux-kernel+bounces-83920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FDD86A07F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1097DB33594
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86B14A4D6;
	Tue, 27 Feb 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAfta2hI"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FCEEDD;
	Tue, 27 Feb 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061813; cv=none; b=mqpi+zcPWhu/RNddvLkOKnIEHzb+hHqqt+nTjM5CTyUQKmNByHhY93CVbXOqszXteSeSGJbvWtaqJp+znE3BdDSflKNuxINMrc+CO7A79yrM3NTtHlt/YSAYQsojEJJfyK68xjLIUwJEPvZXKQzX0/NPW0kpIx3zhWwcRz+Dpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061813; c=relaxed/simple;
	bh=RKNXJxzH67afXdGkNi658qvZRdPJD2gnkLBuWIeIHGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa+dk8pP707RX8u+Y4MY6tTabpU5LYgjTsaUkLsOSRCb2MMdXRFfGAE1MuEAlhKXHnbYU8VW2skeSPu+fX6VagZ78lvouR9gUCVfoSXNtT3frojA8Y39lb7KxsShO36iYD8TcQFx0/ONI088PlOCkis5VngcX/eCa5MQQsEcfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAfta2hI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3523133a12.2;
        Tue, 27 Feb 2024 11:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709061811; x=1709666611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYwCbmjKocTjulplHt7AuBEg6yNJXLZajqJ8qfbT28E=;
        b=WAfta2hI2ZrAiNKBB7YGckJ47fnMNCALGVTVfMRPsjHqZHqwSfgJnePNlghAU4+16X
         BsK9nSjRZnn4hqAcJ55LhKdrsDNxRKgbNaE7kmkKo8CEF/Do2FZcbbylCIPiHPVBxAks
         jSLz3goWsKqTb2BnksPK3eEGQSqV0AmQioHic1zN7HzEdO30KKAWB0t4IQrfCJxz2a04
         phrmR0dAQ3kgforRnH3QX4/dfKiwyEB1Hdu8sOdshpVXZz8gJRdwta3IUYQ93aplHCSz
         lN0LB9e+PuSL/8WvEOzlYJLwIY+KfJ0ffXXYlisYwyFyyuCrX+rC3pE7ZS+v4FflG/3r
         qbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061811; x=1709666611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYwCbmjKocTjulplHt7AuBEg6yNJXLZajqJ8qfbT28E=;
        b=RhDNBNOZwBpmv0kmLEi+j4KtkQH6UPSI2mx+OIcuEq78x+3mc0YM9oyZ71VDYd0LKn
         QPT92Rmx3h60JNLySAYcn0oiRpe6XsaeNAaddBoCm8UCQOxGe9fTzRd30iim7oqP1knW
         Pv5v1j/qbGNUTFXlTnOuw33LhUzORAqRWfdGUgIfRJLKrrRZPO4fW+slYlM1yqyKZLQ9
         yvuz4fDRGhLbbPSZMIJvIMj1CFw5g3a1RK6T4uXsn9enQQNU6A8hP3qQbBrrAk73fLja
         GRFvKDZ3Xsc/SNFTLSbK+0e5H6Oowb+U2fkrtJdwq5DzaftGsTcL582iesNtWgIbmi0V
         qrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr8BqgF+4A/XGt216vDJit+u/QrI+KJtldzmGHTTpbiMaNXKjJsHVrGho/ch7uiA+LfmgvVALfzBt1mCJ6WBXc1tAcPR8+cF/CaSU=
X-Gm-Message-State: AOJu0YxvACQiB1zJ6qlWZn9RyJbtWL1Geh6JrlrzjLxNEN1d7nW4UaZ6
	kvMQn51b4TPiZyHxMqkGa2faLpxzfvCM9/0bSZOFu+7vZg2Efqc5Rhz9qvB/UBQHywkCBcm/WMY
	yVZhLWmI5M/RmuB3oXAN0IVJVxQ==
X-Google-Smtp-Source: AGHT+IElZiB4w9pFF3whnjteYaxWjx9JKTlcUXLgCE1EQA0YupucYFeY1cCft9hAHiyGOSm9PXMRPRR9g08ntxihazk=
X-Received: by 2002:a17:90a:6047:b0:299:3efe:8209 with SMTP id
 h7-20020a17090a604700b002993efe8209mr8178469pjm.4.1709061810765; Tue, 27 Feb
 2024 11:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALGdzurFCbu8hg5n9SpbRkJiH7pYt1OcwiXcviOM57Am7gvN8g@mail.gmail.com>
In-Reply-To: <CALGdzurFCbu8hg5n9SpbRkJiH7pYt1OcwiXcviOM57Am7gvN8g@mail.gmail.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Tue, 27 Feb 2024 13:23:19 -0600
Message-ID: <CALGdzuriibTyqRmB4_nVx1W=ALASubu0xeFoxOPtEt+0v4yLJA@mail.gmail.com>
Subject: Re: [Linux Kernel Bug][drivers/media/dvb] possible deadlock in dvb_demux_release
To: mchehab@kernel.org, linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Zijie Zhao <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Developers for DVB,

I am reaching out to query if there is any update for this possible
deadlock in dvb_demux_release.

If any further information is required, please let me know.

Best,
Chenyuan

On Thu, Feb 1, 2024 at 10:08=E2=80=AFAM Chenyuan Yang <chenyuan0y@gmail.com=
> wrote:
>
> Dear Linux Developers for DVB,
>
> We encountered "possible deadlock in dvb_demux_release" when testing
> the dvb driver with Syzkaller and our generated specifications.
>
> The C and syz reproducers and the config for the kernel are attached.
>
> ```
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.6.0-gd2f51b3516da #1 Not tainted
> ------------------------------------------------------
> syz-executor325/10412 is trying to acquire lock:
> ffff8880468d8ad8 (&dmxdev->mutex){+.+.}-{3:3}, at:
> dvb_dmxdev_filter_free linux/drivers/media/dvb-core/dmxdev.c:833
> [inline]
> ffff8880468d8ad8 (&dmxdev->mutex){+.+.}-{3:3}, at:
> dvb_demux_release+0x8a/0x600
> linux/drivers/media/dvb-core/dmxdev.c:1246
>
> but task is already holding lock:
> ffffc9000a5aa4c0 (&ctx->mutex){+.+.}-{3:3}, at: _dmxdev_lock+0x40/0x90
> linux/drivers/media/dvb-core/dvb_vb2.c:110
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&ctx->mutex){+.+.}-{3:3}:
>        __lock_release linux/kernel/locking/lockdep.c:5467 [inline]
>        lock_release+0x3c0/0x870 linux/kernel/locking/lockdep.c:5773
>        __mutex_unlock_slowpath+0x9e/0x600 linux/kernel/locking/mutex.c:90=
7
>        dvb_demux_do_ioctl+0x3ab/0x1630
> linux/drivers/media/dvb-core/dmxdev.c:1171
>        dvb_usercopy+0xc2/0x280 linux/drivers/media/dvb-core/dvbdev.c:986
>        dvb_demux_ioctl+0x31/0x40 linux/drivers/media/dvb-core/dmxdev.c:11=
85
>        vfs_ioctl linux/fs/ioctl.c:51 [inline]
>        __do_sys_ioctl linux/fs/ioctl.c:871 [inline]
>        __se_sys_ioctl linux/fs/ioctl.c:857 [inline]
>        __x64_sys_ioctl+0x1a2/0x210 linux/fs/ioctl.c:857
>        do_syscall_x64 linux/arch/x86/entry/common.c:51 [inline]
>        do_syscall_64+0x40/0x110 linux/arch/x86/entry/common.c:82
>        entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> -> #0 (&dmxdev->mutex){+.+.}-{3:3}:
>        check_prev_add linux/kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add linux/kernel/locking/lockdep.c:3253 [inline]
>        validate_chain linux/kernel/locking/lockdep.c:3868 [inline]
>        __lock_acquire+0x24a1/0x3b40 linux/kernel/locking/lockdep.c:5136
>        lock_acquire linux/kernel/locking/lockdep.c:5753 [inline]
>        lock_acquire+0x219/0x650 linux/kernel/locking/lockdep.c:5718
>        __mutex_lock_common linux/kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x14c/0x940 linux/kernel/locking/mutex.c:747
>        dvb_dmxdev_filter_free linux/drivers/media/dvb-core/dmxdev.c:833 [=
inline]
>        dvb_demux_release+0x8a/0x600 linux/drivers/media/dvb-core/dmxdev.c=
:1246
>        __fput+0x287/0xbf0 linux/fs/file_table.c:394
>        task_work_run+0x16d/0x260 linux/kernel/task_work.c:180
>        exit_task_work linux/./include/linux/task_work.h:38 [inline]
>        do_exit+0xc38/0x2c00 linux/kernel/exit.c:871
>        do_group_exit+0xd9/0x2b0 linux/kernel/exit.c:1021
>        get_signal+0x244a/0x2640 linux/kernel/signal.c:2904
>        arch_do_signal_or_restart+0x86/0x7e0 linux/arch/x86/kernel/signal.=
c:309
>        exit_to_user_mode_loop linux/kernel/entry/common.c:168 [inline]
>        exit_to_user_mode_prepare+0x150/0x250 linux/kernel/entry/common.c:=
204
>        __syscall_exit_to_user_mode_work linux/kernel/entry/common.c:285 [=
inline]
>        syscall_exit_to_user_mode+0x1b/0x50 linux/kernel/entry/common.c:29=
6
>        do_syscall_64+0x4d/0x110 linux/arch/x86/entry/common.c:88
>        entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&ctx->mutex);
>                                lock(&dmxdev->mutex);
>                                lock(&ctx->mutex);
>   lock(&dmxdev->mutex);
>
>  *** DEADLOCK ***
> ```
>
> If you have any questions or require more information, please feel
> free to contact us.
>
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
>
> Best,
> Chenyuan

