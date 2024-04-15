Return-Path: <linux-kernel+bounces-144559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033728A47C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BF4282EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F971BF53;
	Mon, 15 Apr 2024 06:07:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DD17BA4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161224; cv=none; b=MHehNVJC3tf/JbmAYPJK/i9dRx2736JCwnnuisFi5hCaXleH/AMh/EOUKkm05G6Fl3xjOaqyLPcien/ndnNJbbFsqOquTHHzk8pxaNkx6aanajfJGIliK9lk3/OA6B3A8ddm52b2AFALLc5xjEgb22Wrk1nLItoBweRnXBVKQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161224; c=relaxed/simple;
	bh=SLDGSOJkil5j8BWrdqO6QvDaUROBT/7AIb2uclUsM/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jwbGBztA+eBz1q3OGv64JJlC3uCxD1+G9IDfM4xpw+M2aWQXa/39F4cf9CR3YolItFWkD0ZBvnuwjhoIkN/f3IYeFpr7kLDjWgEm0rimSg/jJn1sosKkuF6lroSTIQCE6xDrU7AARC3kB3pMD2VE3W7OmTesEhIAaQ5OK1OR0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc78077032so422885139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713161222; x=1713766022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1TbaFqI3KsB45NMWdOUiOzp26MTBzv6GMSvaj3exC4=;
        b=L3s+0xmj1bURd8DvNC/RhPXw6SY8uQHhv8oeqFVUBnTXbx4Vv7vq09sJiyhmmUkfX0
         ahK7xzR1SmMehAHAsoGjSmZAYLHWhgGkCztxcxqLDq5++SqV1OLGP8mI/pjY+0TJvv3m
         kO0KmCgFezFBN4dWrzgQhbD5HulghHdfahToN+92SigaDZ/SXVqJr524bzX+fXEGxkEN
         JRGsp9rcLzge6aCiw0mKY1HNiDpEzrs5QFxlKaXsMPd8bdLYoa+eURIFG7484TPz8PmJ
         dvl2tQQbgm9kU6oWzwivOfDuyQUkY7pxU01a+EyO8zWjoW+Fy/wCbdhNx9yLRFSD7eYq
         cA4w==
X-Gm-Message-State: AOJu0YzW6dT4k49u1j7D4N5QoZ9o4P4L2E6oATrGziK3PICul0+i1IUh
	3F3I+ASCl1kEatbNc4nfiIVURQEwxpoGm13VXa2D04upe/MjDWqxdl8nzjjdQ3g0SWtnMU/Ss6Y
	wGYDcuSsGkF+4DkKcUb/VaSmiuRF9YPxVMIavsmpCZ245PYSkKdcxSJc=
X-Google-Smtp-Source: AGHT+IFhsHJKyYtxA5kA0PQ3DGmwzKqRIjGyP+SqZlxbia/dZT4Q1o+nZ0FKj4U96pBjbJ7M0VRLWI7qGwKUOpQtaZ2Gn55/R6Ls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:36a:391f:2508 with SMTP id
 j4-20020a056e02218400b0036a391f2508mr629046ila.5.1713161222294; Sun, 14 Apr
 2024 23:07:02 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:07:02 -0700
In-Reply-To: <CA+LQOUdHzCOZ3aGuFxAMb0npwJWSRvCQROnB5yFtmgFTQoaLtQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000191d2a06161c6e4b@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in do_open_execat (2)
From: syzbot <syzbot+fe18c63ce101f2b358bb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mukattreyee@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fe18c63ce101f2b358bb@syzkaller.appspotmail.com

Tested on:

commit:         0bbac3fa Linux 6.9-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1750dd43180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a0771384c447c6
dashboard link: https://syzkaller.appspot.com/bug?extid=fe18c63ce101f2b358bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

