Return-Path: <linux-kernel+bounces-101514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DE87A81F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AFE1C21B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6806405E6;
	Wed, 13 Mar 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUWQH/oe"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4F3D6D;
	Wed, 13 Mar 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335676; cv=none; b=SigYPry0V4y+J20Wp1NA75nj1kGG/aWa6CSCr8CZN5xo+F9PJgOa5o87jrUOJuZ6Z1RCdoHpOiLn4Bn7OIR5jrEr/WuqG0CZCV+RUWS5hu20en6FfsDARctaLLO5EPQKxe1xHmxls2XFWRJg2fHOqhohEhZb+2/d3LZgkGxmrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335676; c=relaxed/simple;
	bh=3lPCV6TMJN27iHN7aHUHJ4vzXoB99xP6MVHG7wz9amo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTiogKtvHkbd/u3CKETFumbs2DxlDV9KnnHn1YFClRpDUH/b+XCl/QAbKfp2yyZ2whFMrmYTujyunbI16VxzjTKPeBbnjVvI3rftu3Cq/zvv70sCK006galAQK1Qrd40+YcY1tyLA0sQpkURjk07Paao5BXIQwVrbzRQ5JXLIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUWQH/oe; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690be110d0dso6497146d6.3;
        Wed, 13 Mar 2024 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710335673; x=1710940473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJzpsrmCenFu7IdfSOWHkDmErNlkUDvh3Q0XzBbLgos=;
        b=gUWQH/oe0OYj0jI3Ycfu9TGf2CWFdfMTq2sx9j/sIjBXKpb9zbbC9ENS1G8hpX+vYO
         D6wXPNE4QnFbcy2W8IitOI7A+0PFOHP5pEghSCnqshI5D68UEiHpDfCUjPgn3hxY/jtY
         +0N1Sp9lIhPXSowDgxFLpRpNCltQCBo9n3p0r/wdlumuwD9SbU67zf22wAVBQc4dwV1M
         qGp7wVvtYLAEBJ1kZxoIqTG3H7YW+MXeFa8CMFvh2qDeCfVp6uZjXG50pWSuge5+M8YB
         /FhW5JBrs+EuREgJw3oEZTesajse2gAWYpJreNIRFbkF3j5Dx+kfQ0IdbV6k0EwC04mY
         eVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710335673; x=1710940473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJzpsrmCenFu7IdfSOWHkDmErNlkUDvh3Q0XzBbLgos=;
        b=DwuVdJv0IaHCIBU6+01sX3sMlHNbuv78PdNhcC7AZpxVa1kegGEpi1FtVkS7xPi6u2
         b6pjo6x6Kv7Ym6RP6OhPib9d0wBcjftc5NipQ1salzpxFtcmrnVn4vnPZI/8ePEyiqeY
         pJcLYz/SCAx052P9waP/SqyvWKK8Lbahdw7KBb+V11pLxhr6Yj9EFU0hkYZ09BgO3oqX
         UeCPcqw/ag+WrdxeRoFA6FQZnwT0TDPLoMDUW0gBbX6QHFxZwyqRRPU9bmDqvJ0jIylP
         XPE59NbSwWtpDi80/b29UY5rKkG/fOzmX6eAZbFGsMVC2npaHlA7hCDo5Focvc90kN+r
         GwTw==
X-Forwarded-Encrypted: i=1; AJvYcCVyYheMOadFrMIsf72bryEWdtzvNH/U0KWkNd7IUYeBvrfBQRW7FlMXQHMFSrM8HzzVP6OnWMPU8qfvU78ZfFzQH++llTNItn9Y92vbznRGNSc+44U3V/feqDOwo39qFesEfEFaa+Rx7zlXvQ==
X-Gm-Message-State: AOJu0YzLQuhsPmpmCWgeh3RSWUWtxHalyaGmbR6Mgzfk8GqnN11sx033
	7b9xjb8D/CKcnvd412+rjKoxeJQu42Co3ylFgIJsRSAboLI4fFO4eyQvH/RiekFD6PInvncTD5/
	7dlCjGwV06oscdWrQurjlStllCsIlE8dhXEM=
X-Google-Smtp-Source: AGHT+IEANtx3n/nwac38tJl9g9GjbrpfrfkMtfkUzYUrTQ5kTlnhPXpbKorPdNJEIzCBygefN9FG2Zg8ttieo7AKiig=
X-Received: by 2002:a05:6214:5d2:b0:690:eb4a:2ae9 with SMTP id
 t18-20020a05621405d200b00690eb4a2ae9mr4596450qvz.48.1710335672615; Wed, 13
 Mar 2024 06:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03d7a29c7e1a8c5741680ea9bc83b4fb40358a25.camel@elektrobit.com>
