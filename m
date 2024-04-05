Return-Path: <linux-kernel+bounces-132940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62166899C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96531F2295C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305BA16C6B7;
	Fri,  5 Apr 2024 12:01:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89916C69E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318466; cv=none; b=P2Hp8WgmmkeP2f7mL/0ZtNuIzf6DAaD3z6dno+QyJg7R6l1YsU2u9R6bLOTaj/iXRXSmV+CDzi3miJSOkkD6sPIKBPQ9S4qhreVfM2zVflcRElwFtZkKFivsZIWa40aYPzAC2NXuyNyJCQJKsIuE/lEWAJVtmko8+vQgHAAgcrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318466; c=relaxed/simple;
	bh=PPlJqxpQHoAtjbPLXJHXiDBu+jOz0BQhqP4SwSa6fWo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U5FH+yJLtXYzU42XmjkOXIuvo/m4NXWbpmzMi7cfFH4IfyMn1xSWuXcM3nHmfOq9RW3ufXfxzv89f1su8b0Orn8cYEPMjrVCqZvDjhff3CqWlZTVQoJyG4MEhY6YAZPSycWr35vJNprkOBGhlkcPBZr187DF4dpJbMzXKwYPolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc012893acso212045239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318464; x=1712923264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+2bGjZ5bXU5Jyjw/hPKObCDQon7IZrrva5+NdOfmYM=;
        b=KlifEUscXu0ga+R3P0zOqNRpzqbDQ125J58Y0imHoPyQILjYz12VKk6KTpka7g53pD
         gxpdte6WBm2dCx+N14yw2EV5j6JOPRueZrmXQuBWDyuuqQHPj4bQ3G7t763akuso1wgz
         ywRz21XwsuR2et8k4NA4CV/yIBSfxGyVpNKSHS8T+kcD5VCSvFeK6AUJyEEjGoMzg+hY
         2PdOaFBuggJyMpELp7ygDnKvp/WfFflzH6IeWGURHPZ7j4v/xJLUIfH5ImtK0hIN47yL
         2kbvb77oq9v/BVwbhB+xYmKNDgNKO1DZMHJU2FvvB/vibpwwfYXTzhj3riPxwu9Wf3kX
         NjNg==
X-Forwarded-Encrypted: i=1; AJvYcCU5xvk1s6V+fghNgVUD2Pbi3PlIMgqrdySNNLXlZ5I853Tf22hxCJRtUqPcGoeG1PpUNtVOq92FH0t+FTTbrcLQkC89D2fafcQ1gzp6
X-Gm-Message-State: AOJu0Yxgkd3r2Lv8CyYidBCUluURfQtjcocRWOQaco9QPGQ6PWEC9PiB
	XEdBDRI4T9N7lMV2J7XoRPmyf3YetIRuhY4754NPl4v/KKM/6ynKQ1uD/GW7Y8bnGGiLm8GrSq9
	HyIu6GJUqOZVbdW9/5kv/fZ5bcFynIYCQYM4QdzIjKqFqxIvfgqumHYg=
X-Google-Smtp-Source: AGHT+IE1D/TEXf+4qApYpOoI8HPj3Ge9wGIYouUqObjPXJuA/Im15IdGe7ptIxsZ9IbWUIJP1Cs/fz+iW6j6BrQTUktydF+zKLHu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2582:b0:47e:d240:4d82 with SMTP id
 s2-20020a056638258200b0047ed2404d82mr19208jat.1.1712318464427; Fri, 05 Apr
 2024 05:01:04 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:01:04 -0700
In-Reply-To: <00000000000032adb00615568aee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d099c506155835b9@google.com>
Subject: Re: [syzbot] [jffs2?] [nilfs?] KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
From: syzbot <syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com>
To: arnd@arndb.de, dhowells@redhat.com, dwmw2@infradead.org, 
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nilfs@vger.kernel.org, richard@nod.at, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9c8ad7a2ff0bfe58f019ec0abc1fb965114dde7d
Author: David Howells <dhowells@redhat.com>
Date:   Thu May 16 11:52:27 2019 +0000

    uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113c6b3d180000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133c6b3d180000
console output: https://syzkaller.appspot.com/x/log.txt?x=153c6b3d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141bc615180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148423e3180000

Reported-by: syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com
Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

