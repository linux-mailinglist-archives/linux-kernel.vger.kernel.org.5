Return-Path: <linux-kernel+bounces-91252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61263870BC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43371F22A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4EBDF6C;
	Mon,  4 Mar 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PaIcEdTQ"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE2FBFC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585142; cv=none; b=kIUJ7x2TGYPDAAqrcvCm0FpF1nm2/4Ozz8x5Lich2aZOajSUvOxJK9r+mOczMk8fpDk5Effnqe2F4/YgvMkyeh623nFa7qXzRCf22t5rqxRVDMcfRiZ8Cd2BM7ZyKUt7jf6UYa+aCyZBSXTiVe1gzEd1DUJmegdwAEe2i9Lerj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585142; c=relaxed/simple;
	bh=QHw4KuupoF0z0/b5KzLfYGoLxFX1ySm7okhwrFM/3P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB5MdEHJIePDWi+Cjy3caMdI5XtlbpUQNGPDKFgrnxR9SWnC4KEpZUO4tbvJR501CRwDQwlXfvt8qDUMJ/dSipRU9gsAVpY+XDvLuIMiyy8hNXRXVblBcIxtrZ732qBrWrOYm/akWuHVBQyQfyAvbqEPz6Gz4kUsS2DnkrlI+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PaIcEdTQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607e54b6cf5so33692247b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709585139; x=1710189939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSaE4L/9XpyWT21eAkg/wH5NujZBuFfazFChaUZ0Mi8=;
        b=PaIcEdTQNf1v+N9C5WSONR3IVaGS5RZxYW5E+nCCBim1HqMr2ssBLkuF3s0ibQLKpY
         2/e8b6fWhaxy7YQylWupYh/g6THbJmHm3SGAo63RRk68yCc/sJIEUgf8htSh/eh+KKrv
         GgzS1PS0pgDjeMPPhTnVDg/vTmup+wgfNsPXOif+s0pSm+q9sBagImiQhBRFKZc4bv72
         zNgsW9Gr810z2xTtOkn6a5iMliPmkFdxr1r3yrHcgh80vozD8/DGtung13Gm1rxcjB2y
         ixRQn/IIuLLA7GJSRYdu6ozNEzbnYQvsF/UNCpvFd5A6d5KCE4rQCjElZLcatMATOadY
         Tt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585139; x=1710189939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSaE4L/9XpyWT21eAkg/wH5NujZBuFfazFChaUZ0Mi8=;
        b=EA6csL9jzg+bZbPN+HJjraiFWoXPjY/ZI20JekH5YpCCjuB1s28gHd5g9pPB2gZyAk
         cLuSNd9AL2wERyUPO79DSprwgCgMOAu6FjxUjsvVaLTSDD0IpMyQ98+lh9C6fsS5fZtk
         o39egRaEKMS3zj1KevwbLQudmfq1qMlJ429nU7HTS5eoLQkzwDWGLrNxMvwyaIe9tKwD
         p4OEbeFvQksA4gxfzDRl2hArxfEuvnnJHcZGaI3D/HUpwrkX6jNUDqIYO5QPQs01pngy
         FpBoZ8MKcJllzxBAqNQAizpYa5dNB1ZXqp9D7/HNFvHovDc0tdr+0rKu0zpcIKqb6258
         Ge5w==
X-Forwarded-Encrypted: i=1; AJvYcCWarC9YyaV7Qp698ehviO63ul3D1fH4x4bi9iwEjoPPtaSeHlRba2ye0iQxF/1EAkMeMYwZauj8AGyUUFEyrTwlR4Ise/tHNjT7HlfO
X-Gm-Message-State: AOJu0YxKivztwIffp+YunROGhEf347Wb1U15l7hGfENJ6+77Fq9RA709
	nBRGkc0sxB3BJ/xt85T5SsCF6ZowYsb7ZB4Qi+LFDnAqRQDFsbp89mQQqsw0anMIiWpxwUyUCXz
	b+ny7dqIgB4x4KlC59+HRNxbhyGhewiTHm+dk
X-Google-Smtp-Source: AGHT+IGs3wwZ7G77wo8f8jOiIFMqJ6nx8hRpGXjJVXSvPcJXjbWO7SL2fdrpphPjyRTLpJ3ImIREbhh7+h2p1643gGE=
X-Received: by 2002:a81:af18:0:b0:609:81aa:2c6 with SMTP id
 n24-20020a81af18000000b0060981aa02c6mr496218ywh.7.1709585139627; Mon, 04 Mar
 2024 12:45:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOh-5_KzWih=qUxynbn=mMz=UfnPi6UftbyT8+MTDP0jg@mail.gmail.com>
 <CAHC9VhQ3crxcLXbT3fw2k7jYJFKy1VOm25npKpD9ZrwmwKzvJw@mail.gmail.com> <CAJ2a_DcSurcF5_G-DjXL_0X=utasy2y8oJ_ywCms-Qhyy6GORQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DcSurcF5_G-DjXL_0X=utasy2y8oJ_ywCms-Qhyy6GORQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Mar 2024 15:45:28 -0500
