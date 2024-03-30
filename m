Return-Path: <linux-kernel+bounces-126139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1FE8932AD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831721C20994
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA56757FB;
	Sun, 31 Mar 2024 16:25:13 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313713FD99;
	Sun, 31 Mar 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902311; cv=fail; b=kw+xaRRGviqccNs6SrxlrlqkQWtt/F365IUL2T9Cw3cFlBu6T5Gt+ixobhWvo0udt97CMm4NJLFWkheRdkWQ86bwoB/ya2C48X9rdhWRu/91IEge0ls93SFM7BN6vCN+vtyG1vrfVJ7P4gORw0YWEhlKlnQdpjz0ViY6rWRO2Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902311; c=relaxed/simple;
	bh=BWifmfgTMPXHPpw3oX+rwHve0FFWaL8lNkqjQ3bw6jI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JAZFst1spEL5piSaMduCN25sBXCX9J3PX1xoFQeKD/f4dvrVBdSOeCKN2rvrMajHblluPAKZoSU6pICXE4HOncal8dRb/84uJ+UL+eFfyd8xTr7FHLE4KAiZcFULIGUs64ZqGxu9oVeJ9MCwR7bL/d+HckdXKIRJ7cV6PmfvZZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=fail smtp.mailfrom=syzkaller.appspotmail.com; arc=none smtp.client-ip=209.85.166.200; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syzkaller.appspotmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E8129207D8;
	Sun, 31 Mar 2024 18:25:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORjMLZpfdmT9; Sun, 31 Mar 2024 18:25:04 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B762A20612;
	Sun, 31 Mar 2024 18:25:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B762A20612
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id A7B0780004A;
	Sun, 31 Mar 2024 18:25:04 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:25:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:49 +0000
X-sender: <netdev+bounces-83500-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAINPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAXAAAAmYoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 24730
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83500-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 8CC612025D
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711796548; cv=none; b=PosxYqb1zAY/YDAhdASyjwR3d02h4pA4RJzdPR+plZUs9RfH5g8OtO2sBS2TnFf98Yce0jYp5FEJEnmSSnp3KZ9sxciz2ioegNK09cd1ej9m3RbtAYYwQtRYnT1F9Ky3qPpFAh/LSW+6jZrDm7xL/XdWDYJOLr3zo4Dv18vK3yw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711796548; c=relaxed/simple;
	bh=yPcfTvipI2/+vcDGEXJhfS40amnwmytukAZNlZ00LQs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qExrOcNVU+859vmsVDqF7BLLwYxKZvZLmhoT5Y0laDAa2J2Qoqzq78Zfk4THLzVX2U/bVN3peeWOLWmacwbOfwVSJnao0hUTzj7M5P6/PMHiPae567nKqCCXvLko87onfk5ZXpnPV4Ij1btQLoTlM8k6FKrOu+nho0M+nol+jVQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711796545; x=1712401345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53tpjewSWu0Vresc93uaKcyJznO8Iz9abIky6N2xuK8=;
        b=Lemjv6aYFA/ePK7C2eMHpA3UmYM2ypJnPjfwM478q1hTiEXhT6RDJ1EonEMBjWLavM
         gKCvS9crJbn2WxMn6E9+xnzWhBbRxNQ34VluwhgRjQPr8sjckRnwvgkuju6ZxRZ0O+2L
         NeG/VgZyzjiIv7e3eCn8xLNYlpZhGPk4HEfHtu+OBXU5cLBCI/i3P7IFn2xjm9u4ai8O
         y+tGs2BbALLn9GEKvUmaTxaGU0J7/3Bu0atXrxyKY2OWzFXk5ux/++8X90FNkM+RleQB
         S7XCRlRPtZ0GGSPOK9Gw4Ik02d5Atbm4VlH09mzd0xkpEsEusleFBKlWtB11EsyEUQDT
         fgFg==
