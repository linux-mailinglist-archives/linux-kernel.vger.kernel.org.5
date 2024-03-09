Return-Path: <linux-kernel+bounces-98045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA75877404
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68181C2134A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3851021;
	Sat,  9 Mar 2024 21:19:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527550243
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710019146; cv=none; b=GGD0bF31+2l5OOux0LQGzd15QTa//dcBQOiqpbjgsijtYvOFsu9cLUE/ei0hGiLo2Hib0xtp5jEEVfhYb7FzawjkdSnQv1mvTvlnZkPe1micPyYVTK3JmMjKRlEYlyD8OkCCNP+QOZe3UzKCgQCwpgevizpqt3izkUdTBX3U3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710019146; c=relaxed/simple;
	bh=Pa7sx8/xOTjjXflylsOjtScryyrbysvuk/h52s9G43g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mdqpclhgu2lDm9WYAfUZE7Swwh2K83viYybm6l39b9JVQ34OWYJRtkUxY6RJASrs+aGY850Hj8cZfpr6XJ7Ht8ncu/zW5gRAETeX43YxzjTPIUMybuLFphYHP9tN2LIq6Zf4xXampkFTcV+O3NH4sU0qU4mbX7+tBBlcMQj/7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8aa6723e7so27545239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 13:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710019144; x=1710623944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRFBXIh18wCLBO2+SM4FmreOxz5t2k1uDB7yZ8xEagg=;
        b=FGAUaFGVni9AfFQwK3xXVNxBgtmH2JmFlkLOJcrigDNi9Eaa8I/DlMGJVz56en0S4K
         hrMZSWo5BKu3n/7RH3MzS9dKMWEB2I85DnQS6hUUbA0o/d8Hkc4ZVmZjp8GlSFH4Mato
         65JZ/dm8KnZ8++zEOI3nVxtjJQMVzXw13Tm3oJZ7k38qq++YZ994wzRGE92MwvVq5fDN
         ir7I13c1gN2VZKUZauS0fXhytZ3sYPmqIHV/URfCFEP02Rbp2TVdC+fkflC9cghs5xu2
         psvsuz1AJoIBUxy/GuLPi29nseKaerqthTafqyyljUiC0kbDIrb8KFrfQIVqRZ8PzH6y
         qKxw==
X-Forwarded-Encrypted: i=1; AJvYcCX7ujCACxxnpfO83YQgvROcxxoiH8cFd8+uBKDTGD0ZWEuDQc4E/ihK2BOJoIFlSFIEJupJg8Xcnz4O+c2Rcli4vTzniYry92v/Hlcw
X-Gm-Message-State: AOJu0YxDcsx45quggqsEzwNqxe0JIw40lY3MGWc9yS/YGZcDLnpZJm3G
	I74Seb5Z0aTzrm8bDUQrYS3+iN6jM35bUalAk6UCYyt58rudHiXb8zHkppVRxiqVS47mQfX/7x9
	JCSgquCi13A4z483etBj9kEkzHK1H9cXPyp/UA34Kvkbu8FOXtXpwELU=
X-Google-Smtp-Source: AGHT+IFQgC/Y/uWGVhcWmNcl2ho4MafDLtAn5gwYRiBKdk1E4x8S2kf/9BZ6o500V0XRqam5OriFuXksXHwaP1QMt52X96IwDuf6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1653:b0:7c8:4198:c430 with SMTP id
 y19-20020a056602165300b007c84198c430mr36002iow.2.1710019144429; Sat, 09 Mar
 2024 13:19:04 -0800 (PST)
Date: Sat, 09 Mar 2024 13:19:04 -0800
In-Reply-To: <0000000000000149eb05dd3de8cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9c150061340dbc9@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in ntfs_iget5
From: syzbot <syzbot+b4084c18420f9fad0b4f@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, kari.argillander@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1649668e180000
start commit:   3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ccc59c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10928774880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

