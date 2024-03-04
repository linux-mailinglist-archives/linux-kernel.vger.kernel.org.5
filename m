Return-Path: <linux-kernel+bounces-91208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449B870B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931591F231B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB47A15C;
	Mon,  4 Mar 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FeYnI4FL"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46B62160;
	Mon,  4 Mar 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583093; cv=none; b=tWsB5/FMwJQkSb+O8bPz0xfMtlwSrNfwdg85u4Ur28I+5gDxQuzYucvZ5lz4h6ENFKDZo9i1pyydPbWozIZ+19A4IfxPwluajyIxM5pZ64AMpUJcxc+94Ty3IQzAYC1qi5C/MWs1VsdVCQx+XbA2zoatrCZQz/t42ir3i8l3UsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583093; c=relaxed/simple;
	bh=bdP/eHPYBMn2wwuUeV7cy9YNjtzJOgv/ycrCPRjr0WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+PS7s+0+SYzEKjUDAzgnGFlg0Gc3NaabpUYx981iiSrbrxbbVqlbsdAmlOly+vIZVB429w4gv/kdlRYEVCFSk+Ys5s65JSTcERV9WaqeO0FOWhrOG56tSiJcJ39Qbq3mWPKpmjmFoPanj9oV1EAsCIjFw4YWHfffgQK90L402w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FeYnI4FL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6089b64f4eeso42106307b3.2;
        Mon, 04 Mar 2024 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709583091; x=1710187891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQnotQmz3bXHkOIgtJxc5MNzdkatrJsCAiR56YrE5YA=;
        b=FeYnI4FLLTMCSG8K1hRYRNFVvbX9J4Us3kEpKtS+mL2gqjweWTiU/FCzBj7VQpMhpK
         gBCuryvBxbnAVf/U0w35m9xdz6oFzV3NmpKxy/IbQrplJdclosUG2fkPtNQV2pFVQgN+
         upphDQaCo9Hmv5yCY4vAFXnew1TPdjCgu/1TJra/r1pkcq5zwdX8oQfsoK2lwccQ1/IQ
         eYLIRrjFnL4hmpYuBcwfJtJuG3FxBnUzqDES2xKcTU1aMAlwMvmYj91n/NilGzoQ02hd
         iVwzyqkN4HCxy4No8+nVYTyVUvZG0AXiQBfa+13znRvwRacBIoyjwPaYEt6+uiS/GJMX
         +B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583091; x=1710187891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQnotQmz3bXHkOIgtJxc5MNzdkatrJsCAiR56YrE5YA=;
        b=jUT1ZPrj455+dDxhvYt7uoS0duI8jDmGbvQ8kboZzZetEQadmZp8BgnedAOdYBwLNT
         2KSYHZ4m/0lv6SQkXqCTYAmSthtOpkdgJ9OM7ygWWidA4adXsyKrvBsq6eOTtSXmzpZq
         iba/j+zvdwtM8Y35urlRVQKCw5sxpitnFrzq4mKEx7Ts2CLKAgiq0yC0UfCSnhKPQiyF
         QwQuqDjHz/72h9PDmrP0srQb8W+wcDhw03kZimFIfwao5xoY4NHnbTn1VY7dCcYjXpJ5
         /fCk46/vibh9DtAKoedTCAfKF/ji+9X45ck6ZGlRE0miW/bUzjxvidBVP3fp2vzaPwvf
         JZrw==
X-Forwarded-Encrypted: i=1; AJvYcCW1CPDesCJ6fFVR15rRYm62MIlbXk6ovulDOCkB2eOQLhEj4urs9wkf7ktiwpHHhP5n5vrYmQkDoENxs5EqalBw3iKfdn2nhHVg6Kr2UzBSQB8z0jDyQuWg1ruUC4QT/En2Ggvtgw==
X-Gm-Message-State: AOJu0YxGmJlpYrJqbosjWyCjInd98s8UwBmGr8CqVsYf3iVL+JZe7yjU
	Avj2Y9SxrVThDfVAVo4F4B61OKSdgJfqGcmAjWDI4d3gdmmaiqYGe6vcIeLJHXPJ4Hc1+CmAsw5
	9h+d2iE2oqesDxABOrCwIhHKZ1hdxkvvELfM=