X-Forwarded-Encrypted: i=1; AJvYcCV/6QrjSwqi4gGxUzVso4hdZRNXb19ibQKeEqVeXP7Vn/YecPpcxyILHoESrkx9g+WincGJTOSMpdG9Hocm4nat1ibCplm0
X-Gm-Message-State: AOJu0YxX8znVuVSNHyk4q7Qg/juCPMbuw6f4ConwHSvpxphntVCtBzky
	zJ9fQcBUj+PNO0N195aTQOE3w8s5t/AtYx9/UFenDRIVdEfHi8jE3CJuH1D9G0b+m/8SCFSQwdt
	+AjmnSadxsSAK8axoefcYjIHJrRr5MR1uiBEZRFiQSojfmiP5LaHNtTQ=
X-Google-Smtp-Source: AGHT+IHv69JzOfvTT29TShFoM/iodtSW6dmhPzDpDQg2zztHr8hSEYTmewIQpE/qHaWyeJ9BmGXrYmPL7FCNH6qlTCEmh8lPzblN
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:368:8135:4559 with SMTP id
 g5-20020a056e02198500b0036881354559mr352355ilf.6.1711796545698; Sat, 30 Mar
 2024 04:02:25 -0700 (PDT)
Date: Sat, 30 Mar 2024 04:02:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008cd6e0614deb1db@google.com>
Subject: [syzbot] [nfc?] [net?] WARNING: locking bug in nci_close_device (2)
From: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
To: <davem@davemloft.net>, <edumazet@google.com>,
	<krzysztof.kozlowski@linaro.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking.=
.
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D12ae3185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaeac3f3565b057=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3De29c204bd2e3906fe=
69c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-=
707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-=
707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Ima=
ge-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 10856 at kernel/locking/lockdep.c:232 check_wait_conte=
xt kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 0 PID: 10856 at kernel/locking/lockdep.c:232 __lock_acquire+0=
x78c/0x763c kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 0 PID: 10856 Comm: syz-executor.1 Not tainted 6.8.0-rc7-syzkaller-g707=
081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff800099ba7240
x29: ffff800099ba7500 x28: ffff0000d7f65a00 x27: ffff0000d7f664f0
x26: 1fffe0001afecc9e x25: ffff0000d7f66458 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000000c17 x21: ffff8000922364c0
x20: 0000000000000000 x19: ffff0000d7f664f4 x18: 1fffe000367fff96
x17: 0000000000000000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000040000 x10: 0000000000022c3d x9 : afcfeb2b6d9f9a00
x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099ba6b38 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __flush_workqueue+0x14c/0x11c4 kernel/workqueue.c:3146
 nci_close_device+0x140/0x5b8 net/nfc/nci/core.c:567
 nci_dev_down+0x40/0x54 net/nfc/nci/core.c:639
 nfc_dev_down net/nfc/core.c:161 [inline]
 nfc_rfkill_set_block+0x14c/0x2d0 net/nfc/core.c:179
 rfkill_set_block+0x18c/0x37c net/rfkill/core.c:346
 rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1305
 vfs_write+0x3c0/0xc3c fs/read_write.c:588
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 2283
hardirqs last  enabled at (2283): [<ffff800080297cac>] raw_spin_rq_unlock_i=
rq kernel/sched/sched.h:1397 [inline]
hardirqs last  enabled at (2283): [<ffff800080297cac>] finish_lock_switch+0=
xbc/0x1e4 kernel/sched/core.c:5154
hardirqs last disabled at (2282): [<ffff80008ae46784>] __schedule+0x2bc/0x2=
4b4 kernel/sched/core.c:6625
softirqs last  enabled at (546): [<ffff80008003165c>] local_bh_enable+0x10/=
0x34 include/linux/bottom_half.h:32
softirqs last disabled at (544): [<ffff800080031628>] local_bh_disable+0x10=
/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address dfff800000000018
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
Mem abort info:
  ESR =3D 0x0000000096000005
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x05: level 1 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[dfff800000000018] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 10856 Comm: syz-executor.1 Tainted: G        W          6.8.0-r=
c7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff800099ba7240
x29: ffff800099ba7500 x28: ffff0000d7f65a00 x27: ffff0000d7f664f0
x26: 1fffe0001afecc9e x25: ffff0000d7f66458 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000000c17 x21: ffff8000922364c0
x20: 0000000000000000 x19: 00000000000000c4 x18: 1fffe000367fff96
x17: 0000000000000000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000040000 x10: 0000000000022c3d x9 : afcfeb2b6d9f9a00
x8 : 0000000000000018 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099ba6b38 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __flush_workqueue+0x14c/0x11c4 kernel/workqueue.c:3146
 nci_close_device+0x140/0x5b8 net/nfc/nci/core.c:567
 nci_dev_down+0x40/0x54 net/nfc/nci/core.c:639
 nfc_dev_down net/nfc/core.c:161 [inline]
 nfc_rfkill_set_block+0x14c/0x2d0 net/nfc/core.c:179
 rfkill_set_block+0x18c/0x37c net/rfkill/core.c:346
 rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1305
 vfs_write+0x3c0/0xc3c fs/read_write.c:588
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 34000ee8 aa1f03e8 91031113 d343fe68 (38ec6908)=20
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	34000ee8 	cbz	w8, 0x1dc
   4:	aa1f03e8 	mov	x8, xzr
   8:	91031113 	add	x19, x8, #0xc4
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	38ec6908 	ldrsb	w8, [x8, x12] <-- trapping instruction


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

