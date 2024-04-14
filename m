Return-Path: <linux-kernel+bounces-143953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF18A4004
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B20F2818CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6E17551;
	Sun, 14 Apr 2024 03:26:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408293FF4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713065164; cv=none; b=h/vdxEIQqul8/lsbiDgjXlNuBolyTgh55hWCD/6v/zAQ0Y27JE2+Sd2B8gaEUrHNUxoLue+gY1sCexOiRudNmfXWl5oQDyssO9p28DHsRXtBglHk5z6jtLD1wPX9xVBln3RQgT+CxbKY2aXcRCA/N1pil4ZpE8ak5n+NjqK6khs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713065164; c=relaxed/simple;
	bh=GKIGybLGRzkn0P4oJ/2Yi0U7cpZFepdtHyFXNuDNEMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EWZPUhAqTcbA+ktRCyMe5TO9wg2WKlx+t1RloXN+QYRge9wS5vD/u73hz7tlFItfqxmhIc523hvqjbkoqEZRJ8/zNtuDIid/l1TgT4gbHqti6HQFL2YGEAAQaWG8RN/BZsZS/IrY1gEE5i9JRq/2L8d16DUoEcBlV8pFY7e2CEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d676654767so261740539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 20:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713065162; x=1713669962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2A8R4OgGaKEbiEYxSaJLZpQ3aQP0r/NUCilfVDvspo=;
        b=GFlaLRa34g8nvrwZdTLDYftfOxBwTHn7OauRzoxpEpUpUsXQHZg6gFvLfGHl+rcPJh
         4dcNS+XzDJncOPdMjIxsgD/Z/qmGUq7ZtVE1lGL6kV0o9PnVw6HdQPW39Qp41wXtkJr0
         KlmpF3Qb2wqkVvQJfT8zz+Yimqs+Y6QUwQeVKNnAElTbn+tN30/doIhCBbUFKSM//cy0
         qOOLJW6aRnf2QQ8hWzeemDn3CmbMVDl9GDNEc6dll+P8iEXHYf534TNn7aeHEIXEJady
         Gii6uIHH3IDfYDVXNiIR4Z0levnUHUpZr/FjL12+bXTeeaYzT77HVWPFlGlbxvLnW6SX
         xHzg==
X-Forwarded-Encrypted: i=1; AJvYcCXa46CbtSQWKAKUqWD0REK/rdVdNbdbNCuTtcWtJCBRvshRcbqguCtyhk52cNvG78EqV278jfv84GQ2GIXBkFL12bquYsr1I/R7kDrx
X-Gm-Message-State: AOJu0YwAcp7Picy0AI+JPYPrDPya4YHKwabmAKlX8+3cwn8Aln48qXIA
	Ahut1dXpBzNQg+Nb290saJ1ZmYuwfzlcPHyI66JYtpTR1VpAm+iL3EHkD8kImKQZl51xOEGviX5
	7ObWEpv2Lo//DQ8Pi9wnvQp9iRaoKYza/NIgbjnPLcR2d1joRp8/X5R8=
X-Google-Smtp-Source: AGHT+IEV+V+bjvTUqhBxyLb7THjYPzhIMsrrMTFYJdvlz72/m9z8uPz84uDB1YcVWfdgLOmPDCCo8nzrG5+heT1Eq3VrbZ5GMlAs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:369:f7ca:a358 with SMTP id
 y10-20020a056e02174a00b00369f7caa358mr530157ill.0.1713065162455; Sat, 13 Apr
 2024 20:26:02 -0700 (PDT)
Date: Sat, 13 Apr 2024 20:26:02 -0700
In-Reply-To: <20240414025336.2016-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c4dde06160610a3@google.com>
Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13cea36d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11872f4d180000

Note: testing is done by a robot and is best-effort only.

