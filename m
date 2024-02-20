Return-Path: <linux-kernel+bounces-73542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A385C3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AF52863EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C412FF7E;
	Tue, 20 Feb 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fspexrKX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDB6A8D0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454816; cv=none; b=pw0FivWtLUE2qyfNy8SQnUQXbia/4NxeaxIAbjVEZ4ZJEDab3b4bFbdvhEqUiauhAwlEaJCn7CZmpo2G1UuKz4OEd0PDG9p2iDjJKsgDUekRFP3MOJyr0kY12ra42IWCBLMLf0UtAlniNnw6LiNnqpMdwPa9/UBbN9n6pq3NnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454816; c=relaxed/simple;
	bh=S5/+BMhufhlU+j4tI5F6lpIQUxppM1KAAFV9/YfJhKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJcMafBPzOm5QvJzOE/0/lg+DG4jqMsghknkduk8wEzMJQxg8hKqQZ45b3VqABzcS30mSLGFUWgkeq1l9NM+iNA4g45bQg1SWN2SUIZWAnEQzNFLJxXNVx5WhcNin5UNFen4o/QFbj+s7deH0JF2EIdpKZO+mwzYUzBuruFTPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fspexrKX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7431e702dso56956615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708454814; x=1709059614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IOuxIDb5Z0KCM+pcpaR4R/cgjAJTg+4LwAhQ75Rsbc=;
        b=fspexrKXbl4gXlMfzSRHGgH15XjyCFpV11nRwzoOWHGFmGOv0TbfR4Ek1eQ+iSWR+w
         skZHysaPRJ8+FrfhdEGAweELXBrl1X4xq0cCJgbgvZP4quupORIENlz3HFtvkedj0FjI
         7+MRmBDdMeu1Cr/L5Q56MzCxqaCCxpLsxbUto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454814; x=1709059614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IOuxIDb5Z0KCM+pcpaR4R/cgjAJTg+4LwAhQ75Rsbc=;
        b=plqi8BprGQNCWPGVTsm02+6XT6IZ0E/5R8mG8Mw5XXoi/tnP7BW8Vj5QXANQe8o4fH
         8KYUYEztIw+ghRv9zNG2w/K/GfeE0rfnoDsibqzzB3NfJhoOj/ePZrMxtt+ZMyDjr0IO
         rdZVYTGaJ/jxtBfOFlHlNtLGQRMdoS1VtFv0XFk15Q/1/U8omTHP9zbVa69bOf2bWOv6
         kSeB3FcLCAnoMdYTP9AaI/BUVCbpLmLmmNA2Sk3BV9FKoThrjTb9WRqbyqPvihhW5GAf
         Wpk7z3bKTHHJSa4U1YMJsKalX10is6cstSRx+evMV4FpFAttMHmseVgqNRORBX7cH6ri
         k87Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgk+EGEDyR1lW9KXE1EOVToRKafQ+fvU15JzcWBUvyclWpi4QU30aItou0fQdLkpOM5HMwe+eUY22Y7BMJKfmoPmg7NqNwwf9vxkeH
X-Gm-Message-State: AOJu0YzTskR9a4YGi8qQgcCe/In/ZBBCQ9Q/rjUqHD3wHv6IH704pnVL
	59oPGY7F8r7FpwS1MVmV4GhorMZp9ihkHnzuS+s5s3lbTtTlJvY2B5HYQFrv0Q==
X-Google-Smtp-Source: AGHT+IFWA7Nied3uq9/sUXiW7CQVX4GmtTjuyjDQg/qgZ6qivlQZYt51G4sdK+dbdLKr9lHPIDBdrg==
X-Received: by 2002:a17:903:22c7:b0:1db:f372:a93c with SMTP id y7-20020a17090322c700b001dbf372a93cmr6133046plg.43.1708454813927;
        Tue, 20 Feb 2024 10:46:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mf8-20020a170902fc8800b001d9fc6cb5f2sm6596094plb.203.2024.02.20.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:46:53 -0800 (PST)
