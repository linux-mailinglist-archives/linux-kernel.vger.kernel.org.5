Return-Path: <linux-kernel+bounces-96163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448828757F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12E1B2534D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6E1384A3;
	Thu,  7 Mar 2024 20:09:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB4130E39
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842145; cv=none; b=SaT1jFN600738kUOMulnvgc0tSfZcjJGMMmH/La6vA1cVYqG7SYgJauXAupIhQy5GMUZtx+Pm3dF46P/0/1bRopfFRglx7t9wsSwIcXd0bhN10eqL4sfTQKQXfc4JPkCCps8/hZ7ZV4IJFyzFbdAtzopqodnKpybX8P1QYwMuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842145; c=relaxed/simple;
	bh=TSQ7AfrXLucKWQheLsgzlE+z8sjF6wEGYB6N+5YuKCA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p0r4kJETcm+DoH0OL0gn2CGs9rjAAVZokpckZ8d25l7D5bZquYYMVAQLizIECiBMHDomPg/1+VTy2SwjJKl4jn+hBP6CcJoHp0Rx6mTMFPZuQ/uybywWcVC+dJb1j6GLk956CconUHlb+XQJeTyii1ZAgZtUkIeqBMX2zDaS+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b161279aso621635ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842142; x=1710446942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPnadW8PWoeFYDGj+Rcds2yWxUTI+tugiFM477DcjnU=;
        b=RFbBwkUrbzSjtsI45C3DP7Hb9cE4ykqEfM1DVYjy+fJEQTUGnxGfmx4TQOA/wJ6olf
         fpXu8xXFVN2mgnIu8t3is7M4hDwYvfCVRoBNlURVrKTs37vA/IMsAYKjbx3jUyDU2GMl
         4qYAIQKuPEU9J68cTVhJgO4lw8cJjpGPF1wVYlNRuxxzwUYG39uPVyev1OdXv5tY3Mx4
         nj8MeJfVL5t5wqymMtv2srhuWiatNtkQrZlVGstQoP+nWJ9SjEyGGRhqXeaVro2GAs83
         6XFrrLyOY1UXgylq34jGGaj0oYBH4rXnpv1f/BkQDKAKJcq9O6/aFBcGztO3riLjTEc6
         xRCA==
X-Forwarded-Encrypted: i=1; AJvYcCXkmrqWIB9oN6HizRfQaqhscglcMGiDVERSt7ywBZLSEHCrbzIbI37t7/HL2VGiZRsvaQ7M6EnASl12EBDWus5Ti5ejc7i7zKd/952U
X-Gm-Message-State: AOJu0YxrvjY/jm4VsEvp8Nr5A0deG89pZqyHTCW9NJeAkRZUPCJFpqqI
	/fbY3garqUtJ4g2/+spPrIvbm0G9nJ7f7NcAj3lApbljKwYXi6xiDCErjWAuBtjaFX3VzLNzdVz
	qau2uBJV9AZK9rTpK9fbXFjQnCqwj/JZGAhO/JsAmr4cg7BRbyRI1zK0=
X-Google-Smtp-Source: AGHT+IHf0A1bbJbf40iM9gk/Vn5lgktnauIGxNzkggiI77z84bps/c8Vlpz+R4jEIRrBIDzEioemWGSOafctG0M9EBFR/8AFCv2Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:363:de50:f7b5 with SMTP id
 r14-20020a92cd8e000000b00363de50f7b5mr794885ilb.2.1709842141829; Thu, 07 Mar
 2024 12:09:01 -0800 (PST)
Date: Thu, 07 Mar 2024 12:09:01 -0800
In-Reply-To: <000000000000aa9b7405f261a574@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c7392061317a56f@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfs_mdb_commit
From: syzbot <syzbot+4fec87c399346da35903@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, kch@nvidia.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126c98ea180000
start commit:   7475e51b8796 Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=4fec87c399346da35903
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1286c3c0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121cc388e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

