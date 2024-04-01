Return-Path: <linux-kernel+bounces-126435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F9D8937F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D051F21503
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F278BF0;
	Mon,  1 Apr 2024 04:07:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373879DC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711944425; cv=none; b=YupIlpYqzg5CHOMUaJE6JCkem1OC5hn8bbjh9jB/m70ATmmMAk+v2pqWeVQn6+Ny5Tz1KanqZxNM0WrvrhgsrvXIuXr6UzLAa1eDpLhocsD9XukXgm+Ky++Lo0AU4ycnhkGj3P2v6FkD3bcezgwTbdQ9bAkg/KNcq6Ay6ygw6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711944425; c=relaxed/simple;
	bh=9P6gwRofG5szvPpS5wk0bIlYhfBwym4zzbh1JT6mdAA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HcYg/aoXO71EtijKfvnn8xe74hlWJI/OL0ZLYXndtx2qM6NZfVuK8kHMDeezHIitjYwG+pORTs7M0bJFiR4V3zMa7DQOJjvxibhwSKBtAsga7351p6szwmk8C2Z7qsidHeR0LceMBBVGdL89RvFH4pIa8kGIN1pp8rAC0avm+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a6a04d9so440460639f.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 21:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711944422; x=1712549222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4a37mosSIHw59NRouG0xmXBCgPNqP3yYJ95pn186is=;
        b=ICTK+Xb9ctXglYPxCMf8IbviwcanrjG6exTPzugULI5/vnN/BEOMTMF0n6UOncZNv3
         GxsMNc6hzry5QRixHN3l7PVuD2ZKoh/E+zdQ6423TNHZP7Sv5NgQ5VizsItZ9385006C
         UDnJkAgBu/m1lgnd7VCvwgt/1YXa3TElzD2bHo+AMMVmbtCAhIvwYH1dGAy7OA+wVG7j
         0igCB3XsBXjgWTAZyrdlYDNdx1iHSrCp3R/kNwAEZ7J/b3Ln7ZeY3o+hSg7bzH7OrO6Y
         a6DZNXTJZ4kfnMI8YokVgXlrVXHdZzmAuAfONYNWZwgwa9u3e0px1MknL7Jy+oYzjYuM
         VAFw==
X-Gm-Message-State: AOJu0Yyri/qHCQPm3VF0XZxqy7KIhQ3DlVvL0HDVbZhx0q+1GTunOPG+
	7SOqSJVwknT6NtvfQHI9Tp9aMASesVM2z5vztjLgtdZPqZ7wYGqtvbjMskfFzuuxiWzf5u3Ae03
	w+E6MZ8rXx/R9DmslUC2+r/UTFDo6Ghp8olY+LAUi7RxQQNMZA7g3XWT1FA==
X-Google-Smtp-Source: AGHT+IFnth7bDLYMwjICk2s2ZZHiakAtA+olZSuP1tezC941CUChzp3UvtrpmWZLAlFlHtw9obY7+AmGEl1rDodeTJIML4pOQJA8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:368:5dd6:25e3 with SMTP id
 g5-20020a056e02198500b003685dd625e3mr687813ilf.5.1711944422731; Sun, 31 Mar
 2024 21:07:02 -0700 (PDT)
Date: Sun, 31 Mar 2024 21:07:02 -0700
In-Reply-To: <20240401030112.463548-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003145b90615011f96@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-use-after-free Read in
 hfsplus_read_wrapper (2)
From: syzbot <syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=113e1cc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7b3ab32bcb56c10961
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a2321d180000

Note: testing is done by a robot and is best-effort only.

