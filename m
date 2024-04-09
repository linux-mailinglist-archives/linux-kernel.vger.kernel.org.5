Return-Path: <linux-kernel+bounces-136888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A670989D96A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568E028A4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A81012EBD6;
	Tue,  9 Apr 2024 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEsNCgBU"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AE12D753;
	Tue,  9 Apr 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667080; cv=none; b=lQTL/pVBk/FSX8c8V2gPgvkVoJ5m5LBHfpGZnlW8t6iPSKaJqoj/7bmtru/NXoMCrYUCOOSnwsDc9IZnL1/si9jKJAJFQb7gjBf9sXl0o5E5zfNYjyKzTBTni/KYgVjLLI0QFlkTFuPDk8FZl+DkJTc1KzhWHKJ3W8EG9f4wmDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667080; c=relaxed/simple;
	bh=DjNT0L5DEzFWRydMIfmLZI/hD2TY6TxAHIauI8t1flQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glGkR8tihU6wGZ+/ePK/5qo/oSTwnM5os7iOw/glZNH2XjcEK82kuzlh0mjGDPqdxcBIoeVuyPmsabPMqQwtoPUiqU67I5CpgxRZV0Fi38p52bigyB5YJ6HzGb9JQMDyHWUMhH2opLbHk3zjkQvuJNNZQtHaSci+uYq/iQgC1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEsNCgBU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so4808470a12.2;
        Tue, 09 Apr 2024 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712667077; x=1713271877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLZRWIxxIpIyRano383QAFQNgeysi1fKEMitJfkcMIg=;
        b=TEsNCgBUnSDGjuWAwZ6tEQiGc+Dk10FI24vnZMah2UzznwmbSo691z+lAKF85ZScDc
         Q4X7Rx1RL88dJ2sg7ouSzZDXhIQL4vyAG0ImliKf3HXDcFNsggO2oRtWpRC3pP1l9Zje
         BjWRvS3HQwZXmApOUP4uWAw0iZ9DB8xCB+P1wCdP9+CrvVpgoX0wwWF6ZJn+Jd5XqIGz
         kHr83CV7Xdr0Y3u6jbikzq7+za10A+69W16LjR02gYrOXkxMH+a8Qwwb0Q5QZJpXxvnw
         3xUYX70LeK8sYEiKXNGhE5Gbj1h2B4giuEUPsv7yfrcc+Bq8LMD+ujrsY3hDt/BsCqAr
         YoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667077; x=1713271877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLZRWIxxIpIyRano383QAFQNgeysi1fKEMitJfkcMIg=;
        b=c8B3A43rC77gbJY6UaStMEZLzDFIOhtFrCofmSBFBppX0vVSG5njY9oyJhJrSh1ycn
         eCaabwjRZBfpCZwB+nF0gQR/dTnkF6cx2IAGjl8cCSyL66Lc0G5Wj7wc+mYVzKtqKmWG
         s43+MWZw6zRhBuPrCNaYcTZyCzmorJh0nDlZaW8ioyeRxlJinBFkv4rOIVVUPoK7RoRX
         ksKxr6kkAkTTsGu2hTNDC69MKHPnA39KdGo8klz1f+vs9CSFtjn77N3F5a+mGclHeUY4
         60KGi5sxIv18wM14SBsHEMRZDc4g8ugEfJfYUXu2hIU9HZD5kw2WKf9TZRvnEoRkDhc1
         5z5w==
X-Gm-Message-State: AOJu0YyKax/bE041JyPXCLwyMyvofG3a3J1HgXY5/zFSNzZGvPP63mZ3
	KZzwK8SJpY7ijpm7Q76e+SuOlFln1DSPaBqbN9pFaKCBp26IhNP6SMVtJCWYP+xgedkCksG79jS
	AI/i5YsnDwyEvqx7GBBBvZqrbg4hvcQkEfT+a80M5
