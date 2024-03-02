Return-Path: <linux-kernel+bounces-89302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D99586EDFA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B021F227E6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2887748F;
	Sat,  2 Mar 2024 01:51:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A66FB2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344265; cv=none; b=mLkUVDvqu+rlkQvRD2QjLbgTSgnXIjUvdW4OGZjkXcMzf+XLZkCkp5ivvUyb+1AGWh1P+66RGynXCImYoPP59TjN0H19czA28LVTeHxyeqy5g7EhT6C1nqszcIX0n/EG8DuFpU7lE9RGJocQ7D79u3X22yXGX2xgvlLkuHk3PfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344265; c=relaxed/simple;
	bh=j/JB2jyENDKPMzsPZBblzk98S3i8gV/N1pLSReCqPhY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y09nSqkQs3fzMXdljVLIdVsfbvPsYB2SSFmRqQoZKN+HrRD2eibphMvn2LPO9Zw6uwXkWMBEXDxKwO6mcruHGiygWdeBUeU5HlkVnbn29+L26A9r+NacibErS0Jwxszf+GkI6WxuXMKATwZL6PyZ6suZgcg9a1sfKD2BAXIXN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7ee7fa1caso307200439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344263; x=1709949063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvJsx84GDRR3sGeQWUlw8maTlVsrsS8sB6uzDnbyywA=;
        b=lmpBV+6Zh8o4Cnk1+0+B/zZg/4jDZKVRWo1QGOuj0InJmDc/0/mosRc52isUVE+Rxs
         qWYzcZuKAMcq2BPEy/iWV5aOVreNbWZaEBRMWV3TBqTeL5REp9nizrj4/AfrN+rq2wGE
         nEtj1txClHeP320waeXGR6yg5dbxVHGyuRe8UNKB3sEAfujBUqlRWfbsaQJmaNb1ZSzw
         DztLkBeOvPHqlUCmIKxUoAOUDFMd3MzVkOp5KqCi5Zb2jP7ldWnTeMqGEtbLKfwusmp7
         3YWETTgE3u4mOArvTV38562zQW34KexG6icQet9xpyo+pK/2Pr5p1PwDU2BYGSMcoE5z
         UvBg==
X-Forwarded-Encrypted: i=1; AJvYcCWIUaIls388EPgb/wviIFk+5XiDayETNX5uygu8JvxEbY7f3DlnxeyVZXrVvfiQ8swGfaBLpLWQxGWdFyS3RiUOeDtY+rjC1WSe/Yk0
X-Gm-Message-State: AOJu0YwqL5k0FrcTS559FvXyrj3kMLsTnASnT16npSXrdIr0OqGTepJz
	tHzNE15fCZ++31h/kfKWNEfuBqMNOzzPu7G6PvjoDzral4UHB6hQ+BOF/GSPpkw93DfRW+v2D/1
	Ors/KIbQLE2ddTcaFGkvX4zGl2yA87/PWCj+kuDfIPiwz60ncPskJTxw=
X-Google-Smtp-Source: AGHT+IHuZLEai30Vbe4B0f25cUi3TWUjAJVlZiXgrG7JjlW0Eoir/37IyGI70zz2FHDwFteKbxHcLXnIYeVoRrWtAVl2bbv76tjQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:629a:b0:474:8177:31c9 with SMTP id
 fh26-20020a056638629a00b00474817731c9mr111536jab.5.1709344263133; Fri, 01 Mar
 2024 17:51:03 -0800 (PST)
Date: Fri, 01 Mar 2024 17:51:03 -0800
In-Reply-To: <00000000000094d9bd05eb190572@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a64380612a3b99e@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in reiserfs_in_journal
From: syzbot <syzbot+79bf80830388272ba2f9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	bvanassche@acm.org, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e80bba180000
start commit:   611da07b89fd Merge tag 'acpi-6.6-rc8' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd
dashboard link: https://syzkaller.appspot.com/bug?extid=79bf80830388272ba2f9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ca8c63680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dae351680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

