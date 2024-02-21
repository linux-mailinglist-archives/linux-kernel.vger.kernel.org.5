Return-Path: <linux-kernel+bounces-74828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A485DC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40787B26843
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86BD55E5E;
	Wed, 21 Feb 2024 13:53:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C63762C1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523586; cv=none; b=H1z5LKK5FkRF31DbBwcJzaKLdKP0Y7aeHqGnN14/5SdI77BnhApvkC9faUXOG/x7r/SBDl+bkWWeaqmlsup5lTeIsA50EJuzf61MMABhRc0vMT29Ej3+2HD+lo0YLZQDS1/pKGA72F9SGum1XTZacjRwKWu50tiIHq530R4Aa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523586; c=relaxed/simple;
	bh=VWXccFbysa1rP6LCm230g4wFngBWx7wgJA6oH3HMuIU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KbfqOnkYanPDBRg17DbuHEpgQ0HOm96wy4U1U6CuBlSj66IbcWtCZ2w/7Yho25XNfh1ICYfMEThFyarN631YeNTs0B5WzMmvKrJi+tmMnzlVvSSe5LUC59dq2E9rvpkcsDq6rbgVAZKPkqMjG61mwHIP18lb5kQLDvYdneoeJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-365116383bdso6687085ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523584; x=1709128384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TmmxVKmOx7JUR4pXKSv9WPFUBql9re87YVO51w+Pe4=;
        b=HCZWahDylxhbu3ahrNBzC2TXAcJdAYQn94oh/JT6ijkUzYzrt/l0nuaR+kQPYgKx5u
         SiQscGXFbvGJwDiG+NJ6Wv+aHbcV2A7eM3yMmyd+TA123dXEU+WOYVeHAjN7920zRx5Q
         Lnd1Rg896UNpVpjmfxmIz8nIVDzqvD9xSbGT0Re0CU3FAb9tkiRPx6JtLZpLRPs8dLqx
         7qr2gpBb/KHe9llXkEbHz5fMBpPlDcaVqVMnFZAfdVAdnxkXuoKzzDnMPFwXrbdqggig
         y3wEIBDtvmmlmSkuCKDaBwECJ//YXUyt2MdkFn3F9EIhd3bAFo2SSeSTdrpriU7RlWsg
         ywpg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Rb9rhdAFa1nR9UJ6UOFq9ZkI7X4lxhU15LTcH+aA2J3DWYw3HPhXJZNK54d6NPbLNQFHYeihip52Zb8WVQRzIMs3vVpl4nMAe8et
X-Gm-Message-State: AOJu0YwtH5CemO+J8t1ljtrZqsoDhDZ9Ij6JUEfz4O336ZLIaUjc3knl
	vqy4IQ9nOJBfpqYZspvib8ccivLhXJmoETpfYYP34AGP1ajIvB8IIyyWpselumestrC/tsi8/yY
	zKYdlUNRCQaK4sbwB2IQU0ov34rAOfVINBWXf0Rz5RAho5vaZxyNyS7w=
X-Google-Smtp-Source: AGHT+IGXk7K6uDXVLTh3rlHTvKS2wUcmz6qXFPdmMHDjENDdeEYEnvmGfmTrOFd7ff8HTJHvpPpYrBuhBZ2YyFsWXAtM6pq9DbQc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56a:0:b0:365:4e45:7922 with SMTP id
 b10-20020a92c56a000000b003654e457922mr160003ilj.5.1708523584003; Wed, 21 Feb
 2024 05:53:04 -0800 (PST)
Date: Wed, 21 Feb 2024 05:53:03 -0800
In-Reply-To: <20240221122904.1393-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050a83e0611e4a597@google.com>
Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
From: syzbot <syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in cec_claim_log_addrs

INFO: task syz-executor.1:9052 blocked for more than 143 seconds.
      Tainted: G    B              6.8.0-rc5-syzkaller-00063-ge6ac7c55d3ec-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:0     pid:9052  tgid:9051  ppid:6538   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_timeout+0xb8/0x348 kernel/time/timer.c:2159
 do_wait_for_common+0x30c/0x468 kernel/sched/completion.c:95
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:148
 cec_claim_log_addrs+0x180/0x244 drivers/media/cec/core/cec-adap.c:1607
 __cec_s_log_addrs+0x1238/0x18d8 drivers/media/cec/core/cec-adap.c:1922
 cec_adap_s_log_addrs drivers/media/cec/core/cec-api.c:184 [inline]
 cec_ioctl+0x2684/0x37b0 drivers/media/cec/core/cec-api.c:528
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
INFO: lockdep is turned off.


Tested on:

commit:         e6ac7c55 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1772604a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=116b65a23bc791ae49a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13488eb4180000