Date: Tue, 20 Feb 2024 10:46:52 -0800
From: Kees Cook <keescook@chromium.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: syzbot <syzbot+0c35af046fa98c893c84@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [hardening?] BUG: bad usercopy in raw_getsockopt
Message-ID: <202402201045.F3C4279A9D@keescook>
References: <00000000000038b6700611d207b3@google.com>
 <9a98f3f1-6a39-4b05-b100-93be1361fd76@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a98f3f1-6a39-4b05-b100-93be1361fd76@hartkopp.net>

On Tue, Feb 20, 2024 at 05:28:17PM +0100, Oliver Hartkopp wrote:
> The issue has already been fixed with the next commit in net-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=c8fba5d6df5e476aa791db4f1f014dad2bb5e904
> 
> Sorry for the effort - but really good to see, that the problem has been
> catched automatically. Good job!

Thanks!

And this also nicely demonstrated the zero-init mitigation as well: the
uninitialized "val" pointer was NULL, not random stack contents. :)

#syz fix: can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS

-Kees

> 
> Best regards,
> Oliver
> 
> On 2024-02-20 16:40, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    74293ea1c4db net: sysfs: Do not create sysfs for non BQL d..
> > git tree:       net-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13dcc4b4180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=970c7b6c80a096da
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0c35af046fa98c893c84
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f38cf8180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136d41c2180000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9bca2f6e074e/disk-74293ea1.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/611a08387d8f/vmlinux-74293ea1.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/78c388071345/bzImage-74293ea1.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0c35af046fa98c893c84@syzkaller.appspotmail.com
> > 
> > usercopy: Kernel memory exposure attempt detected from null address (offset 0, size 4)!
> > ------------[ cut here ]------------
> > kernel BUG at mm/usercopy.c:102!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 1 PID: 5070 Comm: syz-executor201 Not tainted 6.8.0-rc4-syzkaller-01053-g74293ea1c4db #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> > Code: 49 89 ce 48 c7 c3 40 db b7 8b 48 0f 44 de 48 c7 c7 e0 d9 b7 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 01 c5 60 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> > RSP: 0018:ffffc90003a3fc50 EFLAGS: 00010296
> > RAX: 0000000000000057 RBX: ffffffff8bb7db20 RCX: b071ef5fcc834300
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffffffffffffffff R08: ffffffff81753e6c R09: 1ffff92000747f28
> > R10: dffffc0000000000 R11: fffff52000747f29 R12: 0000000000000001
> > R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000555555f8e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020001480 CR3: 000000001f404000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   __check_object_size+0x601/0xa00
> >   check_object_size include/linux/thread_info.h:215 [inline]
> >   check_copy_size include/linux/thread_info.h:251 [inline]
> >   copy_to_user include/linux/uaccess.h:190 [inline]
> >   raw_getsockopt+0x37a/0x490 net/can/raw.c:852
> >   do_sock_getsockopt+0x373/0x850 net/socket.c:2373
> >   __sys_getsockopt+0x270/0x330 net/socket.c:2402
> >   __do_sys_getsockopt net/socket.c:2412 [inline]
> >   __se_sys_getsockopt net/socket.c:2409 [inline]
> >   __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2409
> >   do_syscall_64+0xf9/0x240
> >   entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > RIP: 0033:0x7f21bfe782a9
> > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffcdfc8f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
> > RAX: ffffffffffffffda RBX: 00007ffcdfc8f208 RCX: 00007f21bfe782a9
> > RDX: 0000000000000008 RSI: 0000000000000065 RDI: 0000000000000003
> > RBP: 00007f21bfeeb610 R08: 0000000020001480 R09: 00007ffcdfc8f208
> > R10: 0000000020001440 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffcdfc8f1f8 R14: 0000000000000001 R15: 0000000000000001
> >   </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> > Code: 49 89 ce 48 c7 c3 40 db b7 8b 48 0f 44 de 48 c7 c7 e0 d9 b7 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 01 c5 60 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> > RSP: 0018:ffffc90003a3fc50 EFLAGS: 00010296
> > RAX: 0000000000000057 RBX: ffffffff8bb7db20 RCX: b071ef5fcc834300
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffffffffffffffff R08: ffffffff81753e6c R09: 1ffff92000747f28
> > R10: dffffc0000000000 R11: fffff52000747f29 R12: 0000000000000001
> > R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000555555f8e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020001480 CR3: 000000001f404000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> > 

-- 
Kees Cook

