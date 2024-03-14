Return-Path: <linux-kernel+bounces-103149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B62A87BB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140141F23D84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1C86EB6F;
	Thu, 14 Mar 2024 10:57:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1D6EB59
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413853; cv=none; b=oxWsKbjH3F2tFkIbhtZbTXFJOSIhRnGfH3nmz8v5EN6I0WVb1QokEWD6XUoSxx9nFRYboxcMz0vWh5C1cqXP+1mCCAwalnGKp56+X4Q7KxjaFCdYbClB5DP5DZAqK3b51gTpsiXHDJAfLt5T9q5wxZTdreXghedWvpnmPov56pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413853; c=relaxed/simple;
	bh=wqW8Cfeo8H5/uTSQiLDF+ZZ0kCvejX6xUsqyF6X6QfU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mGcmFFVshcyYmMUHx1Rtm63nVb8bdrKjn1H+10t2ZRZNlhJGajpvgHfbu6WqJtaaMRlIrMl1CAo47CqsUy9jVGcgjhXvEzbuicZlFuAcmlJG1IpMGk5zb2kd4x2wurwI3nP1IOe+1um9r8LzJJUA7KgVUVtY08wYmCSK2PCdlzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8b8a6f712so65651939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710413850; x=1711018650;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq7e2gcF/L/dH/HAItcQ1BpEoiEbfL1oa9AWQqFNdjk=;
        b=PECPWuIybfdm3I2QNsApAA3vaPRMv4F3WxaZVvU6amYun8oP5iMTamttTKMiyUZ6wr
         KXv1NjUjFSXFHWbmJwkRiei4U5k237L3oiNrjt1pBPls8aHw1bCB1ikhOhDu74jghlLC
         lLOjRsRzpOv2RiZaRfMzMEK3piP6RoyBAb1yYvIFUwPsZ+NRkBDLLhobXrqM2RxHhR1T
         GgTqfcN0Qo5TyZo464CLd77gyPqHcriEfKY9COcvbwLM7xXguNXAAoTOWIMUY2GhOQlX
         GfmgPiX6YP99BrpIFipSodwiOf4ShC9xz4WriQ8b4ghxaFBeUOheB0MWJMYUrSTkhCBT
         a2uA==
X-Gm-Message-State: AOJu0YzcXhfhFos8vL3bgXSvL0BD+skrls0xUe1dt81RImulydEBxaOX
	4M7GcTKXEUo4aQXb+OOt73yXtxWp/OymeV/sEts+AZG01QXRTj8bDemOHPKLCdzXuYtUq631M9Q
	qeQ4WpMjy17cnm7MfiGc9aQUvUJgHCGJWOxzQ+6I7DoZNU/naWtJ3HuwwPw==
X-Google-Smtp-Source: AGHT+IEXXQtYdGejuNfcBi3ZrkGwafrpTasOhti1WFIG0pViXZfetfwn+aEoqcZDOKoNZSw5bvZpi+dlRoyYj7BrvVpm7u1DPAZW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2045:b0:476:ecfa:83e6 with SMTP id
 t5-20020a056638204500b00476ecfa83e6mr74252jaj.2.1710413850062; Thu, 14 Mar
 2024 03:57:30 -0700 (PDT)
Date: Thu, 14 Mar 2024 03:57:30 -0700
In-Reply-To: <0000000000003ea6ba0613882a96@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3c5d906139cc17d@google.com>
Subject: Re: [syzbot] Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
From: syzbot <syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
Author: brauner@kernel.org

On Wed, Mar 13, 2024 at 03:23:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f1a876682f0 Merge tag 'vfs-6.9.uuid' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1541d101180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f0300fe4d5cae610
> dashboard link: https://syzkaller.appspot.com/bug?extid=9b5ec5ccf7234cc6cb86
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484d70a180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b38d1180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9de3cd01214c/disk-0f1a8766.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/af661293680e/vmlinux-0f1a8766.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a439df6ad20e/bzImage-0f1a8766.xz

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9d9539db8638cfe053fcd1f441746f0e2c8c2d32

