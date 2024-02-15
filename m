Return-Path: <linux-kernel+bounces-66900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8AF856358
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C583C1F22F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89212CDBC;
	Thu, 15 Feb 2024 12:38:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F412C53F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000687; cv=none; b=hyALht58jc7hWiT8pMyqvRfTCZbCyYqeN+JFmqL/KNYY3hoGo4iyxZGc/21hkda4WTxGbbNKT5BfZJ229dD2iDXNJpJiDSY8cT6aNjI8fezeEkYE912a9nmPpg3REpBlrJwenY5Cw5djX+sOjLF0SZr9JVBoIOjlq7PJeRCxmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000687; c=relaxed/simple;
	bh=LznutpEVOxHt4TsC0YpPkpc5D9HK8cOlRg1tQl6qTLM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mYLR2hWgbIkWXQHk2lwWSrzMHVGfr7u4jsn0k1JSP7NtGiGH814748+KH8zb5bYYHTnqso8LIA3ARwrk+2caHV39hJo7Okbdxa0saBupWb4C5HFyx3PfahFMGTaJa59tV3AjHJ0Vr9NJiNGcqraqfl62NB8LHtdTzDh++iMNI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c0001148c3so58957239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000685; x=1708605485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4EiGIu2mTjtQ2BKESlH87IOtFfw0dlvPHITGr5W5T4=;
        b=ErkDTMrJ//3RlNAD5xBnVbonY0O9pMRQUarfPO+zhqmXcH3mrz66Kos8qgxUlRCOc6
         vHHIEVK905w+zaJlJ8KhmALpzMXIRiS/F/vV3bA92cYXZ08iWSuKWF/oU6MNCRpi5p85
         aOkvi0vSjDuuzA0kc0CeWNP6mHDiayxJ1/rVNxwuCbIhQJtwCk9AjfHoWqUbZJJMbqV2
         ye/95dqKB1FlZedOHlt0bPh27JM1AzAc0IC6fYFetFSGHSR1BbYzWQgeh0UvFnmq812F
         vZrNje3b/R3dUDIL+/Jc9XBir9S2uMKr78iwlq/TTDyGrkMCCNMJzuV7Susv1YqbfCCB
         CR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1j+lX5R3hsAWba8P7hZ/VaMgEVIhCgQ+fjbretmViJMWw8A6N1lIqhAsXLajTbSXhEgcXjHF2uYWnaysjzev6fBI5HKs8WppQNx0V
X-Gm-Message-State: AOJu0YxHBwRVg+2I/tPRCNdcTQqTa12bAGjI4y3CDyWTIRcsobwiQTvQ
	n3o1AYGrrJp4ViqxpKd8e60S4bTGOC+6ek/XeC3SZ64HTVPqxZK0tHhp8VbE8FggIX+TWnsjQ9H
	x+m3Jt84Hi3xRVhNpQYNrCPOWTifZETdMa2ZfyoCHqhe5tLW3t6h2cM8=
X-Google-Smtp-Source: AGHT+IFL92pJv2bjiJRhXIiR95FF9dQns631ia4A87d6518YNfgSwHqS1NKPmdx+39TqBAEzlU9IOeqWxjvpkl7HaHm7mH6Rg4Wu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4387:b0:471:3c6d:b574 with SMTP id
 bo7-20020a056638438700b004713c6db574mr10331jab.4.1708000684861; Thu, 15 Feb
 2024 04:38:04 -0800 (PST)
Date: Thu, 15 Feb 2024 04:38:04 -0800
In-Reply-To: <000000000000a3818b05f18916e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018f2c806116ae6d3@google.com>
Subject: Re: [syzbot] [reiserfs?] BUG: unable to handle kernel paging request
 in reiserfs_readdir_inode
From: syzbot <syzbot+3f6ef04b7cf85153b528@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ffd320180000
start commit:   534293368afa Merge tag 'kbuild-fixes-v6.3' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9688428cfef5e8d5
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef04b7cf85153b528
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138d82bac80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123fed2c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

