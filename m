Return-Path: <linux-kernel+bounces-75260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E3385E561
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF6F1C21D24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C185285;
	Wed, 21 Feb 2024 18:18:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D485268
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539486; cv=none; b=qQ1Fh3EAJiY3mP4Btwiz6tgcZJmI1m8KR/mYqh046xGO0FLX0ceD7qj7+dvnEVoH5w3d9Fv/Brdx1dm3BeSYW3Y7h5ONfouXVbdlW0CO/KDn/UudeQhF5jZuKhvOptixjebWh/+AaFtQbgc4OxxyRO9k1uQ3Q/hKoMFU50Y0Ihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539486; c=relaxed/simple;
	bh=Aim7Qpie5ii7CQT/cjFzRoVNO7qGkO73CWE8Fvg1iLk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pSrEpzdmmJveo/MMl8z7ny2cekWKp5Kux4EF32xMKQs7WfNjTwdxZNhu6xHTNXBB0nXWTYwg6bYw9hvM0sSa2EmD6pUoX5LF1LxE9itEL3iayORXPuUmuV+jPNnQGbm4MSaNkfFQPwjKB6kX0BQDksxrd8SzMo8fgJMhy/cvG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36541324e57so22876965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539484; x=1709144284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJd9Mq9bf/RBjIYNar7qNvmrsOG2DCgFiKzOfjcbWYE=;
        b=TXSBvFUXMlROY3AatrY/FQD3OA8OOObK8Mng9JbVwqKLlsjjZdhNRV1UDwq7ttSt+f
         LJf12efx41j4eACqX0zD1EFifLsvsKJB6MOEWu0V6NAY3XhQl09gataPfAgFbHG+vfSi
         SgDBUPcv1d2UHGpj8M/IfgsBOE6BEiBwL0EohYeT1RH+XRiMWIAkzifdAPJ7Rkbz3vNB
         +CDmK0smehzQmgJGU2WpNQUOCAkz58yZm4z00ts+hhCpj1jnyyw9N/TlCawSu695ITaE
         dEHTfhB5xWiQubWr4vLhV5lTmIijJOMxV3L8YTKwOGb7KaO2T+1f6JsV+d81D3LiIGL9
         YdwA==
X-Forwarded-Encrypted: i=1; AJvYcCV4+IT7MlNhD3yQ6WrZhPDTNa0G4957TgA05z701+ERySBP/T0G/YLO8T3KLHmmCX/3fpKYncdTdAnN+Nxty7NMPLE4vrjf3EL49hHz
X-Gm-Message-State: AOJu0YywZQXCU0rM/vSNMC2Jg36BXCn+/XBx8TF76oQSJUVbZbg7sOCB
	eFH9HonsTzXYnpSZuAXdczY2ofsYGBQZ98MVO968CMLdqPwVBOuG9O7cUuzIknXo/nVspDZWCrL
	Sk9LQCMXBC4m2z90uAfti/UVWCz0YodJAcfv8XsFuO67RxzfeTHbg9Qw=
X-Google-Smtp-Source: AGHT+IGLjTi1I4UnSLykK1KGsO3JplFSALaCXnxdpBvFruTsaOMe8XAVmVMcSAgBRngvxmFZPL1x1S8GHu+QOv7QW+ugTVfQa3ve
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:de50:f7bb with SMTP id
 j15-20020a056e02154f00b00363de50f7bbmr1446503ilu.2.1708539483081; Wed, 21 Feb
 2024 10:18:03 -0800 (PST)
Date: Wed, 21 Feb 2024 10:18:03 -0800
In-Reply-To: <00000000000010719b05fed5d82f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f95a7a0611e85807@google.com>
Subject: Re: [syzbot] [reiserfs] BUG: corrupted list in __mark_inode_dirty
From: syzbot <syzbot+4a16683f5520de8e47c4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1410e3d0180000
start commit:   45a3e24f65e9 Linux 6.4-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=4a16683f5520de8e47c4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bd1013280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101d4adf280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

