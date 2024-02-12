Return-Path: <linux-kernel+bounces-61391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B68511C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEA82831B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED839857;
	Mon, 12 Feb 2024 11:07:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E738FB0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736025; cv=none; b=L+VY+9N7AnHklp2mk32OQAu7u+GVdC9ArYa2d8FrmB6kM7uQldJnnT1gMJ7La5wvetW+e81O7G/NfrIYmaPo6ep9lh3RvVuSXxbsRkz09gvi9riVh58ZPsesySme9Ghkl+JFX+O98H8CeWeYNflJ1VqTbPcvjCA8uwXYR3NyrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736025; c=relaxed/simple;
	bh=TiTTw+hGF84P0tRgaBMy2VpXj54TRkQdwyGXOuSJuRg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TW4luAjAc/sgqnzl9GJe/x0UDpl0aFcFXog5pnYvpVYs9riu4itF8s/W47tvJINOTNk1SLVrHUI+x7lMeAWjbtoS1JdyDO500yuiQ48iwhyE903WqGVK2QjG1Ea7joOPKlgK4t1rNa0xNiyQxN4vJlfVbTKA97vAcmCQd5JLWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363d5475522so20553285ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736023; x=1708340823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/xJQPp3141bB6LLHb+O47KgAgODwbbVCXQLBM4yS0E=;
        b=DF6MgSk5qRjGkuvij07KJwIdkTBFKT3rh1URewHmRprR1KLxd8AOlj+JRbbzy9zeoE
         Rwm59R/GLMsOelbjs/3Vb9daQddoCBCKkXe0V9Mc17rcRFzqZAzCtlOFGwbgyRZJBqTZ
         Vk8DBLVt69LvWUYnQ2uh8DjzIN6AKwEdf7qbBi16m4OIAzDSUEoKMCzsYh6hSoggbRcA
         j3T+j0Ve6RvnRfae3UefaF044i3SzxZLIpu4W8S2O4a07YlAfYsMCS0B5OEkRs+6DGdh
         6Mex8TLZo6i7uX41fkOaEphwNdgecnsU+9BWilLGc3nHiWeJdibzuJPoZ9NgknBw5Ito
         1qdQ==
X-Gm-Message-State: AOJu0Yz8/1VJRWFgJCS+NpQQbje4L8NzUT82lpH0279Fitg3ZlBUej55
	NAW/QmSEg5O+Y398SqFrBbr+mdICO5mOmXRz5ZZqKQjQf3xYjUIi422E3Xo/Q3FYLz2+hiLuwKe
	TRJUiCJilPtO47DhAZdVxtb6H5iUwPPZpC6be9n+5tbfftJIQ+L8oraE=
X-Google-Smtp-Source: AGHT+IH16WGqEbfrd3+o1CSIasNblQnZGNn7ZhqheuO8ThHR5IJ3F8URiBZA5m1q8b0W7FZFL4ADFHowhQo3vgmeTSNPXWhV6RB9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:363:ac48:e28d with SMTP id
 g14-20020a056e021a2e00b00363ac48e28dmr679193ile.3.1707736023784; Mon, 12 Feb
 2024 03:07:03 -0800 (PST)
Date: Mon, 12 Feb 2024 03:07:03 -0800
In-Reply-To: <000000000000ddb17905ee995d32@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011649a06112d474c@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: use-after-free Read in reiserfs_release_objectid
From: syzbot <syzbot+909a2191a4352fd77d25@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14df7cec180000
start commit:   ca57f02295f1 afs: Fix fileserver probe RTT handling
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=909a2191a4352fd77d25
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1563673d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134d9425880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

