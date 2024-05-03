Return-Path: <linux-kernel+bounces-167276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FF68BA6EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA761C21A21
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2904139CFC;
	Fri,  3 May 2024 06:18:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBE139586
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717088; cv=none; b=tSEkCKHJbpH7B+nCgpPWNK0XwErzeIJ3TsQHYKACboLqpt+0VolNy2FHAcOeyEcLUP3cp9V4O7ehUxyHQb/oD7ZLuAjEjktMFChQjGEh1+VQ/PVSMDcjq7a6Szb6lKZ6W+plv0VCjs7bg8n8ERaBAfPhQIYrflGBtvxNZ5UKcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717088; c=relaxed/simple;
	bh=aEEEX8bGzekyicX2J1VZkc93HVVbjjNiDhTsEMtYrFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JVyPZ2s5/Wra2EzSROFFDUT28rPVVlrTaDa3gW9b4GcNDUJYl9flUkJEzQEijlDHwlLUHrRhu97cIXIPdXHNG/q7gRgbfsonh4GBLhmHKeYb9FAh5fXzdD83oB4ueE+I8iYD6s4yTTGr8OX2dNxgdj60i3reworCXDSgm/RCeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36b1fda4c6dso90034085ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 23:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714717086; x=1715321886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX7vX7Zd+C8yCjAehdMFvbISFNkOBbU/CK5loF9oZgw=;
        b=Uv31kuzie2Dfib3osavUwowl0/LlowJ8W8znWB2UlSw4V8s2bxGPK20Lm+TO2CNvyD
         dDEZmMW1y0Btfz36A1hujKTJ3nHpErpd7uzQGVI/GCLBtRi9nUepRSz1ScyP3ee4rwyn
         lHPxupmeOGtqZ5dl1PSSC10u1cNryW5YoyEKozTMf5eJ+dIsb12lp3mml4ksLYnfNJ6q
         OirS9PUx05JVxUeyPozqdBpdTPWjKxSYPwF3AH9GbnWnafNhIgMhERNJ+MNYTnyFFzRr
         95WjJSeI8Klu3vUARYh0bneYO03b82OwFg9uxoZ6h55MMkHX5F7KjhOrIc62tWpKYEwc
         6SUw==
X-Forwarded-Encrypted: i=1; AJvYcCURqQU+5dnkYVoNdKjxqucWvJOnb0B1fx69q5DymEljSyFQsdHInJty1hhPUbD6LTXvRu0Xxzxu0CdASNsra4/zBuJmUU0fhyi2A9md
X-Gm-Message-State: AOJu0YwiJHahUHHtLcQyeLWBGwhCmj2xwB/9M26vds4r+WloSFxcWJeV
	zxbPnU71leE6gTs5FtFRK8cW6BVi+Vgov+ysiCDayHJEUrsnd3skrC2yVGd60UB++oRCKCOgs8f
	LUhvgLokmQ0LZDXqHsgoC/5DzedtCnNOr947jD63FM61EQEV42Zu74FM=
X-Google-Smtp-Source: AGHT+IGM2IrL/D4YOCUUpI0zJUlZDWjDcMG4u7Sj9XBbOlboUBNpf1/RTWsEaBp5xcOHaVFPWwNa3JfcPPWkXZS5cMJ2O+7qInsM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:36c:5520:9597 with SMTP id
 l2-20020a056e021c0200b0036c55209597mr72685ilh.6.1714717086281; Thu, 02 May
 2024 23:18:06 -0700 (PDT)
Date: Thu, 02 May 2024 23:18:06 -0700
In-Reply-To: <ZjR7nJdjXIgVpGlV@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d18470061786ae7b@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (2)
From: syzbot <syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com>
To: hch@infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com

Tested on:

commit:         5875772e block: refine the EOF check in blkdev_iomap_b..
git tree:       git://git.infradead.org/users/hch/block.git blkdev_iomap_begin-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=109d76c4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=0a3683a0a6fecf909244
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

