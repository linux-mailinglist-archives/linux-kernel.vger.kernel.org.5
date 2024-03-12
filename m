Return-Path: <linux-kernel+bounces-100024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D078790FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017DE1C21A04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652907867E;
	Tue, 12 Mar 2024 09:29:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D567827E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235771; cv=none; b=JvuhZuapTIx5W4Rv2ahHQgg/ql+ttn96dywSpUBATB8pRqbHduM3EeDrKXSr56woeSgcZ/Y2P/redCCXPCcisLqCl4p62/KI/AmIB/Z2wFhePaJC28EnDo9nc+f+otC2ZRipgbSA/LFL7w6pjrFwmuHl2/b/nQBmHCNkFxaEgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235771; c=relaxed/simple;
	bh=oQ0fJgicIcem3o+93r+NoNpV8EvVrbBZcKThJfj+4/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GadtodNScqGDX+AnVIvwgdxZsfYP1hZX7NDQegdVrxQu4P63xgMsKDrZ/tiAmLwI4zOMWAWs8LPqY2TbcmS9dorQYcf0+6fGF8xBIuu9rzZYaoZzJKHm3xzNhYnubIhC3qEWgBty/69bSDeE7nRzuENYeijJ+ZRZ800eLvaVa2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c874fb29a3so475789139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235768; x=1710840568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Hr30nM15V8weJdzXLe17u9zEcaYbFDWB4eVxhT/QoM=;
        b=IbF5NA9LbxuC+fYhQrH792S6OpabjJ0UFHgGjXk+Ye/kxZ0XFxCZSgD3dQaYIz6kAX
         0+SPSojeL5XljpgweSzpZ0v32eSZNWyotrvEVyXiDfCv2JGmJJ/jLn7dEHgPWuxSie8e
         aO6J7w6CCUxRdyQDv/f38tUFstKdVFv5J5AJvebn5wbRKNhS+U5F8LRqnrHp3FQibzVY
         Bf8E3s4K9l0Dy9HYnwMntF9Itp/0FMgz06gPrBv0ypMOfDRbiaWZ8yFvbEpsoPJXVdL2
         RXa4tVXM1MO5IhXeYDHPLzEr4Z3GZUa8t2yXe0Fql6rSJV8WxqvJBuXk10cMt3UcbOwq
         M8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX/Cbr38tFpuTaRHcPc2k5aGBXZDTY7OV/mkFsr0czGV1snfQla9A3S4Hlqai3ZPEvxLehSG+QP4vJnbum0jzNZxSlZg0dZ07VniOVG
X-Gm-Message-State: AOJu0YzWse+OZiZoyOKjglklB5NO2Vptm4rJhmSgsxbM3oDXzqiVUpaq
	QtJHjnK8YMUT8O7ZfoZlCOs8nSMhRA7scC5+US0MlI+etgsvhDh7zilcn08NqhkJK4IB7slQm0o
	R3b44rpmeL1iqvDiBrkI2nNmSQI8/p0h6CBlnAAn1nKwUb6UiX/1ngug=
X-Google-Smtp-Source: AGHT+IFpGY0Txi0H6/WYIqz/o0vuRKBmWq9Kro6R/BB9NeySF7okP8eDmbMonH9ZELZDRXw2T3W0PFrWmX6GQTAhoRc6fphm4ie5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3424:b0:7c8:37ac:23d4 with SMTP id
 n36-20020a056602342400b007c837ac23d4mr211808ioz.3.1710235766610; Tue, 12 Mar
 2024 02:29:26 -0700 (PDT)
Date: Tue, 12 Mar 2024 02:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059e9150613734b41@google.com>
Subject: [syzbot] Monthly btrfs report (Mar 2024)
From: syzbot <syzbot+lista09af84377603bde66b5@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 39 issues are still open and 52 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5822    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  2942    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  301     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<4>  261     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<5>  226     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<6>  145     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<7>  111     Yes   WARNING in __btrfs_free_extent
                   https://syzkaller.appspot.com/bug?extid=560e6a32d484d7293e37
<8>  106     Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe
<9>  96      Yes   kernel BUG in set_state_bits
                   https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
<10> 84      Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

