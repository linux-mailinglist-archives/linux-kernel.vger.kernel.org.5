Return-Path: <linux-kernel+bounces-100026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF48790FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE041F22EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF97994D;
	Tue, 12 Mar 2024 09:29:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81D7828F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235771; cv=none; b=gqjjNeRdsoANS+SJy93lProCKUVVRe7FjVaxiCB0mnrjT1u40UF+t/Y5e2sgfD6aShGF7fxr7WmxMMX59/oq00cC4VTc18voh65EKGPAAF8JRL9dZSyp5o75aauBjGLnBY3c9GpU+g4uAituTWvIOLnO8RFBwQM31YUxWx9QTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235771; c=relaxed/simple;
	bh=ehWpkfkMr4Exik6vYYe2yGX8sbZqG5YleARftCleK0U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nmH2oR3vOFaiZ9qx/32IBpBSsCUM62hpBUzImS11Bd3HqyNJ5ZqLd5u6+zhhQ0Y1+AKtV/wPBH2pl+aE9iDHbTalc16Oum3kMJNw71oCwVYWawzRBRmE1OgKFT65etrcJtlIuzcFhUcs4hT+GYED9Ny53g0O38uZPLqfQmk+GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7c9831579so573199239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235769; x=1710840569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFetsjEr0kUioGW5XrIiMJoGBxEPtRzAwYLRDfXTaMY=;
        b=ItsyVpLPUBE/9BuGs/kf71j6CJpGBxtIzIMx1Vzf3reAjtIoDzz0kDZBocJeuNZw0r
         Hv8Q5y6zl5++5NdT/6Ora72nEht5nBLyM32RLph6ZHIGReLP5yZVwX56gvb8owa2Jrep
         gO2HCKlRGydV16fIAOuL9Wk9zSn8gOG7JL5qE3a5K9hqlUZVBQox4oz8ZiuvLqJSURLd
         v/pGeTjJh0aOEXBbhVkMz5rhLTPOTJuFI+QnLzu5WfvTrVOFJ/2U6IDAgNQwkKMwgLma
         k35Sv50rJU3oRPx68sHYd0h9VXUmSnqin5efaCdpiM+RdID2Q2imFTcYyH98L9Dlakv8
         ax1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCGo6/x+OldsFrNJ0Vb+lQ8wAAE5TwEFwBaY8/33u+7IKC+I3cAET6In4ucMx+RxlmtdQb98RlQYkjOK4Csm9Bk0UB/2RafX/ZQYdz
X-Gm-Message-State: AOJu0YwQKNJrgRfVmiimiq3UHLVLmGCAzBcPtU1LHVLDDUiN2pAgOipm
	ZoZB9oFCvmdKmMikSNx8xPOP9gOdhNeI3rGNl77iAXRdWn9ulsYR7A8aL4tnE7cnxWZT3mfalXu
	Dyhc8G/iPX6+7hH82jNzLmk5dRCgA/p2CsWqKEmvLrB2dURU9TPjy5gQ=
X-Google-Smtp-Source: AGHT+IHhz/Axrt0zZCKf3PniY1Mh1aydPtxkbDwqNPaTDtF0sB8pBoy7STMPAKzoXmjYPCvamqPfzoT6Mma8+3/tz7bzOG/dk9wy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1506:b0:476:d5dc:b729 with SMTP id
 b6-20020a056638150600b00476d5dcb729mr93611jat.4.1710235768831; Tue, 12 Mar
 2024 02:29:28 -0700 (PDT)
Date: Tue, 12 Mar 2024 02:29:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bfda60613734bdf@google.com>
Subject: [syzbot] Monthly ext4 report (Mar 2024)
From: syzbot <syzbot+list9a35871b40c53fa1b44b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 1 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 130 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8629    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  697     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  401     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  173     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<5>  81      No    WARNING in ext4_write_inode (2)
                   https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
<6>  23      No    possible deadlock in ext4_da_get_block_prep
                   https://syzkaller.appspot.com/bug?extid=a86b193140e10df1aff2
<7>  22      No    possible deadlock in start_this_handle (4)
                   https://syzkaller.appspot.com/bug?extid=cf0b4280f19be4031cf2
<8>  18      Yes   INFO: rcu detected stall in sys_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<9>  18      Yes   kernel BUG in __ext4_journal_stop
                   https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0
<10> 7       Yes   kernel BUG in ext4_write_inline_data_end (2)
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

