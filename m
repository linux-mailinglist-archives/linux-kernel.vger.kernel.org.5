Return-Path: <linux-kernel+bounces-125978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482D7892ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E96B1C20B74
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945D79F9;
	Sun, 31 Mar 2024 07:16:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6491FA5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711869364; cv=none; b=uCmoNz0oQYiFU5pWShr9OH2UA3DDReUoMX3awBIBzwE2pk2Bhb7bzIBJmwks64rt+6zaiojTlZ91dxCj9mSK6ElgFcKG/Z1ONo4IEnXbJwFhQbqPw+MEc54ZJaNd8kLUvryKoRQT5urtqNHPG0Q6qTd2oWUgJHjEdDRMgLowcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711869364; c=relaxed/simple;
	bh=VSH8tuVdAorJpSZ2e5jXcUsL6uSJAkeZ03ZBiAdL520=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eJDjmgaCqHpTWE8cSALguGROmUEOAn3pefwVSgRPY1qtNcCaXnQf872X1tcqyizYIR1BITCLTaOsaMAar0toftF5ILhxFuco2Rlf7CQkFna3qcHiZpPPDyR4PrQxLr/raOXq4KC9vV2t5TrzIKh4zfMbsMUdVOirCFCmsIJryZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-368814a0181so28491025ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711869362; x=1712474162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21RVnApNywo6ossisKF32eKUP2wRcymur2CT9ZHGjuY=;
        b=IzAPuOxtRjtbUwkdVkcbVA9do0iavBwmZajBhojpSLfHqYsmI4o05O9cF5NdVL6Gjj
         v6hoTqtexTYL5O+PxzYNtqlB5OWwcHS/PXhLzmlMo8Ky4ett36/ii8ezBHcATCw8IoD5
         nPHdnRtvOGxcQ3sH4/4FcAeRbfOsTF43ScrFY+D3+tteJrlxWYKixWowGe9QpfuJvDE+
         XQjx9vcR6BO81lkXbTeEIdxoVEX/eevfppRIeT5UKghJ08tQyXkIGznWWBLUZYkqGvzM
         2wrcX0tWGrZmzZ1M9E0745om3A/UPzQUA5KhDRSbNkPi3Qdoe0Ebjy+rqTziGkQV2u4J
         MNtA==
X-Forwarded-Encrypted: i=1; AJvYcCWGv6m/T35g6JPwuYTRQA+7AsnvVGpDtf0ub5FEpdQ35rPGqBEyE4jkuoMLNXMEeHw8UwhYF41TC0CiNEVP9BNmCUy8lUU6L55D5ZF7
X-Gm-Message-State: AOJu0YyH+iH9JTfKsTPXRAEs9miQyG1SgEFiH4ANSyDb4LDVjMDsH3Hi
	zfrwslN9rPN230cKFEIO8IrSfjrpFa0dZwIx/5jKUarKrmrbyOwnT2nRdD/CsPEN59il1OkAXk/
	6WION2L3d6PkiczciWPypWQLMI/9prDGd8x/hHbU8C67VSLakME5B9+Q=
X-Google-Smtp-Source: AGHT+IHOzxmY7ZjieGARMa0uHtvnpD/Zh+qHIFq1jVzOcJ8j7eeNBsee2JxWbKBl6Dsmly/+v7rsNVQOQP6PBA/FKRySwQp/36Fq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:350d:b0:368:8290:e415 with SMTP id
 bu13-20020a056e02350d00b003688290e415mr409649ilb.1.1711869361887; Sun, 31 Mar
 2024 00:16:01 -0700 (PDT)
Date: Sun, 31 Mar 2024 00:16:01 -0700
In-Reply-To: <tencent_C2874B621B52254CBA78BB3A336C9E3C1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037ac150614efa517@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
From: syzbot <syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in p9_client_rpc

=====================================================
BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 trace_9p_client_res include/trace/events/9p.h:146 [inline]
 p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 p9_tag_alloc net/9p/client.c:278 [inline]
 p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
 p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

CPU: 1 PID: 5498 Comm: syz-executor.0 Not tainted 6.9.0-rc1-syzkaller-00355-g712e14250dd2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


Tested on:

commit:         712e1425 Merge tag 'xfs-6.9-fixes-1' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17bcb30d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a6421d180000


