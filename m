Return-Path: <linux-kernel+bounces-69860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AD858F93
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01833283511
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292437A73E;
	Sat, 17 Feb 2024 13:05:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE32E403
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175104; cv=none; b=DSylIHHwaxiCaiCZjCjhhFnaeRH1OyjheCzp+IhVRbzt6TuqAZa7tOKdY1QhNLXOf+drdY9pmG/tWnKITPntuTGaRvLNl4h5udqYjHlDqbh2sHzh8vAcZYapqMZ+Ns2SuJZVDNoEJOVmjEbWo8AFbdO9GHOntnmRAH9jLTWmiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175104; c=relaxed/simple;
	bh=3nrOran+3E/6VsB078+tXDWuibeDv+JF7NmZjhbKaME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=myca/iXiWR095iGTd9Iub2xZfBfyScg8TbnVnnAzF0+HETeg81VYukOYAfmQTNER2uLo/azUDlCE1Q8dP4V59PJSXImiMHHQi/vGi2EWbRh+XWUlLNbxJlMYFCgAPVn4q5VauuQh5QFN8PZIV3dbi4XjDBvsJ6GANWsAg94Dies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-365116383bdso8192005ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175102; x=1708779902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FThBQXYga9w1cWMyp/yRXDDAEE94fJrZ4ihdn0r8aIQ=;
        b=Mud0fLVkLydXtyckXb/xGYv0+Be+dBvcA8vZ8Ef8XVRa2J3vTN4S+PHOCRdLLwwlzV
         bJTwpoXFTW3SKnvB6Fdm8yN6HHz7XZw69X57gDeJ7g80g1Gol/XpAXTKIBs4pqn6Q5CD
         cd24FLFTQv7U7qmO0IiV6+fNYfqK6pSbOxBdGOlsylLP9lppUsubabm+J7xhl281n2w/
         +jiK2tC6cHYmwCOjKuuHex/H+mDDmH442TCpPd8sXBn/nrN7w1nR1cbOLsz/n4wpCCli
         TyLvB4yffD98so7VPk3mfYfjSUra5hC9quQpb/31Um+XCf0Alz7GwloL58JwnIIJefE4
         mGig==
X-Forwarded-Encrypted: i=1; AJvYcCW3NZirrZBlWbEo27asLLljyJRT+HnE5iM6jWce4pUY3uM07D4cKI7pL3+cuUtLsBYK7pFbZA451qtajcm5OLOw95rhhsMKJ1ZtRN4+
X-Gm-Message-State: AOJu0YwrtSVCTIG9uQg79e/d9fGRA4y8CwVxNyWnPOuw87ncIvZOP1BG
	L9wZoinnPj5N6yZqO9JzSMbPg4fIwNQvJlJsqgUtKaX+6KAfurKMaW/8MjJpccga0OBkpbS9tDO
	y6AheyHui3RnarsEr1sq/jGxBF1zUIKeXpEZACVKSYEJKfz2e64W666A=
X-Google-Smtp-Source: AGHT+IEX9WITVv4GtTYdnW4Gcm9u1rwfgoZb080R3rLYEmMo/IgaR6FjIYJegvp5dLVSAfB3thDnrcKX+MYpjj+ledVz59058AXK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388c:b0:363:a059:670b with SMTP id
 cn12-20020a056e02388c00b00363a059670bmr436688ilb.4.1708175102569; Sat, 17 Feb
 2024 05:05:02 -0800 (PST)
Date: Sat, 17 Feb 2024 05:05:02 -0800
In-Reply-To: <00000000000046238c05f69776ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033f84e06119382d7@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel BUG in ntfs_end_buffer_async_read
From: syzbot <syzbot+72ba5fe5556d82ad118b@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14016cf8180000
start commit:   dfab92f27c60 Merge tag 'nfs-for-6.5-1' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=72ba5fe5556d82ad118b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c987eca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144a738f280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

