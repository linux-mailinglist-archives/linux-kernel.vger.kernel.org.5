Return-Path: <linux-kernel+bounces-106971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984C87F628
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCBEB217AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274E47BB0F;
	Tue, 19 Mar 2024 03:45:59 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B47BAEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819958; cv=none; b=o1Mg1Sskx2unIU9xat6rLWEYkah0F2heXMak5/Wg6IuKgFZwC7T9WwVq9ETfJFiEWaOZiu5owcnhHes1Ytf4lKJMbX0JAnDmynWwUOCoikoVqsnJU38zUm+LotVAkXXZalPDRAMbX/TODUVV3upYQFBfZDF7XJ2CrCh8KOsYsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819958; c=relaxed/simple;
	bh=oyJtr6u/38eCenJ3MKbURfXA3RQR579QgF08IuqWGPU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R12VodZ99uRol2nYYNRRI3dHMnFlcCZfvTV65rkJTSZ8UkNjgsImEbW3mM3Hla1vOFnWVMu0d2ypyhhxZlj+ApymrvgxHkI/bhamBC0sIriYqMROl1EOYbLlwdVgHzgIe4vHkvho8ZDgZvpGv+NlpnIMaljpFil0bxBCA9yHgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbffd468acso314061139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710819956; x=1711424756;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrayssQB58t2QOD4OYzfn9wDiUaAq8cZsiayBWD2Tz4=;
        b=H+tByd4m3+d7mQ5IHXvV6vPMRsngIRmqdBBz1UGFiZJAV2+f8OLRAAWuRfQ9lF7n4g
         5S1m1Qk5e/i9m6GGtJpTOLyKandWMfet3WFBkIphSPqZrflFMpHEjhz81XjX/c1Kt9Rn
         U1HqtUpk3TIAjcHHAdjvaiNaY+OOQjxY5hyvO5ezrKSG/bN069O/p2STWwm/+scajsKO
         /lcXg+JDCFy7EQRSFWdkrSWq/pIJ1tLvHK6FdJU76P9zrqf+1lw2KuzeH8SzrTo05AYQ
         bXV4GMOACek/R7izfqzzU39wTZcbScNgADN/2RpWMlptI/aVtIW/rEt1HR/PYHSzh9VH
         brag==
X-Gm-Message-State: AOJu0YwCco2ygdVU/6HgHXIKhREcM+1HIc8gAOP++lCdQICYTcEecfNn
	w8PzWFwnvxLcM+0lYj9d7SUYgY3q3dtd5u+soNcwnGZq7CthkhTqH8psIrNXx3dUdMKc2pYUYej
	FoB1I4ba2fXihg0s+gZrEWvM9rGg/j3/OPzl6IuZgTppi9FKN3tKxAY9Bkw==
X-Google-Smtp-Source: AGHT+IFKCjpQwKQZZD6OZ6j3k3Y1iSViXQCD9jxqMx38fUWW27Kaf+H5bV47f2WmM4qQRbEpCPOWZg4Wb1+nuYs5Yj+tGIsL8+P4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4090:b0:476:f1d6:93f4 with SMTP id
 m16-20020a056638409000b00476f1d693f4mr57217jam.1.1710819956503; Mon, 18 Mar
 2024 20:45:56 -0700 (PDT)
Date: Mon, 18 Mar 2024 20:45:56 -0700
In-Reply-To: <000000000000e981c10613fb227e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c846560613fb4fce@google.com>
Subject: Re: [syzbot] Re: [syzbot] [xfs?] possible deadlock in xfs_qm_dqfree_one
From: syzbot <syzbot+b44399433a41aaed7a9f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_qm_dqfree_one
Author: david@fromorbit.com

On Mon, Mar 18, 2024 at 08:33:23PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    906a93befec8 Merge tag 'efi-fixes-for-v6.9-1' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d6ea6e180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5206351398500a90
> dashboard link: https://syzkaller.appspot.com/bug?extid=b44399433a41aaed7a9f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-906a93be.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f096ab7eaede/vmlinux-906a93be.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/52e0859d6157/bzImage-906a93be.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b44399433a41aaed7a9f@syzkaller.appspotmail.com

#syz dup: [syzbot] [xfs?] possible deadlock in xfs_qm_dqget_cache_insert

-- 
Dave Chinner
david@fromorbit.com

