Return-Path: <linux-kernel+bounces-89442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D4F86F067
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1360C283F5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF2E1756E;
	Sat,  2 Mar 2024 12:14:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB34A92F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709381646; cv=none; b=ti8eO4m57MNdRfEoToqJGn038/3pu1w4shF/0LFNH9+meVD5d4+q3w91bsQc4RwKWN0f6r0ZmlRYcM0r4wkD/EKOKt5g3ChqIL2JohsaQyt1tCFYFOFDHMZAnXM71AsnXR0p7PLcIvJtSSps3lVnS+z72u/9AD/Z++zFrKYlHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709381646; c=relaxed/simple;
	bh=bFd8eX4Us0/YjmKzSKzjGwgIDpnWpg6gP95kNMPOmz4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oOB7HhOVj6p1U+TeOyzWeFmm3QVmTjrlH1WH3nBHfjeQGjZtspmDl/qJ79novlnUMgGzC5dWNmL/w3rw8YVOzhvdmfOqi+OsddYnXKGK7zJhy4DZ51AWRK5SofyVycYrVxw9pUPB36gCNkUDq5K7AL7NKjbkpUN/E5IHXCHAUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c000114536so288668239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 04:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709381644; x=1709986444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYoaaKFkoOiUzi2l6hHhIz7YnyXz41iQ7tjdGLqGYME=;
        b=ps0J72W6/MSBi1IqTDkCfT62/dn4p4gcB3APnue8AdbQb92E1HDsFshps+Qf/nw+RL
         aMtF96i+cBIhIjOdJuPEFYykpkz11OewzCzIB/WXuhvwYQxMtScnysmjAQHmbGr/h/Bb
         XNmGYcwpSi1SFfDobYGYMrx33nTdMPsKfjh7988Z2Qwp9nlYi5IZzGW5fRqlAPzuCIIu
         wGzdyFp4+17Dg8nOVtjZ7QxcnaPQjDmIkcHaZpv1tOpnfiTsYOgnps5a0LhhdC9O/Ixj
         JNKOy0L/GAwM4WxuYyGzI5JzOl0ztWrqa5n876IbsSVUKrIz2OXgAwsXkLVEViIhQ2o6
         47yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjoGM/wpaNTcwtFug3eNVc3Iri2l96/qS6TrBmkHdFS3kFC//hcv7mxSsypxr9Pwo6kZS8uMPeX/THRaMaAuBLqkELxKEKn6ajurrB
X-Gm-Message-State: AOJu0Yx3iqiWs9ogKmnEMLg7Q8SRRQMMJVduCCTMB1gc0+GsuVnuP8uv
	lg+69bdAkLszodFoh6Gq0GmU7/V2HEisnKsHkzUEl5MAB4RwGWiNE6hi4vBG6Z+BfPvHJGeWikv
	JBAWnbHmi5s1bPmx1putgqlWpT0ZbhYQpgF8Rb6oHzCrAXyprcwxdFkk=
X-Google-Smtp-Source: AGHT+IGzYKGUPBAnHpRKFUS/Ttvbm9t92JKxhV3NxYE8TwRbo6Ol9O0X8ysMfiGCvGBL2jOGpG2Igxb5fqxTso+TPijHwSAYOSTK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:365:26e3:6e51 with SMTP id
 e5-20020a056e020b2500b0036526e36e51mr147746ilu.0.1709381644143; Sat, 02 Mar
 2024 04:14:04 -0800 (PST)
Date: Sat, 02 Mar 2024 04:14:04 -0800
In-Reply-To: <000000000000eccdc505f061d47f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af5c290612ac6d86@google.com>
Subject: Re: [syzbot] [udf] WARNING in invalidate_bh_lru
From: syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	hch@infradead.org, hch@lst.de, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liushixin2@huawei.com, nogikh@google.com, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a093ce180000
start commit:   9a3dad63edbe Merge tag '6.6-rc5-ksmbd-server-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ebc3c5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e8275680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

