Return-Path: <linux-kernel+bounces-30004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DE831695
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3521F24F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57216208C9;
	Thu, 18 Jan 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbpdsxtI"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCB2033F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573311; cv=none; b=AbeL1346C0nEPzheed6hUsrBkHhYxxxSL7TAEzOltQ/MHh8gb9nn/NN3oi8tKYXNkedwRhqHPwb6o3RsL/vbHGkoOj4oT5rQ8l3+wi1vleOUHwEpAgZJZskCf3KYXyZIx3PSCR0ryQ3j9YL6Qp+IyZ3ktiAUXv+jkxm9Y0usHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573311; c=relaxed/simple;
	bh=9JvO3V4hl/Z0FCis6bH5EbIWoAgoCguGO7f11qpUOOY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=KkjRWoJAsdDAIKAcPVdeNFegHsluvZjUVs6Pejp/otaAU0BHyr6adaQAai3OiH5t5/ylKkJJ31+Nn8yhhO2MYPj+OKBbKw5e6+A7pohko2ZRd7PF5KYT2siBdmxjR/EOgdpz1k6if1fhCKSyxOiZaUvnVVODJ+Ezf4fTljVgEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbpdsxtI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-559f5db8f58so3768a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705573307; x=1706178107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+q54GlvDsPAI/ZP1E3lIxmlVL+R6yvHYDIqhE6fh+KE=;
        b=pbpdsxtIwPFhhaba9fEohC9laTCO9h6OnzqBUnvyNSTtzfOUiGJb0DfOos9ymORmuy
         0p8ECF0isat8xeGHlJPed+cYiBZAqs9+j1DzeCBbiO/r23o3yWOwZvCDnV9urNWQy1mZ
         WmFcPSJLUeHb5DPAM3j1sKfeMf8azTmJ6R0dSqbXGL71Op9kPeVDHq4IskM9MhYf5YSD
         7VUEZmdHIwRfvRBLtwaSLMeBhwKbSpgRHAfJBK+DSFmjv+lyg1Ue0T7B6u38U6iX70Er
         pRnTiqAhczz5vzSVSTt88GQw85YO8dfTPtOuOouUA1LvevOBU47pWl3+Ed5XozWREWPP
         5WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705573307; x=1706178107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q54GlvDsPAI/ZP1E3lIxmlVL+R6yvHYDIqhE6fh+KE=;
        b=CG4grACgXgUuMcT3ucvmVeK4svVqmDbB/hnHgqJCQiJaj7pAZdyvrHMW1XsYFU84KX
         3cebEvAGKA/HfWwMdrT4tSm9//eaFZFK0Stf1XqWr2LZ6OZ+UZkHMdQayy+Sk9zBkgbO
         RceiwI0SKbq2ezyrr0EplSowEzqSOd9BtEUTMjkvdCcRVbwgUpjNJ+T88dFpaUVi8Wjb
         pmDRi/3r82PZkAeACAQQiihGS77fKo92GxSe0+IVPVGfHf+kOwlH+RLzfcRyafBTIQ7f
         zad0ETtM4TFhWqhiEdR1PRwyoQRTtJFQzccqFVt6FANTWdY+40FuGjy593dMWUuP6BXj
         pItA==
X-Gm-Message-State: AOJu0Ywnq/n7JAMukwcjimTcCgp4I9acLwmQcXZoqoHctWtduo4RQo1Q
	pNzr28IAB103p+uWdQrnPcWOCXDXQsKkR5Koo2aZauAkjIjo5k2FHCgww3lrSqfhnI6S82QmJ82
	8rUwSp1kL/QlF8ypsWhKSUUqKNal1WUEAEVH/
X-Google-Smtp-Source: AGHT+IE976k/qq8a7JoY2DbX801O4oqjq1Ncg4qIuOynNsHCmuA8vEymhmZfdmjdT1igZpXyOJUPOsEowLJOhonEKdE=
X-Received: by 2002:a05:6402:2061:b0:559:b668:90b5 with SMTP id
 bd1-20020a056402206100b00559b66890b5mr43365edb.2.1705573307367; Thu, 18 Jan
 2024 02:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a135c0060a2260b3@google.com> <00000000000037f0f3060af9e763@google.com>
In-Reply-To: <00000000000037f0f3060af9e763@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 18 Jan 2024 11:21:34 +0100
Message-ID: <CACT4Y+YBGDYbhXvpEAo6iXS--QOSsUxXqkGZxOpUCuCd3CM3aQ@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
To: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>, 
	Matthew Wilcox <willy@infradead.org>, wzhmmmmm@gmail.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 14:18, syzbot
<syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1678a3cce80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
> dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com
>
> Bluetooth: hci0: hardware error 0x00
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
> Read of size 8 at addr 0000000000000078 by task kworker/u5:1/4455
>
> CPU: 1 PID: 4455 Comm: kworker/u5:1 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> Workqueue: hci0 hci_error_reset
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  kasan_report+0xd9/0x110 mm/kasan/report.c:588
>  check_region_inline mm/kasan/generic.c:182 [inline]
>  kasan_check_range+0xef/0x190 mm/kasan/generic.c:188
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]

Wonder if this is fixed with:

ida: Fix crash in ida_free when the bitmap is empty

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af73483f4e8b6f5c68c9aa63257bdd929a9c194a

?

>  ida_free+0x218/0x2e0 lib/idr.c:511
>  hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
>  hci_conn_del+0x78c/0xe10 net/bluetooth/hci_conn.c:1183
>  hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2643
>  hci_dev_close_sync+0x5a7/0x1160 net/bluetooth/hci_sync.c:5021
>  hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
>  hci_error_reset+0xa6/0x190 net/bluetooth/hci_core.c:1059
>  process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> ==================================================================
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000037f0f3060af9e763%40google.com.

