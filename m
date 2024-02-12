Return-Path: <linux-kernel+bounces-62391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE4851F90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82F4B2213C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530294CE06;
	Mon, 12 Feb 2024 21:31:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AB4CB3D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773480; cv=none; b=NSMDZpRAnKWYF9SiGL4CLQcpLxHi0oykXWtGV+B+fvZudgBjCQsmAHNB4O0XMp39uBTVxdAEpFcETESg2OG08H9IlNfD9SzcSW0Fwa2O+NsQNx+0Thrjd1+2qCZ+U3jKhQ+fgrDVP//Ctu+ht8+B1puS13mAJDrX9kXIXk1xuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773480; c=relaxed/simple;
	bh=UQhOjUdw/dNaYTHglly9JvhE3kjY99zNLtVVdnQ0dvg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OhFNcK2SDx+BuJQ6chfr7Ixtg6A55IDQ0df/HW9RiktdOr5AvZ6Nl58zsGaPNUIg+gy8wqaKHpkWMLZnhFoPYuqc8gqnvZeeXHR6GVC//VRvTmn1D7IOlir/MPAzt3gdqnx1DGMtWQQ2PTRxIlWi5pUdID43Urql4So7Q24ReJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf863c324dso293816439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773478; x=1708378278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtmheStau3mxfam7XQ+ryyvhH3Em590sLVEpsnXD67c=;
        b=wgvce7QK47jdv+JL4S2ag8iaNC8opqDRlCeR3fvTcLrpqUgxO8Qxqcq8mPdtAS9i02
         afgAMpM5GDeLM4OLbYOwxoPZrIBV6nbwOjyYwnZkJPvr3qTt/qa1oR4fDlzd4hNj83Cz
         u1D7L82qgQYo5aEfqLPsR7IjvpcZ+KF3gFTKYND54UOU9H9yyd8ho3lPxE7PCCBYwjVp
         TOBRl1Vux3Pw3X6SwXJcqBO0jBkeNDUbp/SBls038YJtai2zvgfKJuL884PibZGEpOTZ
         2L+DVM4dHWTykIY+PkSWpw2aj/iIvXOCKrlkSIQY0tBVGjSkNKJ9nrh491K8NxNi7hBr
         79WQ==
X-Gm-Message-State: AOJu0YzCIW9rKAF6cPtM7WaWOV08zJ9Z6JCjyskSbOMVKiWEGepAv3hR
	wn1MQHWhZ9DTZVUkU2V/vsM76kBQ0YQU1LRKTJ5Edf8ET6QRGoAvOgzh8NjtGifx5r4u7EJys5G
	XbkCwM3LidXRLOoIMbzIYo52AtGWygCB/+74X9EmwrQEeTt3WKqmMAyI=
X-Google-Smtp-Source: AGHT+IEH6UT8andQy2alHnOHYSMdxEM0YRZG5dn+PzYHsOp7m+bGo8lI7FpcJITDJtjKw3aXxp0I5EHa+9TsxKZmfUZFD3JCLnuV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:360:134:535e with SMTP id
 m15-20020a056e021c2f00b003600134535emr47776ilh.1.1707773478642; Mon, 12 Feb
 2024 13:31:18 -0800 (PST)
Date: Mon, 12 Feb 2024 13:31:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d2ab7061135ffe6@google.com>
Subject: [syzbot] Monthly fs report (Feb 2024)
From: syzbot <syzbot+list814f946788f272e19d6d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 5 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 338 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1114    Yes   BUG: sleeping function called from invalid context in bdev_getblk
                   https://syzkaller.appspot.com/bug?extid=51c61e2b1259fcd64071
<2>  231     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<3>  203     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<4>  92      Yes   WARNING in do_mkdirat
                   https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
<5>  67      Yes   INFO: task hung in __fdget_pos (4)
                   https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
<6>  61      Yes   WARNING in path_openat
                   https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
<7>  60      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<8>  34      Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<9>  20      Yes   WARNING: proc registration bug in bcm_connect
                   https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a
<10> 8       Yes   INFO: task hung in truncate_inode_pages_final
                   https://syzkaller.appspot.com/bug?extid=b6973d2babdaf51385eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

