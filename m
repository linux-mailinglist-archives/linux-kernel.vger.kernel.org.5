Return-Path: <linux-kernel+bounces-104435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331787CDB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A351F228A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E325613;
	Fri, 15 Mar 2024 13:07:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EE2374A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508026; cv=none; b=uMBRyPy4dNB3Inb5QJ51977z5t4MO7P7d2ezKVdRcRgAEZ2nWeqWheuHxSc4uKOBnp8tWY5aA/Ih1gJq+MUT03yGNH/ZNF6VXIx0JtrPZ+BJONHPqrNVoWLQPQv8V748y0Lc3Jd1LEYgz0Ey2NJ4hM2f8x+58nmZhc1hrB4w4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508026; c=relaxed/simple;
	bh=Zk1+QM8Mp7D6C4Ax3bAQLs0hyyOiEgbA7bCMgIKQ2ZY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CYNkBTklj4vjJSQVACRljEJRBql7P86QNhd1+VRRoq7GrEF9C5pcp9EU7q0p8XrutnLMX+bOQ9cVOMNqbnUFitJ33k4E0/Vi8ioEfrnupCYVEISwHt9Lxi82uQ5kX8vUzWG1NctwECLSYPfiMZNjALGHRaDLWoUD6R2msFnrXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c874fb29a3so146010139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508024; x=1711112824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUpBZioC/dn8Fi5qWaAgB/XKmxFecPjr1f5eBhNHbfc=;
        b=GMBBMx6DQfK29DcoUVQ4ZOZlnHeqn0Ngu5fLwjohfgnPM9c7wBKb/Hy1iubCbMCQSj
         FyUAymMpAe0Me272bxx9DOj/kIRbyAMOcirTzWCtyUYIdGwddwzJmS7mFCPqvMjkbXKY
         F2qegzne+pmGzOgAcjdE8hvFtTZWc9qdgrO7H49RT90LnsYX8KtrgbdlQMERUFb/rAco
         hflkt0RHi4VkQZpMIVw/PUOGsFGYkfVZyL4fOniFdbbGMp4GbNn/bSKtw18abS8hhkfE
         WPeEHv5wztVIKf252QrqZ098GFpnolVB0cJ8wBNM2j1PzMaFTpGxEcJPjZ+RqoHe5CW/
         1KeA==
X-Gm-Message-State: AOJu0Yz+lmEyjr6HfG6GFyq0xmJQzayBfFWdREJRMmIW0ynQe89WowLg
	7XFtS8MGFIXX9jNySStxY7AEvu84ZtjDKdity3Xwh3KvWzlD0Pzjut+mwILxQyznAG93gfFTdie
	jdQkS+ed6ZP0155th2bx1bJg3B+kZjLMPVJY/sU+x5sDF4SR6h00UXbmFXQ==
X-Google-Smtp-Source: AGHT+IH6HawuAmz3XIpz8TEkIlnF1hWQEXhjEgar1mM+g/YbxEJmMhh0kmD4hvaWWh/9GfhvbJ9S9wmz3CODTooSOb76gaPtVjgu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2165:b0:365:26e3:6e47 with SMTP id
 s5-20020a056e02216500b0036526e36e47mr253652ilv.0.1710508024164; Fri, 15 Mar
 2024 06:07:04 -0700 (PDT)
Date: Fri, 15 Mar 2024 06:07:04 -0700
In-Reply-To: <0000000000000b9a510613b0145f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a81490613b2affb@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
From: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit beb45974dd49068b24788bbfc2abe20d50503761
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Feb 27 08:52:45 2024 +0000

    ALSA: timer: Use guard() for locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148a87b9180000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168a87b9180000
console output: https://syzkaller.appspot.com/x/log.txt?x=128a87b9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=28c1a5a5b041a754b947
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14835185180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1132fbfa180000

Reported-by: syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com
Fixes: beb45974dd49 ("ALSA: timer: Use guard() for locking")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

