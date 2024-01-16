Return-Path: <linux-kernel+bounces-27531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E19782F1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09462285A86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C91C687;
	Tue, 16 Jan 2024 15:37:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97D1C298
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf4c4559daso142393739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705419424; x=1706024224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IxXmg2QTH1uWatAty5Se5XI+hxlkbNQTXE25GkvfTM=;
        b=GKJQyBq5rM6lwmC1WFDxCdkIOY+rgnIFjKw/Mq9jmqhHCtdMj467KYm+fmvNm074lp
         QCCZTjMsycA5hkAU8TAa/n6ipXMJiwjEGysG2sBImz12JcTszeHSw4iReb9llv6hLUd5
         FYUJmMuFMtOS4TNzEGXstqnBvEm9SocAS7V/sZN8QK1m9gKfrFKlFvCjNHYDIiwyM0JA
         Mst2qfSgshPi2yfwguvTeWnzC/NP1ba+Uu/wx2WPS10tm0N7dQwtDPFzBMs1csJJL99d
         +DKkSpuv8LpUmwNdtCxtmF4mTd1/2c/1FXXdBgN6OMBAV2k1ZMW3mp2CpdoAb74J+v1g
         sr/Q==
X-Gm-Message-State: AOJu0YxehZDddPDNqTIkpM4pIJJS1ZJZUQSCRuha359O2vFcnnwB7LAm
	edFEawBHb4Fk6QNzJ33xt7KonP2jZnERf1pFP1NrDx4hel5/
X-Google-Smtp-Source: AGHT+IFkr77m41MddNLivOqVYoFsRpCfpZaVtjAZlEHbGZMEqdO2VMYndx5OOcv+/QAr/YvNJs/1Bvf/czPIeXGWVZJjNamsryFO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b12:b0:46e:3890:4cc9 with SMTP id
 fm18-20020a0566382b1200b0046e38904cc9mr531817jab.4.1705419423891; Tue, 16 Jan
 2024 07:37:03 -0800 (PST)
Date: Tue, 16 Jan 2024 07:37:03 -0800
In-Reply-To: <000000000000743ce2060060e5ce@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f447a1060f11e6ed@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in find_inode_fast (2)
From: syzbot <syzbot+adfd362e7719c02b3015@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17852f7be80000
start commit:   2a5a4326e583 Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d5e7bcb9a41fc9b3
dashboard link: https://syzkaller.appspot.com/bug?extid=adfd362e7719c02b3015
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d27994680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

