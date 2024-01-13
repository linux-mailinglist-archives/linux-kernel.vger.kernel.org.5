Return-Path: <linux-kernel+bounces-25385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0EF82CF5F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 00:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD26E1C2102E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 23:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB01805A;
	Sat, 13 Jan 2024 23:43:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6018036
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fe8c398a2so57977085ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 15:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705189384; x=1705794184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVTEW8gc72M35iNvfDiHYtRKqIshGB2+jqJ982idX6k=;
        b=GqH3+/HXWdXVPI81Yzd+P2IUC/6N7lEwCi7N6yMUdqH45RrkerbZZKrk5XokDAMeHF
         zyhXNGoduOPqbG8yrPnzeOIQsCd1BDalDSO3CASCc0Zn2fbaKg6/T/pQHIK2c+lIcE/E
         qDSsLkq4QBn85C1vyqo/rxeoj4579OCSxDos8ceO/IV99tvvg/F/EWcOFt7kSsuEj0ru
         lHT7HSsWlevYAg68NtxBvWsOGfU5EuHM7guvAkD6o9PkkDq7gnTBXCL/9FwoLUTzsiIj
         qOq79fKgjYJptQfLrzXblCeZK7U1pNTsmJYvUhEHLOWM8ihgLqarldZZITJ1O6dL1yjp
         0EsA==
X-Gm-Message-State: AOJu0YyU2pzbyGkgOPQOMOFN/UdHmhbRakc2lIrO2ZfLGHPvUN7xwd+u
	UbCYYlYnGS5BTEtJQTkmdQ9FqiMzY0VN7/TBPM/FGty7Y11C
X-Google-Smtp-Source: AGHT+IEoE88xswoj1XMACKCuRvTqh3qvUyE+/ZEIUu0VnsFJvYaDtYF86Tu5LYULFTn2qTIYM66IXQwHIh12WrkP+WjTC6B3RfxB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:35f:affb:bd7b with SMTP id
 s3-20020a056e021a0300b0035faffbbd7bmr535715ild.2.1705189384468; Sat, 13 Jan
 2024 15:43:04 -0800 (PST)
Date: Sat, 13 Jan 2024 15:43:04 -0800
In-Reply-To: <000000000000ed1df405f05224aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008942ff060edc57fb@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state
From: syzbot <syzbot+f91c29a5d5a01ada051a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, bvanassche@acm.org, hch@lst.de, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, martin.petersen@oracle.com, nathan@kernel.org, 
	ndesaulniers@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, viro@zeniv.linux.org.uk, 
	yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f71683e80000
start commit:   8f6f76a6a29f Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=94632a8e2ffd08bb
dashboard link: https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15af0317680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10de04b0e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