X-sender: <netdev+bounces-83500-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAD9Pp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAYAAAAmYoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 24740
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 12:02:38 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 12:02:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 45C052025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 12:02:38 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.446
X-Spam-Level:
X-Spam-Status: No, score=3D-2.446 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, FROM_LOCAL_HEX=3D0.006,
	HEADER_FROM_DIFFERENT_DOMAINS=3D0.249, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_MED=3D-2.3, SORTED_RECIPS=3D2.499, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=3Dno
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_HQH-_t2Beg for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 12:02:37 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83500-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com A9F0D20322
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id A9F0D20322
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88E52832B5
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C3A2BAF6;
	Sat, 30 Mar 2024 11:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.1=
66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C217745
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.166.200
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711796548; cv=3Dnone; b=3DPosxYqb1zAY/YDAhdASyjwR3d02h4pA4RJzdPR+plZU=
s9RfH5g8OtO2sBS2TnFf98Yce0jYp5FEJEnmSSnp3KZ9sxciz2ioegNK09cd1ej9m3RbtAYYwQt=
RYnT1F9Ky3qPpFAh/LSW+6jZrDm7xL/XdWDYJOLr3zo4Dv18vK3yw=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711796548; c=3Drelaxed/simple;
	bh=3DyPcfTvipI2/+vcDGEXJhfS40amnwmytukAZNlZ00LQs=3D;
	h=3DMIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=3DqExrOcN=
VU+859vmsVDqF7BLLwYxKZvZLmhoT5Y0laDAa2J2Qoqzq78Zfk4THLzVX2U/bVN3peeWOLWmacw=
bOfwVSJnao0hUTzj7M5P6/PMHiPae567nKqCCXvLko87onfk5ZXpnPV4Ij1btQLoTlM8k6FKrOu=
+nho0M+nol+jVQ=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dfail (=
p=3Dnone dis=3Dnone) header.from=3Dsyzkaller.appspotmail.com; spf=3Dpass sm=
tp.mailfrom=3DM3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=
=3Dnone smtp.client-ip=3D209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dfail (p=3Dnone di=
s=3Dnone) header.from=3Dsyzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3DM3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36854f4e9b=
3so25783045ab.2
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 04:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711796545; x=3D1712401345;
        h=3Dto:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3D53tpjewSWu0Vresc93uaKcyJznO8Iz9abIky6N2xuK8=3D;
        b=3DLemjv6aYFA/ePK7C2eMHpA3UmYM2ypJnPjfwM478q1hTiEXhT6RDJ1EonEMBjWL=
avM
         gKCvS9crJbn2WxMn6E9+xnzWhBbRxNQ34VluwhgRjQPr8sjckRnwvgkuju6ZxRZ0O+=
2L
         NeG/VgZyzjiIv7e3eCn8xLNYlpZhGPk4HEfHtu+OBXU5cLBCI/i3P7IFn2xjm9u4ai=
8O
         y+tGs2BbALLn9GEKvUmaTxaGU0J7/3Bu0atXrxyKY2OWzFXk5ux/++8X90FNkM+Rle=
QB
         S7XCRlRPtZ0GGSPOK9Gw4Ik02d5Atbm4VlH09mzd0xkpEsEusleFBKlWtB11EsyEUQ=
DT
         fgFg=3D=3D
