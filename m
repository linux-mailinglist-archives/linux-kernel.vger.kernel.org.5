Return-Path: <linux-kernel+bounces-112260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F47887792
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A059C1C20EDF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D8D267;
	Sat, 23 Mar 2024 08:44:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CF1A38C9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711183444; cv=none; b=NgBAdlBqXcEghzsZ1r4ZZoL3ztudb9K8btZVD5QOcjrUncTcePg1DzJ/M+muBIOAcF+aC8xJo5Eu35YSaWzJgJ+2GtdyL0Inwps+52eAfgUMLwRRlOjUjwwwskw0u4HnDksNL5dncgZ0lzu0mR9hwOYi7G2PZwkw66sNrvIO43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711183444; c=relaxed/simple;
	bh=OKzkA6r4/nNLv2GbsyQBYCkTS9AeC6nq+PsIEjYgEnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wq2fXUjgrO/D4GtB3Ov+e2hzyBeO60w0v5LKH8gKk7cYr156E+BHyV2UG4PcxRE/5odLSO2Hm3exxvdiy2SEx1IkBrRHlpDPR9VRwMYfqYmjJkXUuaYefiiQMOZSk2bpkK5ha4AvvNhCQ6VV4tEgNtUtInHHgUKpehbK1QVWZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3673c792f3eso27206565ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 01:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711183442; x=1711788242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIZ7wSmWYj0M/zWvTvhHyBp2dQ3AQTUKieh0YLkFYgY=;
        b=Kh6pFYXbjbTWetVDG7h9XA0mKbPOj7EiEYBlTgrOzA7VoxIgYtHuy2gEQCy0Omjpsb
         7tIPi06Z2XdDYJJup0RRuE2iuVMxOFzUkIf7BY8pRcvChbTbyrNw09/mjdRmi8jW6N0k
         1A9OEn6txndKcM1ij8l4dnDGl7S02S4+XUh+SxjUrqy+cjlp3ICRb4h0K+H/KuyL/ALf
         cUrAIQUNN5VneaivlLkyKBqPfjVRVNk6vqAHxT01RtYr6ea4RubxFtKvCUrjtAJ0MuIQ
         wyu5tp1l1qqXglzDa+JOc/35e/0hKUQPxOxb1WWUIjEYODVdRptJ+c9w3Bbb8PmLWsjx
         xP6w==
X-Forwarded-Encrypted: i=1; AJvYcCVrsNx8vKtr5OTtu5cbZLSFSwOp9tPSdA34u5mtvP8S8l2YL9EKU6fBk0Vpblf3CTOv0LhWAPKmJYmmHdjE4rVFsXf+ta2+/CRKnYhq
X-Gm-Message-State: AOJu0YxJz4Xnz83oEo6l+BRyT+zWlMPYxHl7JoPxdfqke2UtjOVwtFz/
	fLa+/DEdHhmABbYUIKft2dYbwFdBRA74mY/r7kq1zJ3fcZjd9uklGEFydKApMr5a5HxTuGj8cKb
	MKVH1+LeFjfDbzG1QDF/E3x0df49nT0/SckKk7XYt0FUQ0HERDWy3Euw=
X-Google-Smtp-Source: AGHT+IH3HUjKZZCJiY0/DvlOQMd5z3v8fEmpqW3pTr5wQVaMOuHeLo/3i8XXXbCS7jTOhksKFFzTsNJIZLY0x9rB7BtZQthY6HK0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:368:79b4:dd11 with SMTP id
 k12-20020a92c24c000000b0036879b4dd11mr105141ilo.6.1711183442642; Sat, 23 Mar
 2024 01:44:02 -0700 (PDT)
Date: Sat, 23 Mar 2024 01:44:02 -0700
In-Reply-To: <20240323000223.2660-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e99f806144ff1a7@google.com>
Subject: Re: [syzbot] [tipc?] BUG: soft lockup in do_sock_setsockopt
From: syzbot <syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com

Tested on:

commit:         707081b6 Merge branch 'for-next/core', remote-tracking..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17e6b481180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=10a41dc44eef71aa9450
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1222a94e180000

Note: testing is done by a robot and is best-effort only.

