Return-Path: <linux-kernel+bounces-90583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0D8701AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9901F240AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E003D38C;
	Mon,  4 Mar 2024 12:37:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF2D27702
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555824; cv=none; b=Be66A2TzkCqFkRaxa4qfNm0KHXFz/AJYOdrAha0PgtwoXY2NBlPRAOLqze7e1STD5c3ewEr4HSFTae/S/K/dKapS2Kx1JCOx+NoM8T3VnZLuZSmq+71D7f0ub9iIkof4b9oYgfQ7QPECZZ2kvQWMSHcZakNCF99pzj9Dw2Mt/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555824; c=relaxed/simple;
	bh=eylvi3XlKAQDcDq2lF5jwYNjHDysndBP8IqQugOeCVA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hopZHbBVZ0Gg65eyh6d03aTSPCq28A3qB7+dK96ERrG8dtjO+0P8kVfYBgAZXyIfbTG7lRMMbOraFt7yQ2OyibNwkmcwKOvIFGlojkubXrvBfBGzGOuRjFEFQWPLL8YHt3S+2PSb31qVU9L26WOequiYMcvkJZg15iw5bKx+0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c495649efdso580268739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 04:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555822; x=1710160622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NbNnyhd/B5XCppDwpIFPOlZsSIrkjocsr4QA1pmJsU=;
        b=LG+gPJupSMoYa48X9EuDyjuL3mot3Atoilam/Xv6ykRdZ6jqLLWPNUEn3h90JYUnyQ
         iGBdc283w+fCcxnd0yC3fzl6Gze1Dm5LEn1xAv3uOiP8Cawx2boack8uFGPYgrSy/cGP
         kwbG20YWPsJFFPmUdsAcOJ+2gmz/Zp8tKGKynkJjUb6o/xVnoNbmIEBLA6pw3R8bz+ti
         Cn1G6ecZ+NohxM4i92k/ItvpQDt/JEKCVV6c7Amyv6+RA1yL9xBHBo76JtsIAEHzxKHv
         NuH2e7motHGxqOUEnlAbdbQJeKP/MDv6b6Okv18UDcc4Ua64FYItS+z1oiCVrQlqTOEK
         4DVw==
X-Forwarded-Encrypted: i=1; AJvYcCVJujR+/qUw7uH2e5ciQJqesu5KgCKfyMUD7TZE2Xt0aGF4fmeQ7J7U8qjqxLzI5UFPHXX98EdYRAO0TKHgoJznV0x5/o69jlEqHpkn
X-Gm-Message-State: AOJu0Yyl/VuXMT35GV10cCkyd1QBXbXayhgOVjdYn5c8DTXZrgIleQcZ
	hAn3km6FMp54gJm9WaPR5vFrqVNydseFidAIqWsR+ts3YiLLH6fGyMY8pTWMkyUFCkk/HXUjAsz
	bIKbV9Gn9W6AHQ4w86/4pZiEQA+ZIlPEo7wgOTOfowUeqsqeTeEfmDNI=
X-Google-Smtp-Source: AGHT+IFU4f03ZjvncZbdrXzXkVo0rpMKA/5FLqVUEdHywCy6BHCHtXYsDtg0Q9xCSX48Dp1C+/EwiWItU9BDpYG49ks9cOYOlbX2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:474:ecf8:1f55 with SMTP id
 m35-20020a05663840a300b00474ecf81f55mr190193jam.4.1709555821881; Mon, 04 Mar
 2024 04:37:01 -0800 (PST)
Date: Mon, 04 Mar 2024 04:37:01 -0800
In-Reply-To: <0000000000009dc57505fd85ceb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cb7130612d4fb95@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in rcu_core (2)
From: syzbot <syzbot+b23c4c9d3d228ba328d7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, dvyukov@google.com, jack@suse.cz, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	rafael@kernel.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yukuai1@huaweicloud.com, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e58b32180000
start commit:   e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=b23c4c9d3d228ba328d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d6dfc0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161de580a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