X-Forwarded-Encrypted: i=3D1; AJvYcCV/6QrjSwqi4gGxUzVso4hdZRNXb19ibQKeEqVeX=
P7Vn/YecPpcxyILHoESrkx9g+WincGJTOSMpdG9Hocm4nat1ibCplm0
X-Gm-Message-State: AOJu0YxX8znVuVSNHyk4q7Qg/juCPMbuw6f4ConwHSvpxphntVCtBzk=
y
	zJ9fQcBUj+PNO0N195aTQOE3w8s5t/AtYx9/UFenDRIVdEfHi8jE3CJuH1D9G0b+m/8SCFSQwd=
t
	+AjmnSadxsSAK8axoefcYjIHJrRr5MR1uiBEZRFiQSojfmiP5LaHNtTQ=3D
X-Google-Smtp-Source: AGHT+IHv69JzOfvTT29TShFoM/iodtSW6dmhPzDpDQg2zztHr8hSE=
YTmewIQpE/qHaWyeJ9BmGXrYmPL7FCNH6qlTCEmh8lPzblN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:368:8135:4559 with SMTP id
 g5-20020a056e02198500b0036881354559mr352355ilf.6.1711796545698; Sat, 30 Ma=
r
 2024 04:02:25 -0700 (PDT)
Date: Sat, 30 Mar 2024 04:02:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008cd6e0614deb1db@google.com>
Subject: [syzbot] [nfc?] [net?] WARNING: locking bug in nci_close_device (2=
)
From: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
To: <davem@davemloft.net>, <edumazet@google.com>,
	<krzysztof.kozlowski@linaro.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset=3D"UTF-8"
Return-Path: netdev+bounces-83500-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 11:02:38.3244
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 0f717a41-2bff-429e-aa5c-08dc=
50a8e993
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.399|SMR=3D0.341(SMRDE=3D0.035|SMRC=3D0.30=
5(SMRCL=3D0.102|X-SMRCR=3D0.306))|CAT=3D0.057(CATOS=3D0.012
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.022(CATRESLP2R=3D0.001)|CATORES=3D0.021
 (CATRS=3D0.021(CATRS-Index Routing Agent=3D0.020)));2024-03-30T11:02:38.75=
8Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 15532
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.035|SMR=3D0.024(SMRPI=3D0.022(SMRPI-FrontendProxyAgent=3D0.022))=
|SMS=3D0.010
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAd4OAAAPAAADH4sIAAAAAAAEAO1Z+XPb=
RpYGSfGU6HgcJ1
 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
 McufFt7uPvRFP0RthBfZlM8cRjbGZNqGcLObYU6As1r1y02JZHjV3I
 cWBdPXJoyNm/HZwdnAyYP/e8xiwOGw6asDH0RPr5E87eqjerKthqY2
 Ooi5R7yafMGqEvBO04oC2bHZ29Zk/ZEt03xZch5g7FFB0Unx88O2eP
 7XkY0so5+vnJPjv+GbM4Qo/cOCL02dE5wffZj/7f6UZwOJBDZ9rp+S
 +LwR/PJF8VfD0sRY9p5Eo/8qyYfrwYW3MvRldpxda6tsdnf5cMj8/O
 smobYkRfsYTwhy8l/Bf/tbw5958nN9bkwLbJ3YlWLw7P5MyrKx561q
 18eI7Y3D5zY/n0Hwn67XqI3qXBG/H4mnOf0U8qDIFfhH0xLyIGfx3j
 fBT6iDoPwyAcsFfBLFqesBZRYG8fae/Y6eujo5en5+zs5ekXNZrnss
 lEw5j8dsR+Yel113lu7zwNs3fXef5f7TzXauT/y85T6911nr9zxd91
 nned513nedd5fl7neRg4ON60qWpzDp0tbay2cdPX0JVoWps57U57zG
 HO43aP22Zf7T353G6jsXZJaaIbiiI+HXm37PGI+o0Juo7oiThMM5Xe
 Iab6JJc9ei++r3v7OExrji2gHYKmGifXNLgS3zeA3rwPBbBHwNSi5K
 JXVgKo9fcF+hEWYUfgbcKnhieXF4VLxkTzCOnyb0yTCie+ScFOGI0S
 hd9KCv0d+6HRII/NZuJ1th/F4dym7oLeagl31Wvn9LYyFO/JGO4m3O
 ehRS9hRrfMYuj7muw4ZlO0ArSn4Owsz+pRs1474zx9AzgJgubEa+Fh
 evTv4jXoFPVH9CzhVHY06GLmcfIWrpm+eOfiQMzDiNmWj8YBuljUTl
 NPmJ7B/ypfLE7CYD4TrxabmVf316h22Cv4TCTHJQvGmVewTQYtEeit
 ej6iw/Zcvgu+CK6pTaUsn/uuDReAcXyx1Bfdyli8XVw6y/KoBN0u2h
 ru7KOVW5jILn2wHInXw94tBYD4QZVHmKe3mgPGbyw7bsi3lY3YjT2e
 iKH3ntcWekxoFKATk9VSCv4uYtF8hHIQ82m0L7mvsI5IhRSBhplfN9
 Lneu0xhY3s8FysBDgrnRPtTMQQKpq+5iOWvrR/st1+5sxnnnQWGFl+
 gPkQDPg2vYBdmAyR/83xHYwbCVFDct1i/9x3AubwhSRk0jbmQM1nRK
 0oRaVWUspFpVRQdqpKDTd5pbyjFEvK7p5Sx2NJqRRySkXZweCOUi7l
 lK+UckXZK9DIHqaeClowwaf8E1RleSM5A7an7FSUWlmpgGExp/SUSl
 U8Yjan5CUhbu4p90FbUqrADFYwBYwDcF95gMEdcM4pP2QAUtxD5duK
 4ID7cq6SV5R8DsKVXC5Pn0oBsLwAV5QqqZ2r7CgKuCU8lWpd+QpSQA
 57Aagpu8LSojCkAp9AN/FYhgInSgXSJUaoXQYAs5I5BJWFIS+3wTAC
 WF6MfIQb5ApYIU9K7uaFCQt7y6nbob+QWBC01UpO2ZXMc4qhlB8q3w
 CwS1H7RpjzEOK+FtGBtomLhLaFXFHc53FTpPRAPpDny0I3uLGgKCQ6
 pzwQtCKgy1npTCjwuaxyO/eUvOQj02aTmxSRRzg2GGI2Sa1cNZmCFb
 nKMuJJ3EGi/IvwUj33lcyECsVxKTFzUxH5XwZlDX/k+YJAIl41sQqQ
 CcX0TyQD4lL8pE/yueInjZV8dkVoNtxeJCb/e4KwlAr0+YfM5+pIDp
 8KDSY3q8jPGUw5rDxuB0uV8ovBjZsH+SXs02ARl+onfJWrfcpR5R1K
 sASwFhQC5Mp/EOVCFk/JAfcpORLv/qIkLuuh+IPcRWSTNC4kZbYoi8
 /HYRuzSI8aAA8X1ViKSyVm+ZRIq3VMSVT+z8Sk1lUzAFoptGSoWqZ8
 0pEPYnIlREHWrg8wKcpIfRIjYyEx0o1bxd1X8jKOsrDLe8zSfkE21m
 D7vQxgGwzlCJidQlLAS5swaX5e1JDCanA3YeBWXmCyrIoUcbrJ+vNh
 rih0KMjUXWO7lWQvQ7KmbdaHSbhzZblAZJGEiHxuR4xU7ytfQ9VvhZ
 6ynmc9kK1CW2lLtB7lAaOcVSCTVFIo7aEZwm/wmK6vbfhEkLCiAkFF
 OqgkO450TrLGqbomOSzDnRWXJb8vyFP3foC8KnbDkqg5/yT2qYJUUs
 ZXcigTzwdFUUzuLZyMKYw8yCl/Ur5+IPZlYRcYlh4o3+bFRpPYRXt0
 Gj6cx0rJYSa5oVk5UpR7H4koiTOSBOSx9RcXDicRKQelVFP2sJBryr
 2UyQb/QjW3l7BdjJRztWQbze3KmwX5DiyVJssale6qIoLwgPBV7uuE
 Dx3eir9pi8fRAlUnJ+Xe7fJ3u/zdLn+3y9/t8r9ll5ebJipqRVHoRq
 mha85sZE9AtSs62eKi8gsAdiJgamsjhaThKgpuNFigiEBKdRVWkjCh
 IRS4X5RbGzmETgu7yrdJTcaOo9TwKRq6oswHsbTlbqt8I1r+9PghtN
 0TZlblwpSzcv+FEv+s1NBKF0RxSH248BI40I8J/5rhmbbVeNyl/ZF+
 D1k012XJubro02X6iY1G/hCRlG7h86qkkpgq+blaE6ouwDs18StKnb
 atvTR/JFgquWjw72UVgGeki+QGmmFI0v+YHBsKwmm1rA74rCtfpfji
 /wAptyhd3zMAAAEKjgI8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW
 5nPSJ1dGYtMTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUu
 MC4wLjA8L1ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIF
 N0YXJ0SW5kZXg9IjEwMTIiIFBvc2l0aW9uPSJPdGhlciI+DQogICAg
 ICA8RW1haWxTdHJpbmc+c3l6Ym90K2UyOWMyMDRiZDJlMzkwNmZlNj
 ljQHN5emthbGxlci5hcHBzcG90bWFpbC5jb208L0VtYWlsU3RyaW5n
 Pg0KICAgIDwvRW1haWw+DQogIDwvRW1haWxzPg0KPC9FbWFpbFNldD
 4BC9kIPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2
 Ij8+DQo8VXJsU2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2
 lvbj4NCiAgPFVybHM+DQogICAgPFVybCBTdGFydEluZGV4PSIyMzYi
 IFBvc2l0aW9uPSJPdGhlciIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcm
 xTdHJpbmc+aHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9s
 b2cudHh0P3g9MTJhZTMxODUxODAwMDA8L1VybFN0cmluZz4NCiAgIC
 A8L1VybD4NCiAgICA8VXJsIFN0YXJ0SW5kZXg9IjMxMCIgUG9zaXRp
 b249Ik90aGVyIiBUeXBlPSJVcmwiPg0KICAgICAgPFVybFN0cmluZz
 5odHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/
 eD1jYWVhYzNmMzU2NWIwNTdhPC9VcmxTdHJpbmc+DQogICAgPC9Vcm
 w+DQogICAgPFVybCBTdGFydEluZGV4PSIzODYiIFBvc2l0aW9uPSJP
 dGhlciIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcmxTdHJpbmc+aHR0cH
 M6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWUyOWMy
 MDRiZDJlMzkwNmZlNjljPC9VcmxTdHJpbmc+DQogICAgPC9Vcmw+DQ
 ogICAgPFVybCBTdGFydEluZGV4PSI2NTciIFBvc2l0aW9uPSJPdGhl
 ciIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcmxTdHJpbmc+aHR0cHM6Ly
 9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1hc3NldHMvNmNh
 ZDY4YmY3NTMyL2Rpc2stNzA3MDgxYjYucmF3Lnh6PC9VcmxTdHJpbm
 c+DQogICAgPC9Vcmw+DQogICAgPFVybCBTdGFydEluZGV4PSI3NDYi
 IFBvc2l0aW9uPSJPdGhlciIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcm
 xTdHJpbmc+aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5
 emJvdC1hc3NldHMvMWEyN2U1NDAwNzc4L3ZtbGludXgtNzA3MDgxYj
 YueHo8L1VybFN0cmluZz4NCiAgICA8L1VybD4NCiAgICA8VXJsIFN0
 YXJ0SW5kZXg9IjgzOSIgUG9zaXRpb249Ik90aGVyIiBUeXBlPSJVcm
 wiPg0KICAgICAgPFVybFN0cmluZz5odHRwczovL3N0b3JhZ2UuZ29v
 Z2xlYXBpcy5jb20vc3l6Ym90LWFzc2V0cy82N2RmYzUzNzU1ZDAvSW
 1hZ2UtNzA3MDgxYjYuZ3oueHo8L1VybFN0cmluZz4NCiAgICA8L1Vy
 bD4NCiAgPC9VcmxzPg0KPC9VcmxTZXQ+AQ7OAVJldHJpZXZlck9wZX
 JhdG9yLDEwLDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMTtQb3N0RG9j
 UGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0RG9jUGFyc2VyT3BlcmF0b3
 IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3Is
 MTAsNDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMT
 EsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCw2
