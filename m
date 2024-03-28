Return-Path: <linux-kernel+bounces-122939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0715B88FFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2EA29437F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FF7F481;
	Thu, 28 Mar 2024 13:08:36 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8F3771E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631316; cv=none; b=e7Yot/ReknMX2YwI5RhC5oOm1dkHWiCCWh38Obs1YIi9NrqMb9SqGuDVMqxtfRCWFE/HPn9JDRhnMC7kHRHmDldxNvEldFUeZuEKUPuzpVOjPJ9sERiJBkovM9D7xjPTDfquZx8jrILrzUxsfexh5ulPOfM5QMcmvGchJvcVtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631316; c=relaxed/simple;
	bh=1Gq5pEaNXrbu7yF2EJf5b4IE0l7/gZsdHSMEOPyFyyY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Y/Biuv3M3ZOQ2uYZ455RDXpKGT77SyCIsMpXoXrRSlfd4twwlRR1PJPRhVJHhvvwjAWv3oLuvLMxWjPZRCyxHF9NpBboIbOKjh2PSH7owwTTcSOr0BJtTc/rxhLEd4dYXqLfpPorz0Xat49CGlPs5GhTL+MzFzmIHUbGso5FpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so55865639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711631313; x=1712236113;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phTm8D9QxIqku3+dzOk7mAuzWATH8ccFfySGlvdYVpw=;
        b=Bp5x4WnzQHvrZdGIPeChpeLBpzk26WpokSFFxcrv4ni0RXqeDhSmZabWwTgPQ8UoaH
         YddNpmWNl7wVY+COhTqi3e7VC8meeduhThLiMQ62m+TL5aT3uspm9K5iYUUGGMvqEzR1
         F+RAjTSaC3uQs5b7apoKwbX7GdEbWJQZZl0YAfj/Gsl0YTN+Ar75l3ADYj23JR99D0Ks
         am5w5XU3AwWDvXmDhwsdM+fRy6rCsr2fPYyh3imB78MrdaTyd6pePykI8Fkx2+YP1PtO
         678b6oUHeVg8WvOUZaUoFLPHQ6aottmXojqv7e+feFx3HBOn5OggUl05VCwD8lkN0p7+
         RtTw==
X-Forwarded-Encrypted: i=1; AJvYcCWv0LZBUsWSGvTr0CXFv6zfKBCPTALhzkGhY1iZI97K3esCx08aYpDVbzFjhINoVEKwwLPxWcvXqaKFsrS/YxwsGn4zMV4eF1GLw9Qk
X-Gm-Message-State: AOJu0YxqhQeLuORcKTy0ndGGPEkNoNltJZixOM7XUB30hw5HmhNcuHN5
	dQ7GSfxzFg/6oyPpdWPbHH5dBHxF0J5aKX5xNnOU5u1Sppfhsk+bfHM6SjrGs4qbS2eGckiow0Q
	ehsTCp99SJV1s91kpaQWh4Np3mT8LeoIPZ7842490QvYqPk7FdYH+BXg=
X-Google-Smtp-Source: AGHT+IHVstareIQr2iQt8P9A37R24y5Hcmor2dMv1fVqXV3He2chAs+ykyZXD9HnfYyfbzs67ps9/XJ4T8VQ1Cu/MRR2oRPtrbdB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3413:b0:7cc:7112:ea9c with SMTP id
 n19-20020a056602341300b007cc7112ea9cmr54675ioz.2.1711631313702; Thu, 28 Mar
 2024 06:08:33 -0700 (PDT)
Date: Thu, 28 Mar 2024 06:08:33 -0700
In-Reply-To: <271f4b9c-f879-4933-b1e9-1e7481a809eb@ghiti.fr>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070a2660614b83885@google.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance (3)
From: syzbot <syzbot+620209d95a0e9fde702f@syzkaller.appspotmail.com>
To: alex@ghiti.fr
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On 28/03/2024 09:27, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    653650c468be riscv: Mark __se_sys_* functions __used
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1110f1e6180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=88360569be845301
>> dashboard link: https://syzkaller.appspot.com/bug?extid=620209d95a0e9fde702f
>> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: riscv64
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-653650c4.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2701bf6276c4/vmlinux-653650c4.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/aed54fe6b3d5/Image-653650c4.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+620209d95a0e9fde702f@syzkaller.appspotmail.com
>>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv	
>
>
> So this is fixed by 
> https://lore.kernel.org/all/20240326063036.6242-1-osalvador@suse.de/
>
> Here are the relevant syzbot tags (hopefully I get them right):
>
> #syz dup: [syzbot] [mm?] upstream boot error: WARNING: refcount bug in 
> __reset_page_owner
>
> #syz fix: mm,page_owner: Fix refcount imbalance
>
> Thanks,
>
> Alex
>

Command #1:
can't find the dup bug


