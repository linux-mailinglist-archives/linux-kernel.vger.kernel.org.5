Return-Path: <linux-kernel+bounces-73400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AF585C202
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8A02814C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6876911;
	Tue, 20 Feb 2024 17:07:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E1692E9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448828; cv=none; b=NXuyfPwL9CH0lLT0dcVIBfaFlfMCJZGQN2eouC2ZuO8BVGbB/CXN+qCErjUmlSVq2LhMLHSeXghCA0detje2d2P5UsxG9aIBLJvKP5MqhX08plBywrq6svpbfRL7+dqwYeGM+4KhEDFF/kfxwtKcMY/az+3D8JZGcyWAQfPv3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448828; c=relaxed/simple;
	bh=fpOYDYG45k8U9HV65cDW94tz/kvIcbCC6Xq+v6pMoEE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lQ8fB4JYzb2FTGWoUWtltDJgHSluf2iCkKOnTGg5z0S5VIsxYLso9DqgpwKU0MoWAMqrbzyEUbNzbyEI2MIER3BqizdzMIifv2UombL1gZWUggvYNOgQLJt2VDarLxvdaOWk2jdgMuSxKvSiq5L92hXwnPS47a+glXk9XdG6wmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c0088dc494so246183239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448826; x=1709053626;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoB9Sna81nB4vSaNge+i8EhIjXereiwccH3aqSzPYT8=;
        b=jBClf6whOvI7gUvCKLTHpjlJr4LpnlKrRiGCRfjM0k4weEu41Jh+TlS9qK5pdqF9I4
         eDGd36uQA3tJgpydG2eqU+efcQVnMmOO5mfSXqNGCPRA2mtPkmn5tGYHnnhehOqErWN1
         X+nN7wjgCA7cToTREbyzm+qvHW6PpZqsfUWeWnuqzORMIzkQkXA5U11uZPTw2v2lzboR
         YC3tz8Zvok8fYD3DLQoEpbPacclW5lUkfA/W/UXypAm4uVH973nYyLGbsuDTjJQEpMMM
         TZ+rc5hxCfOCIGQecxJRaeF8G+T+vazYfl5kfWE2VJJDpC2vhYnpiB5wXBwNQ3UmHOfY
         uu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKuc/YK6L0L1vOyjEYitZ8vjEIliJJP9rWbGtMOmlkYnF4IKiEV3IPlO+Qk70bSgsyVzJeY3uKbxgIgq+/HZsKCIM/MYpC9ZOcYrtm
X-Gm-Message-State: AOJu0YxLKTt6dA8+SbDZiRMudG4khmCBwKvs+RiNWx8MCBm2O3iDjMCt
	7krG7dKGffo6uxfIbiOLtRzstfD81XpSxfKTBByM3r+h58/71dW6i0KuvPRyLCi29ZmtROqXnUD
	34js7BLTrlJUYb08y4PKDJ8uetYRDCf3dq8Y365rvgEtBXgDfug1R7X0=
X-Google-Smtp-Source: AGHT+IF/3RaeuI4CtitYxgcUNh3Is+XjhShaqoOBbnB9V16ZP6HtCD2adFQBNxOo4oeozbzjVfa9j8UiQubiKpaMwAhfub19N5aj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f07:b0:474:35a3:6300 with SMTP id
 ck7-20020a0566383f0700b0047435a36300mr42842jab.6.1708448824305; Tue, 20 Feb
 2024 09:07:04 -0800 (PST)
Date: Tue, 20 Feb 2024 09:07:04 -0800
In-Reply-To: <0000000000005f876b06075a4936@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a34ce0611d33dfa@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in lmLogClose (2)
From: syzbot <syzbot+cf96fe0f87933d5cd68a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cf63d0180000
start commit:   b78b18fb8ee1 Merge tag 'erofs-for-6.6-rc5-fixes' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
dashboard link: https://syzkaller.appspot.com/bug?extid=cf96fe0f87933d5cd68a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120a1c45680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1230440e680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

