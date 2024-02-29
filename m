Return-Path: <linux-kernel+bounces-86476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54E86C607
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D77BB2472A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D760629EB;
	Thu, 29 Feb 2024 09:50:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344F6281E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200205; cv=none; b=JSsobFTw7JThzcyKMq3DUK1W93zjO7gYVriAUD/y19sncSMG/oQ1MynJ5n5HtKVv+6kdRoQF2kfiRo7EDx19x+pqDvJa0zHz5XGwlqpZO+8z18yRrMIHytNmhfgMT8sbvKM/OIv6UBwZAEByrUOUfY7L+5B0GmY0H4frBa08MNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200205; c=relaxed/simple;
	bh=xi6HIJAD+eeBu9LW7f4Hh3oqUUXdFVpYzkHwowOaOQU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s8jwgTfOq4JcRX7AynByCl5+M7cu9C1gkITg2Mn3N4qkRoAbKsqwq/QXKMTbp090TrJENF6mw0BSG0vzhRIiqj4mIbI6XpLYvoa805YFc2/N7ugjVgW2D5KEA124Huq8aBumyQEilEieuE/JL+dyUv8R04MnzA9flnuy6MeOpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfffd9b47fso69676239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200203; x=1709805003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDGmgKlqgwk985gGaF2O6kw62GJaKE8V/tYQe0mxx8U=;
        b=A1FQ2eKk7BsTZ3IVkcFQJm6X1sDuiYDz2l9GppsP/dfDkKcmJw7Y8NYWXkkECjOtve
         X+GQnM9zYNdwfoNWX8KGOZyzV3/V7DP6mSQpU+MfJu74wqTA5QalGqSPSCWp0Un3VBox
         Rx9bj9BQcYbURmIPMyHr6pUk5zcXHFVDQVgYieottJZ4KtgSC+IjARhFIUDiYDOJCVlj
         sA+FKDdtDO274QdvIgJ8cCnvjuhIKyZvrbqynSf2ue53rrAHk/50VkI5IDygQtMQF7pO
         H9VMix6IsBNxArFt8Irm6b0w1PIB0LDvAuYkgqnCWDixX21IH63Hnk64hs/A6uGAWr7f
         jYCw==
X-Forwarded-Encrypted: i=1; AJvYcCW9e4+En/OkqgHBWGOIMJE3jPyhYBZWiAe2jvAoR+0FND9vJirN9MdTGrwr3ilh3ROyhOfOUj8E9SFKLd7THFXVFtgshZCaChxgl7pa
X-Gm-Message-State: AOJu0YyVonqu98BdNQrOfM0WnMTq/VvmArSjKQpEGXZGuRd8Wavqo4MF
	cwiN4iUP7XPWzR12kcOUfHAi5B7VWm4C2f5SCPnOveN2ArdPRCDBopvvYMSA3Ss7tdHjlYHh4Xi
	ZGoGOJgYtlFxvSxZorZ+sUC1e4Ioh1FfIt1VULc1sK81xdIz/FGpGErY=
X-Google-Smtp-Source: AGHT+IG4QI0KeghT/04h1y+qObg0of7pbkvKUpoiyWTfn6I+VKPKB7VJiBDBfJC6+j8HBzzrx2DohQ/EipLv3inF8Xn6oz88XXxK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:365:1c10:9cfa with SMTP id
 h14-20020a92c26e000000b003651c109cfamr129745ild.5.1709200203621; Thu, 29 Feb
 2024 01:50:03 -0800 (PST)
Date: Thu, 29 Feb 2024 01:50:03 -0800
In-Reply-To: <000000000000e2c68a05ff02fe43@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcae190612822e30@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel panic: corrupted stack end in do_sys_ftruncate
From: syzbot <syzbot+3e32db5854a2dc0011ff@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12203874180000
start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=3e32db5854a2dc0011ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a44d50a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bee4cb280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