In-Reply-To: <03d7a29c7e1a8c5741680ea9bc83b4fb40358a25.camel@elektrobit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Mar 2024 15:14:21 +0200
Message-ID: <CAOQ4uxg+RveBHjgui_HjCasYGor3JNeuv-UroR=5j4n6TgRd7w@mail.gmail.com>
Subject: Re: possible deadlock in ovl_llseek 27c1936af506
To: =?UTF-8?Q?Wei=C3=9F=2C_Simone?= <Simone.Weiss@elektrobit.com>
Cc: "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:10=E2=80=AFAM Wei=C3=9F, Simone
<Simone.Weiss@elektrobit.com> wrote:
>
> Dear Miklos and Amir,
>
> For some experimentation, I have been running fuzzing campaigns and I
> noticed a possible deadlock in ovl_llseek .
>
> As there is a C reproducer, it could be bisected being introduced with:
>
> commit 27c1936af5068b5367078a65df6a3d4de3e94e9a
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Mon Apr 12 12:00:37 2021 +0200
>
>     ovl: allow upperdir inside lowerdir
>
>     commit 708fa01597fa002599756bf56a96d0de1677375c upstream.
>
>     Commit 146d62e5a586 ("ovl: detect overlapping layers") made sure we d=
on't
>     have overlapping layers, but it also broke the arguably valid use cas=
e of
>
>      mount -olowerdir=3D/,upperdir=3D/subdir,..
>
>     where upperdir overlaps lowerdir on the same filesystem.  This has be=
en
>     causing regressions.
>
>     Revert the check, but only for the specific case where upperdir and/o=
r
>     workdir are subdirectories of lowerdir.  Any other overlap (e.g. lowe=
rdir
>     is subdirectory of upperdir, etc) case is crazy, so leave the check i=
n
>     place for those.
>
>     Overlaps are detected at lookup time too, so reverting the mount time=
 check
>     should be safe.
>
> It was reproducible on v5.10.212 and a syz-crush check also found crashes=
 on
> v6.8-rc1.
>
>

The reason for this report is calling llseek() on lower ovl from
ovl_copy_up_data() when ovl_copy_up_data() is called with upper
inode lock and the lower ovl uses the same upper fs.

It looks to me like the possible deadlock should have been solved by commit
c63e56a4a652 ovl: do not open/llseek lower file with upper sb_writers held
that moved ovl_copy_up_data() out of the inode_lock() scope.

I am not sure what the statement "a syz-crush check also found crashes
on v6.8-rc1."
means - does it mean that this reproducer produced this same lockdep warnin=
g
on upstream kernel?

Thanks,
Amir.


