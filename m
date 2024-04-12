Return-Path: <linux-kernel+bounces-142707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03E8A2F34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3802D282266
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F0824AE;
	Fri, 12 Apr 2024 13:18:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C981ABF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927903; cv=none; b=QkZTP7EKyHXPSagt/vp3Oh3BtR9p68ALNZYvc0v2ZKL6BbiTOzgTDxN+n5OlppHkci9VJWl6QFVwjH/jnt9NnHbxha6+JivA4mhtuhTdmmZIf10JuYp58oO4k+SQFeSpWn5zQ+y4T6w98244pfdqVKfpP0T6hrwvCwGo0ET1W1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927903; c=relaxed/simple;
	bh=8paOf1b2ZdWmbAcpzi5dPqOHFQ4WfKdYlsrMjVePZ1g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z4XE9aKrEKVf8DVzXX+gJ5uiekUD6bgV9nL/UZBPAeNEmjQryawi7Dl8JTqnGHrzsRM+/REG15PK1pzGMMb8oYJGpgOpZB88vCZpFmpN2nnqGza064sQxpE9wS/A4Rw/tcDj7mxC4tZrDOKBZFiqWyu6Q/YA2YzaymS8zwQsZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc7a930922so115944339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927901; x=1713532701;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3cHTthowrpp9xIJFbk6MbY4tgEyPpmEH92M1HEhhi4=;
        b=ggujKLZTaDDTM6l1EJAYlCmBbhpsQnqB5pC4dSZjQVnV8tYnRqhIiN8WwtYjRotbdH
         iSDKHedn7SxF9eT35wkGVK2wKI85IHx7wblYs6ix/Sz+oFS4IIdIlKJkdJveRnPS5KPY
         0GK1lNArtJ5OigCOe2ThzKieDjbUw1SHNVkRYi7vi3noOrp97cF35FmaijBzMFhVqgHi
         EPzNdveISv4cmdP3Wfw1zvLtgeriOfpKY7uJ7OahHw560RS+aj7Mn9i6L+lj25I8LQoo
         d7Sju0gUbJL6maDpS1wR6BaM2QEX4RmkvOlS8vnu76fd1OW1q3NLlZU6zjK5E7BFB7r9
         u+pA==
X-Forwarded-Encrypted: i=1; AJvYcCWe17bdzvS6yi72THV9wBgvlQtyrGbncgWMLlNlwVwqk5Dtlz4HiuXjxgdiq5ZgMJyRowwBJnrT2JDJSw5hLAZLanZBLcbOFfSn7OzL
X-Gm-Message-State: AOJu0Yz/Zpo4ozYcrudTxKgiOA/822ch0BgUIMdjOnwJGt1F4eCRsklk
	DTiPB33f5EzHhQR04GLGr72lP1mEwpBnjMbQr5yq/LFQOafwlCbojNseYuUxwQ+bhn18evOJB8b
	bSbkG7Q4OFm0wuSd5fsA9+6BQCqFd3J8X9vfqu62w4Nq6TF0Sf6oYLFI=
X-Google-Smtp-Source: AGHT+IEMAfwHuimoEKjZt2qj0wf7iSh3NykVvAIrOhyP0+q3Nt3cW3irN4/F48Acaa7IVFZSN/tVZnCUIvaFeZJc4rG5bSLCbLLR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:36a:220b:4078 with SMTP id
 k9-20020a056e021a8900b0036a220b4078mr181862ilv.5.1712927901318; Fri, 12 Apr
 2024 06:18:21 -0700 (PDT)
Date: Fri, 12 Apr 2024 06:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000158d280615e61beb@google.com>
Subject: [syzbot] Monthly ext4 report (Apr 2024)
From: syzbot <syzbot+liste73a7dcf846b305a7eb2@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 1 were fixed.
In total, 27 issues are still open and 131 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8793    Yes   WARNING: locking bug in ext4_move_extents
                  https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2> 706     Yes   WARNING: locking bug in __ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3> 435     Yes   WARNING: locking bug in ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4> 151     Yes   INFO: task hung in sync_inodes_sb (5)
                  https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<5> 33      Yes   KASAN: wild-memory-access Read in read_block_bitmap
                  https://syzkaller.appspot.com/bug?extid=47f3372b693d7f62b8ae
<6> 20      Yes   INFO: task hung in ext4_quota_write
                  https://syzkaller.appspot.com/bug?extid=a43d4f48b8397d0e41a9
<7> 19      Yes   INFO: rcu detected stall in sys_unlink (3)
                  https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<8> 13      Yes   kernel BUG in ext4_write_inline_data_end (2)
                  https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

