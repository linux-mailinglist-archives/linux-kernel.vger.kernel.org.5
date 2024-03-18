Return-Path: <linux-kernel+bounces-106662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF687F1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7521C20AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679958AA2;
	Mon, 18 Mar 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho0dvD6F"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBD58ABA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795798; cv=none; b=e4JCdReSQwFvDZMsCHwy5/+l4zTYlTifjfqVgKq3nIXtpIFJ+LBIrbtS4B6IQ8bVcyXmf19cizxCAFomh/IEjQtTcOLyoPWHfDKabGXqkqs3s8BYDbQbZ+znc2CpBfCVPKFBzwu7Cx2K6jF6KVDjuaQnAXTdS5Wss8j8EkQXAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795798; c=relaxed/simple;
	bh=DwpPM+oVXubBmc1sbSQ/XM7V6SsaUdrngUvpvnQqXxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKj0lxrApA+0p2FO5PFhsRUMSsQqsINrZgccZ1lLjuSy3zsyKZwvdVLKnN+HlshpfkVU5b287bDu1HGh6CQD/izLAk1NQqRJAEinNtObVAILdoIaM1w68u2lIpkW5TJL8R1GD0SaTMbB9Zj8KuWlw1fHFDC3f98YNr4rxkDtCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho0dvD6F; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a47cecb98bso2044061eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710795796; x=1711400596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdUoNk+AdcNzgEKbiFEZWryIFkFAsqcjJShgKTbGrcA=;
        b=ho0dvD6FgqSaBQ8C/TXSWL6TCmg/2jFxgUFcvYdmivRgD05R8lqMMSaiiEYi5wXyc7
         4vjFnP2Aa23DblvJo1nPRsux3SEQ//tHfIF4iBjZL4JaL1rv6T7fRPUAcFRwQxxYBHux
         JI3jj7BuQyUCi5Cwm6QexRCy0IIo613sIN5k3S5+lUimHGdEBjAvSAgxt3jslQHiDLOG
         WMYRFx5JSY1gsuQhDqbBA8nUYiYiB5qVS6mnOvobfLHZyQFbp8chEkWJsadHU5Il14P2
         OibZ/AN76us+5z2Xyacj38nNRV0s7U4IpLK+oHZhhCpzWHMoMTFaaFNJ+WYvOLXOSikz
         aIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795796; x=1711400596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdUoNk+AdcNzgEKbiFEZWryIFkFAsqcjJShgKTbGrcA=;
        b=dTwX7ntPhwxQrejWIqpBpiARdcUEqzTIYaUxSTRk07N2I6e2hOCFPYgSX6utFyadc1
         LEKqIj+qxzz1D5YiGCA2nXNzJ3v5tnAXyGJZ3JmjvQ+nlnMwFhLJ+ksKJHmn44qO/JDD
         s2yMRAdVp/sj4E20NVQ8yyd94eQecW/T2n6gPMFov2BQFffoY+d3SetJOCBnh4d9XSnC
         RMPiThJ4QZCnPHGgfToPDQNCYP2u+DWqmf0ZDlNB4YAs+kRt9NGFCNYATMqgzz4egsOh
         /5KwsNGdl933UqiwTMwJWja9XImJNqjbMl0lHeEmzxMYmdHCJ1U9R3Z2QS9O40UorPse
         SRKA==
X-Forwarded-Encrypted: i=1; AJvYcCXpjdNq+tSJGSsYODE+47P+dCsgtftUklwdd3qJLPDrCu1JBj4zLy63Wuy3+ZduxqvRqBD0NPZZiMfkMBTs7nTo7JXPWnSC/lO0CiUM
X-Gm-Message-State: AOJu0Yx7S+rN/SiJ889qk0syyqtFaIjmfGNMrV9bkI/j6YLYbQFFBlXu
	ZazmHyBRMjA48A1jB4WEloxUWs5VUl3W16CJGoUsmbIFdAzOJzb5HA4RRS+M4k3B6C5oAT6GJHo
	mQA8L+l9La1cnwQ0LtdLXqFMHf0lbs+ZZSV8=
X-Google-Smtp-Source: AGHT+IFNBhKxlZShP9RB+uxdatc2C31HCBGRF3jiaJEyJeXWYONyDbOmGodUj4DNAbOkm0SemGe7bemw87K/4hqPFUg=
X-Received: by 2002:a05:6820:54:b0:5a4:d09f:1eea with SMTP id
 v20-20020a056820005400b005a4d09f1eeamr547627oob.0.1710795796106; Mon, 18 Mar
 2024 14:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318204212.36505-1-21cnbao@gmail.com> <0000000000009221d60613f58726@google.com>
In-Reply-To: <0000000000009221d60613f58726@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 10:03:04 +1300
Message-ID: <CAGsJ_4xdKbH8v0WaBFo_kDOHPXQnX7zrc43D=+irfzM-=2RxGw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	ira.weiny@intel.com
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:52=E2=80=AFAM syzbot
<syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> WARNING in __kmap_to_page
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x194 =
mm/highmem.c:167
> Modules linked in:

+ Ira

Hi Ira,

I noticed this warning is coming from commit ef6e06b2ef87077.

you have a commit message like
"    Because it is intended to remove kmap_to_page() add a warn on once to
    the kmap checks to flag potential issues early.
"

Do we have a replacement for kmap_to_page()? The background is that we
want to pass a highmem buffer to sg_set_page() but we only know its virt
address.

