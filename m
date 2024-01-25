Return-Path: <linux-kernel+bounces-37921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D983B7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1A6B2552F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F21748D;
	Thu, 25 Jan 2024 03:17:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F66127
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152625; cv=none; b=ie89XUDycNNH6197oJFG+qttnN2q+mhVjlLU7K6PC8hvwFBu47INn87fakqZ8iHMRmaIpPu1/doXXIgMpkc4Z+za/z6YhK4+yZ4iJwFzgstgd+HvMGGea6UwxjaUDVrG7TclxtSaJ8Gzm5VCZsAtCiU8z3tCvxOSiEw+eDOG5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152625; c=relaxed/simple;
	bh=3b4QVeF1pYvzutP3o1SR8RZDpRDEWY4FFGHRQYxAq34=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LgLmHoWc/5CjkxIcN7NGkyHg0/FsCDqEaINSpgkCaulis5s7YlPiGR+/8aKYRNZ/e3OHT2dXhqBwAxn2WXvkA8KLrHSH2WygOmbuELl9oDYoBV6xis1OvkLJwrqyYCimhPEHIkAJg8uFuPbmHuG4DmNBX8W4CN2TVf8PwflmlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so910819239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706152623; x=1706757423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLRpZma8mtLPRBhL0fvyMPkNbwpSrpDOLPb1BBDBo+Y=;
        b=jFPl+/jf8xN0HqT9qEs673jaHmnTEs1r17P/LDHpePuKv3ddlfAXSSIsQdUlcJX2Uv
         vwgFbCV5gK0Pg+ltgcBRi5baSIwgns1+cj9VkufZ5sMR+WbhBk07+GcJdbHoIaj5psjT
         zJhWcHZSTVSnJ4lol38ZtGiWmYsN8Wq3V8kOHqye3B3yRvW7b7H75QQM/52VCLzcsHDm
         3i4uaXUKn5EMrZp0nBqTAqObBNM4IQErb/5z+eNQo1Qdjrh0IDTEXHWPGyut9KR2kR3+
         tYMgXBfo1xLQmjdOd+FoM5hCOd2XnOQF4Zzeo730VhFqXjpu2CYQ0noCavyU3fmG4XCD
         H7mg==
X-Gm-Message-State: AOJu0Yyj4wX861cCLVOowtSsy0WFa57QVLTNyq9qBeGrqeEDm18+zy98
	Ae6aKi/AQeEisG3Tw7RL6vNTs1RN0i7SCpXuG18+zxs5ZPKbxy9DJ2KWWIkuvxtTDMF89WCRBKG
	S2zNjlZZNkmeBXgpyNl0jv+H2Q9mZhc3uL0yXYknTRi7vR5qrqS/cUVg=
X-Google-Smtp-Source: AGHT+IHKRif9C2TVCAnTB+ddDTrv8NsXW4n+JGnOJwbfjQJTlgshEPUGDuOThKi5/ROZbD1cuw/iTate8kx83vH4uJP39FCE7aVp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22cf:b0:46e:d5b8:e1e2 with SMTP id
 j15-20020a05663822cf00b0046ed5b8e1e2mr11984jat.4.1706152623065; Wed, 24 Jan
 2024 19:17:03 -0800 (PST)
Date: Wed, 24 Jan 2024 19:17:03 -0800
In-Reply-To: <000000000000562d8105f5ecc4ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007cd5c060fbc9da4@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end
From: syzbot <syzbot+198e7455f3a4f38b838a@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1682e45fe80000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17277d7f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123c58df680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

