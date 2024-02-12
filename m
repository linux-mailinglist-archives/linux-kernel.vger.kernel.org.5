Return-Path: <linux-kernel+bounces-61029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B84850C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20318281985
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321B217561;
	Mon, 12 Feb 2024 00:00:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9225CA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707696006; cv=none; b=CQIv0QG07guMJX0AJOJaZzZr+uvUpJP4JRxgt9PLOAHLWG/E9BIPLostEMKA6mvacKkCTTwmp5cnBL8ESbAMkEG9AZQAUw0k0MNGyLAVVLgJ3k/76mX0sv5cyX6NbAGejQtlK+GzXjF3zBDJORVYNkr8EQpDJdZ1L9QQ0FF53dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707696006; c=relaxed/simple;
	bh=JQH3bGP0Sfaxj2eCFe5H9MccjiugtupxIysd0pL4ZXw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IDJxFQc+xZ3ntblmy6XxUl1fEHCDtDm0L5yfVSG1B3JPISvEClmYC5fqRV9WPdy/o+1lHiY3izGBC4BqpwS3Gco/utUNL0xpyAAXd0HAbwpRPUpmXbDzks/zzr4f6CzoIrV2PPXoHU11MZNgtIwQUTmmc+5VsJUm0XdKni++Gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36387e7abccso19500745ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707696004; x=1708300804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEtJpQMQObyxFAndxkl3jMzodLW4BfLQf1d+4n4EzAA=;
        b=oe8SeyNxHN0X1InVEEQiSkj7DWI012yVLgTZkV2WIvlCC9T8cgPzAmud4DdU9WqEDT
         Rp4p8CWSmPX4ui5O5EvteC7DkYgjOs/xCcutIBV0yjBIKgc0/f/FF283lYlLHkKdASyB
         Hde7LjurfxXPZmxHhuW1VgH/AEh7/52SnSt+R8/sUcD8YDzxL8JOjANqVZcVj0pDBRga
         CZy6GjjfhSc9ydRkgG3UgjikyGYY77xgPkL5q708jTaHPNgWbihnWGtOjhKC/xASxGKK
         c3TgGMlV56Odnks6Jko2Iizw7vH5BWRyU9aXg7HETrlCZbzhEYCPnY0B0JdJ8tgMIMj+
         wwyA==
X-Forwarded-Encrypted: i=1; AJvYcCWzPsYnZjLChzRH541zol5ADBFNGxtUj63K9QhhnUc7z8IEufCLYt9bBuUurCka6lAv61kG2isXC+ThB2ZggjCIj4oDM1F6cRI36eCz
X-Gm-Message-State: AOJu0YwIQoKRaVv/Ej/L4NGAIMkDnClCEaRSeAX0SLXaqr8HwuIkHi/+
	deOWcViwsEigqzTNAPRNSeKRzp2cibJJVmfwDPKYJ03VegsKT3SAPKWRRw0AweGEQIW20BXVJrt
	a0oyHco2NvDlYhcyD89rI9ItY2oZcmT4ZA44Ueem3SbeYIzXCi9raP6I=
X-Google-Smtp-Source: AGHT+IEKIuOMw8JbKg2Kv6fI5S3YSY+xiVn8YLrrANJRKL7SuSEdLpBJbWMZECkqP3yzIeQ6TZFBLMUg7q2TJNYj4CqXCoNyoERc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:363:e232:23c6 with SMTP id
 h4-20020a056e021d8400b00363e23223c6mr486052ila.5.1707696004388; Sun, 11 Feb
 2024 16:00:04 -0800 (PST)
Date: Sun, 11 Feb 2024 16:00:04 -0800
In-Reply-To: <000000000000e17185060c8caaad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9df7e061123f594@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in lock_two_nondirectories
From: syzbot <syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	eadavis@qq.com, jack@suse.cz, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, willy@infradead.org, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15477434180000
start commit:   a39b6ac3781d Linux 6.7-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=2c4a3b922a860084cc7f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1687292ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d8adbce80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

