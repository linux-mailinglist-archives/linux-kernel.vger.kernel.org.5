Return-Path: <linux-kernel+bounces-28713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A483022A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241141F24E97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F91426E;
	Wed, 17 Jan 2024 09:21:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFC13FFF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483282; cv=none; b=KGQZj7MPyWEUOgMsrEFLDpuyF6Ngl/GX46o49h1G1nXH5Xe/3W+vWHTM8dbUTi2fiI3u4uJojaQIpsqt7d7ZJjq1v1y6sCzpzcF68AqhijVAEmqWsMt+cp5a04U+BIgdzAWZjfS1zxYMq2dRGSVnshfbGsFvVljezUysGm53MvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483282; c=relaxed/simple;
	bh=2XWUHbX8JT3cQhfnNQWQueZTLs7LDrMX25Hwg9wJjDM=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=A3dUybk9PpAyXsXBkZDGJj3QjlhP/l5loSqpKOZFpMpK0haGzVUtkO6BgYtFE/WCKSg3HiQi/csNJU/VYHWDRuvh0HJEbJ5vtIJiy4VB9yI0xcBCy/0EYT+mvhQLt1PYRhXLEcGb0+hwdzfWIth3J22MOIQiIP9BLWRdypxoo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so1015598839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705483281; x=1706088081;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFh/rsH0XQlYH+i9hmK0u1AnArr98LEzzQ9MnkFrr9c=;
        b=Nw2pkWA3CZ8QidmOPJL6EAtaYah5HaHKvQV9cHSPKyHOz6mCexaisWdOXWnBuQP5NH
         7VRL9vB6n/2sG9Bl3IP+BOzNMFS9vn81C5mFsC7CrFg3ZkpHzCYJpsC8KcZmAd7E5q7M
         ZoIaruAI04b+DG7NFvMC6PguDMXR5IBUqiLH9tPxofDul4PBppA/c1+4UZjjrVf3fbHA
         NguDj35bGLD98FlnqaANCwegYJdGiHOVUHCJPaTBjOSI0M32jZMCJzLXmTGw5qAlGEC7
         GJaFhZwt0JsnD44vdZ9bufRf9b771MnNNsXYpdvnwPxN/mXUKrbtFlhSJNg+wEV8ZtB5
         6r3A==
X-Gm-Message-State: AOJu0Yy/GnAFQ20WrwegKuY3AKtrhkWfF4b6ZOiDyMCrrTJtex2+VKSe
	l+M6fF2FFPB6kZFyqXskyBddjDOaTAulZO9q4bYvf1WrZceCgf4=
X-Google-Smtp-Source: AGHT+IFO/sjBgcgXLZGX2Lb85iONqhAvUeCWMbbHDRfetpnj6ydJHofb32n2Fq3tTiWwVgMgVZhzCD47nFiNoMTshzH+CMPPjzOi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:361:9684:be1 with SMTP id
 d12-20020a056e02214c00b0036196840be1mr76728ilv.1.1705483280881; Wed, 17 Jan
 2024 01:21:20 -0800 (PST)
Date: Wed, 17 Jan 2024 01:21:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020a118060f20c5f3@google.com>
Subject: [syzbot] Monthly mm report (Jan 2024)
From: syzbot <syzbot+list48ce08ed778c7a25633f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 2 new issues were detected and 3 were fixed.
In total, 34 issues are still open and 223 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7363    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<2>  607     No    KCSAN: data-race in generic_fillattr / shmem_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
<3>  489     Yes   BUG: bad usercopy in fpa_set
                   https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<4>  55      Yes   WARNING in __kfence_free (3)
                   https://syzkaller.appspot.com/bug?extid=59f37b0ab4c558a5357c
<5>  27      Yes   BUG: unable to handle kernel paging request in list_lru_add
                   https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
<6>  24      Yes   BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot
                   https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
<7>  11      No    WARNING in __gup_longterm_locked (2)
                   https://syzkaller.appspot.com/bug?extid=f2577d8071a92e596253
<8>  11      Yes   kernel BUG in do_page_mkwrite
                   https://syzkaller.appspot.com/bug?extid=cfba1abcb2cf7b39a320
<9>  8       Yes   kernel BUG in filemap_unaccount_folio
                   https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9
<10> 6       Yes   INFO: rcu detected stall in dput (8)
                   https://syzkaller.appspot.com/bug?extid=eb9f416500ff134ab699

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

