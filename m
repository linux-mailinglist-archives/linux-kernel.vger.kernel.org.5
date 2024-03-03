Return-Path: <linux-kernel+bounces-89639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F186A86F373
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 03:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798A4B22954
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D1D5CB5;
	Sun,  3 Mar 2024 02:55:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72237F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709434506; cv=none; b=rvSUWsk8FYpiwhhP+3yK4j2XigBTAWYoXWs1SeyG0bmFW9Hxv8Ur0AiMmZmgvs+q+W5AtoCUOw5001pISJVtImInkfHMKGRBVzrjfBBtehEwOZEdTSrnzJ0z3OcNvAsbXgIMBpxHd+Xw3SXxAQBal2mOSaWAcZmdivVFtz2fDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709434506; c=relaxed/simple;
	bh=DjSs0mQBLZI38L0jzSzr0Wlt9Fby7CV6ad4XDYFzAq4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ft1O96aUP2iOCVDOvruBMfKIkA1ev7FDe9Og/d6wdLL6phczSpkpZWNW+zYKBBQkh619wMD5mxZq5Ax1QhI7kgle3vvXZ5Sn89y/e14AlrRiGBW9r0VhmHfTjmHmqzdS02JgGmz28+qDZUicBU3F61MXfI9rSeNsEXawvZ2kEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8364e4a31so76242739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 18:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709434504; x=1710039304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFlPxAxbMaIBt0XzyHKJhPUPplbAYy5uR+Dhxwse964=;
        b=LQ92VJZqQNz5nmoTb+17PjXD5RNymPfzZldshFahhRh98UzEjwdlxVn2yArYBDDfRY
         S4j+MxGNA/cFS1PLEXcJOheQtNhNggC49cFeDa/CfxblxM2vVKJlKxQYyJ4Ah5X8DgCf
         TNw72B24MD7U1Psai+19gfrCOFXWb5CcjzSAwBbvO/wtriJfRu24LUo50F1t1S3qmY3Z
         X9Al9yupNNch4whKiF/I8cTILgqZajo0CM0mD/WCle5YZW8hqIwwhiQXaZONOgBDDeSj
         0x1eyHTXeXTMgOsMkckcbiUTrsR6P2hineTMNfAOmSkVw1uatUFksbpT2MTpyeaVb1w8
         EL6A==
X-Forwarded-Encrypted: i=1; AJvYcCV2AQufwLxdtXmJLOpEeo5h3oOGbf2NQ1EYIGmKbo75kaFkniRQZJUQ7wL4u1ETREpD7O9t+3Mpj4Twu0wH6U4vS19m8l7UvcxjxWmD
X-Gm-Message-State: AOJu0YxOhxUCKpHB8Bts3IGnG2bL+xtL/TtjPfLcvMN58WW7PuBwMH7a
	es7mo0Xapf4F1lSosGa77TAZKVFIINW8bghAxClsHLrerBFwdOdXhKcTILkaJZsS8In6Ru7ZJCE
	jF7+BtSipZEi6kzrhvTBBPjocghxFA9U38AyYbRffF8dsz0Q57FBiSBo=
X-Google-Smtp-Source: AGHT+IEuYU6tkBtiTnxAKaOShmToEu2kuX00CZYwDy1lId02U85LwjJQpSTQxzgmDhFFdcD4k6l0A50ZMRE4tRSveH45df3QlcC/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a1:b0:474:d744:c701 with SMTP id
 w33-20020a05663837a100b00474d744c701mr223329jal.4.1709434503995; Sat, 02 Mar
 2024 18:55:03 -0800 (PST)
Date: Sat, 02 Mar 2024 18:55:03 -0800
In-Reply-To: <20240303014351.1274-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060a5870612b8bc8f@google.com>
Subject: Re: [syzbot] [usb?] [media?] KASAN: use-after-free Read in v4l2_fh_open
From: syzbot <syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com

Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12012abc180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa01a41dc74de670
dashboard link: https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1709bcf2180000

Note: testing is done by a robot and is best-effort only.

