Return-Path: <linux-kernel+bounces-147995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF358A7C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CC71F2371C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5965BA0;
	Wed, 17 Apr 2024 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZFo5gro"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28253657B0;
	Wed, 17 Apr 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335704; cv=none; b=p7YI4tdxXT2YnrcJiiMd5MLiWoqaPXV2I9VNNOcEzlQqBRa7GDFzXanISlGQu63akknQRYuUGfPVDkeIEVLGe+l+HL2/eZJKDke0kuRmrSO2ZGi3GFnZS2V2b3JesdhzYli5p8A1FfeTk9+wk39Mp9Gss6X7k0O4m6tWYEwypNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335704; c=relaxed/simple;
	bh=EKdKhbBfwCgxWOd/SIJMcmDwql5vodTnlVj842FGldY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aas78w/oaHBOv3IiYBX2iOyYOWIwis4mBhFg2R2SJWwQFR4QR0/EBTykqTB/JCqNmuSaoiOwGj1NSiB8cEQLNA1dZPtCKQuqokPuD+5cwQMfh0R7zHDT/V7YbpMJv7uQ6Z6YtU2ZjGqJRcDDe4ACPGixmg+DWAmVXkKXUWP2qjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZFo5gro; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5200202c1bso685779366b.0;
        Tue, 16 Apr 2024 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713335701; x=1713940501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p74U05au3463azxpQVZWhtcaru2hq/shbVKOKWYd3z8=;
        b=AZFo5groRzmbWo988PR1q3jOg88wM0t8YYVS9m1W76ZqJkpNP7ZgZBoR54Z2eSfVqc
         wAov/C8l53An6AskjOWrYTIN0tye5g/Cv2q+1BMujRu0D8097gybqKZmddbaiNWwj+pU
         2dX267BTmCwZzQwL3mZK+8c+uo0v5oOPHXcRA2i2bxPbnO9B3XJJD9bClUTCvlFl7Gke
         JpbHKgsExSUakqw+nqRmeEQo4ZL+/z3wX6x2z+GFM5dTsNVPzAoMhuWS/0csygoakBOK
         80w3PO+THpdD9oxEfJ8+x17t8wzHo+Pa60OW6UkmCe50r0REJIK1Ppr46WTNSvXvJqeh
         M0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335701; x=1713940501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p74U05au3463azxpQVZWhtcaru2hq/shbVKOKWYd3z8=;
        b=kmmNTdhJSVGmL5OrQLjTQ5wJH0u6Aim97J+63yRzcF6/zOzqzPrqjKo5JhTIIjhgek
         si5M32ZOD24eDCkfxUie2AuEZ6mdMCkhdxkqQkkauYd/VRxruFL31/a0eYY+4n/xjUvN
         Bz3a1UrydIcAz7eZo5cM963AJUArdpuPkc/NOkk3HvwcHAn6Vw9uy66NdFcxoLkCJI3A
         yhkjtcMEPTT3PPn45kU+/rgTBYhwivaiSgDHEbe/KYxwOpR/oD55aV42efjTj2w96yIv
         d2+btEoqtaZUiO0rM4F3ASRIPVa0H7bREQfSGWpb98eL2A1TukCs661fT9PkrLCNLn35
         nE7g==
X-Forwarded-Encrypted: i=1; AJvYcCUH7JgsHwJ2vknnIbU+tX479uUyRUjoJ3zRhDtipaq30VBlmpn/DFoFw5ki0xjzq4rk1T9ZQPX02lwa50rSccBUI/XFCjI1
X-Gm-Message-State: AOJu0Yz3kXtdD3PObAYBzKvrdYrTWU3UOvFcIHnorJpNwIbd8z4WeVTB
	bhGeelpRaFZVhQkkEKYjqMrqXK1U3W3nXGCySXVdH7gUNSDcH+I7h04Hdbm238JDwA/1yLslWrl
	0KvJd3pvB1ZfSXEekeyZ7wFGEyCU=
X-Google-Smtp-Source: AGHT+IGzuG1KQGSuS4q/NVj+STQwFYpIbPNlWccBlyh+4xa+BXzCo7x0l35MjmdifbiwW+oyAqvwqNDvlZGIuYewRI0=
X-Received: by 2002:a17:906:f90f:b0:a52:225b:602a with SMTP id
 lc15-20020a170906f90f00b00a52225b602amr12120585ejb.7.1713335701239; Tue, 16
 Apr 2024 23:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com>
 <20240416142428.GO2320920@kernel.org>
In-Reply-To: <20240416142428.GO2320920@kernel.org>
From: Sam Sun <samsun1006219@gmail.com>
Date: Wed, 17 Apr 2024 14:34:49 +0800
Message-ID: <CAEkJfYPR-jeZoVz63b2UmvjgBOen7DDy8yyrojLckD9OT2XaiQ@mail.gmail.com>
Subject: Re: [PATCH net v3] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, j.vosburgh@gmail.com, 
	Hangbin Liu <liuhangbin@gmail.com>, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	kuba@kernel.org, andy@greyhouse.net, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:24=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, Apr 16, 2024 at 08:09:44PM +0800, Sam Sun wrote:
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
> > Fix it by adding a check of string length before using it.
> >
> > v2
> > According to Jay and Hangbin's opinion, remove target address in
> > netdev_err message since target is not initialized in error path and
> > will not provide useful information.
> >
> > v3
> > According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
> > ("bonding: convert arp_ip_target to use the new option API") to
> > f9de11a16594 ("bonding: add ip checks when store ip target").
> >
> > Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
> > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> > ---
>
> Hi Sam Sun,
>
> Some comments about the formatting of this submission:
>
> * The list of chances, (v2, v3, ...) should be below rather than
>   above the scissors ("---"), so it is not included when the patch
>   is applied.
>
> * Looking at git history, the patch prefix should probably be "bonding:"
>
>         Subject: [PATCH net v3] bonding: ...
>
> * The diff seems to be a bit mangled, f.e. tabs seem to
>   have been translated into spaces. So it does not apply.
>   Which breaks automated testing. And for this reason
>   I am asking you to repost this patch.
>
>   git send-email, and b4, are two tools that can typically be used
>   to send patches in a way that this doesn't occur.
>
> ---
> pw-bot: changes-requested

I sincerely apologize for not using git send-email. I tried to set up
the environment but it did not work. For some reason, I needed to use
a proxy to connect with my gmail account, but the proxy service
provider banned using their proxy to send email through smtp. Maybe I
need to rent a VPS and set up a working environment there, but it
would take time and I don't know for sure whether the VPS provider
would allow me to send email through smtp either.

Could you or anyone please help me submit this patch? Sorry for
causing this trouble.

Best Regards,
Yue

