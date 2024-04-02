Return-Path: <linux-kernel+bounces-128310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E1189592B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED20A28F19F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F3133435;
	Tue,  2 Apr 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxzW0Xon"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB758AB2;
	Tue,  2 Apr 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073732; cv=none; b=kbzNeQqAHO9xJKlhaU8ePKQsVF9gO05PPoWPQX2sLEaJi61XrbeW1ZwF+DGSypktTOXBlfoI+dommltfi2csXclan6YCEX8aSZR+UmF8MtOTKThmvynoMMg6pc89A4e7SZVSoOfQ8RyMAVAu7DV3oxzIh+jjY0x9Aj30BXeaF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073732; c=relaxed/simple;
	bh=DEOn1xNgAKpZbZ6xMd+kRpC3aUmgYt+buThP+4kuWKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lctyVSOb5RkZNUxwPOmYPhswigEvGHA/HmO5wskSUHL2nux0RoqhGOeh2A3zAyd+sxXxq4uYBQpRf0lJ2Ig4FDG3k+lgm+uIPnszHO08SX1S8YmhyCIsEnPnA2n2GphMYatxec68OA0jV2Gq6j9U9JAFSeXXcgyS1voplwPV/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxzW0Xon; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690be110d0dso30997726d6.3;
        Tue, 02 Apr 2024 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712073729; x=1712678529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DuwW8ybOkzmr/SOGy90F/bjCxdf/25E5aFwCgbN0mk=;
        b=TxzW0XonjsquSJl8mgxOItKd6mJbBHa81SWNB/Qrmf1wF9o9wobmWC6/cNehI5cbF/
         s9mtyQius6ZR9xCzZnm7bnfLCNbneVUBZohG6A0jDm4/jIP5fwebm4/i3TuT/itAmlXs
         +sMtXAc/0/bo21PydzputV4vMZVosUNDrRCOttMPG0Jc6BmUJlmq07HPKKxBXULc3RMh
         S4kPK/79e+G8Jua96QeIOpoq2JliEWH47/wPGZpLGxYPCuabL8W3xnOQKWs868CXYdHx
         XiK2I1rJqINC2dnqPt6GQGLlts/ErEDRPjB3MpmizGGO6z8dCObPkj7d6ARtdsrrmDr5
         HEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712073729; x=1712678529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DuwW8ybOkzmr/SOGy90F/bjCxdf/25E5aFwCgbN0mk=;
        b=wkPpfii8b/I8sL1BmH627cRIjkLO4SiBe7NkWuW+J4zKiFDZFj46hbOxLo3LKRh7Kq
         x+ZDtJtbNPFP+Q4EKVTNXxG1atmCJnPKzulNc2n380WYnkTdBQBGbP+kASMROTqeZLnU
         1e45SNIUxL4gRQMjvOObfUHqdv7WLUmymQkBPlBQK/L6lY23Mv3lLxEB00HInsHg1kVc
         Jp35mDUx2rgG1Bpt1AZqYAlpuLed7VdVPAx2ZeVdX+Ql6I2Lm5r3kLQG3vdOcO0Gtsir
         myrV0lBpKFdbJlcwY1MZEyBuZ5Kldu+7qTDDCljABl/DSlM62a3julOB9b0UAA9VlpW0
         ohpA==
X-Forwarded-Encrypted: i=1; AJvYcCXg/WtgWibHkPYS4w5J0szd1L2q3VtD253vd8nu4YYgEWNM9HIIf80oS3zGO20yIWNcsUcA1VWAj4YuAStzV+a55dJ4Ctl6QXsuGz/huSoCk0PR5XzDGkT48VsUDXbkWRRn3jCD9szI3Xbfu68DC++tqd9o4xBaHvxraSwNUCs4GN1d02Rni0NgD1NLdPVpXYnIKWeK8V/Tw7QatvwfNPlV/xvBWTjUzPwvosUg+fdShlDhT67gyEgHEEqQ+nuxeQ==
X-Gm-Message-State: AOJu0Yy4qCfpY+fOOah+aNj1xqQZaHWT2zmAFncEml8b15Mz/tRwENjk
	Y8um1ZFT/DpF+0pzQPYTSc4B7j8sCTYgf5b2sKl5fCP//kN/Sfm/rxhU4OE1edWXjWQCZlgmzPq
	5KP3Q+QCnUYPN1gt3LLJGd3mkgss=