Message-ID: <CAHC9VhQVqokvnnqLPc8tv0jpewnUKqnWeAzQs-sMj3BLrY5=CA@mail.gmail.com>
Subject: Re: [Bug] WARNING: zero-size vmalloc in sel_write_load
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org, 
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>, syzkaller@googlegroups.com, selinux@vger.kernel.org, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:11=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Mon, 4 Mar 2024 at 20:19, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Mar 4, 2024 at 9:08=E2=80=AFAM Sam Sun <samsun1006219@gmail.com=
> wrote:
> > >
> > > Dear developers and maintainers,
> > >
> > > We encountered a warning in function sel_write_load(). It is tested o=
n
> > > kernel 6.8.0-rc7. Bug report is listed below.
> > >
> > > ```
> > > WARNING: CPU: 1 PID: 8109 at mm/vmalloc.c:3247
> > > __vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > > Modules linked in:
> > > CPU: 1 PID: 8109 Comm: syz-executor370 Not tainted 6.7.0-rc7 #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> > > RIP: 0010:__vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > > Code: 65 48 2b 04 25 28 00 00 00 0f 85 98 02 00 00 48 81 c4 70 01 00
> > > 00 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 71 43 b7 ff 90 <0f> 0=
b
> > > 90 45 31 e4 eb a1 e8 63 43 b7 ff 48 8b 4c 24 40 31 f6 45 31
> > > RSP: 0018:ffffc90002adf9c0 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81cdc194
> > > RDX: ffff888022124ec0 RSI: ffffffff81cdd16f RDI: 0000000000000007
> > > RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000001 R12: ffff888107373a48
> > > R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90002adfec8
> > > FS:  00005555560953c0(0000) GS:ffff888135c00000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020000010 CR3: 000000010503d000 CR4: 0000000000750ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  __vmalloc_node mm/vmalloc.c:3385 [inline]
> > >  vmalloc+0x6b/0x80 mm/vmalloc.c:3418
> > >  sel_write_load+0x27f/0x19d0 security/selinux/selinuxfs.c:603
> > >  vfs_write+0x2a9/0xd80 fs/read_write.c:582
> > >  ksys_pwrite64 fs/read_write.c:699 [inline]
> > >  __do_sys_pwrite64 fs/read_write.c:709 [inline]
> > >  __se_sys_pwrite64 fs/read_write.c:706 [inline]
> > >  __x64_sys_pwrite64+0x1f3/0x250 fs/read_write.c:706
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > RIP: 0033:0x7f40e7728f8d
> > > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> > > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d
> > > 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fff5bf39508 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
2
> > > RAX: ffffffffffffffda RBX: 00007fff5bf39708 RCX: 00007f40e7728f8d
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff5bf39708
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > > R13: 00007fff5bf396f8 R14: 00007f40e77a6530 R15: 0000000000000001
> > >  </TASK>
> > > ```
> > >
> > > The cause of this bug is that in sel_write_load(), parameter "count"
> > > is controlled by user, which could be zero. It is passed to vmalloc()
> > > as an argument.
> > >
> > > If you have any questions, please contact us.
> > > Reported by: Yue Sun <samsun1006219@gmail.com>
> > > Reported by: xingwei lee <xrivendell7@gmail.com>
> >
> > Everything appears to be working as expected, vmalloc() caught the
> > zero-length allocation request, emitted the warning, returned NULL to
> > sel_write_load(), and sel_write_load() handled the error condition
> > triggered by vmalloc(0) returning NULL.  Did you see any unexpected
> > behavior beyond this warning message above?
>
> Probably because kernel warnings should not be reachable from
> userspace ...

My question was asking if the reporter was seeing any unexpected
behavior *beyond* the warning message.  I wanted to make sure they
weren't seeing anything else on their system that we should also take
into account.

> ... although in this case loading a policy is a highly
> privileged operation - , because they mostly signal incorrect internal
> state and can lead with the enabled option of panic_on_warn to system
> halts.
>
> I have two suggestions:
>
> I. Can the documentation of vmalloc() mention that passing a size of 0
> is discouraged?

One could always submit a patch and see what happens, that's almost
always the best way to get feedback.

> II. Can the global SELinux state mutex in sel_write_load() be acquired
> after the avc permission check, so that rouge processes with write
> access to /load but not granted security { load_policy } can not pound
> on that mutex?

We need to make sure that there is not a window between the
avc_has_perm() permission check and the actual policy load in
security_load_policy() where another task could race and cause some
unexpected behavior.  For that reason I think we need to take the
mutex before the avc_has_perm() call, and we likely want to keep the
vmalloc()/copy_from_user() after the permission check for the same
reason you wanted to delay taking the mutex.

We probably could consider moving the @ppos and @count sanity checks
before the mutex.

--=20
paul-moore.com

