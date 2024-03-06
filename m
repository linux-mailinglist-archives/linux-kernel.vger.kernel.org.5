Return-Path: <linux-kernel+bounces-94635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADEC874273
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131661C21AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773B81C2A8;
	Wed,  6 Mar 2024 22:08:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745911B952
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762912; cv=none; b=K4r89xoS6YGox0StvSZtTZAVtXZszX7BUdFkli9DtzWUc3tcLVZG5x3aHhQ94/aD2amBeVY801sOhKZSCXdtYAD0v52Hud+disy26Ub5nmaSrji2JL0j+lFnc31poJ1druc0xcCPPhaZ5Yz0vNamm2qGI5zxSGzUL6Dh5kOk+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762912; c=relaxed/simple;
	bh=jObsL/UNTrrOralMnNtL9QtuAbpVCZJ1k/FmyyBW5V8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fvj2nHKIjKts9RhhPsP7yhHdO2wvGYt2Xd0AZoowUpByquZC41ysxyV/EMlb+mXF6wuAnNQx32pheAZ2ioF8eVk8WCBvTysoO6cspIHBZgySGn1vsznTzfaAcpajx+/Ykhia0KSdFhvV+ZUb84egIgUDUDYzu++TZrj8AdHZGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c874fb2baaso35493139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709762909; x=1710367709;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dP5mf6ppaJeeeqDuDdgoLYu4nUp5wMZfTV0hczsj3VE=;
        b=pouhKv3ixU5y0mhamibM2CiBXt9RqDfXrbbjSVlL7nw3DSklwd/1J0M/568G2QozUU
         zwdI91WcEQ46+KeJZoD6bWT/E1xEQA39WzowWKCWVqTfnWHNlkJPkn7OqyWJmDbW9mOp
         4xVracbdF/GmVDeaaxZDXzu1yKv8uAzoLyJgMMh+bpKsHVQ4npIiZnp6myAqK+IZqnc6
         h3L8PDszMxABJqjNguROewYyGLaiYqGguNDrh7KJB7UBTJ6vz6Euu7fmHC3/CcFs91KW
         WbgiCLA62dZ+RIwYzhXmsnLZSFHLwGfix+8Tsse4PsIoYEuT9++YxUKUp+0+gOW5lV7U
         eWVg==
X-Forwarded-Encrypted: i=1; AJvYcCVmR3YQlZ8lOKMBOSNTjE+gA0mpbOYK1+XhHGzmXPIanbXvlKntaLh6uGE1exxMyl/GybChkuTLaSUtYXJ+cGz25womDKwbDfGi50G4
X-Gm-Message-State: AOJu0YyZK89NX11pOu/ubV0KIyh27Fc0SK2PUNtnePVNkBHSEL3OLKF3
	wIKwpICWBq7C55RtOkai8ru8REENWhZWS1ssK5SLA9wCzMJfkrM1pK39sWrYRlp2wwyiwOACaqI
	3yKx6OsF18Edfh3ObshAZqLrSRbcey8gz0Gup9GSgJ33EMC8wRERy+/4=
X-Google-Smtp-Source: AGHT+IFPqSCvF/0U8pDf7pIswMxHcFHvDUPvrvqAjK+q5PYCkNfskzE7xmuQEyTGAK8OtumE6ovM9gu4ZydBpcx5uQUSMQs6fwxE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2584:b0:474:76c9:b667 with SMTP id
 s4-20020a056638258400b0047476c9b667mr877556jat.6.1709762909035; Wed, 06 Mar
 2024 14:08:29 -0800 (PST)
Date: Wed, 06 Mar 2024 14:08:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7ecf606130532ae@google.com>
Subject: [syzbot] Monthly jfs report (Mar 2024)
From: syzbot <syzbot+list454fdd6114742843b8e5@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 36 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1815    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1621    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<3>  1031    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<4>  576     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<5>  390     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<6>  299     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<7>  252     Yes   KASAN: null-ptr-deref Read in drop_buffers (2)
                   https://syzkaller.appspot.com/bug?extid=d285c6d0b23c6033d520
<8>  144     Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  130     Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<10> 87      Yes   kernel BUG in lbmIODone
                   https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