X-MS-Exchange-Forest-IndexAgent: 1 5418
X-MS-Exchange-Forest-EmailMessageHash: 58B4AA6D
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking.=
.
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D12ae3185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaeac3f3565b057=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3De29c204bd2e3906fe=
69c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-=
707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-=
707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Ima=
ge-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 10856 at kernel/locking/lockdep.c:232 check_wait_conte=
xt kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 0 PID: 10856 at kernel/locking/lockdep.c:232 __lock_acquire+0=
x78c/0x763c kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 0 PID: 10856 Comm: syz-executor.1 Not tainted 6.8.0-rc7-syzkaller-g707=
081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff800099ba7240
x29: ffff800099ba7500 x28: ffff0000d7f65a00 x27: ffff0000d7f664f0
x26: 1fffe0001afecc9e x25: ffff0000d7f66458 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000000c17 x21: ffff8000922364c0
x20: 0000000000000000 x19: ffff0000d7f664f4 x18: 1fffe000367fff96
x17: 0000000000000000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000040000 x10: 0000000000022c3d x9 : afcfeb2b6d9f9a00
x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099ba6b38 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __flush_workqueue+0x14c/0x11c4 kernel/workqueue.c:3146
 nci_close_device+0x140/0x5b8 net/nfc/nci/core.c:567
 nci_dev_down+0x40/0x54 net/nfc/nci/core.c:639
 nfc_dev_down net/nfc/core.c:161 [inline]
 nfc_rfkill_set_block+0x14c/0x2d0 net/nfc/core.c:179
 rfkill_set_block+0x18c/0x37c net/rfkill/core.c:346
 rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1305
 vfs_write+0x3c0/0xc3c fs/read_write.c:588
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 2283
hardirqs last  enabled at (2283): [<ffff800080297cac>] raw_spin_rq_unlock_i=
rq kernel/sched/sched.h:1397 [inline]
hardirqs last  enabled at (2283): [<ffff800080297cac>] finish_lock_switch+0=
xbc/0x1e4 kernel/sched/core.c:5154
hardirqs last disabled at (2282): [<ffff80008ae46784>] __schedule+0x2bc/0x2=
4b4 kernel/sched/core.c:6625
softirqs last  enabled at (546): [<ffff80008003165c>] local_bh_enable+0x10/=
0x34 include/linux/bottom_half.h:32
softirqs last disabled at (544): [<ffff800080031628>] local_bh_disable+0x10=
/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address dfff800000000018
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
Mem abort info:
  ESR =3D 0x0000000096000005
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x05: level 1 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[dfff800000000018] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 10856 Comm: syz-executor.1 Tainted: G        W          6.8.0-r=
c7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff800099ba7240
x29: ffff800099ba7500 x28: ffff0000d7f65a00 x27: ffff0000d7f664f0
x26: 1fffe0001afecc9e x25: ffff0000d7f66458 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000000c17 x21: ffff8000922364c0
x20: 0000000000000000 x19: 00000000000000c4 x18: 1fffe000367fff96
x17: 0000000000000000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000040000 x10: 0000000000022c3d x9 : afcfeb2b6d9f9a00
x8 : 0000000000000018 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099ba6b38 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 __flush_workqueue+0x14c/0x11c4 kernel/workqueue.c:3146
 nci_close_device+0x140/0x5b8 net/nfc/nci/core.c:567
 nci_dev_down+0x40/0x54 net/nfc/nci/core.c:639
 nfc_dev_down net/nfc/core.c:161 [inline]
 nfc_rfkill_set_block+0x14c/0x2d0 net/nfc/core.c:179
 rfkill_set_block+0x18c/0x37c net/rfkill/core.c:346
 rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1305
 vfs_write+0x3c0/0xc3c fs/read_write.c:588
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 34000ee8 aa1f03e8 91031113 d343fe68 (38ec6908)=20
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	34000ee8 	cbz	w8, 0x1dc
   4:	aa1f03e8 	mov	x8, xzr
   8:	91031113 	add	x19, x8, #0xc4
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	38ec6908 	ldrsb	w8, [x8, x12] <-- trapping instruction


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