X-Google-Smtp-Source: AGHT+IG6zDVYSC74tLvhayQ0Wy6z5Gn2S/WSmUva7gmngOWuFFffWZg1A9odCJoPg8J4ahUtWwmRqJcjATq3O74uveQ=
X-Received: by 2002:a0c:c309:0:b0:696:481a:e2ec with SMTP id
 f9-20020a0cc309000000b00696481ae2ecmr13405904qvi.22.1712073729241; Tue, 02
 Apr 2024 09:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008caae305ab9a5318@google.com> <ZgrwugCEDH2fLJXK@ural>
In-Reply-To: <ZgrwugCEDH2fLJXK@ural>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Apr 2024 19:01:57 +0300
Message-ID: <CAOQ4uxj4E1_iDn9oeP71sbs01RNs5LojDpuPdvwHyYc55fKHHQ@mail.gmail.com>
Subject: Re: general protection fault in security_inode_getattr
To: Andrey Kalachev <kalachev@swemel.ru>
Cc: syzbot <syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com>, andriin@fb.com, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, jmorris@namei.org, 
	john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, serge@hallyn.com, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com, miklos@szeredi.hu, 
	linux-unionfs@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 8:43=E2=80=AFPM Andrey Kalachev <kalachev@swemel.ru>=
 wrote:
>
> On Wed, Jul 29, 2020 at 01:23:18PM -0700, syzbot wrote:
> >Hello,
> >
> >syzbot found the following issue on:
> >
> >HEAD commit:    92ed3019 Linux 5.8-rc7
> >git tree:       upstream
> >console output: https://syzkaller.appspot.com/x/log.txt?x=3D140003ac9000=
00
> >kernel config:  https://syzkaller.appspot.com/x/.config?x=3D84f076779e98=
9e69
> >dashboard link: https://syzkaller.appspot.com/bug?extid=3Df07cc9be8d1d22=
6947ed
> >compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> >Unfortunately, I don't have any reproducer for this issue yet.
> >
> >IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> >Reported-by: syzbot+f07cc9be8d1d226947ed@syzkaller.appspotmail.com
> >
> >general protection fault, probably for non-canonical address 0xdffffc000=
000000c: 0000 [#1] PREEMPT SMP KASAN
> >KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
> >CPU: 0 PID: 9214 Comm: syz-executor.3 Not tainted 5.8.0-rc7-syzkaller #0
> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 01/01/2011
> >RIP: 0010:d_backing_inode include/linux/dcache.h:549 [inline]
> >RIP: 0010:security_inode_getattr+0x46/0x140 security/security.c:1276
> >Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 04 01 00 00 48 b8 00 00 00 =
00 00 fc ff df 49 8b 5d 08 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0=
f 85 d7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
> >RSP: 0018:ffffc9000d41f638 EFLAGS: 00010206
> >RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f539000
> >RDX: 000000000000000c RSI: ffffffff8354f8ee RDI: 0000000000000060
> >RBP: ffffc9000d41f810 R08: 0000000000000001 R09: ffff88804edc2dc8
> >R10: 0000000000000000 R11: 00000000000ebc58 R12: ffff888089f10170
> >R13: ffffc9000d41f810 R14: 00000000000007ff R15: 0000000000000000
> >FS:  00007f3599717700(0000) GS:ffff8880ae600000(0000) knlGS:000000000000=
0000
> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: 0000001b2c12c000 CR3: 0000000099919000 CR4: 00000000001406f0
> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >Call Trace:
> > vfs_getattr+0x22/0x60 fs/stat.c:121
> > ovl_copy_up_one+0x13b/0x1870 fs/overlayfs/copy_up.c:850
> > ovl_copy_up_flags+0x14b/0x1d0 fs/overlayfs/copy_up.c:931
> > ovl_maybe_copy_up+0x140/0x190 fs/overlayfs/copy_up.c:963
> > ovl_open+0xba/0x270 fs/overlayfs/file.c:147
> > do_dentry_open+0x501/0x1290 fs/open.c:828
> > do_open fs/namei.c:3243 [inline]
> > path_openat+0x1bb9/0x2750 fs/namei.c:3360
> > do_filp_open+0x17e/0x3c0 fs/namei.c:3387
> > file_open_name+0x290/0x400 fs/open.c:1124
> > acct_on+0x78/0x770 kernel/acct.c:207
> > __do_sys_acct kernel/acct.c:286 [inline]
> > __se_sys_acct kernel/acct.c:273 [inline]
> > __x64_sys_acct+0xab/0x1f0 kernel/acct.c:273
> > do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
> > entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >RIP: 0033:0x45c369
> >Code: 8d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 f=
f ff 0f 83 5b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> >RSP: 002b:00007f3599716c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
> >RAX: ffffffffffffffda RBX: 0000000000000700 RCX: 000000000045c369
> >RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000440
> >RBP: 000000000078bf30 R08: 0000000000000000 R09: 0000000000000000
> >R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
> >R13: 00007ffda41ffbef R14: 00007f35997179c0 R15: 000000000078bf0c
> >Modules linked in:
> >---[ end trace d1398a63985d3915 ]---
> >RIP: 0010:d_backing_inode include/linux/dcache.h:549 [inline]
> >RIP: 0010:security_inode_getattr+0x46/0x140 security/security.c:1276
> >Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 04 01 00 00 48 b8 00 00 00 =
00 00 fc ff df 49 8b 5d 08 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0=
f 85 d7 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
> >RSP: 0018:ffffc9000d41f638 EFLAGS: 00010206
> >RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f539000
> >RDX: 000000000000000c RSI: ffffffff8354f8ee RDI: 0000000000000060
> >RBP: ffffc9000d41f810 R08: 0000000000000001 R09: ffff88804edc2dc8
> >R10: 0000000000000000 R11: 00000000000ebc58 R12: ffff888089f10170
> >R13: ffffc9000d41f810 R14: 00000000000007ff R15: 0000000000000000
> >FS:  00007f3599717700(0000) GS:ffff8880ae600000(0000) knlGS:000000000000=
0000
> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: 0000000020000440 CR3: 0000000099919000 CR4: 00000000001406f0
> >DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> >---
> >This report is generated by a bot. It may contain errors.
> >See https://goo.gl/tpsmEJ for more information about syzbot.
> >syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> >syzbot will keep track of this issue. See:
> >https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> Hello,
>
> I've found that the bug fixed by commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0af950f57fefabab628f1963af881e6b9bfe7f38
> merged with mainline here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?i=
d=3Dbe3c213150dc4370ef211a78d78457ff166eba4e
>
> Kernel release 6.5 include the fixed code.
>
> Hence, the stable kernels up to 6.5 still affected.
> I've got early version (4.19.139) from syzbot report, here is the first t=
ime when been reported.
> Maybe previous versions are also affected, I haven't checked it.
>
> I've only deal with stable 5.10 and 6.1, here I can confirm the issue.
>
> The tracing results showed that GPF caused by the dentry shared between t=
wo processes.
> Suppose we have a regular file `A` onto lower overlayfs layer, metacopy=
=3Don.
> P1 execute link syscall ( `A` link to `B`), P2 do open `B`.
>
>    P1          P2
>
>    sys_link
>                sys_open
>                  ovl_lookup B -- lookup non existent `B`, alloc `B` dentr=
y
>                    ovl_alloc_entry -- non existent file, zero filled ovl_=
entry
>
>      ovl_link -- link A to B, use same dentry `B`, dentry associated with
>      `A`, lower layer file now.
>
>    sys_link -- return to userspace, zero filled ovl_entry `B` untouched
>
>                      ovl_open B, reuse the same dentry `B`
>                        ovl_copy_up_one
>                          ovl_path_lower
>                            ovl_numlower(oe) -- return 0, numlower in zero=
 filled ovl_entry `oe`
>                          ovl_path_lower -- return zero filled `struct pat=
h`
>                          vfs_getattr(struct path, ..)
>                            security_inode_getattr(struct path, ...)
>                              d_backing_inode(path->dentry) -- NULL derefe=
rence, GPF
>
> Stable kernel v6.1 can be easy fixed by 4 mainline commits transfer:
>
> 0af950f57fef ovl: move ovl_entry into ovl_inode
> 163db0da3515 ovl: factor out ovl_free_entry() and ovl_stack_*() helpers
> 5522c9c7cbd2 ovl: use ovl_numlower() and ovl_lowerstack() accessors
> a6ff2bc0be17 ovl: use OVL_E() and OVL_E_FLAGS() accessors
>
> Just commit 5522c9c7cbd2 has conflict caused by
> 4609e1f18e19c ("fs: port ->permission() to pass mnt_idmap").
> It is enough to change mnt_idmap() call to mnt_user_ns(),
> in the rejected hunk.

Hi Andrey,

I don't have time to review this backport series, but in my memory,
these few commits were part of a much larger refactoring and
I am almost positive that there are fix commits that mention
Fixes: 0af950f57fef ("ovl: move ovl_entry into ovl_inode") in upstream kern=
el.

If you do want to backport overlayfs changes to stable kernels, you should
specify how you tested them and that should include at least running
the latest fstests overlayfs tests.

Thanks,
Amir.