X-Google-Smtp-Source: AGHT+IHN406RZaJpIeCK6nfBi2fjsC7VYE0x27ycejQMk521LSjnLB9CBSfdiaSLlwSl6rrNVG3Ywc6xKK6fLOJ6iks=
X-Received: by 2002:a5b:608:0:b0:dc7:acb7:af14 with SMTP id
 d8-20020a5b0608000000b00dc7acb7af14mr7610507ybq.5.1709583090782; Mon, 04 Mar
 2024 12:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOh-5_KzWih=qUxynbn=mMz=UfnPi6UftbyT8+MTDP0jg@mail.gmail.com>
 <CAHC9VhQ3crxcLXbT3fw2k7jYJFKy1VOm25npKpD9ZrwmwKzvJw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ3crxcLXbT3fw2k7jYJFKy1VOm25npKpD9ZrwmwKzvJw@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 4 Mar 2024 21:11:19 +0100
Message-ID: <CAJ2a_DcSurcF5_G-DjXL_0X=utasy2y8oJ_ywCms-Qhyy6GORQ@mail.gmail.com>
Subject: Re: [Bug] WARNING: zero-size vmalloc in sel_write_load
To: Paul Moore <paul@paul-moore.com>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org, 
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>, syzkaller@googlegroups.com, selinux@vger.kernel.org, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2024 at 20:19, Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Mar 4, 2024 at 9:08=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> =
wrote:
> >
> > Dear developers and maintainers,
> >
> > We encountered a warning in function sel_write_load(). It is tested on
> > kernel 6.8.0-rc7. Bug report is listed below.
> >
> > ```
> > WARNING: CPU: 1 PID: 8109 at mm/vmalloc.c:3247
> > __vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > Modules linked in:
> > CPU: 1 PID: 8109 Comm: syz-executor370 Not tainted 6.7.0-rc7 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:__vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > Code: 65 48 2b 04 25 28 00 00 00 0f 85 98 02 00 00 48 81 c4 70 01 00
> > 00 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 71 43 b7 ff 90 <0f> 0b
> > 90 45 31 e4 eb a1 e8 63 43 b7 ff 48 8b 4c 24 40 31 f6 45 31
> > RSP: 0018:ffffc90002adf9c0 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81cdc194
> > RDX: ffff888022124ec0 RSI: ffffffff81cdd16f RDI: 0000000000000007
> > RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffff888107373a48
> > R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90002adfec8
> > FS:  00005555560953c0(0000) GS:ffff888135c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000010 CR3: 000000010503d000 CR4: 0000000000750ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  __vmalloc_node mm/vmalloc.c:3385 [inline]
> >  vmalloc+0x6b/0x80 mm/vmalloc.c:3418
> >  sel_write_load+0x27f/0x19d0 security/selinux/selinuxfs.c:603
> >  vfs_write+0x2a9/0xd80 fs/read_write.c:582
> >  ksys_pwrite64 fs/read_write.c:699 [inline]
> >  __do_sys_pwrite64 fs/read_write.c:709 [inline]
> >  __se_sys_pwrite64 fs/read_write.c:706 [inline]
> >  __x64_sys_pwrite64+0x1f3/0x250 fs/read_write.c:706
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > RIP: 0033:0x7f40e7728f8d
> > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff5bf39508 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> > RAX: ffffffffffffffda RBX: 00007fff5bf39708 RCX: 00007f40e7728f8d
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff5bf39708
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007fff5bf396f8 R14: 00007f40e77a6530 R15: 0000000000000001
> >  </TASK>
> > ```
> >
> > The cause of this bug is that in sel_write_load(), parameter "count"
> > is controlled by user, which could be zero. It is passed to vmalloc()
> > as an argument.
> >
> > If you have any questions, please contact us.
> > Reported by: Yue Sun <samsun1006219@gmail.com>
> > Reported by: xingwei lee <xrivendell7@gmail.com>
>
> Everything appears to be working as expected, vmalloc() caught the
> zero-length allocation request, emitted the warning, returned NULL to
> sel_write_load(), and sel_write_load() handled the error condition
> triggered by vmalloc(0) returning NULL.  Did you see any unexpected
> behavior beyond this warning message above?

Probably because kernel warnings should not be reachable from
userspace - although in this case loading a policy is a highly
privileged operation - , because they mostly signal incorrect internal
state and can lead with the enabled option of panic_on_warn to system
halts.

I have two suggestions:

I. Can the documentation of vmalloc() mention that passing a size of 0
is discouraged?

II. Can the global SELinux state mutex in sel_write_load() be acquired
after the avc permission check, so that rouge processes with write
access to /load but not granted security { load_policy } can not pound
on that mutex?

>
> --
> paul-moore.com
>

