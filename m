Return-Path: <linux-kernel+bounces-125964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A832892EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EA1F219BB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057A7490;
	Sun, 31 Mar 2024 06:01:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0B6FA7
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711864865; cv=none; b=i2ldWeExvBwBmak2fEjSnhF4UPaUbapeHjNo8LjYYAAfFh9Kd6LD1Y2gDLGymI2xlbnCGhF8rBg+pXUK/6mFE9PabVrgja+nlpDjPU+D2RbLvOvlwuHUVN9JruNAPHTlOcBofpJtkr5BqxF1PqZ8nYNF+JOC3lfb0/FiGJ8IiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711864865; c=relaxed/simple;
	bh=ideiMZMwbNehoEO3iScR+VjeMazw2/S8yiFBiEfZS1g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a97SiU+dMoBXYARH8aClIZhXNNQEnKzy+0OgBu7FnwNRANz5wlRP+S6EuLFC06R5FIFqxPlVHyM9d6dbuGtWk6zYhqyKbZYRFAq880qz2wIs5sbA2ykED2faJX92Q4GIIQ8AkV3bpy49U+DqbLdf3bgeDxJoGg4ZjejQpfYreCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbef888187so312830639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 23:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711864863; x=1712469663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5mlMxwOI1H4b9p1J7fHoAEMIUJxBb9xtfOVdtEvbC8=;
        b=DD+6fvW4rtsw2GsreLENpHGAZ5eGW7mcmzldSBVF7MA4UDXsOrNyV7Xf7/1CoE7wlL
         07CF/HC/nS2zNvBzCfUW5fC4W/GzZodZUPncKTRraNgRLhTQCg3Q9RMc6JzJYlBh6eow
         IalvTLVpI0R6JyQAqfiapnC3ncJUe4y/oBOwLbC+Iny940iRpxaYTZ9HBc42AWcaLte1
         7flz/i0JeWZ9WhJ53QByw5kOiIkGJLQnOhZXKpXC+5lyUmWTX23rATm+VqZ21PJfGRh9
         O9EHqxvB5bQYL0sgp3vCLu/TQGRBX4lNVPORD0e/374MwfRrb7colc0g3bulmBb2ILQM
         EWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV53ktyaUjV93GOW6zWf5L0r+Q+T8DDZYhT9ITV1uYWPuoHyMisEJzvMq8dtQFs0QtAAQ8vGvHlNmcCQQBQZ/5GSUQ91iyGnHfHEi1a
X-Gm-Message-State: AOJu0YxOxDcA9IEc7npPFt/tI8hozfMgyyh2XIC6c0/lvLMSSte8aui8
	LU64KgRdBH46ASUjSbSwppQKhG8NUL6WaCM36rpsfzSmPIlx+KzPseypajbIAqRhGpnttxSLekP
	Fvqv4Gd/tJ/rGgnZRBZJLmixev1RyKnQIjYTvNpEAStdIIpTFMEW2Fgo=
X-Google-Smtp-Source: AGHT+IFBYrOTdDP8nrnrJ4R+byhGUCu7v21kl7EufHAol3WE3SZMhuRuDACuRM/HCYOldkDULBomKOLz5ZMbMQH1i0n9TNBl1V+q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c11:b0:7cf:16d5:181c with SMTP id
 w17-20020a0566022c1100b007cf16d5181cmr312659iov.4.1711864863105; Sat, 30 Mar
 2024 23:01:03 -0700 (PDT)
Date: Sat, 30 Mar 2024 23:01:03 -0700
In-Reply-To: <tencent_A50DF61259DD955DDD190C4FE50D88A5C207@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011b7ed0614ee9943@google.com>
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
BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:755
 trace_9p_client_res include/trace/events/9p.h:146 [inline]
 p9_client_rpc+0x1314/0x1340 net/9p/client.c:755
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1032
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
 p9_client_prepare_req+0x210/0x17c0 net/9p/client.c:642
 p9_client_rpc+0x27e/0x1340 net/9p/client.c:689
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1032
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

CPU: 0 PID: 5499 Comm: syz-executor.0 Not tainted 6.9.0-rc1-syzkaller-00355-g712e14250dd2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


Tested on:

commit:         712e1425 Merge tag 'xfs-6.9-fixes-1' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12ec65b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1485fa1d180000


