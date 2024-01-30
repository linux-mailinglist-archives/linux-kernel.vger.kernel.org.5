Return-Path: <linux-kernel+bounces-43711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718D2841835
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7B31F2324C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB4364A6;
	Tue, 30 Jan 2024 01:15:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419F36131
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577307; cv=none; b=H3kgouTs92JBpJMtFv2PXnaVr+XseoGWepqPwDvHtpXK3gLQvJnL+hxvrpoTnmxNstkwBcwXd7Ju50sXCZVovZHui52PIHE09S1eSaz0q5hc5TKDXZrNL1MfcOCjJx/Tn3g5f7GJKDjOWkG8vKU1+j+cndgn7KCcAMLUG5Bho/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577307; c=relaxed/simple;
	bh=so5QSURj/q00SmuR2nUtVzf/xhC26xqT1M2iaUkim7o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q4wrxjqENHe7MmNpBgNap0MpHTBY0+jf+1SjBivaG7RvpAlB4GswEQbo1CtPNYgXC6t/Z3WyurwYD4t/RNXo5GnmhrnVOdMXJ1sPA+HXZ095Bwhzn68ZqP/kybPR+dhBD5hk3OcnxZ2gBKfJcK00+9dorKDacdzhZ8GVtt7mKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36387d42a2bso6488095ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706577305; x=1707182105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdc7QRCS1wWTEvEeMyJCa1mkMkOnCjLZGW3fF4GUftQ=;
        b=uhx+z2G3bub2BQ70zRGSUAi25+a/jPGJ4ZI3zVmFfHXa0ZkZJmWfbcC24fiXjNoDuq
         yyfaylmn6Ao8XNYNZ1swrOKgBl+gnQ50dLIUrhRQsNzbmqRc7qOdAKPPaQK4WqCKHY0Z
         aTOkEZF89BshvHoA4tV2SkWyYMyybt+lNqQSTF2P7W+CMNSyYhBjXauU+uzpMJIWy9wB
         Wvbw8FFOrwzOexstZufn2hVfBX14ua2/Bi8huWnSo7Y8M2k7s3YI05ht9CAyeajkqvME
         Smj0AoCOGuRhe1+hYdt59WRGy8M7TpFtCJJSFHqjRtix6EflPCrGRM55FUmGuvfL+XmO
         ybpA==
X-Gm-Message-State: AOJu0Yza77ywwHxG13jIHeTg3vdzarXGzl+bfUUz2sEx31QkO/prHfWy
	l0QfdiUp03zYb4Pr/TVCIKgE3swrNqg91I2AlgkrXyAmV9ZGNzkv1m4zPy78Ds+6jwG4wDHu21h
	k81CsZkqBdiMELtVhA4WGM/zV99CgIKR7WKDxuMgejmJBIOQIuIj7eKk=
X-Google-Smtp-Source: AGHT+IGn0AzaC4C1QZId4smIBYuQ5/t0fQDXBqD1mncnniCGd9BefJbroW9fh+2Eid9SeO85H4NxjyY1fgxiiWZjOvog2uyErRl1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd89:0:b0:363:7bac:528e with SMTP id
 r9-20020a92cd89000000b003637bac528emr467514ilb.1.1706577305077; Mon, 29 Jan
 2024 17:15:05 -0800 (PST)
Date: Mon, 29 Jan 2024 17:15:05 -0800
In-Reply-To: <0000000000000ccf9a05ee84f5b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d130006101f7e0e@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in __getblk_gfp
From: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	chenzhongjin@huawei.com, dchinner@redhat.com, hch@infradead.org, hch@lst.de, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116642dfe80000
start commit:   d88520ad73b7 Merge tag 'pull-nfsd-fix' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd
dashboard link: https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a77593680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1104a593680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

