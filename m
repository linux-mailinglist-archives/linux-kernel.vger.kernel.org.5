Return-Path: <linux-kernel+bounces-108159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B38806D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6FA2824D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5764084C;
	Tue, 19 Mar 2024 21:40:17 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECA3C488
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884416; cv=none; b=JA6ozUY9umTMCLyRW3ksdQO3mBwoiVukB0z8jYIWwtHoufn5hWp2V5txZWgAkqnp0Bv5QiLF7FiSAoUWk8KmSFipxyfcMYzkOueqfKiZIP6TGOqmwdV6R2IIJ3iHXE8s7Gr28QB1oRbe8hdq6i3SOtDQy+JbSHVV0UvnrThdFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884416; c=relaxed/simple;
	bh=yVqbV9I4KQrOE8IsFWRvVd4t6K0+gqhH4L65+1qybrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gim7RPoTmoHRQ5TlBDS9bWHAHx/NPMgoWQ+JeK0a/aqmUPXDfpE8obF801SVDcn92wtXLn8kG1s0uc77/TPA2Z39zC6RxDZ/1XrOfYF4ikgiqxmpxtRI47phGyc0EYwHV5o5Nnf8AqmLTKh4UoN9fcxW48t88FXdpmliUGlymmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso523945739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884414; x=1711489214;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltrpFHBofu3evE07fFVui1SM5lh/BzuuQCgwRiuic/I=;
        b=Q4H5KT5/CvWhWKLwf14OzJchBrnPo9wp4BhZaAZ8SD5rHKlG1xgq7BzynAw8tGJumT
         625QKG4pC7wstVkZQz6ULLSrOvwWlO9GN3z8n0kuK6JxtioVnd+NTO9nBTvpMEvo/XlR
         Xt62a0/TJrYS6HXcWoLMoz1n59uMVsqmBLTfiIMjA/OqPWxYMltmzC0tV87SwWX8ISrk
         INQHd8Qya7+3C+wc9524Su05ow5Pozon4iZvXYH+qVCDGsWB5svkpJURQYMoTYh2XtnR
         CPN1zA15jjynByOowEBx3haRtie8HJae0n9Tnoi8oYTjlW26r04KYwVCMHS9u/KFnKWj
         3gBg==
X-Gm-Message-State: AOJu0Yw1f7KB2pg9Z0LFOW1d+xjm1uh0/EQ8UYo2km7kZ2tJhP2l3cBu
	ZJj1fZDnq++bxAYFitq+fPvLNtrHaXnrwBOaL/JUxXoutA5lO61RQ5xGaNR4oZ5UIc+28+8sjBT
	7+cMvQGiDc+3zI2tgK3uclxNFjsM1Su+GDoEAf/0821Nzf4twaDG/akobMw==
X-Google-Smtp-Source: AGHT+IFaM8T9NU6XAvJ5PKLcBmk5UsZHAqEPS5/4DraOvIkWME8QvB3HGDUxlbiKLq2WfJKUDeTMWRY+ul+o9u/oTVoZg6QduK2q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2043:b0:476:e7e9:7528 with SMTP id
 t3-20020a056638204300b00476e7e97528mr193891jaj.4.1710884414541; Tue, 19 Mar
 2024 14:40:14 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:40:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7e3a706140a512d@google.com>
Subject: [syzbot] Monthly mm report (Mar 2024)
From: syzbot <syzbot+list86f7db79e418dc2ec105@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 8 new issues were detected and 1 were fixed.
In total, 42 issues are still open and 226 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  707     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<2>  657     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<3>  649     No    KCSAN: data-race in generic_fillattr / shmem_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
<4>  88      Yes   WARNING in __kfence_free (3)
                   https://syzkaller.appspot.com/bug?extid=59f37b0ab4c558a5357c
<5>  47      Yes   BUG: unable to handle kernel paging request in list_lru_add
                   https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
<6>  45      Yes   BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot
                   https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
<7>  34      Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<8>  11      Yes   WARNING in kunmap_local_indexed
                   https://syzkaller.appspot.com/bug?extid=691cb37358791bebebe6
<9>  11      Yes   kernel BUG in filemap_unaccount_folio
                   https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9
<10> 4       Yes   INFO: task hung in __unmap_and_move (4)
                   https://syzkaller.appspot.com/bug?extid=b7ad168b779385f8cd58

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

