Return-Path: <linux-kernel+bounces-59969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E684FDFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C537B1F23ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A711CA1;
	Fri,  9 Feb 2024 20:57:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B6568A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512246; cv=none; b=CliijxcHFvyOTZYraZIMZquob9YX1f1NT72rAuGi+YbplTjdLQj33swabyNFFYbAIC2ol7f7+L8baSBqsWy2ySuQMoB+OymiN0erWOD/teQ8obRsXCmACIdLcaVXe3ddwBi5zu9PJUE7mgdcMojAh1xwoymH69UhW2pWv2u+GwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512246; c=relaxed/simple;
	bh=XAE7ATL/jegVfgrR8lbA/aRxSZgGXPCm/xE1Ed3s4EM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O2d450Gn/dI8Jp1GwgSaagrnhyvlchy4oLypUKpeBBkiawbuKJ4PS7TBYhbwDDh+Y0LUXyiYYUKp4QJlcitk2Fk2NLcgh6G8+rHUcYZJLjSSwjCGJ93mj61PPAkehFKoWcncMlMjCO9l1KddA2w/1eayVUH5lF+fQ+Oh6merlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363d7d5821cso11216815ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512244; x=1708117044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKvqImy8cw1LhvsNR3nEHucJbZLhRfd1laFEvsobuqo=;
        b=jCIawPGAYS4CVGjQ19y9KhPRZdbWlt6SY+t0jOC08+Kq8J3yqJyk0C5BXpBCNQoc3V
         qJmG+XGwpQGunIHVkbM3L4++EHnqS4ioyb2bq7XoxK8D7pvn8JoA8PubazniD1rBcrW5
         hgqM2/GEK8LwJ2MF6WUP/Xj8Lob+XG9F+2rkXwcLALFWKip4zGuho7E9435vjxbu8a6k
         KH4h5OJkQjSyEBl3AqyWBX8FXTUYOdYowp70zgWms8l1Y3R2RNseLWY73223io6/+RA9
         GTlsISTdMoeG9O9NJz9pJ6c2buhf17PkPCCjlkkR+g4JH5OSbNZ+lgbsUmuzeXdG923U
         EGzw==
X-Gm-Message-State: AOJu0Yzorevy2mkGuDHhr5ECyVlFJd6kHS/Q10/xdo8XvCgCGpYM+ERh
	uRVKPixcFUkstaWRnNu0EuYtYe+G55znBDB3mdYswpJVhJ45D0sTLSmsd4UD550uGGFwujI9vmm
	2+zEmyLxWVq6e53bnrNgkjeT8BOXeMgh6c46UGGxsy26tooedHQYcut4=
X-Google-Smtp-Source: AGHT+IHjBL6Pjlu61pfLjoD6/MIvHJCk9lDR0TqrxCAXXPbzCvRe1dhyglslSkJ0rdZImVayHu0FazZRI04/ACErCgkx7HLxvc1O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:363:8f57:27e1 with SMTP id
 r8-20020a056e0219c800b003638f5727e1mr20973ill.2.1707512244024; Fri, 09 Feb
 2024 12:57:24 -0800 (PST)
Date: Fri, 09 Feb 2024 12:57:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c13e840610f92c96@google.com>
Subject: [syzbot] Monthly block report (Feb 2024)
From: syzbot <syzbot+list577ce3954401a176ebb2@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 3 new issues were detected and 4 were fixed.
In total, 19 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1291    Yes   KMSAN: kernel-infoleak in filemap_read
                  https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2> 486     Yes   INFO: task hung in blkdev_put (4)
                  https://syzkaller.appspot.com/bug?extid=9a29d5e745bd7523c851
<3> 182     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4> 70      Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5> 32      Yes   INFO: task hung in blkdev_get_by_dev (5)
                  https://syzkaller.appspot.com/bug?extid=6229476844294775319e
<6> 26      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<7> 13      Yes   INFO: task hung in truncate_inode_pages
                  https://syzkaller.appspot.com/bug?extid=bae3c73c7bf2fe3a740b
<8> 6       Yes   INFO: task hung in blkdev_flush_mapping
                  https://syzkaller.appspot.com/bug?extid=20e9a5e0dd424a875f55
<9> 1       Yes   kernel BUG in set_blocksize
                  https://syzkaller.appspot.com/bug?extid=4bfc572b93963675a662

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

