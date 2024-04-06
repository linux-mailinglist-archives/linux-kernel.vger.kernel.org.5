Return-Path: <linux-kernel+bounces-133931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED289AB06
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A651F21D1F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6E364AC;
	Sat,  6 Apr 2024 13:17:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D754C84
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712409425; cv=none; b=j6nisbtrboZ8LVVbInXLvhLsCoqSqF5/cYrcgxioun9/g9VPydQ0Lu2vzX5jbsxqaO8tcW7DHxQw/R0+kjhwm6E2+e3q2RKGWJ7DhLEhnAgrOsUMJ9oScyR/K12J8diCkrrG+tzjlbJh+OEsnjfh3XBDNIbnRqdHDbBrQkEy3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712409425; c=relaxed/simple;
	bh=KMhukZtgsZO4dHvIkftEz2Oyh2R49vTRcA9s92Krv9w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lB3luNQlPXkz59uj51tWpnxvNJbW8MWT1Yazx5jVl7MGHzvlt6s271iiHel4sJWisjg3EihJ6ccN24Y1FrgzUu4XcHkX91dZL/+0i5i1LdvDIhHuq+MSzAnuLqwApAQOv/Q3B1R4vh4R2RzEV7zjiVNgv9c5ZY+iqfeYuhwQA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36a14031548so8218325ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712409423; x=1713014223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKnAyi0kK1rIW0irK/rA69jp4sKFJlV7rbD/uJ4u/zg=;
        b=NynnWDqy/68zcOHbjbHpgiIRabn70jhUIlMVyPyjsEYDpBMb5qDktobrLZ5VqirIlZ
         4WKKUZV/6/jj7f5LANgYSFFd/iWY+frbfpPDTv2uz97Bmq4nIRyyzslA6ARojXjSf/B/
         V94RiBe2g1Pg8nK1P1hqd53Salamek0eUb58yolfacZ0uUaqBTsN1ExLVTAn3Io1MzRy
         Ju/QjuF/X3LCCL8bizsJLkYtry3dp265NQm/QDqNOV4SbnXHKbGsyGXhoEA5q/kD9DLw
         N+q4PZM70o8aT//6cFJ90HduZNwCnVQ+feGksCQEVwnyK/2phJD9E6P8YxLXZcVb3npM
         bb8A==
X-Forwarded-Encrypted: i=1; AJvYcCXUbSpLOYEof4mLYuGHczuTnyC12TcWRqWwOLegV2orZVgVSpHo788oDNXuppJSo+4aVIDQBKfXDg9ZEYbBO+xFdFxOcaveYV66qD0/
X-Gm-Message-State: AOJu0YwT5hDcsPLgw7tME2mRMr8LMf86nn/J9hEwpZrVw4+ja2UOL/EI
	t6GvSPHI8wLyzcExnbqVT85L/QrRp5k2LNYku5m9RPiMnG7h6jCK9KYEzl9nJpSfTUZHm6VUvql
	f6wKFcVYEnVUYDwWHw/PuctqPCGKF7tdf9dNRXAuuZi5lKdyLEmHdZs4=
X-Google-Smtp-Source: AGHT+IG0hSJmbkQ5ogGuWJxF6wapg0inUjEE/QkjwBMYnnoPxVUmF10miSUzt5t/xPUfjyLQ6nppjqZlxtcW9UDsNvvJ8VNrCF6a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220e:b0:368:d130:a718 with SMTP id
 j14-20020a056e02220e00b00368d130a718mr304148ilf.0.1712409423144; Sat, 06 Apr
 2024 06:17:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 06:17:03 -0700
In-Reply-To: <20240405100620.953-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000607a7206156d63c9@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in l2cap_sock_setsockopt
From: syzbot <syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=136840bd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66b62423625ca66a
dashboard link: https://syzkaller.appspot.com/bug?extid=8a1d152fba6b41f760ae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d15f19180000

Note: testing is done by a robot and is best-effort only.

