Return-Path: <linux-kernel+bounces-74832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2F85DCB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0434D282CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406AC7BB16;
	Wed, 21 Feb 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXr922P2"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6076C99
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523786; cv=none; b=lDEy/+jTdFjvK4LmoXCsXwkTDJOnx/BqEKwPv6uOafzZxkx2p8pf5gTEcVwtphcUgHtero6ouZmXygDSCxplVAjdou6KZFJn5lLoMLADLxstrR4SYHECqJjxxysAhyEF1Sz8wIE7GZmKZmwNydrqji32chH7of6xJv7T3q3qwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523786; c=relaxed/simple;
	bh=yYxG8XvD7j2sZVY0Zn6ccIBYTJ/xW/sw6qipLJdn8pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fi/2h4SV1z7m/IMjwVDKOlvptyKdqKhng7E5gXML8o+2TMOvmr8sCGhnmJqMuBsdefzGxvgAheoAmdhwXMZC/QbfJEwZEuUZwm9eJfkdrnVnvnG6oYUCqKEBjs0qxGgy1rNfVWjPuRoTiQZrbbwnOO3Kg6k9EBACe6rJClLoguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXr922P2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-299c7e32642so2062209a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708523783; x=1709128583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ/uFQZIIaU0br62rNhn8y6EuWp6TkIsHAM5PGBxpKw=;
        b=fXr922P2ZEHWsEw1WgXtRAUqcygq1eULOr26QAITJ7E1NhrQAsTAIWRYgFQ77sRGn4
         tGRmimqlFgF5Qe6ctJDBO4gs4HszpqBHZLTWndGRqWJeUam5qv8GZ7mlz4x3qjCmXbj9
         DqhNUwJGuLkoYIcqpWYiJH9o1CmCphNMFHRAg5Biij1ZmMToRd62zIQ2+sJ0wm9w1UtG
         xCIADwUUL2ikCMNOkCvw19cZ8ai8sKDXR3r1OBMHDkKe7m3W9/Vo3MAVEyLQQduH6vCV
         jB5BPTa/tkjGZ1AM6pm9g/2kydfysxUohCG3APrhQ1aViacfcrvLfHiu9FwajLtzLlo6
         Uz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523783; x=1709128583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ/uFQZIIaU0br62rNhn8y6EuWp6TkIsHAM5PGBxpKw=;
        b=pWwtV+e3B/EzcWSwJNzXyp+FmCcpPlXxQrrx0fubrktSdcBPVq8SIxmRSwFum16NA4
         ROlrxZlixz39/3haUjrhQMsuhGRFYAOzVUM87sTQ8AK0Qd7AMGQ8k9262UctBiyteHCp
         wj5ehISuj8heDYcw1EeSXqsS2j/gFMbkJ0ABWvW7jwM+He5GtggvpDDgaS4/7x0xuqMm
         jByLL1vvo6m6PqFDlQb/ugDwXWCyHCCIn9xsf2Q6OYu1Nps7etU61C6xUeZo2Gog43W9
         4C4aOYgvzpzj8NyAx347bcupHngTViGTUA3UulaO/r6Fro7TtXtv4jifq+4T5L3Me0Rj
         A2WA==
X-Forwarded-Encrypted: i=1; AJvYcCXwn8Wv4ifEx45qufwLBGCN5AlmQa3R6iDIxFVXqfDwpMqIKHshFShgLmf+iVK/1vxiL71tKCDuCwV+Wh2rn3DLNHuCCb2uSBCbF4Dp
X-Gm-Message-State: AOJu0Yx/ky01PXxGh2y91/uDK/TS2yGbTC+XbAsnNKnEG5WVcIfl4HFM
	7P2m1q2MvVlQ5ECtw4/frIvy6gYBdY8L4eaqDWYLvY2u38TPj6m2TR4IkBlG2+G/frXAx+8xkx5
	7yQ==
X-Google-Smtp-Source: AGHT+IEYND1PzwG+trb6qEOFjAgFLtPajKkdXKu35+GF/BKB06GW3IjOMKfRXPmI0fLXY+f/pgrw1aNTVDg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9483:b0:299:1e3:b566 with SMTP id
 s3-20020a17090a948300b0029901e3b566mr172803pjo.1.1708523782460; Wed, 21 Feb
 2024 05:56:22 -0800 (PST)
Date: Wed, 21 Feb 2024 05:56:20 -0800
In-Reply-To: <000000000000647d640611db8789@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000647d640611db8789@google.com>
Message-ID: <ZdYBBPypcFATU8c5@google.com>
Subject: Re: [syzbot] [kvm?] KMSAN: uninit-value in em_ret_near_imm
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+c9aca2253922f806a75a@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 20, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f1dd5e91e2b Merge tag 'sound-6.8-rc5' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bec778180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
> dashboard link: https://syzkaller.appspot.com/bug?extid=c9aca2253922f806a75a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b6e52e101a62/disk-0f1dd5e9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/64025c9168bf/vmlinux-0f1dd5e9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/491e1a922dc9/bzImage-0f1dd5e9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c9aca2253922f806a75a@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in assign_eip_near arch/x86/kvm/emulate.c:829 [inline]
> BUG: KMSAN: uninit-value in em_ret_near_imm+0x13c/0x580 arch/x86/kvm/emulate.c:3192
>  assign_eip_near arch/x86/kvm/emulate.c:829 [inline]
>  em_ret_near_imm+0x13c/0x580 arch/x86/kvm/emulate.c:3192
>  x86_emulate_insn+0x1d87/0x5880 arch/x86/kvm/emulate.c:5292
>  x86_emulate_instruction+0x13c9/0x30a0 arch/x86/kvm/x86.c:9175
>  kvm_emulate_instruction arch/x86/kvm/x86.c:9255 [inline]
>  complete_emulated_io arch/x86/kvm/x86.c:11212 [inline]
>  complete_emulated_mmio+0x70b/0x8b0 arch/x86/kvm/x86.c:11272
>  kvm_arch_vcpu_ioctl_run+0x1837/0xb890 arch/x86/kvm/x86.c:11384
>  kvm_vcpu_ioctl+0xbfc/0x1770 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4441
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl+0x225/0x410 fs/ioctl.c:857
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Local variable eip created at:
>  em_ret_near_imm+0x3a/0x580 arch/x86/kvm/emulate.c:3189
>  x86_emulate_insn+0x1d87/0x5880 arch/x86/kvm/emulate.c:5292
> 
> CPU: 0 PID: 6232 Comm: syz-executor.3 Not tainted 6.8.0-rc4-syzkaller-00267-g0f1dd5e91e2b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> =====================================================

#syz fix: KVM: x86: Clean up partially uninitialized integer in emulate_pop()

