Return-Path: <linux-kernel+bounces-127448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E2894B85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB701F23B03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492929437;
	Tue,  2 Apr 2024 06:36:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF024A03
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039787; cv=none; b=WYen1Zam8VzlbN4x+NeO0PlqVohUOqOJgH6CGx7wO1DrjXRHOFtwfG++74OKe1C0pSXH8UmL2w3qj1VBhAtPNH8P0N1TCXdW9nk09xLArnfiEqhFI5a/xDpMgkoKKKeMmRhJw4/awOxlw0vL8foLsNlmuSyYngy6Q2U8t4DNoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039787; c=relaxed/simple;
	bh=UpNhgPX5pJk/ucZAJ9d2nkFuwOYtfcnkbRYGSoOgZQw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cdp4sK4eIb3PV8mG4/SN+os+i0OU+G/G+UeQ99icQs33EqHnIva5UFgKploSuewUldZmTDHwGUFVYiaG9EJxtzLdf9wF2ycm6iTTZWK/aALAkY+HhCS5Wg9wG3SVIh7e4kLZkq+1BuDy5Q1B25Ia0TvvpNmgLmmaiPsHjr4BQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so514642939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 23:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712039786; x=1712644586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGgcl9N6u4wFnOxqWzVNRb0CjVaO5JkGiuxXchA0GQk=;
        b=CDgi4x9VulCHqD/CSF1f/zLcciE8a5ixmh3OaWrgb2J9DBOVSMs8gvPvHsg3eoMiuO
         WYvDesY72qz34blzzXg/3uuQIhrRN1uHSiXcYYlwkB+IW1YcN6pWLURW17Bd3n9Hrzxz
         Evb6+npb2z+XZ0YAqQu/dOFXR5M/eNtOWRuzD3ZUxiLoAKRgC1WlOvj+Ao2FKlBKBDft
         5Qp/YSmyUfNpHecMwfY2J+hEayVkaD8K9jMkSRO1Y/JYaQ087zTN8hSNjHJDbKDtmze6
         oOjMioi0lkLWhc/JfFos1h2v7FmCJ9rI8Rtw8VZj3VBvj1nxJP/RFY2EzuSb/3vfFdOl
         a22w==
X-Forwarded-Encrypted: i=1; AJvYcCUuYuoXrGsYhmgmV23Ry+/dgbSBhHn4E7VgtFWxRbWmj0asFYVqWTp7hcR3YT135BEJmB+QaboRU7h1Gk4Lf/D5TBlT59Bwp4Fa9g5t
X-Gm-Message-State: AOJu0Yytcogio9RAqbWDm4ksrza8Wn3fWhW1rM8c/lXcEqQt6u0Elhwj
	0W84ccvu/V5lJYjTQM1D6/xsIyf0D1eB6ZG+IJ1mbDg+2xiyxsAfC/Fw0SBtmII7I9w7MvcUqGT
	m6FGNXe6OGshVSqFOwjNdbgQlBqqp+PmKgum0tWhH2aB+fgNBxUW9HPI=
X-Google-Smtp-Source: AGHT+IEYEj6d0xT19iBjCW1jFVxSMYZmKm6iRawu+ptTIk8DytC+tb2aDqS3iXamWTGcIVzecHQ6ajlR7ZhU3e8ZqeewW08gnmN3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b07:b0:47e:c09b:69e with SMTP id
 fm7-20020a0566382b0700b0047ec09b069emr472329jab.0.1712039785822; Mon, 01 Apr
 2024 23:36:25 -0700 (PDT)
Date: Mon, 01 Apr 2024 23:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000468fff06151753a0@google.com>
Subject: [syzbot] bpf-next build error (6)
From: syzbot <syzbot+1f0620b0141e43a84282@syzkaller.appspotmail.com>
To: ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e478cf26c556 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168bc92d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b667bc37450fdcd
dashboard link: https://syzkaller.appspot.com/bug?extid=1f0620b0141e43a84282
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f0620b0141e43a84282@syzkaller.appspotmail.com

failed to run ["make" "-j" "64" "ARCH=x86_64" "CC=clang" "bzImage"]: exit status 2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

