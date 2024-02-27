Return-Path: <linux-kernel+bounces-82963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F1868C51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA121C20ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3121369A0;
	Tue, 27 Feb 2024 09:32:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B4136670
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026338; cv=none; b=HvGijNblPdhn8B8lCr/qpRq3fouFutte/kB/S9wq3xCkjwJHsKdbnsmkyBptjuwzmzcoW/lIc3LuOJwYZXlNBKDsi3zeFg7nCdTgcENRzoYdVXZApFm+mho0Y2jWMA91if96leqGFI3pwEhtNnhUk1L04+Ft8O9Aql5wdKMeiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026338; c=relaxed/simple;
	bh=EorhoswHc0CHAHcYABw9rufbXmsLUHZ3Sa1Ab56+QxI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qjXatBYdJBVJDpagxfpoPRSUPsfKSHJLveIMiURcWgSa7KD5FqKYrDU1QTrDaaJpvAMkcwMnIvkfY3pU69yd6WQc6Rn6FBcpj8bfVqLX43fqCG1nZb3SOr5V3hwjiMYCzVKeYRmwlaw3ufbJ+tioe3g0sqI6t59EY7jPVu+Mrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3657bb7b8e9so34920285ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026337; x=1709631137;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWlXwfIu7pmJUidfYjjj0Hw4GjENQdKqfI7wq4lCnDM=;
        b=WiLy9rUvfJ0Phd5FqTiG29sA4jBu5cPDadebsUj1xKEz9zLJ7P2V8Rs1AK+SV0cEPs
         u9Tmp6yF97WjoA9loD/jSChB7ugyrqFJxRWvO0sqAoRQNVbfIRU3/vR6yIUPhx52RxX1
         iz89FzSimjBLZpQqGPrCTtBW3lfUOGKfk4QTlli0+wpPUKVRClTHF8/YsHO94VD1JmO7
         8hJFL4lMZCkhy5aIkb7iezWhlG/49KlQJveH5K2T8cmwL9l1pM7UXjRsVWKb8lKuS0Tb
         okTkUl5vvKELyjIxDm5zCFWGrVTOxUjRgf5vFcr75ZRhfCtxOcnzZUUELGgqcJkOTnbl
         AjQA==
X-Gm-Message-State: AOJu0YysguwIKTY9pPF7JlRnlJ7vaFpl83OLnCLniakWbST7QS/Hftb/
	Gx0znF5N7E3KTzvfkv5iWb83M29D27o3G6Rxp+uqsgClPPre6dQFgo73E570jxPex3ip5kWT/H8
	DnMZlC1+bSBVJDNKroSc4vT3THQSwvWSZcaLODtEhkwnmMy3dw09UC/OhCQ==
X-Google-Smtp-Source: AGHT+IH+m/quQ4ts5DCidM8p7nMKajzanOtFbGs1o/fmnxB5Ms7XBrCXxhA2m+9Wtv4bJhquRMb6YIsmfH+uBKaAmNLS/Iydi6rW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0e:b0:365:208c:e78f with SMTP id
 i14-20020a056e021b0e00b00365208ce78fmr550080ilv.1.1709026336818; Tue, 27 Feb
 2024 01:32:16 -0800 (PST)
Date: Tue, 27 Feb 2024 01:32:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7ce42061259b389@google.com>
Subject: [syzbot] Monthly trace report (Feb 2024)
From: syzbot <syzbot+listb2c419343f446eb939a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 29 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8197    Yes   possible deadlock in task_fork_fair
                  https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<2> 279     Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<3> 26      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<4> 17      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