X-Google-Smtp-Source: AGHT+IHqqbdEqfhqTMpWmBSPML4xCExE0zWXW/QZYTjqy5r4C2uX+Lj6ovqOlaO1cnzmjHzOmb/yasrCZh4idaWK3IY=
X-Received: by 2002:a17:906:b24b:b0:a4e:7b8e:35ae with SMTP id
 ce11-20020a170906b24b00b00a4e7b8e35aemr7764103ejb.38.1712667076605; Tue, 09
 Apr 2024 05:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOs-szTK0rYvDw5UNGfzbTG_7RvjqFOZA=c6LXvxdUt2g@mail.gmail.com>
In-Reply-To: <CAEkJfYOs-szTK0rYvDw5UNGfzbTG_7RvjqFOZA=c6LXvxdUt2g@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 9 Apr 2024 20:51:04 +0800
Message-ID: <CAEkJfYMcdmXAhe9oTpEPGL+_661PNAvM58Y+irwnbLW8FKohNw@mail.gmail.com>
Subject: Re: [Bug] UBSAN: shift-out-of-bounds in sg_build_indirect
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com, jejb@linux.ibm.com, 
	dgilbert@interlog.com, syzkaller@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 8:57=E2=80=AFPM Sam Sun <samsun1006219@gmail.com> w=
rote:
>
> Dear developers and maintainers,
>
> We encountered a shift-out-of-bounds bug while using our modified
> Syzkaller. It is tested against linux kernel 6.9-rc1. Kernel config
> and C repro are attached to this email. The UBSAN report is listed
> below.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> UBSAN: shift-out-of-bounds in /home/sy/linux-original/drivers/scsi/sg.c:1=
902:13
> shift exponent 64 is too large for 32-bit type 'int'
> CPU: 1 PID: 8078 Comm: syz-executor748 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x24b/0x430 lib/ubsan.c:387
>  sg_build_indirect.cold+0x1b/0x20 drivers/scsi/sg.c:1902
>  sg_build_reserve+0xc4/0x180 drivers/scsi/sg.c:2012
>  sg_add_sfp drivers/scsi/sg.c:2194 [inline]
>  sg_open+0xde4/0x1810 drivers/scsi/sg.c:350
>  chrdev_open+0x269/0x770 fs/char_dev.c:414
>  do_dentry_open+0x6d3/0x18d0 fs/open.c:948
>  do_open fs/namei.c:3622 [inline]
>  path_openat+0x1e1e/0x26d0 fs/namei.c:3779
>  do_filp_open+0x1c9/0x410 fs/namei.c:3809
>  do_sys_openat2+0x160/0x1c0 fs/open.c:1437
>  do_sys_open fs/open.c:1452 [inline]
>  __do_sys_openat fs/open.c:1468 [inline]
>  __se_sys_openat fs/open.c:1463 [inline]
>  __x64_sys_openat+0x140/0x1f0 fs/open.c:1463
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f48cf37f80b
> Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85
> c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
> 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
> RSP: 002b:00007ffd29cd7d40 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f48cf37f80b
> RDX: 0000000000000041 RSI: 00007ffd29cd7dc0 RDI: 00000000ffffff9c
> RBP: 00007ffd29cd7dc0 R08: 000000000000ffff R09: 00007ffd29cd7c50
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000041
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> If you have any questions, please contact us.
> Reported by: Yue Sun <samsun1006219@gmail.com>
> Reported by: xingwei lee <xrivendell7@gmail.com>
>
> Best Regards,
> Yue

We further analyzed the root cause of this bug. In function
sg_build_indirect of drivers/scsi/sg.c, variable order of line 1900 is
calculated out using get_order(num), and num comes from
scatter_elem_sz. If scatter_elem_sz is equal or below zero, the order
returned will be 52, so that PAGE_SHIFT + order is 64, which is larger
than 32 bits int range, causing shift-out-of bound. This bug is tested
and still remains in the latest upstream linux (6.9-rc3).
If you have any questions, please contact us.

Best,
Yue

