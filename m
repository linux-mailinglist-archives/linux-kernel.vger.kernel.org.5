Return-Path: <linux-kernel+bounces-78752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F075E861851
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E991F23BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635471292D5;
	Fri, 23 Feb 2024 16:46:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03D84A2B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706766; cv=none; b=sR5rym5w7IKxIfPqhsOBNZ7HW87SuEn8qv10tjqxnceXAwGHBXAg3Ow3nia8gji4lebzfbdW69CJqBzy25ypoEf56cZsFiCxV9b6eEfqZBzmwuEL6FDKx5TF4xcXLW2vvmceY+cFeuepq3qheX9hc4Vc/mShtsQ0h0G5M6yQKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706766; c=relaxed/simple;
	bh=qQXXCJnEn0gEmCgei4EJtGTcYDFQeydarbbINEJ98wc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QrkNDntx1XuuDtfxPZjtTuBtQCakwEce2o7kiGpCSPPO9ppvi2zSVdfQ/2f3Xq/LRmJeYZcObARrNgkms0LoL2MBOsTMe3GQybvyZAO8MqaEF7UB7UwYTyB/LSdwv2lwSFL20vOktxF8aYQmBzZLHW0vBc1P/0VlYGTmbKEtEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so95080339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708706763; x=1709311563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ceXc2lDEn8+HQNQqoepYTtPf4nu6XaifYXdeQUwtmA=;
        b=ZEHYws4qnH5eiaO/cm3sipwptpfnbE8xylzNON2N4ymaisPKZyMkCBMQEb7W1mT61T
         ALkR4H7Y4ay89Op/exBSkrxV2Slb5eWnoxCF58E15qGrwW18xsaFE1yz6/b8heboNaW8
         xbhyMRsXtGSdrQCwSMETYV/8ceosrhW4AQHH0ovyQkfkyPKwX5aPmqZyUqWpvlVN7p2O
         PgAbXrtdsT0Hb+U27hpKznZygMaKpA7/g4nyTynKAUVy4VikbktcL6iMEXaPNIYnn7KY
         1dTgo9wVkXjVgCJaixI4310AuFOKI4uTEfoGvV0Zg7rtJmUyrX36rB+gBMl8Q1h98Cyt
         IT1A==
X-Forwarded-Encrypted: i=1; AJvYcCW78DtefvmsBCpaJXlhUhapdPcfUgIbyEhiO6NsGtfLQyNLVFqejuS6V/FtfZ29+hw7c7+Evk76d9CZ/93LYrVcAU7uisbMXPIwHO4G
X-Gm-Message-State: AOJu0Yy8jXrbcu3EFp4r5djrZC9YH2TSUHDH+CvfR6IHKzTJXdDiHDo4
	6qH1A5pI/xmOTOFGZ9GOHOvEzMNyCDu5/5HIxraWsw6u9VlEg0yCq6GAZL1i+GGyemrGow9m/WQ
	TAqP865hqss5Oe0TJdr1Xrg4nIh7qyIfjUXsxt35V8WQAkQ/qGl4Qt3Y=
X-Google-Smtp-Source: AGHT+IFJyp0MBrj4S7LpAYTmGxLLAIs0GF3qNZ35WmD+27zb/IWGxxjM2bKRA6m25SWK8yidx1cSH3ToQ5m5W8fEDdkEIjf8h1Qz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:898f:0:b0:7c7:96ac:9408 with SMTP id
 m15-20020a5d898f000000b007c796ac9408mr4609iol.0.1708706763728; Fri, 23 Feb
 2024 08:46:03 -0800 (PST)
Date: Fri, 23 Feb 2024 08:46:03 -0800
In-Reply-To: <0000000000007fcc9c05f909f7f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad6da206120f4b2c@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in fix_nodes
From: syzbot <syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, rkovhaev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c5b3f0180000
start commit:   a4aebe936554 posix-timers: Get rid of [COMPAT_]SYS_NI() uses
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=671af399e2dac0e3
dashboard link: https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a4c8cee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a59e11e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

