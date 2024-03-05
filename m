Return-Path: <linux-kernel+bounces-92949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC2872879
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA059B25A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFBD12881F;
	Tue,  5 Mar 2024 20:21:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5B127B7D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670064; cv=none; b=SH1Spce4CJ/Jc3hiyyncLKsNu3GVuS/EoiAYEWIsGWrvnVi/7L+rEjul6Y8EYVincrPjKmQHOawQ01bdGsvMSGXIV3IieVotq4VDyXOUMEYn98F6c7Y3Vkxce1WkMWaWMsZBnxW1aAkx2sX842b0J75IScXuJUKUOMxYJfBZTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670064; c=relaxed/simple;
	bh=6/AYUfzDqzkrxKkZjplJh9OD3V2IdKBUYScD8zp5YJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NFlbHmoKP10pTIu7Xny3qH5v0wsoXwEZ/TtbkLappUpXVCCIlI5NBZgM1pme6SSSHBitoOYS0G/Cg5lfLsdnqypBaewk7SJi8XZ4UR5HhdjM3Vj4ytdUQeCxPAIXmU84yTFfz1937iTifn2uEm3tVesNBB8e50G4M5EnJuS3OGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36576ec006aso56635045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 12:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670062; x=1710274862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUtUYHZsCEOa7X6Z+H+o0TaVUl7jsvxTuXTfFKtx4Og=;
        b=XE+jiUfC8ngrVrKwCdhdhf8f+VMyFakNBFMuQtacLu3zPkr6OgftNJkYGmwGbmIbYe
         /oR1nkjHh9wchHPHVkRrA389QEQBHhUTSKHIEJVtEXxMBEm6TLScuQOaTMrUwMThp9zJ
         PO1tKlMFRmhPQbKdpou2nUxGZSRSXkJOT+iNjmsiKZ3iJEWXgT9KRaS7ZszznvD1xlGO
         r2fIqQwgb1MSn4I2d1qERXRzckP0Uz0s0scRV/niODS/Rv7lMDsNLy9raGVFDNDHOr3Z
         YURHT3pYi8hOKfaD0aLqRfjKrs9o/5MvgFMc03wEKVC4bwBI70IDDyck58tYLqUiFN3z
         1W4g==
X-Forwarded-Encrypted: i=1; AJvYcCXoVstgqu6XA3bBTPBBQ6b+e3vYlh0OjO5LvgW4bIJ8s3D8zspJmK/jnnfjmG9qaYPpJhbC/pfNm0PpXOOBmFbjENQp3do5iTD4UvBq
X-Gm-Message-State: AOJu0YxUXFMnaEYdjtdqzW5HmUeclM5b71wrHQr1AvtbUH4riHFm62a6
	wQIPCdrDj6dHmTD0QIBf1UbaeXUnuul9owQ2kaXiS/Tyst2Axah71M82CjPA0SqqRFzoXOR4U0i
	hF4ZuV61WBMVzWDmG2TfQP4rZU1N6cLoinkZdmhW2x2B4uPZHmmlwkls=
X-Google-Smtp-Source: AGHT+IG0HrTjf9tSzpW5mhEYahI6I+CdKvynp0WSCF6pQbzs6aTIrDo95uQZixM6D1ufLCf+gnTifAlBvx8apq0D07TCgFJ6wpLj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6f0b:0:b0:365:fe09:6450 with SMTP id
 k11-20020a926f0b000000b00365fe096450mr104480ilc.4.1709670062725; Tue, 05 Mar
 2024 12:21:02 -0800 (PST)
Date: Tue, 05 Mar 2024 12:21:02 -0800
In-Reply-To: <0000000000000424f205fcf9a132@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5b2ae0612ef94a9@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: shift-out-of-bounds in ntfs_iget
From: syzbot <syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, ghandatmanas@gmail.com, 
	gregkh@linuxfoundation.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	lkp@intel.com, llvm@lists.linux.dev, ntfs3@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12be09f2180000
start commit:   afead42fdfca Merge tag 'perf-tools-fixes-for-v6.4-2-2023-0..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12da9bbd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174e8115280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