> The C reproducer is automatically generated by syzkaller and included bel=
ow.
>
> If you need any further information, just let me know.
>
> Regards,
> Simone
>
> Log:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.10.34-eb-corbos-standard-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor175/7735 is trying to acquire lock:
> ffff00000c54a0a0
>  (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock
> fs/overlayfs/overlayfs.h:362 [inline]
>  (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_llseek+0xec/0x194
> fs/overlayfs/file.c:207
>
> but task is already holding lock:
> ffff00000c60eca0 (&sb->s_type->i_mutex_key#15/5){+.+.}-{3:3}, at:
> inode_lock_nested include/linux/fs.h:809 [inline]
> ffff00000c60eca0 (&sb->s_type->i_mutex_key#15/5){+.+.}-{3:3}, at:
> lock_rename+0x10c/0x144 fs/namei.c:2772
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&sb->s_type->i_mutex_key#15/5
> ){+.+.}-{3:3}:
>        __lock_release kernel/locking/lockdep.c:5160 [inline]
>        lock_release+0x244/0x390 kernel/locking/lockdep.c:5464
>        up_write+0x4c/0x154 kernel/locking/rwsem.c:1609
>        inode_unlock include/linux/fs.h:779 [inline]
>        unlock_rename+0x28/0x60 fs/namei.c:2779
>        ovl_workdir_ok fs/overlayfs/super.c:915 [inline]
>        ovl_get_workdir fs/overlayfs/super.c:1405 [inline]
>        ovl_fill_super+0x62c/0x28d0 fs/overlayfs/super.c:1965
>        mount_nodev+0x70/0xf0 fs/super.c:1465
>        ovl_mount+0x3c/0x50 fs/overlayfs/super.c:2050
>        legacy_get_tree+0x34/0xb0 fs/fs_context.c:592
>        vfs_get_tree+0x34/0xe0 fs/super.c:1549
>        do_new_mount fs/namespace.c:2881 [inline]
>        path_mount+0xd50/0x1600 fs/namespace.c:3211
>        do_mount fs/namespace.c:3224 [inline]
>        __do_sys_mount fs/namespace.c:3432 [inline]
>        __se_sys_mount fs/namespace.c:3409 [inline]
>        __arm64_sys_mount+0x680/0x7d0 fs/namespace.c:3409
>        __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>        invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>        el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
>        do_el0_svc+0xe0/0x340 arch/arm64/kernel/syscall.c:197
>        el0_svc+0x24/0x34 arch/arm64/kernel/entry-common.c:367
>        el0_sync_handler+0xec/0x210 arch/arm64/kernel/entry-common.c:383
>        el0_sync+0x17c/0x180 arch/arm64/kernel/entry.S:672
>
> -> #1 (&type->s_vfs_rename_key){+.+.}-{3:3}:
>        lock_acquire+0x68/0x84 kernel/locking/lockdep.c:5417
>        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
>        __mutex_lock+0x84/0x730 kernel/locking/mutex.c:1106
>        mutex_lock_nested+0x40/0x50 kernel/locking/mutex.c:1121
>        lock_rename+0x3c/0x144 fs/namei.c:2755
>        ovl_copy_up_workdir fs/overlayfs/copy_up.c:595 [inline]
>        ovl_do_copy_up fs/overlayfs/copy_up.c:746 [inline]
>        ovl_copy_up_one+0x434/0x12ec fs/overlayfs/copy_up.c:916
>        ovl_copy_up_flags+0x100/0x164 fs/overlayfs/copy_up.c:961
>        ovl_maybe_copy_up+0x104/0x14c fs/overlayfs/copy_up.c:993
>        ovl_open+0x4c/0x110 fs/overlayfs/file.c:154
>        do_dentry_open+0x2a0/0x5c0 fs/open.c:817
>        vfs_open+0x38/0x50 fs/open.c:931
>        do_open fs/namei.c:3243 [inline]
>        path_openat+0xc88/0x1050 fs/namei.c:3360
>        do_filp_open+0x8c/0x170 fs/namei.c:3387
>        do_sys_openat2+0xf4/0x240 fs/open.c:1172
>        __do_sys_openat2 fs/open.c:1227 [inline]
>        __se_sys_openat2 fs/open.c:1207 [inline]
>        __arm64_sys_openat2+0x304/0x410 fs/open.c:1207
>        __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>        invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>        el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
>        do_el0_svc+0xe0/0x340 arch/arm64/kernel/syscall.c:197
>        el0_svc+0x24/0x34 arch/arm64/kernel/entry-common.c:367
>        el0_sync_handler+0xec/0x210 arch/arm64/kernel/entry-common.c:383
>        el0_sync+0x17c/0x180 arch/arm64/kernel/entry.S:672
>
> -> #0 (&ovl_i_lock_key[depth]){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:2869 [inline]
>        check_prevs_add kernel/locking/lockdep.c:2994 [inline]
>        validate_chain kernel/locking/lockdep.c:3609 [inline]
>        __lock_acquire+0x10ec/0x18a4 kernel/locking/lockdep.c:4834
>        lock_acquire.part.0+0xec/0x2e0 kernel/locking/lockdep.c:5444
>        lock_acquire+0x68/0x84 kernel/locking/lockdep.c:5417
>        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
>        __mutex_lock+0x84/0x730 kernel/locking/mutex.c:1106
>        mutex_lock_nested+0x40/0x50 kernel/locking/mutex.c:1121
>        ovl_inode_lock fs/overlayfs/overlayfs.h:362 [inline]
>        ovl_llseek+0xec/0x194 fs/overlayfs/file.c:207
>        vfs_llseek+0x60/0x80 fs/read_write.c:300
>        ovl_copy_up_data+0x21c/0x390 fs/overlayfs/copy_up.c:199
>        ovl_copy_up_inode+0x258/0x2b4 fs/overlayfs/copy_up.c:507
>        ovl_copy_up_workdir fs/overlayfs/copy_up.c:609 [inline]
>        ovl_do_copy_up fs/overlayfs/copy_up.c:746 [inline]
>        ovl_copy_up_one+0x4cc/0x12ec fs/overlayfs/copy_up.c:916
>        ovl_copy_up_flags+0x100/0x164 fs/overlayfs/copy_up.c:961
>        ovl_maybe_copy_up+0x104/0x14c fs/overlayfs/copy_up.c:993
>        ovl_open+0x4c/0x110 fs/overlayfs/file.c:154
>        do_dentry_open+0x2a0/0x5c0 fs/open.c:817
>        vfs_open+0x38/0x50 fs/open.c:931
>        do_open fs/namei.c:3243 [inline]
>        path_openat+0xc88/0x1050 fs/namei.c:3360
>        do_filp_open+0x8c/0x170 fs/namei.c:3387
>        do_sys_openat2+0xf4/0x240 fs/open.c:1172
>        __do_sys_openat2 fs/open.c:1227 [inline]
>        __se_sys_openat2 fs/open.c:1207 [inline]
>        __arm64_sys_openat2+0x304/0x410 fs/open.c:1207
>        __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>        invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>        el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
>        do_el0_svc+0xe0/0x340 arch/arm64/kernel/syscall.c:197
>        el0_svc+0x24/0x34 arch/arm64/kernel/entry-common.c:367
>        el0_sync_handler+0xec/0x210 arch/arm64/kernel/entry-common.c:383
>        el0_sync+0x17c/0x180 arch/arm64/kernel/entry.S:672
>
> other info that might help us debug this:
>
> Chain exists of:
>   &ovl_i_lock_key[depth] --> &type->s_vfs_rename_key --> &sb->s_type-
> >i_mutex_key#15/5
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&sb->s_type->i_mutex_key#15/5);
>                                lock(&type->s_vfs_rename_key);
>                                lock(&sb->s_type->i_mutex_key#15/5);
>   lock(&ovl_i_lock_key[depth]);
>
>  *** DEADLOCK ***
>
> 5 locks held by syz-executor175/7735:
>  #0: ffff000005302438 (sb_writers#9){.+.+}-{0:0}, at: __sb_start_write
> include/linux/fs.h:1594 [inline]
>  #0: ffff000005302438 (sb_writers#9){.+.+}-{0:0}, at: sb_start_write
> include/linux/fs.h:1664 [inline]
>  #0: ffff000005302438 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x24=
/0x80
> fs/namespace.c:354
>  #1: ffff00000c54bcc0 (&ovl_i_lock_key[depth]#2){+.+.}-{3:3}, at:
> ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:367 [inline]
>  #1: ffff00000c54bcc0 (&ovl_i_lock_key[depth]#2){+.+.}-{3:3}, at:
> ovl_copy_up_start+0x34/0x160 fs/overlayfs/util.c:533
>  #2: ffff000005302720 (&type->s_vfs_rename_key){+.+.}-{3:3}, at:
> lock_rename+0x3c/0x144 fs/namei.c:2755
>  #3: ffff000006711110 (&sb->s_type->i_mutex_key#15/1){+.+.}-{3:3}, at:
> inode_lock_nested include/linux/fs.h:809 [inline]
>  #3: ffff000006711110 (&sb->s_type->i_mutex_key#15/1){+.+.}-{3:3}, at:
> lock_rename+0xfc/0x144 fs/namei.c:2771
>  #4: ffff00000c60eca0 (&sb->s_type->i_mutex_key#15/5){+.+.}-{3:3}, at:
> inode_lock_nested include/linux/fs.h:809 [inline]
>  #4: ffff00000c60eca0 (&sb->s_type->i_mutex_key#15/5){+.+.}-{3:3}, at:
> lock_rename+0x10c/0x144 fs/namei.c:2772
>
> stack backtrace:
> CPU: 0 PID: 7735 Comm: syz-executor175 Not tainted 5.10.34-eb-corbos-stan=
dard-
> syzkaller #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x2e0 arch/arm64/include/asm/atomic_ll_sc.h:222
>  show_stack+0x2c/0x40 arch/arm64/kernel/stacktrace.c:196
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1d4/0x26c lib/dump_stack.c:118
>  print_circular_bug+0x1f8/0x200 kernel/locking/lockdep.c:1997
>  check_noncircular+0x100/0x114 kernel/locking/lockdep.c:2118
>  check_prev_add kernel/locking/lockdep.c:2869 [inline]
>  check_prevs_add kernel/locking/lockdep.c:2994 [inline]
>  validate_chain kernel/locking/lockdep.c:3609 [inline]
>  __lock_acquire+0x10ec/0x18a4 kernel/locking/lockdep.c:4834
>  lock_acquire.part.0+0xec/0x2e0 kernel/locking/lockdep.c:5444
>  lock_acquire+0x68/0x84 kernel/locking/lockdep.c:5417
>  __mutex_lock_common kernel/locking/mutex.c:959 [inline]
>  __mutex_lock+0x84/0x730 kernel/locking/mutex.c:1106
>  mutex_lock_nested+0x40/0x50 kernel/locking/mutex.c:1121
>  ovl_inode_lock fs/overlayfs/overlayfs.h:362 [inline]
>  ovl_llseek+0xec/0x194 fs/overlayfs/file.c:207
>  vfs_llseek+0x60/0x80 fs/read_write.c:300
>  ovl_copy_up_data+0x21c/0x390 fs/overlayfs/copy_up.c:199
>  ovl_copy_up_inode+0x258/0x2b4 fs/overlayfs/copy_up.c:507
>  ovl_copy_up_workdir fs/overlayfs/copy_up.c:609 [inline]
>  ovl_do_copy_up fs/overlayfs/copy_up.c:746 [inline]
>  ovl_copy_up_one+0x4cc/0x12ec fs/overlayfs/copy_up.c:916
>  ovl_copy_up_flags+0x100/0x164 fs/overlayfs/copy_up.c:961
>  ovl_maybe_copy_up+0x104/0x14c fs/overlayfs/copy_up.c:993
>  ovl_open+0x4c/0x110 fs/overlayfs/file.c:154
>  do_dentry_open+0x2a0/0x5c0 fs/open.c:817
>  vfs_open+0x38/0x50 fs/open.c:931
>  do_open fs/namei.c:3243 [inline]
>  path_openat+0xc88/0x1050 fs/namei.c:3360
>  do_filp_open+0x8c/0x170 fs/namei.c:3387
>  do_sys_openat2+0xf4/0x240 fs/open.c:1172
>  __do_sys_openat2 fs/open.c:1227 [inline]
>  __se_sys_openat2 fs/open.c:1207 [inline]
>  __arm64_sys_openat2+0x304/0x410 fs/open.c:1207
>  __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>  el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
>  do_el0_svc+0xe0/0x340 arch/arm64/kernel/syscall.c:197
>  el0_svc+0x24/0x34 arch/arm64/kernel/entry-common.c:367
>  el0_sync_handler+0xec/0x210 arch/arm64/kernel/entry-common.c:383
>  el0_sync+0x17c/0x180 arch/arm64/kernel/entry.S:672
>
>
> C Reproducer:
>
> // https://None.appspot.com/bug?id=3Df10e9988ed129179c80858a403259185ef33=
2f5d
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <pthread.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>
> #include <linux/futex.h>
>
> #ifndef __NR_chdir
> #define __NR_chdir 49
> #endif
> #ifndef __NR_mkdirat
> #define __NR_mkdirat 34
> #endif
> #ifndef __NR_mmap
> #define __NR_mmap 222
> #endif
> #ifndef __NR_mount
> #define __NR_mount 40
> #endif
> #ifndef __NR_openat
> #define __NR_openat 56
> #endif
> #ifndef __NR_openat2
> #define __NR_openat2 437
> #endif
> #ifndef __NR_write
> #define __NR_write 64
> #endif
>
> static unsigned long long procid;
>
> static void sleep_ms(uint64_t ms)
> {
>   usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void)
> {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>
> static void use_temporary_dir(void)
> {
>   char tmpdir_template[] =3D "./syzkaller.XXXXXX";
>   char* tmpdir =3D mkdtemp(tmpdir_template);
>   if (!tmpdir)
>     exit(1);
>   if (chmod(tmpdir, 0777))
>     exit(1);
>   if (chdir(tmpdir))
>     exit(1);
> }
>
> static void thread_start(void* (*fn)(void*), void* arg)
> {
>   pthread_t th;
>   pthread_attr_t attr;
>   pthread_attr_init(&attr);
>   pthread_attr_setstacksize(&attr, 128 << 10);
>   int i =3D 0;
>   for (; i < 100; i++) {
>     if (pthread_create(&th, &attr, fn, arg) =3D=3D 0) {
>       pthread_attr_destroy(&attr);
>       return;
>     }
>     if (errno =3D=3D EAGAIN) {
>       usleep(50);
>       continue;
>     }
>     break;
>   }
>   exit(1);
> }
>
> typedef struct {
>   int state;
> } event_t;
>
> static void event_init(event_t* ev)
> {
>   ev->state =3D 0;
> }
>
> static void event_reset(event_t* ev)
> {
>   ev->state =3D 0;
> }
>
> static void event_set(event_t* ev)
> {
>   if (ev->state)
>     exit(1);
>   __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
>   syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000=
);
> }
>
> static void event_wait(event_t* ev)
> {
>   while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
>     syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0)=
;
> }
>
> static int event_isset(event_t* ev)
> {
>   return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
> }
>
> static int event_timedwait(event_t* ev, uint64_t timeout)
> {
>   uint64_t start =3D current_time_ms();
>   uint64_t now =3D start;
>   for (;;) {
>     uint64_t remain =3D timeout - (now - start);
>     struct timespec ts;
>     ts.tv_sec =3D remain / 1000;
>     ts.tv_nsec =3D (remain % 1000) * 1000 * 1000;
>     syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &t=
s);
>     if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
>       return 1;
>     now =3D current_time_ms();
>     if (now - start > timeout)
>       return 0;
>   }
> }
>
> static bool write_file(const char* file, const char* what, ...)
> {
>   char buf[1024];
>   va_list args;
>   va_start(args, what);
>   vsnprintf(buf, sizeof(buf), what, args);
>   va_end(args);
>   buf[sizeof(buf) - 1] =3D 0;
>   int len =3D strlen(buf);
>   int fd =3D open(file, O_WRONLY | O_CLOEXEC);
>   if (fd =3D=3D -1)
>     return false;
>   if (write(fd, buf, len) !=3D len) {
>     int err =3D errno;
>     close(fd);
>     errno =3D err;
>     return false;
>   }
>   close(fd);
>   return true;
> }
>
> #define FS_IOC_SETFLAGS _IOW('f', 2, long)
> static void remove_dir(const char* dir)
> {
>   int iter =3D 0;
>   DIR* dp =3D 0;
> retry:
>   while (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW) =3D=3D 0) {
>   }
>   dp =3D opendir(dir);
>   if (dp =3D=3D NULL) {
>     if (errno =3D=3D EMFILE) {
>       exit(1);
>     }
>     exit(1);
>   }
>   struct dirent* ep =3D 0;
>   while ((ep =3D readdir(dp))) {
>     if (strcmp(ep->d_name, ".") =3D=3D 0 || strcmp(ep->d_name, "..") =3D=
=3D 0)
>       continue;
>     char filename[FILENAME_MAX];
>     snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
>     while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) =3D=3D 0) {
>     }
>     struct stat st;
>     if (lstat(filename, &st))
>       exit(1);
>     if (S_ISDIR(st.st_mode)) {
>       remove_dir(filename);
>       continue;
>     }
>     int i;
>     for (i =3D 0;; i++) {
>       if (unlink(filename) =3D=3D 0)
>         break;
>       if (errno =3D=3D EPERM) {
>         int fd =3D open(filename, O_RDONLY);
>         if (fd !=3D -1) {
>           long flags =3D 0;
>           if (ioctl(fd, FS_IOC_SETFLAGS, &flags) =3D=3D 0) {
>           }
>           close(fd);
>           continue;
>         }
>       }
>       if (errno =3D=3D EROFS) {
>         break;
>       }
>       if (errno !=3D EBUSY || i > 100)
>         exit(1);
>       if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW))
>         exit(1);
>     }
>   }
>   closedir(dp);
>   for (int i =3D 0;; i++) {
>     if (rmdir(dir) =3D=3D 0)
>       break;
>     if (i < 100) {
>       if (errno =3D=3D EPERM) {
>         int fd =3D open(dir, O_RDONLY);
>         if (fd !=3D -1) {
>           long flags =3D 0;
>           if (ioctl(fd, FS_IOC_SETFLAGS, &flags) =3D=3D 0) {
>           }
>           close(fd);
>           continue;
>         }
>       }
>       if (errno =3D=3D EROFS) {
>         break;
>       }
>       if (errno =3D=3D EBUSY) {
>         if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW))
>           exit(1);
>         continue;
>       }
>       if (errno =3D=3D ENOTEMPTY) {
>         if (iter < 100) {
>           iter++;
>           goto retry;
>         }
>       }
>     }
>     exit(1);
>   }
> }
>
> static void kill_and_wait(int pid, int* status)
> {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   for (int i =3D 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
>       return;
>     usleep(1000);
>   }
>   DIR* dir =3D opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent* ent =3D readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =
=3D=3D 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd =3D open(abort, O_WRONLY);
>       if (fd =3D=3D -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) !=3D pid) {
>   }
> }
>
> static void setup_test()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   write_file("/proc/self/oom_score_adj", "1000");
>   if (symlink("/dev/binderfs", "./binderfs")) {
>   }
> }
>
> struct thread_t {
>   int created, call;
>   event_t ready, done;
> };
>
> static struct thread_t threads[16];
> static void execute_call(int call);
> static int running;
>
> static void* thr(void* arg)
> {
>   struct thread_t* th =3D (struct thread_t*)arg;
>   for (;;) {
>     event_wait(&th->ready);
>     event_reset(&th->ready);
>     execute_call(th->call);
>     __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
>     event_set(&th->done);
>   }
>   return 0;
> }
>
> static void execute_one(void)
> {
>   int i, call, thread;
>   for (call =3D 0; call < 12; call++) {
>     for (thread =3D 0; thread < (int)(sizeof(threads) / sizeof(threads[0]=
));
>          thread++) {
>       struct thread_t* th =3D &threads[thread];
>       if (!th->created) {
>         th->created =3D 1;
>         event_init(&th->ready);
>         event_init(&th->done);
>         event_set(&th->done);
>         thread_start(thr, th);
>       }
>       if (!event_isset(&th->done))
>         continue;
>       event_reset(&th->done);
>       th->call =3D call;
>       __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
>       event_set(&th->ready);
>       event_timedwait(&th->done, 50);
>       break;
>     }
>   }
>   for (i =3D 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i=
++)
>     sleep_ms(1);
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void)
> {
>   int iter =3D 0;
>   for (;; iter++) {
>     char cwdbuf[32];
>     sprintf(cwdbuf, "./%d", iter);
>     if (mkdir(cwdbuf, 0777))
>       exit(1);
>     int pid =3D fork();
>     if (pid < 0)
>       exit(1);
>     if (pid =3D=3D 0) {
>       if (chdir(cwdbuf))
>         exit(1);
>       setup_test();
>       execute_one();
>       exit(0);
>     }
>     int status =3D 0;
>     uint64_t start =3D current_time_ms();
>     for (;;) {
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
>         break;
>       sleep_ms(1);
>       if (current_time_ms() - start < 5000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>     remove_dir(cwdbuf);
>   }
> }
>
> uint64_t r[1] =3D {0xffffffffffffffff};
>
> void execute_call(int call)
> {
>   intptr_t res =3D 0;
>   switch (call) {
>   case 0:
>     memcpy((void*)0x20000000, "./file0\000", 8);
>     syscall(__NR_mkdirat, /*fd=3D*/0xffffff9c, /*path=3D*/0x20000000ul,
>             /*mode=3D*/0ul);
>     break;
>   case 1:
>     memcpy((void*)0x20000080, "./file0\000", 8);
>     memcpy((void*)0x200000c0, "ramfs\000", 6);
>     syscall(__NR_mount, /*src=3D*/0ul, /*dst=3D*/0x20000080ul,
>             /*type=3D*/0x200000c0ul, /*flags=3D*/0ul, /*data=3D*/0ul);
>     break;
>   case 2:
>     memcpy((void*)0x20000240, "./file0/file0\000", 14);
>     syscall(__NR_mkdirat, /*fd=3D*/0xffffff9c, /*path=3D*/0x20000240ul,
>             /*mode=3D*/0ul);
>     break;
>   case 3:
>     memcpy((void*)0x20000480, "./file0/file0\000", 14);
>     syscall(__NR_chdir, /*dir=3D*/0x20000480ul);
>     break;
>   case 4:
>     memcpy((void*)0x20000180, "./file0\000", 8);
>     syscall(__NR_mkdirat, /*fd=3D*/0xffffff9c, /*path=3D*/0x20000180ul,
>             /*mode=3D*/0ul);
>     break;
>   case 5:
>     memcpy((void*)0x20000080, "./file0/file1\000", 14);
>     res =3D
>         syscall(__NR_openat, /*fd=3D*/0xffffffffffffff9cul, /*file=3D*/0x=
20000080ul,
>                 /*flags=3DO_CREAT|O_CLOEXEC|O_RDWR*/ 0x80042ul, /*mode=3D=
*/0ul);
>     if (res !=3D -1)
>       r[0] =3D res;
>     break;
>   case 6:
>     syscall(__NR_write, /*fd=3D*/r[0], /*data=3D*/0x20000980ul, /*len=3D*=
/0x58ul);
>     break;
>   case 7:
>     memcpy((void*)0x200000c0, "./file0/file0\000", 14);
>     syscall(__NR_mkdirat, /*fd=3D*/0xffffff9c, /*path=3D*/0x200000c0ul,
>             /*mode=3D*/0ul);
>     break;
>   case 8:
>     memcpy((void*)0x20000280, "./file1\000", 8);
>     syscall(__NR_mkdirat, /*fd=3D*/0xffffff9c, /*path=3D*/0x20000280ul,
>             /*mode=3D*/0ul);
>     break;
>   case 9:
>     memcpy((void*)0x20000200, "./file0\000", 8);
>     memcpy((void*)0x200001c0, "overlay\000", 8);
>     memcpy((void*)0x20000340, "lowerdir", 8);
>     *(uint8_t*)0x20000348 =3D 0x3d;
>     memcpy((void*)0x20000349, "./file0", 7);
>     *(uint8_t*)0x20000350 =3D 0x2c;
>     memcpy((void*)0x20000351, "workdir", 7);
>     *(uint8_t*)0x20000358 =3D 0x3d;
>     memcpy((void*)0x20000359, "./file1", 7);
>     *(uint8_t*)0x20000360 =3D 0x2c;
>     memcpy((void*)0x20000361, "upperdir", 8);
>     *(uint8_t*)0x20000369 =3D 0x3d;
>     memcpy((void*)0x2000036a, "./file0/file0", 13);
>     *(uint8_t*)0x20000377 =3D 0x2c;
>     *(uint8_t*)0x20000378 =3D 0;
>     syscall(__NR_mount, /*src=3D*/0ul, /*dst=3D*/0x20000200ul,
>             /*type=3D*/0x200001c0ul, /*flags=3D*/0ul, /*opts=3D*/0x200003=
40ul);
>     break;
>   case 10:
>     memcpy((void*)0x20000200, "./file0\000", 8);
>     memcpy((void*)0x200001c0, "overlay\000", 8);
>     memcpy((void*)0x20000340, "lowerdir", 8);
>     *(uint8_t*)0x20000348 =3D 0x3d;
>     memcpy((void*)0x20000349, "./file0", 7);
>     *(uint8_t*)0x20000350 =3D 0x2c;
>     memcpy((void*)0x20000351, "workdir", 7);
>     *(uint8_t*)0x20000358 =3D 0x3d;
>     memcpy((void*)0x20000359, "./file1", 7);
>     *(uint8_t*)0x20000360 =3D 0x2c;
>     memcpy((void*)0x20000361, "upperdir", 8);
>     *(uint8_t*)0x20000369 =3D 0x3d;
>     memcpy((void*)0x2000036a, "./file0/file0", 13);
>     *(uint8_t*)0x20000377 =3D 0x2c;
>     *(uint8_t*)0x20000378 =3D 0;
>     syscall(__NR_mount, /*src=3D*/0ul, /*dst=3D*/0x20000200ul,
>             /*type=3D*/0x200001c0ul, /*flags=3D*/0ul, /*opts=3D*/0x200003=
40ul);
>     break;
>   case 11:
>     memcpy((void*)0x20000100, "./file0/file1\000", 14);
>     *(uint64_t*)0x20000140 =3D 0x80041;
>     *(uint64_t*)0x20000148 =3D 0;
>     *(uint64_t*)0x20000150 =3D 0;
>     syscall(__NR_openat2, /*fd=3D*/0xffffffffffffff9cul, /*file=3D*/0x200=
00100ul,
>             /*how=3D*/0x20000140ul, /*size=3D*/0x18ul);
>     break;
>   }
> }
> int main(void)
> {
>   syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=
=3D*/0ul,
>           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D=
*/-1,
>           /*offset=3D*/0ul);
>   syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
>           /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D=
*/-1,
>           /*offset=3D*/0ul);
>   syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=
=3D*/0ul,
>           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D=
*/-1,
>           /*offset=3D*/0ul);
>   for (procid =3D 0; procid < 6; procid++) {
>     if (fork() =3D=3D 0) {
>       use_temporary_dir();
>       loop();
>     }
>   }
>   sleep(1000000);
>   return 0;
>
> }

