Return-Path: <linux-kernel+bounces-6168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789B81954B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F9D288F93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279DE440B;
	Wed, 20 Dec 2023 00:30:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1671FB6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fa6cba91so86511339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032203; x=1703637003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB4yfa/gkpOsXJDXGczqw9b/EB2d2YrDYws3LKmd3wU=;
        b=OJWEGmEdsZ1CACm7vMLv01kykQSxyEAHeAJc4nItvneTuOKJ03FV265q6HjeHRDsZe
         /q20QUjHJ1MpbL6GoZWM+8BnY18ZRerLdpJElIPFEeDm8pawag9GBW7Vdkwv2GQAiy9+
         b08db3T9v80+DrJe4Yqu0RwZQh0Cw9nk8U+kvovm0g23E24ZUOs9RtEK7SteXbp9z9bU
         JgvUT++tlfsesup0h+E+JnOtqBMjiw6KTVeojjrdPYu+MKr24Z+4AbvSNdx/QbSqNJu0
         C7kK/p3VP/oTuWgKRkYPQbDOC5cvNJKBCuZIEyAZgWWr7vRfOVcUBlNm3kEK3GOX3VCZ
         ENKQ==
X-Gm-Message-State: AOJu0YxdmYSKYP485nPQGiSnCIPndA9nJ508nkrxEZlZD3e+la3DdMBM
	ZeqOsxBu5hO9LmO4Y7m3jB/P48vqielQO5mXafHrezIYXSlj
X-Google-Smtp-Source: AGHT+IGpzlanNXyUXLz8ztZUudG8cCibZeW7FsWjkwVgcLUP+171LFpbOUNnK6UdyNs02nKqZOrH9gU5Qf47KS6Z25X3dvBwYVfr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d93:b0:35f:a015:322a with SMTP id
 h19-20020a056e021d9300b0035fa015322amr999281ila.5.1703032203274; Tue, 19 Dec
 2023 16:30:03 -0800 (PST)
Date: Tue, 19 Dec 2023 16:30:03 -0800
In-Reply-To: <000000000000e171200600d6d8bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000847160060ce61580@google.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
From: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
To: amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1e8c813b083c4122dfeaa5c3b11028331026e85d
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 31 12:55:32 2023 +0000

    PM: hibernate: don't use early_lookup_bdev in resume_store

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b15592e80000
start commit:   2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b15592e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b15592e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f9f61f96525c62cc7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176a4f49e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154aa8d6e80000

Reported-by: syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com
Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

