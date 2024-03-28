Return-Path: <linux-kernel+bounces-122583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CCA88FA01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CE91C2AF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3456B65;
	Thu, 28 Mar 2024 08:27:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A126AD8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614439; cv=none; b=H7638v1FNzoQ7KFYFA92PMudXDAq+4RIJgqotkLKuhnXMNnIk/vb6mcd5Z+ASx5YxAcWAOkxJHwN9/WQCYOpym1BlOKbeR573p6XkfNJoALkTL5ZWJLr9G8/jXYXkXyOub5uZWufMeTheRzKE4MGujzB28xEC3XHLYUelobyvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614439; c=relaxed/simple;
	bh=g/SbGd2F9byoqsrkRkPWWH528ldR4o1+h/wnBBunMnk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gNSe1IyTo4v3RHFgnWArdG4ZH9dUJTua93ABlgKlC7Ux5NaZs4Vpw0pPNL3YHA2Wl6yOauvGj70Cc/2lHeJYRx87jqluHU0RJaUJdEU4evTNfWRw0mahoxHu6DD8x7lWIHAbbLrrHJqARtnIXs+CjeoGv2KbhEZYS+wXzlXnSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-367858dd387so6499185ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711614437; x=1712219237;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7LtcZu6Gv0nqzHmczcIx7im5xvOcwCAJaiKZxY9O5s=;
        b=Lfh3GAqYOA7Wy/YHqFwKj7fZWgYGW6PDT+hhXdAQp9lvjsWwlsclhRt7pGE7bzmu55
         Dw6tlU+oRkX+cRDMFkpoDHkK+jhQ7ICdN4WcLzuh4ntLxlRx6HodzpB8uEPwh+9Y8uma
         jblLOgd0IbqMyC+sM4L492seXY4I6W6Ti4rZY2UgAQs5T2CGBv+JHi0ylCqwgGLaMeEa
         MYAlzJSp+VeHkfK1fqwClk2JMIS0AlXzS8cGTOZu1uiyQh64wj2y8U5Qyv73uAdR+SK0
         m9A2qppDzTBvhAw2p3RwFK0+2RhZcqmDBvhvoIL01xPnxQyvjXyi36zpC82Fhc2oozvy
         CMLA==
X-Forwarded-Encrypted: i=1; AJvYcCXEn7JomKKRA8ps3Hn6sk4WkN5YyCyiueTR6+VZX5f9waCFRk54+hgtezCyYUbSfj7d4UyRfyF05zm6JRFe+k367IIawYqyhv4DPZKi
X-Gm-Message-State: AOJu0Yw4sjO08qnZlzBC3/aJu1ODQitmS2xFUOeVy9m8iBknHLS3eKIG
	T+PuUCZ6Zs88Kwnmo3y1Zb6Q0s2ioxKXteiTeRq4RHt1enVYf1l7Rr1jEt8LCTKYHXEiUoWeSTk
	MOaJZHVR/RT7PHxLX/lmIVGK5C2gTNEfB+C1ejAqRBmiBbv24Yf2Nnkw=
X-Google-Smtp-Source: AGHT+IEhu7EBwQJO0RH9od2MbxlSRSn5WV0Htc17+GWpseaHZK88iV4am8mKtxYsKyoKbDnAx0eBTUSQzgoOX1AFHB2d6EiqfiL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198c:b0:368:b289:38bb with SMTP id
 g12-20020a056e02198c00b00368b28938bbmr110263ilf.3.1711614437515; Thu, 28 Mar
 2024 01:27:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 01:27:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a75510614b44af1@google.com>
Subject: [syzbot] riscv/fixes boot error: can't ssh into the instance (3)
From: syzbot <syzbot+620209d95a0e9fde702f@syzkaller.appspotmail.com>
To: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    653650c468be riscv: Mark __se_sys_* functions __used
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1110f1e6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88360569be845301
dashboard link: https://syzkaller.appspot.com/bug?extid=620209d95a0e9fde702f
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-653650c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2701bf6276c4/vmlinux-653650c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aed54fe6b3d5/Image-653650c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+620209d95a0e9fde702f@syzkaller.appspotmail.com



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

