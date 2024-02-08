Return-Path: <linux-kernel+bounces-57758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD384DD12
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36190286E63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130AD6BFA0;
	Thu,  8 Feb 2024 09:36:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CC6BB3D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384968; cv=none; b=DPNfeerclKae8/squt/0k9zSwMZdnN1BlQlnFFufhoBayLfFwpBjKWHZDkYU7L8q8NjA4GEN+m+Mc7Iwnr+EF5KzEk8c12nl/vyk+UskSYu5Vjya6V6hV9rZRumFG8ATCPwS+lBEVAoG/jYWF/phAHuWyJ7sF+j5DypYxwZAdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384968; c=relaxed/simple;
	bh=2+xVcWPapgskE1J4JQmDto8kQCN5WpySxe8VopRmGuI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hq+ANfImQC9P0BrulxW8bQMkF/cy0DWZnKIxwgfrZH809QiBzepLcW+UU3h4m580qmjtioJoRkPkwOiBtskEQ1cBZ0fRDgTaN2VdIeVY9rNUejQJkxPyXJtwsq+DPCZ1mKV4M9g2hNXlWN85bXQEpP0xqv/FPwlqdsNpztzd6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c02ed38aa5so130753039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384966; x=1707989766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjH2Ul/xBI3xctJlWjZ91mgzT37WBgLBcUIhV15q+xY=;
        b=VNERqRXRZA6t6AMGx3Yyq/iHSyblbQHkNp+io+hy5E4tofL5Tyt52nCiKHNFLz3ZS/
         gRCOlt4nguYruES791c5xRk0O831/EdFqHwgmYoR+2hgAfDNzJ773+OAm62i36yNH3VM
         r3N0XghErGn44T6UJS0opNun4PONdo1cMRlAsMYWPLu922BbWDBJhjrhKrhP9iBqQr/E
         npcbQQQ1bdPILV1aWfzraKHob5UXTJfTkag9Ktfg+0MMrnYsV8ucJhSFpFGJLs0R1Hpb
         dVSaD9WaFFdTScelJC2/T6HKoEug7Ie86lV5gqh5heHPL4PvJTU2idR46x6d67hetWDr
         QWFw==
X-Forwarded-Encrypted: i=1; AJvYcCWtkJkHj+yEcNVOzdDQ+vbdoI5YXBqjNyxxWz3xPyL2rATw0Z3Hyc+nUI4O7n47UannWLAPUr+WWPpVoMCtQikaw80KSyoqCEYxWlGE
X-Gm-Message-State: AOJu0Yx6GkIEn7u1xtqY7bmdNqbM/PyYsUNKtaXuWhN8wF1xbGq9KEmP
	liZpTsH+Lenbq5Y4mo4Jy8KSH6xH66e+mbz9EPRkTtqLuD0LvP3Glrh9Iu3bEbKeIczaPbG7Vge
	mIFnSjSfKJEyj5YVg+Ad2vr2WxyQE9sGmn7KxJ7/RpEimUKqUb3qnTAc=
X-Google-Smtp-Source: AGHT+IFLeQ6dx8cC1eWqpDA4E6IuVoZiQGMseOzRrozFrFcrTqNYzbipUce5400Xz4WIEea2BckX7xGorOQ8/UBZRBCX/y1oPEPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4a10:b0:470:f2c0:7f20 with SMTP id
 cz16-20020a0566384a1000b00470f2c07f20mr58240jab.6.1707384964828; Thu, 08 Feb
 2024 01:36:04 -0800 (PST)
Date: Thu, 08 Feb 2024 01:36:04 -0800
In-Reply-To: <tencent_E9DD8E5D8799084FFF8DBA25EC0D84921407@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052d5570610db8a2d@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING in input_register_device (2)
From: syzbot <syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com

Tested on:

commit:         04737196 Merge tag 'v6.8-p3' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13ab9118180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a569be813824c2a8
dashboard link: https://syzkaller.appspot.com/bug?extid=8e41bb0c055b209ebbf4
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fc85d4180000

Note: testing is done by a robot and is best-effort only.

