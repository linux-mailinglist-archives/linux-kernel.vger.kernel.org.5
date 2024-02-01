Return-Path: <linux-kernel+bounces-47771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E2845290
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF351C264E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EFD159587;
	Thu,  1 Feb 2024 08:20:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BF158D8B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775606; cv=none; b=T8uFoosOZDgeL3gU+n1tQ6POLany0RKNJAbBCN2/+8/6x4HK/MR/nnRMvJNjS2KBg5uu4Ljtnn1zE4sMjKIJQzE4Z6cNxgA4l/cAZ8r6KQ7KbMdK24EX38rxCeoPP7JbvQPVqYhMMQMIY8aZqpt+7gQp5i1R6zl9Iuu8flR0WgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775606; c=relaxed/simple;
	bh=IT+/IznFUZfP8voVJHxGSDhujN2yYOYuh0E8y5jDUBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RdPfpB8QO7PF6nuN3FhijuJ3ubdNCsxZqGP9m04o2QqaH0AFxoZnfpK0MOjzCmBIcemuqjznwPqS5hPRaJqgn21RR2q4TqPmrEAhvN/jDGP/MfyVcrWXClnmSpl72G7O3JlHlOE5LJteNh6f5WYIaZaFS3VUm7eMXV4AqpuQJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c0088dc494so48049739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775604; x=1707380404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oj5sIJNV5dqs7fT2C4aqfxRFgCGhxW6XP8G9oXlz16I=;
        b=Qb3QHhni14MUlrKsFDMLT+nstj1GFTfG5lP2qOIotepB3mRxcGlP3fs6PA3yCB6B10
         U/4o2jvFOACDVwT+q3Tddzbow4EwC+MW7sjm4Gqp3Jb1WhWto+AwR/YGgrU8hYZ+0cYh
         oGNnl6MLTtBSUK/xaDbqkL+IK1qqK17MlkiGsZyK//3dzjMWb+V0D21DPJO26dad0+oz
         m4zVvC6Fb+K8HL08Y7QiaQZz+xxMpsrVoXgxChzxSnUink6xUf3BbEWQjNkgZN3ErtFh
         V4AV6x7WetlNHJRobBW9p0n8BoBfNvD+j3pSDgataOtMeaWHXCJF/U2FKVZZLoELCTlV
         JPOQ==
X-Gm-Message-State: AOJu0Yz2KIj80PpWI/FxNVReOk4gTenkMwP+pKI5SzLEBJMBFtvhwfvA
	y56YDwJNooree3Otd1BerXZie03wHPD3+sr1c8GkDu9uS1b4gghe0DqSOM7F4w6pQ4WJECfu3wE
	f71/ZjoUQNaKfKKkNGH2VMMoqIjt1bf2xxGRs1FB3V6D8PfnN+NE+2Ms=
X-Google-Smtp-Source: AGHT+IGMneXP1VwttEU6QqMbn9Gto8Ha2qHva7b18FS6I488vw1v7coYv7Pm5/27FVSdHOXBwv51x8UF1Ur1lNgCzbwHZrnXMOmr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:363:9d58:805b with SMTP id
 i1-20020a056e021d0100b003639d58805bmr115442ila.3.1706775604492; Thu, 01 Feb
 2024 00:20:04 -0800 (PST)
Date: Thu, 01 Feb 2024 00:20:04 -0800
In-Reply-To: <000000000000b62cdb05f7dfab8b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e002e06104da983@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
From: syzbot <syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1606d4ffe80000
start commit:   3a93e40326c8 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c35b3803e5ad668
dashboard link: https://syzkaller.appspot.com/bug?extid=db6caad9ebd2c8022b41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2cd05c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158e1f29c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

