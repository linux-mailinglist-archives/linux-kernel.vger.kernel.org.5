Return-Path: <linux-kernel+bounces-25411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B882CFEB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA33282E31
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7755E1877;
	Sun, 14 Jan 2024 07:18:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C521845
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35ff7c81f4aso71869675ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 23:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705216685; x=1705821485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFuCfXt+BxUWXTPpDFo62pMwYcUozTAUPCD33bbohME=;
        b=W4dqauWlIKSW8Z1MRCTSnt24e24VEgs2yvNtnqabg7MJoXtnK85aY6lEShjB6lMX9Q
         tvFV19lbTxXZ/RknK5R0V5gGNbbVeNuK1FjUTXEGMZM1UiEHBjH+z3lWERcRXK2hP4pi
         6ZDYecFDLDONFOf0VrbuHwIVtTbMCoTmuhvxD/cMMk8XrKmVAZCeupTAMLeYPX8a7gRt
         1BgFRPuFmTr4DFlWg9i84NtApBzT9+I3DcL8WY6tbLoHrAfuTLFh5ZP5ggPXkmJ2qOG/
         leHyGE6eSq9RZOIFb2TtgeMZShkg6ELA05pBFt+d+rfYcmyGYXt6fRbUgGI1KCuTgwXp
         LzXw==
X-Gm-Message-State: AOJu0Yx4FOehmNV+Fm1RWX82VzfoZuc8r9PAel3Xd0MPx5Zdd9v7uima
	VdDnUYRGc9eIfaShmZ5b3M0xWAI5KFJDH++3+q0ipCn3xoL3
X-Google-Smtp-Source: AGHT+IGimRhoUIZge/Cefcap1amRLfI0F1bGWHGp+s1g1C+s2YzJZW/J5H80QFOHyQ2sc6MsZ6q2WFU0y1Lb49i7Bwlgo47qNbkD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:360:7c34:ffa7 with SMTP id
 i14-20020a056e0212ce00b003607c34ffa7mr516080ilm.1.1705216685063; Sat, 13 Jan
 2024 23:18:05 -0800 (PST)
Date: Sat, 13 Jan 2024 23:18:05 -0800
In-Reply-To: <00000000000027993305eb841df8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c746f0060ee2b23a@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
From: syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, dave.kleikamp@oracle.com, 
	ghandatmanas@gmail.com, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ec162be80000
start commit:   493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f431d2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1208894a880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

