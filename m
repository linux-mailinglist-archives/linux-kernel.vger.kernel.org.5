Return-Path: <linux-kernel+bounces-63578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D58531AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1E11F28C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8055E70;
	Tue, 13 Feb 2024 13:22:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9055E52
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830525; cv=none; b=esT7z80smqtYGZv2zTuFly++JALBeHKCMd9l2CJ3GkOa9N6VayCc6P9edomHeARbNjdS24xKi8tmgaELSNGbfUaJoaQLRCCMFGkV3GuLW7nqaY9fmk6tU4puXZzMDSTPl4Oak6wAC2qOpqUQeQHFYNDIKhFz8kmVx2PdhQnAPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830525; c=relaxed/simple;
	bh=WCWqpEWxIIzybG/fHZHmHyhLo+i18DFBT57pGNH7hN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiqufhVAsudJMfd9AFeyptbH7MPyAH4fSBsizfzeRDCvVivb75DuZA6jAGWnBms9bdODRlNMBgXutNCU9ZeGqvk+WBPaz7ecCcMNII7DXzlIIAsk3KGUEP9NPKweyTZIvYDqIyEZBvm38/UPuCl+JJL2ITFkBszKWuK8anf8q4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so494836139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830522; x=1708435322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYC1BcP9cXtmRiUh/zwpL7m1Q5/5Z9cxadj63ttyamk=;
        b=HI8DXs+NSNg3ZNir2EuNnANXeeYFqCxjzbQGdb5NYzwnJIvxax4/ArOlmfbgqo2SEa
         LX44Ja5+33tNWTqHa73jG/5hw8PBZmXs77m5sNI75slKjCPh/6XOLEjwK9xazp5w6xze
         YrbvedkelTSmpsAwhvzUf43P8PQCB44jOBu9TXRbh5LOQcXpRINF/Ss/fRJVo1SRyk3D
         YTUJpgHT1W3zDoh5Q4ICI6PlBHDy+uPjk5mN1tMfPBo09FB+VEDq7ZEHbuUdW3Vh3Ima
         hBKBLxODnYXMdiLkijuwyh+hp3/RdQQv7QoP6TBErSwzNjE4R9DkUR/Onvl5ya4wwPsD
         ctSw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2LUGvLAzYXY7YVxiuTdm3ByeJ2HXJbnVqCpLHbhLtQG2888y8P10lQfeABD9uBSQJDSaAHmemQ/XQNod+WKQhap8p/4GG7GdR+Ht
X-Gm-Message-State: AOJu0YyHOz/4okNNVZ8Rb1Wr1a91qJ6JlXmwMJRFIyuMxdLz7exqsAZy
	Oe/osllVcirr4f0wJ74mM9pjyXc21/86yrIdSRWeuBwNvRDnmzNQtTrh8BGQNFrMfKREmiGcKgb
	xO+AkGGiWBAWm3OK3+NAhH7g04CLS++iUrZegrke8CtW/mutJ/LUZj8E=
X-Google-Smtp-Source: AGHT+IGXI9Iojtpc1dEyKuCK0zBZZu4EdKWp8NMzR1lQhvbivqq5MzT9OLkVQE3n8Drb6/z7HxEtFBz5mx7G+UHYnIpXgZl/rNDk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8c:b0:363:cc38:db22 with SMTP id
 h12-20020a056e021d8c00b00363cc38db22mr845029ila.3.1707830522756; Tue, 13 Feb
 2024 05:22:02 -0800 (PST)
Date: Tue, 13 Feb 2024 05:22:02 -0800
In-Reply-To: <0000000000000faabc05ee84f596@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a545940611434746@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_create_pending_block_groups
From: syzbot <syzbot+5fd11a1f057a67a03a1b@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113ba042180000
start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd11a1f057a67a03a1b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17887659280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ac4e93280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

