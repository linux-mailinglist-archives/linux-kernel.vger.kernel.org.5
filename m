Return-Path: <linux-kernel+bounces-85837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE95C86BC08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF17E1C22EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC613D30F;
	Wed, 28 Feb 2024 23:16:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E413D2FF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162166; cv=none; b=t5as4rrrNiRg7FluAlba8H65LoJgW1wzyVqpNVG58nbsVlswNYDYsaPZ5Anmat1q7S8Co7YvQRsMv9wupKd5TgFaPGb2Y6zDnk3uBLCjANAeAbh2awjkPqK8gsQBPDrdA7ayo89if3MjrnMpynrHMjMJNJ89VCEepbq+S3TVKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162166; c=relaxed/simple;
	bh=AQUahNxliBRnxzbiLyFJhAv8zSnsPgpBvtR8vmHjVTI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S6rX7OVXVn4sjv37rgDh9nCDaOg2AjXUbpqm2QGjpJMpOLim/56174K7r/17WCW/d4MdF+yiz6fHI3kHM/WGE/X/Q3clBNfpQu7K5fejcugCX2ysBIHDEZC9b1ixw5QwY1IO1Daku5EVI0+XhxJ/Yebh4eA7AR4yPBj/HGi/cI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c78e7044b7so28071639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162165; x=1709766965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0RlstvxprlM4gkYbdJ5NUP8ntmVKrjAxjshVbrRXSc=;
        b=fj1VzGOYl20Iq9dEBUQzqcuqNJ2j9bfYlZ8JFRU8WBZt6LLIe7agB3fAFiH3z/Wxwi
         aU6d8EY6GMEISacjSCCUBBnjgi5E0a1hDV+fN4sdpACksmxt55bqz97FFEhR8sEjyMw8
         xxRMiQKgPqCapsqwsFPnvcyoiWV2w3qvsLmj2ZqgTYpClsQrUNRN0xG5W33Oa68GX3E5
         SZFRm7+h6wpLk4tV7VgpOddPslmwojZIzFWj6crszUpCR0OmAiXYJLB/hujiR/mwC9wq
         P+PXfnIsPRTKyGL/1Kuk22MiD8XNa42JJfEEPosghqnhnl0PvkBPlv8BS43ia08m6mmv
         z6rg==
X-Forwarded-Encrypted: i=1; AJvYcCXs72QLP3pgpEpwx04ZHvd2bNL0EGoCJTkGKly2Md84C31Lb8KWAvg4+e9J6t/RRDJm2IQRI7zbX6CcqQZqXr0zIZBimoin+98Ju0M0
X-Gm-Message-State: AOJu0Ywb4irWOin4XImr3ISmmXiTgNNx+Bf8Yp3h14JSvzAtEtfPpn8q
	DQ6GZkx9oUlBoQklTgnXfyLEVrL8CvLOdBadStplj8qEusC8tJ7XXF5poaKQGKZbF/koqMNnWFG
	0WVUP8rNpkc9mcCOXEf0JJBR1BhU1ikLYBcsNKvyoGeMK4dMbMjNsKo4=
X-Google-Smtp-Source: AGHT+IFji+gWg2pA+eUmcqqi3S63tv894XUzwmU+L6rl/SIS/OebR1zkMrOwnEALjAYt6aL4+TwLBuzpQRHW46MxBHfiWMdCbk8l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:365:25a2:18ab with SMTP id
 q11-20020a056e0220eb00b0036525a218abmr36292ilv.3.1709162164779; Wed, 28 Feb
 2024 15:16:04 -0800 (PST)
Date: Wed, 28 Feb 2024 15:16:04 -0800
In-Reply-To: <00000000000095141106008bf0b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2059906127953c9@google.com>
Subject: Re: [syzbot] [ext4?] [reiserfs?] kernel BUG in __phys_addr (2)
From: syzbot <syzbot+daa1128e28d3c3961cb2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, bp@alien8.de, 
	brauner@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.com, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1010d154180000
start commit:   95c8a35f1c01 Merge tag 'mm-hotfixes-stable-2024-01-05-11-3..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=daa1128e28d3c3961cb2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14562761e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1089280ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

