Return-Path: <linux-kernel+bounces-162255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F258B58AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9885A1F247CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB883C2C6;
	Mon, 29 Apr 2024 12:35:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A936BA50
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394130; cv=none; b=mkOhsmbw2ecnbNqIdoHkSbGe8bFUKvKqqkWh0C8p8uJ2ebqQUr2ikQY51i7whFb+n0vGDS+p3V+y5DB+AdlhSiNNEq+igtuj8qBX3juXuwgcwPrZl4dNefM0vLljKunkIEWEiX4cZb40xz5IG0uNp5I9od7kF7aXJTbVCZhCYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394130; c=relaxed/simple;
	bh=dcdrL/Klx14x2N4xF4zjGQHhPe/9vDGniCF+z9WFz4c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gRGHH34w9Icnp/EyrG1lC2f0lCtyXoHNTKVxJbRl50pDHe4QuQdhnSFVtdfvZa+n/y2JvP6NQ0+DktvaZ0KSigmbC0oK+qqj2tAuu874uKuSwYyeNPNvD6kJdcamGj/EWpdWrQnaekYhXxwwViRRXD9XLi38Da39XdljLTgk0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3699565f54fso47000885ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394128; x=1714998928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QNL9vLwRhY9DtqBmEx3ErrK8DdxJJL6LhUFx7+sHUA=;
        b=wwO6mULDuVmJ8IOSaqz456nNpYzBPnSRuE0BuuzTV6AaV9Qts2OxUqBbqvcHr90sZ4
         633azNTO407QAt0bHAj3Nl/Lj6pX+afa5xbZEecR2PrSTgcHbumU1kVt/7ZlMm7fIie0
         FYXrRiqZXI26CsOjlbMcgTRQKwYb9We8eOihsuQvHHNH7lL+sy8jKSJAJOIRm+HIm6QR
         dXgpyEjqAQM7+JG8Uyr3qmYxkg64MIpbpYIFvL9xsG/4uD9dHwUAfZKeWbnJkfz4T32l
         Hh4M28NwkVq/Zyd77hMY0lwbNQNDuSG1XZxtYcrMqU1ori+5Hfk8Mwh5IGrtj66ATAc0
         KLPg==
X-Gm-Message-State: AOJu0Yxx/jF17Dkl7358moMrw+ZAYV+LrGtLp+lnq92ZN95K8D9DjoAY
	Cg4HYcJITpUKsC1xODqRNYiChmMdRZDVd7YgRiA8Oh1rg7vcAnHgw8zDaEGmCmbjByczTkkmx60
	QwKKC84gBDkQveAl4Pa2stLKMRl38EgTalEsyk/vytRGeBxkjsscREzE=
X-Google-Smtp-Source: AGHT+IGfoWFCS1dCiqVKKz658YTIsFcZD+K72Fd9nGJ/874P7Chth5eMUNaF6I/lyBY3FGzHxslu5mCeDS19bO/pDpQdxt9tl5Io
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:36b:2731:7337 with SMTP id
 j12-20020a056e02218c00b0036b27317337mr216029ila.4.1714394128359; Mon, 29 Apr
 2024 05:35:28 -0700 (PDT)
Date: Mon, 29 Apr 2024 05:35:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006b93606173b7d42@google.com>
Subject: [syzbot] Monthly mm report (Apr 2024)
From: syzbot <syzbot+list861a5a60b62783e8e318@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 10 new issues were detected and 7 were fixed.
In total, 47 issues are still open and 238 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10216   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7374    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  840     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<4>  719     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<5>  653     No    KCSAN: data-race in generic_fillattr / shmem_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
<6>  372     Yes   inconsistent lock state in __mmap_lock_do_trace_acquire_returned
                   https://syzkaller.appspot.com/bug?extid=76f802bc1dee8ba28a6e
<7>  114     Yes   WARNING in kunmap_local_indexed
                   https://syzkaller.appspot.com/bug?extid=691cb37358791bebebe6
<8>  62      Yes   BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot
                   https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
<9>  38      Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<10> 18      Yes   kernel BUG in filemap_unaccount_folio
                   https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

