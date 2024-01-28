Return-Path: <linux-kernel+bounces-41564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145C83F4A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77445B21563
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2FDF4D;
	Sun, 28 Jan 2024 08:33:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9ED53E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706430788; cv=none; b=u44H4WEI69drXZjhGuhgkrscjKzgfQe6sXzlBvV3NMPtRI++idzT3V1crYlgD6ubL5UdkcE/vWiDXt0plDOkeW9uwrtaGaL10aCUbl263d2p4sj5ZmAl7Pn8GP6G28IgeFNxnAZS/CjrNaiM7044+WF65V6uzNagYCj0ClYfXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706430788; c=relaxed/simple;
	bh=hGMR4U5K86JxyB4kr5e3ZACsI7Q2evvli8q8yzSoiSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HvD4tH4VyJlZZG3ai6IBQ22/yNx+DvJoqaH2XrzNrY89GWwRjWWGiwyvoUjGmwbwSEHKl93Y6NRGomFA6jjafgex6P+5rZvEBuTCwdoUkPQQRvg3VpZ+JXbORKRlyj/3VyYxJ9VJwaqNGaJrxh58oTXpboqrJWWkrBgsj01nYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf4698825eso134460539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706430786; x=1707035586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNN5KLkPHS0YIYwzI5Jykoe2YGdKNWga1jxyVuOp7+s=;
        b=mv8bxy0kqi7aHt5OeeC7PloL7v3LT9uS27HENwZFz7tnMu0ewz+xrkc2/MgL5uJHgQ
         6n320/Ru2FwMG4krNz7wUoSoxGtqlPh4B+jWAIiGzXwOxPuXLec1FcmefufuKUhDw6lB
         0b952dSv5TlrLqvVXlx45hvGVWXHJgwHAZJo55h5b61OJhEqMCmCNsEsOGHi2GtgefNx
         mfH+gjw/nFII7r0kRPhNYmXFUbLiZnT+cX7kzB5y71gAGnQnEPqgmwL2u4pYn5Slewgh
         AJ3Dp/7detW+uyd8z3zrL7qYDC1jK4ZqKxG5AHx9GbtU12KYeFQKj+zn2Nov6KhyO22t
         HMzw==
X-Gm-Message-State: AOJu0YzuMHzL64tZqde4k6dgNzk0DRIQswR1Q1MxwtHROVp2xIPigr5W
	5TMIYOf0ExR5hHF4u7Ko3qnFBrdAwaTIsh8Ml5lqGI5n1oP67T/Kb0seBT4XBvdSCD1tiBnYS7g
	eJB2zsZkK38zxVOFgVsrQP9SDNfCgABiubGgR3l7BKbf2Mc438FU0QZ4=
X-Google-Smtp-Source: AGHT+IE5JhByvi0HswZNtB6u5bhB0ZD545GFOO2qLdKbRVHFiQgOaj511OOcYmw4/xBkKyELGhEbtSg6NtbI2umtY2tG+8LtTdM6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:361:9a73:5a8f with SMTP id
 g15-20020a056e021a2f00b003619a735a8fmr398208ile.5.1706430784250; Sun, 28 Jan
 2024 00:33:04 -0800 (PST)
Date: Sun, 28 Jan 2024 00:33:04 -0800
In-Reply-To: <0000000000007584ba05f80047bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baabe1060ffd60b0@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: use-after-free Read in reiserfs_get_unused_objectid
From: syzbot <syzbot+04e8b36eaa27ecf7f840@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116501efe80000
start commit:   1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=04e8b36eaa27ecf7f840
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d5c261c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eba51c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

