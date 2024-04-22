Return-Path: <linux-kernel+bounces-153525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D58ACF28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193F21C2110C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC61514C0;
	Mon, 22 Apr 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1JBNxj3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372A22625
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795532; cv=none; b=hDOoqixIRrIeay1dvJmDgDmv04R5DZquCxQZhEeOhkPHsa9nUGjoKOsJeLjxGomSJtMz7Jrut9cYXwGCSeS3swgXdw/yeDdeJAD2+sdVSPChSYHAzimlN6XIq0kf7O7TgjvYOU23M1adjK0z+TlzAIFnribOB8auOmMHqT7XgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795532; c=relaxed/simple;
	bh=5NebA/A3MQ0RArecgWlr/xbum8+gfgz73lLHgMGOtBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be7ncRX7Akvqi2XHiazyfWVgc2RyfKYrDI1ZyseQ9DJwDYGa9eaGJ5CK3D4S0MIL/GYj0GKjzVBbfHe5GN3g6mGWCCO8eLfaAFDbKHgaXAipjej8jiLUIyqzwPjplwWVUhjBcx+actvkpxQwPsTuJhmpgrrtFaphGYCDl8vgUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1JBNxj3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713795529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RuEWgRbov+iY+KqOCft+xN2s/HWnJOwqATFyKi7m/SE=;
	b=F1JBNxj3pQdHusuYKAA80Nb6I7Ao8nfpnRnGLUtON6CwN1c0bIE6om5MGrq1lxm6uBEFgu
	BSAWhSjXdaby3/4lHB8tZ1DFOFVYyc0CC2zdF0/gXFQDoNNzr+DkGB2HwfPA/FNXIYl9+a
	2ld6/4iOns9f782o2mHyxpnko2aKG1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-bycl5Ty3ODaU3jlNaXBwHQ-1; Mon, 22 Apr 2024 10:18:48 -0400
X-MC-Unique: bycl5Ty3ODaU3jlNaXBwHQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34b40e8482aso454072f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795527; x=1714400327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuEWgRbov+iY+KqOCft+xN2s/HWnJOwqATFyKi7m/SE=;
        b=Q6ehZGKd/9O88V6+Kz1UWMmJjLyuN7QWEN9wzto6CXq0Whc953j6Zt1oWSYcxJ/Raz
         61bqUlEz1a8Hzh+cxPw7NEMduQ9h6B/Io/aUx70aVdLqnoUFVzDYeXIj3k+7NswbKFAl
         aKF/V9CziBRw72POPh68Bw61dTu/k2Jig8dlfuiFQY+oTsTNFfXtrrQPvaz3Qw9sDGWn
         Nhb7DEdr4QFUUoBTe2LC4VX7iEJtkjBH5ATcZMwnjHobs3QhiM1c2lzFe2aA9th8HtlN
         ulVKO3ufC6uVtnzjvd5PHevMDARV8LkDzjIk+f/eHekxL9GHtkBT5Zy6SmzBH98QWhYb
         wLJA==
X-Forwarded-Encrypted: i=1; AJvYcCX29rIDiApfg/ctH/9Z05nQbp5YdBij2sU+xxY4m1TIzaUMhgIa/XVP3sbdJ3lsqa/WfZnZcqN7Ddl5RzDUSJbvolG0haDF/wYbrJZO
X-Gm-Message-State: AOJu0YxwRONxX8pmqmMpvfHXn2W2hWnhZW5YBH0UiVFx8v2TrppA/MKx
	LY02eBroiTCY9GBW65IlVom2BhIfdkosvstY2D9LGzhNODW+HEHXKkeKHc0NiNuzwWEFzqN07qJ
	A3yjBhwMXm4GSCe/nOm0UgXuE9yD/oa4q/nhFxhAZw1b0yLT4P8rGOREs2XWdfw==
X-Received: by 2002:adf:ce91:0:b0:34b:58a2:dead with SMTP id r17-20020adfce91000000b0034b58a2deadmr209866wrn.33.1713795527114;
        Mon, 22 Apr 2024 07:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr5x0koTy4iow6GLkNZgdwaMcdEjJgD3/LWvrvM95SfAaGPPm7kmwZu+TuEABqDb/EvhKg4Q==
X-Received: by 2002:adf:ce91:0:b0:34b:58a2:dead with SMTP id r17-20020adfce91000000b0034b58a2deadmr209834wrn.33.1713795526513;
        Mon, 22 Apr 2024 07:18:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d6dc4000000b00341ce80ea66sm12114246wrz.82.2024.04.22.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:18:46 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:18:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sgarzare@redhat.com,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in
 vsock_assign_transport (2)
Message-ID: <20240422101622-mutt-send-email-mst@kernel.org>
References: <000000000000be4e1c06166fdc85@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000be4e1c06166fdc85@google.com>

On Fri, Apr 19, 2024 at 02:39:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8cd26fd90c1a Merge tag 'for-6.9-rc4-tag' of git://git.kern..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=102d27cd180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
> dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e38c3b180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e62fed180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/488822aee24a/disk-8cd26fd9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ba40e322ba00/vmlinux-8cd26fd9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f30af1dfbc30/bzImage-8cd26fd9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in vsock_assign_transport+0xb2a/0xb90 net/vmw_vsock/af_vsock.c:500
>  vsock_assign_transport+0xb2a/0xb90 net/vmw_vsock/af_vsock.c:500
>  vsock_connect+0x544/0x1560 net/vmw_vsock/af_vsock.c:1393
>  __sys_connect_file net/socket.c:2048 [inline]
>  __sys_connect+0x606/0x690 net/socket.c:2065
>  __do_sys_connect net/socket.c:2075 [inline]
>  __se_sys_connect net/socket.c:2072 [inline]
>  __x64_sys_connect+0x91/0xe0 net/socket.c:2072
>  x64_sys_call+0x3356/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:43
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
>  __do_kmalloc_node mm/slub.c:3954 [inline]
>  __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
>  kmalloc_node include/linux/slab.h:648 [inline]
>  kvmalloc_node+0xc0/0x2d0 mm/util.c:634
>  kvmalloc include/linux/slab.h:766 [inline]
>  vhost_vsock_dev_open+0x44/0x510 drivers/vhost/vsock.c:659
>  misc_open+0x66b/0x760 drivers/char/misc.c:165
>  chrdev_open+0xa5f/0xb80 fs/char_dev.c:414
>  do_dentry_open+0x11f1/0x2120 fs/open.c:955
>  vfs_open+0x7e/0xa0 fs/open.c:1089
>  do_open fs/namei.c:3642 [inline]
>  path_openat+0x4a3c/0x5b00 fs/namei.c:3799
>  do_filp_open+0x20e/0x590 fs/namei.c:3826
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1406
>  do_sys_open fs/open.c:1421 [inline]
>  __do_sys_openat fs/open.c:1437 [inline]
>  __se_sys_openat fs/open.c:1432 [inline]
>  __x64_sys_openat+0x2a1/0x310 fs/open.c:1432
>  x64_sys_call+0x3a64/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:258
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 1 PID: 5021 Comm: syz-executor390 Not tainted 6.9.0-rc4-syzkaller-00038-g8cd26fd90c1a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> =====================================================
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


#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git bcc17a060d93b198d8a17a9b87b593f41337ee28




