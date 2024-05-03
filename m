Return-Path: <linux-kernel+bounces-167642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318FF8BAC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547371C227D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA36324A08;
	Fri,  3 May 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="plsu0EXA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F061EB31
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739685; cv=none; b=I6WfY6mheXurmi2/p0JPBLb+lOf0repj789GhxIT1PC+wQqEl9JBCcCt1OfRQsfqx/ARA73dkKlL65L7iGAQJjgjyCsuJ9321F8ATPV5RKdjX6sDowWOADzSG3xCQCm/nMzwcCbIKHaG5oro5ZC0O9koD4LioYh90gfcrpHJtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739685; c=relaxed/simple;
	bh=/W93gMGJGyWb6vgcQO2hTPyQCT1+wN2G+A++W9T6d+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2zOke0c77uz2VMvePkcR40PvE2XtZ+dfXQ3XUrs51UN3vIHKN6PcPoOedWn1UYKaD6riZkgpEqyF/rji24OgdPMb8ILE8/rKGPsxsNoW7vWzAyMPznJLQ3Urjn/9os4t02kVpHdcL6/H8rIfDYGVmb+I/P9HNGnItlZ+zeFAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plsu0EXA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec76185c0fso122795ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714739683; x=1715344483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGd5yQ+FbYYaeGV9S8djZOCUHtU56jARjfGFGSFbWAk=;
        b=plsu0EXAowSZ5N0lX06PlbCUhRNE4A1acCH9cu5s8NH5Cs8OGqdfwBgT4fyvMp5rIv
         o/AvugXhCm6S1jzZyJueZLiQeZeqQw8RNOYkp6SpWTd7tj4oopovRqs66RbwXdLQnZ63
         qHaA5HIcCauh/iLYTxJm0cLuowd5aaOpM8EzanEyV4PW/MpH/E8/txuE+DNpyJd/pZjb
         xl3hdvFUxovXXCTgfZSeroh6b4VA4NsSSh2DCkF+wpgQtCY7WgGw0kEZu2eb3HfUVotz
         rlJ3g3h++k0zaF3vG7Wtle4vVw+UYjkC/f/aTbZVqUZmshPjWvNTpYycEHx2pD5sXZr/
         G+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714739683; x=1715344483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGd5yQ+FbYYaeGV9S8djZOCUHtU56jARjfGFGSFbWAk=;
        b=fcISxXJyesK9uSsdk0zFkxaubGMuPPuc+2SzfxLTnrv8HI00kT7ISptlQtBg121V9v
         SHnGLwiDPmlfo1a+dkFIduEhtot50D9qtIM7mWjjfOTMdmFpj3dyri2+WvDhv/Ni+U/N
         J7bHhQ/Z1iJJQ8JHQthYeHCNOJ3CUjehTlXZgi37bicqwCgeIk4HjwO1fnl39APrQZEI
         7bxu/vVarmPaH0InfI5K1EWMzRh11qvg6WEjhcUWBxBnYPT6CHc7MNypc46Jr5ifWRuU
         9g2Q6txDh0vEYx+cTxzTpu95sh5u4uWRDWq/28nxyjVfMmzBJr+TesU6+cgt7PtqVy9u
         eiKw==
X-Forwarded-Encrypted: i=1; AJvYcCUiaHoLtlgJQYAPWgNwTGCNEYmIdEiW4FdWirFK1N6gcwvKBNZX/vSBpvtQNmzTlxWPqJC2Vyil0zhlXf1CP8r/GUSeFnUTo5BCZ6md
X-Gm-Message-State: AOJu0Yx9WcYpbRXpGIz1dQcbwxKNnuWjB4sOmIleh63RcJL4Zfdw6AFo
	teyELLTdtkbeoyWb2H0weD2WMqUzDzIcQtqwLhwx5BdyU7jvHd4VY9ifuBw8zcQb3T3LTFbqPEc
	8z2Eo3ZPKQWreu2/aVXSHxQsjCoHVj+1T+3Nu