> Kernel panic - not syncing: kernel: panic_on_warn set ...
> CPU: 0 PID: 3529 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> Backtrace:
> [<8185fe64>] (dump_backtrace) from [<8185ff60>] (show_stack+0x18/0x1c arc=
h/arm/kernel/traps.c:256)
>  r7:00000000 r6:82622e44 r5:00000000 r4:81fc00fc
> [<8185ff48>] (show_stack) from [<8187d720>] (__dump_stack lib/dump_stack.=
c:88 [inline])
> [<8185ff48>] (show_stack) from [<8187d720>] (dump_stack_lvl+0x54/0x7c lib=
/dump_stack.c:114)
> [<8187d6cc>] (dump_stack_lvl) from [<8187d760>] (dump_stack+0x18/0x1c lib=
/dump_stack.c:123)
>  r5:00000000 r4:82857d18
> [<8187d748>] (dump_stack) from [<81860a08>] (panic+0x120/0x358 kernel/pan=
ic.c:348)
> [<818608e8>] (panic) from [<80243844>] (check_panic_on_warn kernel/panic.=
c:241 [inline])
> [<818608e8>] (panic) from [<80243844>] (print_tainted+0x0/0xa0 kernel/pan=
ic.c:236)
>  r3:8260c584 r2:00000001 r1:81fa8e48 r0:81fb09f0
>  r7:80477264
> [<802437d0>] (check_panic_on_warn) from [<80243a38>] (__warn+0x7c/0x180 k=
ernel/panic.c:694)
> [<802439bc>] (__warn) from [<80243cb4>] (warn_slowpath_fmt+0x178/0x1f4 ke=
rnel/panic.c:719)
>  r8:00000009 r7:81fd71bc r6:df9b1bf4 r5:83682400 r4:00000000
> [<80243b40>] (warn_slowpath_fmt) from [<80477264>] (__kmap_to_page+0x100/=
0x194 mm/highmem.c:167)
>  r10:00000000 r9:ff7e7f14 r8:83e402c0 r7:dedf0b48 r6:800fd004 r5:ffefd000
>  r4:7fefd004
> [<80477164>] (__kmap_to_page) from [<804c248c>] (kmap_to_page include/lin=
ux/highmem-internal.h:63 [inline])
> [<80477164>] (__kmap_to_page) from [<804c248c>] (zswap_decompress+0xc0/0x=
23c mm/zswap.c:1090)
>  r9:ff7e7f14 r8:83e402c0 r7:dedf0b48 r6:ffefd004 r5:840fb8e8 r4:ff7e7ef4
> [<804c23cc>] (zswap_decompress) from [<804c449c>] (zswap_load+0x15c/0x198=
 mm/zswap.c:1638)
>  r9:846e3240 r8:846e3240 r7:846e3244 r6:dedf0b48 r5:00000010 r4:840fb8e8
> [<804c4340>] (zswap_load) from [<804b9644>] (swap_read_folio+0xa8/0x498 m=
m/page_io.c:518)
>  r9:8420fa00 r8:83682400 r7:00000000 r6:df9b1d4c r5:00000000 r4:dedf0b48
> [<804b959c>] (swap_read_folio) from [<804bb064>] (swap_cluster_readahead+=
0x1c4/0x34c mm/swap_state.c:684)
>  r10:00000000 r9:00000017 r8:df9b1d4b r7:00000000 r6:00000000 r5:00100cca
>  r4:00000010
> [<804baea0>] (swap_cluster_readahead) from [<804bb3b8>] (swapin_readahead=
+0x68/0x4a8 mm/swap_state.c:904)
>  r10:df9b1eb8 r9:00000000 r8:00100cca r7:8371e2a0 r6:00000012 r5:00000000
>  r4:00000001
> [<804bb350>] (swapin_readahead) from [<8047cde0>] (do_swap_page+0x200/0xc=
c4 mm/memory.c:4046)
>  r10:00000040 r9:00000000 r8:8420fa00 r7:8371e2a0 r6:00000012 r5:00000000
>  r4:df9b1eb8
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_pte_fault mm/memory=
c:5301 [inline])
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (__handle_mm_fault mm/memor=
y.c:5439 [inline])
> [<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_mm_fault+0x3d8/0x12=
b8 mm/memory.c:5604)
>  r10:00000040 r9:83dfb900 r8:83682400 r7:8371e2a0 r6:001403b8 r5:83682400
>  r4:00001254
> [<8047e2ec>] (handle_mm_fault) from [<80215da8>] (do_page_fault+0x1c8/0x3=
a8 arch/arm/mm/fault.c:292)
>  r10:00000007 r9:83dfb900 r8:83682400 r7:00000207 r6:00000254 r5:001403b8
>  r4:df9b1fb0
> [<80215be0>] (do_page_fault) from [<80216170>] (do_DataAbort+0x38/0xa8 ar=
ch/arm/mm/fault.c:558)
>  r10:7eded670 r9:00000000 r8:80215be0 r7:df9b1fb0 r6:001403b8 r5:00000207
>  r4:8261d0e0
> [<80216138>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arch/=
arm/kernel/entry-armv.S:427)
> Exception stack(0xdf9b1fb0 to 0xdf9b1ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000002 7eded61c 00000000 000001f4 00140000 00000000 7eded670 0000=
1238
> 1fe0: 00000000 7eded5a8 00000001 00021804 60000010 ffffffff
>  r8:824a9044 r7:83682400 r6:ffffffff r5:60000010 r4:00021804
> Rebooting in 86400 seconds..
>
>
> Tested on:
>
> commit:         e5eb28f6 Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1491ea6e18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c23dffc=
38e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a1588b78=
05de3
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1265154618=
0000
>

Thanks
Barry

