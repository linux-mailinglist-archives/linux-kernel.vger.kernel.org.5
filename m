Return-Path: <linux-kernel+bounces-74836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51885DCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146131F22B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9617E593;
	Wed, 21 Feb 2024 13:59:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068B78B4B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523962; cv=none; b=sMonWcyO6WHYplxAknfzxQwAaBXBg+ed4LWiohAyp+9O2Q5ozv7SsGOZZttzGLZ0Nru+95YQySenk+uSMUUPQOPtfsbeW6w+Zx43RH9QrO6h2x2ZqhFAHSUlyjX7hV2JruzpumJqAICzlsYcvLUxLyLY4vfpGT3VPUEsAUOc1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523962; c=relaxed/simple;
	bh=bgNYNGgBU3vKVD3hJeRfH6WNTKsC0XsOvq3Gyh63Rcs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uWk4yItIQRozUNstv/TK4UqRlWDpFZVnuNO3//YbefalzfEoLTiL5AwxX0q+h/VTbBVIxdGryXfYCaiEKjmm7tbDPHMOzYK+r25zB0fGg97HQsxoc+bsi5efHPNpQ65DvXAi7osp/Sd6XiyXPPIfh7/Lki/mmIPdkukb8kE1cRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-364f951ecc1so54111865ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523960; x=1709128760;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ad+ua+BVfwbD9f80Z4OzvkTux8hoWET6X36f44Mygqs=;
        b=tLxd6q+KUrrkr+AobQos1yLZgowBeg22SoqrWLA+EJUaY/4w6vbREDlOKLKyeqhrvd
         jkcZropuMcBR0klqjKhIZx8PcsT/+PRBahIKna3i5degVY/+vJK86YkJT2wlSzDvVRZW
         6nyairersnzU6j3sVKD++qsBihllu76dUgo2UnlNcPFJAz79qzFAAzvz5W0y4r7CgoZA
         OprSiZnfYxT1e+3AvCSMCOwdwnflkrabcweaCmZjtr9jGyx4R6hc8AJ8nGnyFTOFXTjx
         pWaFna6v45Upwb4mQm2Zq5O7x7mOCSWNaAcjtOe7Ug45EKzFkRv3DRMXMQwcyPZ7aOwp
         L2rw==
X-Forwarded-Encrypted: i=1; AJvYcCUIAtGVKilB0DlfpeHPafXUUShweJscNzRqrnyS7+MG7Il7/t4jSKU+zzrJYv4kaYpSWf7aEFX/hqX0j9J7zgelKeOZTZN0qAcpsOYX
X-Gm-Message-State: AOJu0YxahsrtYV2YRNOu+Ld/IgQEeY3Hhf1AsKTTucsDnrZND3tueCgJ
	sJnU+ab0+CVCUlaZ1g6qMTFKydLatxp2K2DD5i+6kiAzTvnnDgmKJDA2RcpmyV+hkPL/YwJRdoo
	X0H8JkYrJfNizWu6EkYT3pc1s9XyAy1nNA87CIUPbVnQbVbUDYSF9ysc=
X-Google-Smtp-Source: AGHT+IEUE5+GIp8gEbbnSmpCYapMUxkAQcWuKpRlehfmIELt6hwbMmEeiO6394TLvTBUqd9Dtx1/MZKZWKo2oqyoekgX2Tpaeujs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:365:21f4:7005 with SMTP id
 h18-20020a056e021d9200b0036521f47005mr944769ila.4.1708523960168; Wed, 21 Feb
 2024 05:59:20 -0800 (PST)
Date: Wed, 21 Feb 2024 05:59:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc78610611e4bba1@google.com>
Subject: [syzbot] [kvm?] KMSAN: uninit-value in em_ret
From: syzbot <syzbot+ee5eb98a07d2c1fb30df@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b401b621758e Linux 6.8-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cd41c2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
dashboard link: https://syzkaller.appspot.com/bug?extid=ee5eb98a07d2c1fb30df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c32ff3cbe7ed/disk-b401b621.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17621a870a21/vmlinux-b401b621.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b06ad3ca55ee/bzImage-b401b621.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee5eb98a07d2c1fb30df@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in assign_eip_near arch/x86/kvm/emulate.c:829 [inline]
BUG: KMSAN: uninit-value in em_ret+0x124/0x130 arch/x86/kvm/emulate.c:2238
 assign_eip_near arch/x86/kvm/emulate.c:829 [inline]
 em_ret+0x124/0x130 arch/x86/kvm/emulate.c:2238
 x86_emulate_insn+0x1d87/0x5880 arch/x86/kvm/emulate.c:5292
 x86_emulate_instruction+0x13c9/0x30a0 arch/x86/kvm/x86.c:9171
 kvm_emulate_instruction arch/x86/kvm/x86.c:9251 [inline]
 complete_emulated_io arch/x86/kvm/x86.c:11208 [inline]
 complete_emulated_mmio+0x70b/0x8b0 arch/x86/kvm/x86.c:11268
 kvm_arch_vcpu_ioctl_run+0x1837/0xb890 arch/x86/kvm/x86.c:11380
 kvm_vcpu_ioctl+0xbfc/0x1770 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4441
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0x225/0x410 fs/ioctl.c:857
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable eip created at:
 em_ret+0x37/0x130 arch/x86/kvm/emulate.c:2234
 x86_emulate_insn+0x1d87/0x5880 arch/x86/kvm/emulate.c:5292

CPU: 0 PID: 5793 Comm: syz-executor.0 Not tainted 6.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

