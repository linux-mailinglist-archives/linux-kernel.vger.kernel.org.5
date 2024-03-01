Return-Path: <linux-kernel+bounces-88062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47986DCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0904B1C2414A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9F69D32;
	Fri,  1 Mar 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9WUbn2h"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E069D0B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281135; cv=none; b=pXLhbTESnnvvoFLM4o1+evOPBjtJOFgOmI6GGPl4Eh6SyycsQdy14YHJ4Otgq5AEyi1r7d/BZ4Guzeettaa7UqDhf4lNQJT3m6W6Ep0SYiHE27+ekaB94OpmEsjiBzCnIsS/HGeyWBouAyDmsli5CoAmwKlVFJHcfni4rTc6TzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281135; c=relaxed/simple;
	bh=xHagoUYaQdxtiqj6+rrcujx2JF0qBG6YXRsFGj5TcXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9RgMn6uQhA66XxUe73/zjbASWGBZMwPtCihpluTuUge0t+4ff3WIIDJdOzo6WmOJuXrToavWxyd+yYh2kfX1IVvxq0Ln1iewLnkpKoa9I/Fqn8/GQOZtK8fEo5lv/i1GnIkcdS7yU1+SLN0JnNn1VYip9fVYUuA0x6Dij3tevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9WUbn2h; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso8612a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709281132; x=1709885932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrNALgwwVg8EA7pSkrmhj3egsdJWoUpdjw+A2WL51kw=;
        b=b9WUbn2hsbl0HA3TNQg6grNL+VEKcbg1tyQNnfewVKm0CpdEnexwqUO/4yo67rd5tS
         DDDkNVKB3/k1LeqByu/Y29xPiyfDqIsUcpf6ajHZqhMyQw4uz+egTkYWPRN2xYef/nzM
         ZO8kI0qz9DFAtDnEd/NFpPeUAEW4P7g6u3WME9WUzNRXIfUaYY6oOIm9t5J/4HKYEvX9
         HU/LBnW+Rp9yoS+ziMgWqeqFNMJFo52hy4Ku/7oroEjOQv/+1AERG4rf3Bt85TETCx7R
         WUQdmoM3lCycKKI9x5Z1cecMb6JjC0ce1IPt07l9+NM9uHArbrg6zE5Og7ee3xyXyN94
         L5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281132; x=1709885932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrNALgwwVg8EA7pSkrmhj3egsdJWoUpdjw+A2WL51kw=;
        b=gWKqn38r4RZrzJLOCEdSjS4dqEn490Zl3g1sMEcUOSD+8aMrRAFFw1zK+cNkY+mE1j
         o/zsyqmO0rN+UrFxngtXSBdmyJ6hv1U1jfp3nQGhD6EFCY75sVXZt/KkWj83AmZVIQ5B
         LRx6toZU02L13VjuF8HL4iWrVhq3wjk/5AwIP+X/gDC+znBB6cNXbwlvueM8EsfWDZlr
         nvJh/RrPJd8jOwNvjO4S0vvoLm8tubS9SLQL5Isx2TdiAsdOOQOle4f1d/LOjFeh/SsU
         2DoEGzUtUNzIlAziWdrVmxRKi8ROzvdYFZtvbYuIfBmyrUAZr/LZRBK+dPkQ2fiDT5nc
         MyHA==
X-Forwarded-Encrypted: i=1; AJvYcCXNu1OYdK/QHMeGSTFcHbENzERKshefcg7L8xvvZWZQJ3MINzu14z273c3eGUMKNaoBaQSo022zq+ebn/MS9VhNZfxGuTXkSuQ+yFqw
X-Gm-Message-State: AOJu0YzNHkAjzvtf+RLkOeA+TdI8yE1QQLPDx5BkrtP53qWazBpFSxVR
	/2FGsLOWMwGoaUt6OzJ7gEfhWlvuZZD9jgIYBh5nCgI/nHPSZsiXC3qDLdXO+U72gm5zbseC1zK
	OHMAxjD4TNMR3JD1a83ziaZ//ua9p17qIzU6L
X-Google-Smtp-Source: AGHT+IFXAVXiv8rotNvMmytfWcjbx2xFutmaYeZe7MsIPJTZ7R6pp5a/6yms1UvGb7tlqZvviNcB3qzyMe8k/f9UwkQ=
X-Received: by 2002:a05:6402:350e:b0:563:f48a:aa03 with SMTP id
 b14-20020a056402350e00b00563f48aaa03mr115763edd.2.1709281131947; Fri, 01 Mar
 2024 00:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPz+xZvczwEnsv1eGsNmv8rtLmyw5WV_rDz_Zui0cNd4Q@mail.gmail.com>
In-Reply-To: <CAEkJfYPz+xZvczwEnsv1eGsNmv8rtLmyw5WV_rDz_Zui0cNd4Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:18:40 +0100
Message-ID: <CANn89iJt1Ke=chUSd7JSNSdCEN4ghjivg2j902Wqa5pSQdrdeQ@mail.gmail.com>
Subject: Re: [Kernel bug] KASAN: slab-out-of-bounds Read in in4_pton
To: Sam Sun <samsun1006219@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, j.vosburgh@gmail.com, 
	andy@greyhouse.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:41=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> wr=
ote:
>
> Dear developers and maintainers,
>
> We found a bug through our modified Syzkaller. Kernel version is b401b621=
758,
> Linux 6.8-rc5. The C reproducer and kernel config are attached.
>
> KASAN report is listed below
>
> ```
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
>
> CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>  strlen+0x7d/0xa0 lib/string.c:418
>  __fortify_strlen include/linux/fortify-string.h:210 [inline]
>  in4_pton+0xa3/0x3f0 net/core/utils.c:130
>  bond_option_arp_ip_targets_set+0xc2/0x910 drivers/net/bonding/bond_optio=
ns.c:1201
>  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
>  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
>  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
>  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:1=
56
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f797835cfcd
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffff464ffb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffff46501b8 RCX: 00007f797835cfcd
> RDX: 00000000000000f5 RSI: 0000000020000140 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff46501b8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffff46501a8 R14: 00007f79783da530 R15: 0000000000000001
>  </TASK>
>
> All


>
> We analyzed the cause of this bug. In the function "bond_option_arp_ip_ta=
rgets_set" in
> drivers/net/bonding/bond_options.c, newval->string can be controlled by u=
sers. If string
>
> is empty, newval->string+1 points to the address after newval->string, ca=
using potential
>
> info leak.
>
> One possible fix is to check before calling in4_pton, whether strnlen(new=
val->string) > 1.
>
> If you have any questions or require more information, please feel
> free to contact us.
>
> Reported by Yue Sun <samsun1006219@gmail.com>
>

Thanks for the report and analysis.

Are you willing to provide a patch ?

You would get more credits than a "Reported-by:" tag :)

Thanks

