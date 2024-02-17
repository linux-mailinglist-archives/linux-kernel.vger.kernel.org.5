Return-Path: <linux-kernel+bounces-69908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69246859020
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1C28148D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313397C095;
	Sat, 17 Feb 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCdjYkeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FB1D55C;
	Sat, 17 Feb 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708180484; cv=none; b=GYehPgttpO4n0L/oEee0xClm8Vq+DMr3o7W8CblRSrbQGmexfdxOThM34Rr+VPHYEaAi7UilLAMVCA9Wil5N83rpcE+xFMH4HX1l/P4j4hDQZbBec5uRUgGFfxgMyTjATFIg4h+WUDRkjIq+BnXdnoDc9o8TKFpLWEpjRA+atak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708180484; c=relaxed/simple;
	bh=SLSc3GxQL1q84Q8iVPAgz8CDIemeG87qKoHhxkcS0Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVH2B+GSxz0m+pwIKuYtLvWJrg/wmfsL+gCAk/1+2KBYDdxXHVLeRKzWIJQ+08fWtZEvb34EVPnRUEwqBdD0wEUTUl7dfQNtsTuYRnlYzDLFMTgheRD8msc1VlcJMEzdnyD6pDEaRHc+fa1NBlNgOmn9SUI5tDq+ZwgrUcO+HJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCdjYkeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01EEC433A6;
	Sat, 17 Feb 2024 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708180483;
	bh=SLSc3GxQL1q84Q8iVPAgz8CDIemeG87qKoHhxkcS0Cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gCdjYkeqJxRFNM+hmieM0lBgyWcFvyCvM5my97qbPAr3oAp3JjV6JTeZ4WS/pFfr+
	 MjPCm/X07NHA0lFzfr+qLm+c1JfRydl4RG9qf88f/iIjaf8GFQmcsSVg2YDumyh2e6
	 JjzFC8uRRfQTIV0W32LIQ6M0TfAe7z84IRRnV1hePJFlBKK6EgAoeU3JnfBOfj54xX
	 BbF2qxymHxDqA1Z4m2dExBbai78O/0RrqRa7A8Cd4XEVt5RT2m8vnpjDLgD3gWTgxp
	 6NssgYy5XP1wZmfFDWKDPXpUuyG5LMKxYrV5FGDKrL1hrT8xWL1DUMPyrn+I08GNim
	 ++dORMY/TLRAw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511ac32fe38so4431759e87.1;
        Sat, 17 Feb 2024 06:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIASzr3uCR/ezX8UlsCtdZedU1huAHDGDsgEUjERoHoI8oydm3xrzUFYYQsZhbfoEQDXfqAjKFZVB3hcMvfjKNB3vePFNPPrqnUaN+cgpaDRJuO2IujtsJAsKPhJew3bw8zo8QLeLAaXlF
X-Gm-Message-State: AOJu0Yxmfu+aVZOg8MNQ0mhAfzaMIHP7Mhs3zsRNCPBZXyH71C4A2Q/p
	0eNcYdEXOhG4M9lNG7umNWo1VzXaMVNyyQEz2RVxPpcHit+RqBe3ebmh23ef4fLlYBLfa9nNtlT
	jIOrTdpC8pkEwsJYj+OeYEwOdd4c=
X-Google-Smtp-Source: AGHT+IE3RwyLUlI9/AYiOu3xcsQXhAO+dbOmzx/o5m2VQWNAWMLmVQVMYmr9qZ/1wcLk+IeO8LTtWiU6yCmon0HRXk4=
X-Received: by 2002:ac2:5925:0:b0:512:aa8a:a91c with SMTP id
 v5-20020ac25925000000b00512aa8aa91cmr237062lfi.45.1708180481898; Sat, 17 Feb
 2024 06:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ff2c3f061189df71@google.com>
In-Reply-To: <000000000000ff2c3f061189df71@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 17 Feb 2024 15:34:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHQYuv2H5XA+abgj+Mw8xyxsoHARx2w-tT7jRrDLQ=EVg@mail.gmail.com>
Message-ID: <CAMj1kXHQYuv2H5XA+abgj+Mw8xyxsoHARx2w-tT7jRrDLQ=EVg@mail.gmail.com>
Subject: Re: [syzbot] [arm?] [crypto?] KASAN: invalid-access Read in neon_aes_ctr_encrypt
To: syzbot <syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
neon-aes-ctr-fix

On Sat, 17 Feb 2024 at 02:35, syzbot
<syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c664e16bb1ba Merge tag 'docs-6.8-fixes2' of git://git.lwn...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e83cc8180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b4dde08ba7d52a4b
> dashboard link: https://syzkaller.appspot.com/bug?extid=f1ceaa1a09ab891e1934
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fff792180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cbe4dc180000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-c664e16b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/864da5a66121/vmlinux-c664e16b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/044de3e4ddc5/Image-c664e16b.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: invalid-access in neon_aes_ctr_encrypt+0x15c/0x1ec arch/arm64/crypto/aes-modes.S:599
> Read at addr fcff000006797ff1 by task syz-executor675/3149
> Pointer tag: [fc], memory tag: [fe]
>
> CPU: 1 PID: 3149 Comm: syz-executor675 Not tainted 6.8.0-rc4-syzkaller-00005-gc664e16bb1ba #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:291
>  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:298
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x48/0x60 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x108/0x618 mm/kasan/report.c:488
>  kasan_report+0x88/0xac mm/kasan/report.c:601
>  report_tag_fault arch/arm64/mm/fault.c:334 [inline]
>  do_tag_recovery arch/arm64/mm/fault.c:346 [inline]
>  __do_kernel_fault+0x17c/0x1e8 arch/arm64/mm/fault.c:393
>  do_bad_area arch/arm64/mm/fault.c:493 [inline]
>  do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:772
>  do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:848
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:398
>  el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:458
>  el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
>  neon_aes_ctr_encrypt+0x15c/0x1ec arch/arm64/crypto/aes-modes.S:599
>  ctr_encrypt+0xfc/0x144 arch/arm64/crypto/aes-neonbs-glue.c:230
>  crypto_skcipher_decrypt+0x4c/0x60 crypto/skcipher.c:695
>  _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
>  skcipher_recvmsg+0x39c/0x46c crypto/algif_skcipher.c:221
>  sock_recvmsg_nosec net/socket.c:1046 [inline]
>  sock_recvmsg net/socket.c:1068 [inline]
>  sock_recvmsg net/socket.c:1064 [inline]
>  sock_read_iter+0xec/0x118 net/socket.c:1138
>  call_read_iter include/linux/fs.h:2079 [inline]
>  new_sync_read fs/read_write.c:395 [inline]
>  vfs_read+0x2cc/0x304 fs/read_write.c:476
>  ksys_read+0xe8/0x104 fs/read_write.c:619
>  __do_sys_read fs/read_write.c:629 [inline]
>  __se_sys_read fs/read_write.c:627 [inline]
>  __arm64_sys_read+0x1c/0x28 fs/read_write.c:627
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x34/0xd8 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
>
> The buggy address belongs to the physical page:
> page:0000000060acabc6 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x46797
> flags: 0x1ffc28000000000(node=0|zone=0|lastcpupid=0x7ff|kasantag=0xa)
> page_type: 0xffffffff()
> raw: 01ffc28000000000 fffffc0000168bc8 fffffc0000199e08 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff000006797d00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff000006797e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >ffff000006797f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                                                                 ^
>  ffff000006798000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff000006798100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

