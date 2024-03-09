Return-Path: <linux-kernel+bounces-97834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D74877025
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8B1F217B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9615F38390;
	Sat,  9 Mar 2024 09:59:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD537707
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709978345; cv=none; b=AyjcERl7pIuAIvI8fkonCLoB06qAMOt6XY9v8kYjf6xASZXioe0cB2BcX0GRyANK72OuBG6+fIALvdCg+4HEGU3ny7qw4AAr/9x8wXJUMgg6UsQacg9f6k/kAKDIIS4SxmHTC06YYBvmfwlyMwGBsOL1e2ZNlFThleK92IGlItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709978345; c=relaxed/simple;
	bh=asn96ezzDe7z4cS9Xr9t03l6ZD3ftiEfDmD7qxHPWR4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MIAV9+MfGDgYjXWsQh4Rt3rLslDZU3rdcNSRKZs8+u2CNyCJaL3ZX8EU7RxVAsjrChd4Aa84ucTtsagRXrvHE2jzwRo24UGZqLiy3m/ggg6wwia/jBMbRLOw7lVNCxdY08/NgLbapepplBLaJUfDvfctm2FZuDaOXmCL4GkLNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3657abf644fso28621005ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 01:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709978343; x=1710583143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVYUoCeuZ1fyxODvD3L6XZXHBvcIymgYiHpvfaB7YME=;
        b=O4r7mAhXzYmJdD7mOd64VbgS/dTUi7rmoQmWbUat12j2s8MihVcCfwGKyvM0rB/IM4
         h7OK3wxv5vcwYXFs9BBtANiFEX61l3qB9XbHPthhrr87Lr4P9dQY3ZvbXbArgoKUiGX+
         IBHvOMVS+UFgB8beG85x0zeqvKL3DXVFJbJqE92T/1Mv3L+ywRcWV9SccHre1pSNlhoA
         mw4/3RwulZkaPrPbfjYev77jmDsmnhCsL8bknBLGWNWw6d+FeXEOhYWZXulxkpERut+I
         RIE5ch5qMJZAEfEdzJMVRdJ7RSdGq1lJSpO1eG4nTAIx7xngM6VjIQxo4ZK+YBwNss8i
         Qnaw==
X-Forwarded-Encrypted: i=1; AJvYcCXlAD/to0tSKnWCzhaT2wykNWQgV1jdqgj3xazxtgPK3AL/bML+DWPbXKwwzGyfr7P/LF4c+n1pNS0OPI4v1f0s8xm6FbZMquN+00RJ
X-Gm-Message-State: AOJu0YyW5VwWhurIxcfd9m9tEvnfhga11F38rZw5UUCeo9ANPYi5c1Og
	yuzTdfV/F/ZAk2qmQDXuBIH3WM2imw5ihxVoqRu2uHeL3zN8R/lbL6K2yRYbsIIQyIinrs+b3KH
	OU1BG2WxUuzCs/3qxGip1gB0ct/dA/UeqmLJNdVmVNcrVd5B2MYfgnOU=
X-Google-Smtp-Source: AGHT+IE1qe21EYraqy1mF2HjTY4C7GyobmyXlxUrrhxJTThu1W+Kf+RgPU89aqiaYRwYdp0pyncoVYWN7fk62Y1+CPuhsAXE2nyz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:365:147b:fb44 with SMTP id
 d12-20020a056e02214c00b00365147bfb44mr62585ilv.0.1709978343080; Sat, 09 Mar
 2024 01:59:03 -0800 (PST)
Date: Sat, 09 Mar 2024 01:59:03 -0800
In-Reply-To: <000000000000cfe6f305ee84ff1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6989a0613375b88@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From: syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jeffm@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11750da6180000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=c319bb5b1014113a92cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113f3717680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154985ef680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

