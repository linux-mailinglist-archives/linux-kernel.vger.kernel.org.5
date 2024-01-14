Return-Path: <linux-kernel+bounces-25483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A25B82D0EF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D0B214E2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5C2900;
	Sun, 14 Jan 2024 14:37:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462E39D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fedd5e6beso72886145ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 06:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705243024; x=1705847824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wt6VIBHV5JomMb6G/SAzgkJ/CF86v9+FpIHEpcIi30=;
        b=hixMNTn8on5stYFsa1uIzDgCYlEEx5ojb7kv6pofx0480/IkoOUJ7ys03NFkFfQYkm
         Db32/FH7mQOgQXL996c41kPt81eq1lKWp55NryxchaQ8+RtWVl/EomqaPQ0YZPWH7bO6
         meJt0D/3xoJ30OfuzytSBSYocr6AhxIUqGytLikHs/JO+CO2ZZ2W0r9RwfMnI1VaFGmS
         iDlOKfsP3vXMiCevHbsX4Gy/0vvBsySp5k/KJfIBbmipU7JXBJJaoqZu3b0/ZDBp5fcd
         Lb7qteIyjqqcOY1af8HoqoVd+XRD1ziaiDtV5Yl95Xk106FzB6OJEar+8YscCdgmd6x8
         f7Jw==
X-Gm-Message-State: AOJu0YwF1geJxjXmSZ2VVc+CX2cPGra/ae71BkIlpIvA5q5NJPgAQFus
	DX8+E+lyfYYpbRgVK+0yCJucbY3XRG698Y9rF+u4CWMBilrf
X-Google-Smtp-Source: AGHT+IHZJp1y0/eT4Y5XcGEZHHluMb+1c3lYitvG1gsjKxbDv/arVmEig0IQH/tbT08VemxEN1ZaDQXwh5BN04ZeASt4LhxR5rpZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:35f:d260:57b3 with SMTP id
 k10-20020a056e021a8a00b0035fd26057b3mr398021ilv.3.1705243024532; Sun, 14 Jan
 2024 06:37:04 -0800 (PST)
Date: Sun, 14 Jan 2024 06:37:04 -0800
In-Reply-To: <0000000000005ab984060371583e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbb70f060ee8d44b@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From: syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127944c1e80000
start commit:   4b2b606075e5 ipv4/fib: send notify when delete source addr..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138aad9e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125e0b92680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Make handle of hci_conn be unique

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

