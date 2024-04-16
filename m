Return-Path: <linux-kernel+bounces-146736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E488A6A16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9427E1C21116
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6D12A174;
	Tue, 16 Apr 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvrzWBhU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206F129E78;
	Tue, 16 Apr 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268945; cv=none; b=OkbW4+cnkP+c1Rhq8W7yMCGBCLQk+0fiBg+QxczpARr4MIHmGrUMHC2613jbQmnVymcG8yvidS3AOcEBBpTBFthJ9/UjVY5XxL7G8KNs5E/TwU1mR7iWEugUJn0kAWENcGorx8yhzkRTmDVsmMhTCZPQCCod7UyrfXqU/CH7//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268945; c=relaxed/simple;
	bh=mehokU/oPv9zSJz1ECT72XIz6TIwRXXiUhrnhSfTj5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsfYT2yuODAxIC7lW/PC4H3nehZ0/Skw128u962Vj/hawjm/mIl5/2gELmulmsE0uBt9tEJNm1hfRqzQC59v4Obco7/S9Vkm6G3LIeivMexMmjk98p1A+Kwy+nwDEFes5B1NLKHaOVu3hzTcmFwPcL8leNfx2vhrVNiY/V+VbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvrzWBhU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a524ecaf215so361156866b.2;
        Tue, 16 Apr 2024 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713268942; x=1713873742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIxLUAMbjgurxXoHq9EdG3sBEmu/NGzsdsQ94b87puk=;
        b=mvrzWBhUo9A9k76i9yZG+WtcVLVFI1iyQHDi0dn372xytKMVG/9wqc2fZVUBR8kYsu
         r9S9d24VYHYYHNssCKecYV3QI4FIu85YYFpFYaVUhtjBSah7AgfUA//v2Adon5oTYrOk
         P/F9PKfP51dxaptKO6qjdkA/dnQTZiF9ry/ce3AbWCj5OapEKFEmsJCto6cwqDmbeVhe
         dfWpxktBSXz2vh/NdlbCOyCXOElMUJlfE/W/xLnp/z6IZ9yt9zlJ2pn9hR6p1heeXFQU
         QV+8Cx6EgRaLHDut69T9Z6WIqXN3hIub4zJdBolzy5WF6aRO1Kz9elxr+jYqI8oTUBG2
         IWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268942; x=1713873742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIxLUAMbjgurxXoHq9EdG3sBEmu/NGzsdsQ94b87puk=;
        b=egfsNxF/zxwl256gN7UzPZZNxRRhKEvO/L8ojA0+2pecGBiO6fYasXfBh1nneXdo6P
         hG6niyTkz5RCtKKoX4BPU1SNBjCGilFjvDct8HaPf+I/1YyKSJ0Y9xU0iDgNWI29UBHt
         itpJpUX4foZplNrwhp5QLCzwE/bKr1jSdoYDNVhZbOeGpEbQYBT1JNJTEAv3yZUbgZYq
         35sBB/rNSFCgW1qsE4q0iYLHYOFhqgxaAVxt49he839yaLQFP6gw6B0WzHXlF0RxGDiw
         i3Igis4u7o9zOjakBvXhcWFZCaqnih8GZE3x8nJUOM7zVMcJi2ejzy43WJV/HpzORXwm
         x8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeGi4n1jE7QptQNMgkkihuTLfF2GBTnFc5B+iYnDEmsmKbOj8E9t3rqUVeOn8u4NsHdBdAjiEk+ar+JoLsn4C2j/hESqwH
X-Gm-Message-State: AOJu0YyjOn8U8xbpG67B5YSjCJuIMzoJVhJaG0/SOW33dpzQlyo9mkNr
	GYBm1vkoYlQFa4+GrxHUYYdzZ1LnA8mpDn1MvsdLoyhW/78Udam+Y7407ROQVhmq16+9mipFF0B
	Zu0JHmtRKTmrXD3gAbFUo/GPwqWBI29/CmeI8apa0
X-Google-Smtp-Source: AGHT+IHr6onz1rxoSR673FwAnVKaunv+548JVGn3CKC2tFRdh/wB3XKIZwJvSd13d1YzW0b9cY5jwSdjwfKpRGciYH4=
X-Received: by 2002:a17:906:29cb:b0:a52:61b9:be48 with SMTP id
 y11-20020a17090629cb00b00a5261b9be48mr4119771eje.35.1713268941706; Tue, 16
 Apr 2024 05:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYMdDQKY1C-wBZLiaJ=dCqfM9r=rykwwf+J-XHsFp7D9Ag@mail.gmail.com>
 <Zh5M_9K3g6-9U2VA@Laptop-X1>
In-Reply-To: <Zh5M_9K3g6-9U2VA@Laptop-X1>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 16 Apr 2024 20:02:10 +0800
Message-ID: <CAEkJfYNZ+X7U2-pDTy0X4q+D8O7H0ZPVdN3Z2hK6b1wFZfQekw@mail.gmail.com>
Subject: Re: [PATCH net v2] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, j.vosburgh@gmail.com, 
	andy@greyhouse.net, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 6:03=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> On Tue, Apr 16, 2024 at 03:28:02PM +0800, Sam Sun wrote:
> > In function bond_option_arp_ip_targets_set(), if newval->string is an
> > empty string, newval->string+1 will point to the byte after the
> > string, causing an out-of-bound read.
> >
> > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:364 [inline]
> >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
> >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> >  strlen+0x7d/0xa0 lib/string.c:418
> >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
> >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
> >  bond_option_arp_ip_targets_set+0xc2/0x910
> > drivers/net/bonding/bond_options.c:1201
> >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:79=
2
> >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
> >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c=
:156
> >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> >  call_write_iter include/linux/fs.h:2020 [inline]
> >  new_sync_write fs/read_write.c:491 [inline]
> >  vfs_write+0x96a/0xd80 fs/read_write.c:584
> >  ksys_write+0x122/0x250 fs/read_write.c:637
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > ---[ end trace ]---
> >
> > Fix it by adding a check of string length before using it. Remove
> > target address in netdev_err message since target is not initialized
> > in error path and will not provide useful information.
> >
> > Fixes: 4fb0ef585eb2 ("bonding: convert arp_ip_target to use the new opt=
ion API")
> > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
>
> I think the fixes tag should be
>
> f9de11a16594 ("bonding: add ip checks when store ip target").
>

Sorry for my mistake. I will change the fixes label to this commit.

Best,
Yue


> Thanks
> Hangbin
>
> > ---
> >  drivers/net/bonding/bond_options.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_options.c
> > b/drivers/net/bonding/bond_options.c
> > index 4cdbc7e084f4..8f3fb91897b3 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct
> > bonding *bond,
> >      __be32 target;
> >
> >      if (newval->string) {
> > -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) =
{
> > -            netdev_err(bond->dev, "invalid ARP target %pI4 specified\n=
",
> > -                   &target);
> > +        if (!(strlen(newval->string)) ||
> > +            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)=
) {
> > +            netdev_err(bond->dev, "invalid ARP target I4 specified\n")=
;
> >              return ret;
> >          }
> >          if (newval->string[0] =3D=3D '+')
> > --
> > 2.34.1

