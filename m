Return-Path: <linux-kernel+bounces-149649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 212068A93F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52111F21416
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3154BE2;
	Thu, 18 Apr 2024 07:25:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827112576F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425105; cv=none; b=X+SPoNMwuAkhDBGlT4zRCz8DGGYL8suh/tvl5X8EdfqO00Q1lI48mDfc9AfAgBUsy+VqwKdNWkCyi0qFpqb8V+MOtLvWFRmzbN0nIXQAW/X0mnaPfuPijNV++EojK0aZgLBjBVreVHdX5kZLJOzxXvLyQ5yLisoRCefW3n2LYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425105; c=relaxed/simple;
	bh=3BjsP3nfhcuCH1XUcvjc1mQjPG2rS/A9hNNMjKKloA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=joKXbxszmmDs2yBvOMd3/gH6NLyi79HOr1yK50gwxL5TUdAVKSpJ6L8GQDzH6GnPk4VIA4Fw4HsEGwXd6VKfEKiGzbIGx1/hRJhrz2qwpTAbgLMIbXoxptI0Mwy75sz74miFJe0Et0CKGYvuH6aqY0VtABgh7GnLSw9kZU/LF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso75361839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425103; x=1714029903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emqYNM6uPXqfGXvH8IFE1wN5OYo8rRqGNB03LA9Oayo=;
        b=rQADYB0IC5JmUMsZOO3Mw6AyL2o9c5RlPItCIU7UflXJdhE89G9QDvXO/7z7+pAKKm
         1wem+xVUwXCHjIbacWfXYUXgGBhzSu7RXqC7TUQFKWBr8h5RAiO7np1oI5B9/pfm1x81
         dNq9Ic/n39z3s88nBCzcQkugIODpWRHxjRx1sxfQk2Ezpo8PHpnr7L91runva4XEEA5E
         uQ88kbpdfW60kLqMDPFdnWrmNuBo+VkX/DT+MsFCaZ5oxR57QARo5s0HUPfhHor76Kqw
         oLcvMpR2GoQ/GoJGXzCRElbOp5C62rXHmjVDXxZa2x/m24eJYEMT++B/ZYwyqOLwM8Me
         qoIA==
X-Forwarded-Encrypted: i=1; AJvYcCXNataKkdJv3vRfletzZpU5jgTxuopSkVZsKvAbYQ3C9bT4SUAniFPyXkV1zO+quKG4MjSkwJzeVIRodLGPt+becwRyvhR0aB00kWDo
X-Gm-Message-State: AOJu0YzY2vnLBOC3057MqwKAjDvs8+DSHXbxP2WPqzmiMAeuYW4oZWjC
	21R67Rb5lCERVGUiZBvDLlUHm/qvX/e8eYcQfF72rOhR9JsHZ4x1vgGQDy7uFhglP42vju9EwgX
	7ZOT/OP/VMFrJSnjpDrmrGwmbiFpBVBf57dtwca4Q2PJ6lzF4zgzJkpI=
X-Google-Smtp-Source: AGHT+IGF7JBT1SXcfdi6VGIsYxKj6xCHnV9Ax77U49+mdHX7Gx1j4+mnLdCI3KvBBHJuH4ka95TKOzduhybc14CQuB94/6DNyKVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d4:b0:482:fa29:27fa with SMTP id
 j20-20020a05663822d400b00482fa2927famr103840jat.1.1713425103510; Thu, 18 Apr
 2024 00:25:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 00:25:03 -0700
In-Reply-To: <000000000000e21aa80604153281@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4f241061659def0@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in jfs_commit_inode (2)
From: syzbot <syzbot+9157524e62303fd7b21c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155eb8f7180000
start commit:   4f9e7fabf864 Merge tag 'trace-v6.5-rc6' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=9157524e62303fd7b21c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101aff5ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d78db0680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