X-Google-Smtp-Source: AGHT+IGLy6D3yQuVSWGCX/oTNa4GAxl57gtqrWYM2jk4hU2dAM/sY+AhNIzLrPUW+Hv3E6n9P/SIw+E3pd5D23lQqCE=
X-Received: by 2002:a17:902:eccc:b0:1e5:e5e8:73f7 with SMTP id
 d9443c01a7336-1ed2c5fc9d9mr2123955ad.2.1714739682281; Fri, 03 May 2024
 05:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dcd2ae06178bccb0@google.com>
In-Reply-To: <000000000000dcd2ae06178bccb0@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 3 May 2024 14:34:30 +0200
Message-ID: <CANp29Y5k1S5ETBibTzWv7y6jiKevOhMYg0LYqM+PGvuFYiM14A@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in skcipher_walk_virt
To: syzbot <syzbot+97b4444a5bd7bf30b3a8@syzkaller.appspotmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz set subsystems: bcachefs

On Fri, May 3, 2024 at 2:24=E2=80=AFPM syzbot
<syzbot+97b4444a5bd7bf30b3a8@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c169df18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbf5674960220=
57b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D97b4444a5bd7bf3=
0b3a8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b345b1c01095/dis=
k-f03359bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d59970ea319e/vmlinu=
x-f03359bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/47407f406f40/b=
zImage-f03359bc.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+97b4444a5bd7bf30b3a8@syzkaller.appspotmail.com
>
> loop3: detected capacity change from 0 to 32768
> bcachefs (loop3): mounting version 1.7: mi_btree_bitmap opts=3Dmetadata_c=
hecksum=3Dnone,data_checksum=3Dnone,nojournal_transaction_names
> bcachefs (loop3): recovering from clean shutdown, journal seq 10
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in skcipher_walk_virt+0x91/0x1a0 crypto/skcipher=
c:504
>  skcipher_walk_virt+0x91/0x1a0 crypto/skcipher.c:504
>  chacha_stream_xor+0x7c/0x710 crypto/chacha_generic.c:22
>  crypto_chacha_crypt+0x79/0xb0 crypto/chacha_generic.c:45
>  crypto_skcipher_encrypt+0x1a0/0x1e0 crypto/skcipher.c:671
>  do_encrypt_sg fs/bcachefs/checksum.c:107 [inline]
>  do_encrypt+0x99c/0xc30 fs/bcachefs/checksum.c:127
>  gen_poly_key fs/bcachefs/checksum.c:190 [inline]
>  bch2_checksum+0x21f/0x7c0 fs/bcachefs/checksum.c:226
>  bch2_btree_node_read_done+0x1898/0x75e0 fs/bcachefs/btree_io.c:1055
>  btree_node_read_work+0x8a5/0x1eb0 fs/bcachefs/btree_io.c:1324
>  bch2_btree_node_read+0x3d42/0x4b50
>  __bch2_btree_root_read fs/bcachefs/btree_io.c:1748 [inline]
>  bch2_btree_root_read+0xa6c/0x13d0 fs/bcachefs/btree_io.c:1772
>  read_btree_roots+0x454/0xee0 fs/bcachefs/recovery.c:457
>  bch2_fs_recovery+0x7adb/0x9310 fs/bcachefs/recovery.c:785
>  bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1043
>  bch2_fs_open+0x135f/0x1670 fs/bcachefs/super.c:2102
>  bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1903
>  legacy_get_tree+0x114/0x290 fs/fs_context.c:662
>  vfs_get_tree+0xa7/0x570 fs/super.c:1779
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
>  path_mount+0x742/0x1f20 fs/namespace.c:3679
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x725/0x810 fs/namespace.c:3875
>  __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3875
>  ia32_sys_call+0x3a9a/0x40a0 arch/x86/include/generated/asm/syscalls_32.h=
:22
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
>  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>
> Local variable __req_desc.i created at:
>  do_encrypt_sg fs/bcachefs/checksum.c:101 [inline]
>  do_encrypt+0x8f9/0xc30 fs/bcachefs/checksum.c:127
>  gen_poly_key fs/bcachefs/checksum.c:190 [inline]
>  bch2_checksum+0x21f/0x7c0 fs/bcachefs/checksum.c:226
>
> CPU: 1 PID: 15218 Comm: syz-executor.3 Not tainted 6.9.0-rc6-syzkaller-00=
131-gf03359bca01b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
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
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000dcd2ae06178bccb0%40google.com.

