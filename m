Return-Path: <linux-kernel+bounces-89328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE3786EE6F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 05:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8A82812DD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 04:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DA17BDA;
	Sat,  2 Mar 2024 04:01:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EE1799E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352066; cv=none; b=VyRIT8fFtcNPd3JG98vrbgGwgZnjfNfv+cGdy4Qbr0zaiQz4qtG1jFtxiW+I0Ggnd5HXjjShMIrmAjwT0+mGwjFdyuLizn/bfl/NHkgKjzXNXDQgOh1ZLY5G/GgLtIh3s0GcMFQn2byiUs7AbXHWq8a7+srz3HnLz91TpKTl3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352066; c=relaxed/simple;
	bh=hBzsYWOZ9hwVRXW6geWH07Rr3cKQIp/xHP8NxOBSE6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iPsI9AIz3pGICAs0uS3ypGL45TQgzl9I6GjNB8xZ2R/jIcaK3kHeOJKTzYM6wPfTSoCDNCqMUBXxNYjhCpq6ZmFoVmxarhX+DS4BriAEyZ5oIN50ieSFiHd39/buRuEH1hRD2Qtbqvnqx5ub/NE3TDYO6Tu3LHGeHyL6SRsmoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7c4065282so366766439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 20:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709352064; x=1709956864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmhzJqAXV+V57NGkxV+UmRMvCvOpY6avUDCxlJj3E2s=;
        b=SW8Z4Pg8y8na5GGJpMe34g1VKAABplosCpOugf5IsnAq4nONqVfP7gdIo6kg6NhYjO
         SG3v/GM7cgxWze/uDgrQ9wkpGe2XchlkowhOxF8yRIIR+EAaOqBZTpTGqBorVqXsT0eX
         ovDArla8nKEimUm0wd+LC9EtwX4TB8/7HPo55L4adbGMn0yEvCotSnr2/CIhlc7IlbTM
         4NwyV9shMNlSVbB7GjVUSUYGo+l3Ud+EtYUR9Shu4Ti6zuYMvy6/YGkToEtteYd//bD7
         JWp+K7MMM64nWHm5mkmkdRhk19TJbpNDi2qwmSi/+KSfkRFov7CQK+s99Ojvlu0S7FEf
         NIGA==
X-Forwarded-Encrypted: i=1; AJvYcCVsMR8D/1KRQlHj7knm3YZPvVHcVFNAVdXgQtInInpxcLqQHaNMoNryA0ARMOmjmIqWU4d295ZEnzWinsOJzIkdmD87TDVpNCo5MMZV
X-Gm-Message-State: AOJu0YwOeBQTAxrrotmt1w1nPqNYbM4jLQQPEA+pr2m7MGc1UjCuzQBc
	osAv2Ud1ZcU2a68iHnDTWFfenN4ecgG9sTqcBzlSuTmpF3Ed8wjOF/2DGUQ7cDHNticGwMdUnnW
	H0NXrnAR3mAPvGxQvyaplxzwtD1tslzHO9oa27q6/z3n/twjd7cNe64E=
X-Google-Smtp-Source: AGHT+IFRUPmPplefbtK78IRnZ5w2Y8t+CinCnvRdEIVgWapklblAFrEUL2DNokXKruJqxz68JUXw4NlF+Na97JF2EwECkee1Xbso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3795:b0:474:d271:9ee7 with SMTP id
 w21-20020a056638379500b00474d2719ee7mr84168jal.3.1709352063321; Fri, 01 Mar
 2024 20:01:03 -0800 (PST)
Date: Fri, 01 Mar 2024 20:01:03 -0800
In-Reply-To: <tencent_DAEC42CF7878366DC42DD16D289568E95E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087ddf70612a58a19@google.com>
Subject: Re: [syzbot] [rds?] WARNING in rds_conn_connect_if_down
From: syzbot <syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rds_conn_connect_if_down

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5694 at net/rds/connection.c:933 rds_conn_connect_if_down+0x95/0xb0 net/rds/connection.c:933
Modules linked in:
CPU: 1 PID: 5694 Comm: syz-executor.0 Not tainted 6.8.0-rc6-syzkaller-g5ad3cb0ed525-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:rds_conn_connect_if_down+0x95/0xb0 net/rds/connection.c:933
Code: 00 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 ee f8 43 f7 49 8b 3e 5b 41 5e 41 5f e9 f1 fa ff ff e8 2c db e1 f6 90 <0f> 0b 90 eb cb 89 d9 80 e1 07 38 c1 7c a9 48 89 df e8 35 f8 43 f7
RSP: 0018:ffffc900050c78a0 EFLAGS: 00010293
RAX: ffffffff8ab19224 RBX: 0000000000000002 RCX: ffff88807f89bb80
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc900050c7ad0 R08: ffffffff8ab191eb R09: ffffffff8ab2b261
R10: 0000000000000002 R11: ffff88807f89bb80 R12: ffff8880218c2800
R13: ffff88802b6d9740 R14: ffff8880182f2000 R15: dffffc0000000000
FS:  00007f22049de6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020d10000 CR3: 000000006ea98000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rds_sendmsg+0x1409/0x2280 net/rds/send.c:1319
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f2204e7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f22049de0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2204fac120 RCX: 00007f2204e7dda9
RDX: 0000000000000000 RSI: 0000000020000800 RDI: 0000000000000003
RBP: 00007f2204eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f2204fac120 R15: 00007ffff6293078
 </TASK>


Tested on:

commit:         5ad3cb0e Merge tag 'for-v6.8-rc2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=120ebcf2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=d4faee732755bba9838e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107427ac180000


