Return-Path: <linux-kernel+bounces-99344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BAC8786F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1EB280FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACA053819;
	Mon, 11 Mar 2024 18:04:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4834EB4A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180246; cv=none; b=pbHAj6qd15mqWqP445vqN8h/CbcKAxKfACxVPv1rDtweF/pgFqvxoSIT4t8DgRNy3ji4lJcuHSK+j7YZwkcBkEujZXrShlxeqES49wLbeOl5nv7RQi1n91aqs14mrFbOc2wRCM/UXB8OjKaxkIvPCW5XuhoEeGN0mVpH215EBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180246; c=relaxed/simple;
	bh=zFcIR4h0TKnNoYQ06gx5cUfDCDhzhOyTIW0c5x7XPQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sINBHn4HmZ81I9KtUJUSYRxNN3wfnjkjroaPFeWcwkQ6h/pUrTOiKUxF0LLM+Cz241dhMRHbBB58HUq4WhDJ4FtvUQK4JQH+qJ8tWlT2kmjLp8ZGMdogySAeCzYPMfwKpSaAV6hF5qtSFCAEMBSxbiGDdBcJfw9pWeOyKT59g+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3665991055fso11294355ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710180244; x=1710785044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yBy19hDFo05+4w9V/H4BdQk6U8Ks9EV7patLY/+FNk=;
        b=OFR2OPwP9ZSKmuACUrZKGG4F/fB1UyiebmQJMmL4IC+a1WNg2ypkMOXxsoXZtezquf
         PnJAceq4tcQe/V2O9pZwr0dLZ9IlnW/DPUTDd1PuIBwufSJ4RtuYln4G6Zcv+hYZEApa
         tnrWAyf1izDfi44P0/nDMKr6TPVpgnQ/IuC+PI1gRaJEBUkhDxwZIkI7hGaqedTmPDso
         5K68GeVMkWIbGDVwpvRq5a4nfTWGXodGLO9cTwuQ5gRJT6v1jaLRTseZ7GOtPpHwWNXq
         RzwTU6sKxEY9Mi4cGiuhja1TpI9DsHUZBk9TsmBY5dUynnVKU6N41G/QIfdt/Dv5EfZf
         Bnog==
X-Forwarded-Encrypted: i=1; AJvYcCV1038yaezSTcwWHxL8MXjueoNVFIIpPXw1tGNiFS7/ayCFOURCAKvYF6EsO8lDD0asgILsYN4p7KmEG0tJK6qy40CXRQW/DNMSW3Ze
X-Gm-Message-State: AOJu0YyxiIGMrm+dcKEtd0YXVtlcuXLI6mg5daU0emCrTUIEAk66DoRI
	marqAyW4DQXqS4fLzjvcbb1iaa1rPo9TXtTPghY4LGnyQvVRNCp2QpHFjhlJgofd6dyjQ69eSyS
	A5c/tVaWXjdFDGyYqOkuUqtUrGeuUbxY1afSox7jdTPW/gLVHXj8S+zw=
X-Google-Smtp-Source: AGHT+IFyHCAwyzCLLw803UDlvdKw+MneFpO5vafv/T0V4RaM5JPBn4wRkpQnv93PEtYdiY0Aek+1NUNcIsTPZ8QtrD0ZK4dpeY4p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca8:b0:366:3766:6c2d with SMTP id
 8-20020a056e020ca800b0036637666c2dmr215892ilg.1.1710180244286; Mon, 11 Mar
 2024 11:04:04 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:04:04 -0700
In-Reply-To: <000000000000c74d44060334d476@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f67b790613665d7a@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in do_open_execat
From: syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-ntfs-dev@lists.sourceforge.net, mjguzik@gmail.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e3f58e180000
start commit:   eb3479bc23fa Merge tag 'kbuild-fixes-v6.7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bdf178b2f20f99b0
dashboard link: https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15073fd4e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b20b8f680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

