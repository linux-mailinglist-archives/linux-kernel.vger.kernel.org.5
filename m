Return-Path: <linux-kernel+bounces-107161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2787F857
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8C3B21C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26F7524A2;
	Tue, 19 Mar 2024 07:26:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590753E04
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833188; cv=none; b=JVkZwMxlv3m/yS4SpenrQT85bcFvyenwdOqH7vMs8PGMAPIZWAciGtHkVLtKquxekSyhYv8r4cDA+5GPt7+re0ldrH6GNRynGLMFAuKVEp+LhMyLm7gb4UiQKS+8Ka5kZuqSWPFMrZNZfT6L26d4QrKE0x6UpOe9ZHBop71yK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833188; c=relaxed/simple;
	bh=wI1T0EzdWk+Ahj6218/EOyE9S19iLjzHRDYJ+5toT40=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C3RfqZ9OgHUYq2ApOvjYhhUc/2+7TGCZj6CHph13ylZCb0w2McGha6qNsJNV5x4ytN1EFcQZN0HWqEYRPENXpxX8p6UiJVwozxG8iimUdm56mkTv9DJtqE/gQCNn/VNVMK6OqfsDxnJZiBjdx5oFWg1gG0Nz3qB/Ae+i+Kf11cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36660582003so74521985ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710833186; x=1711437986;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWwA4gt2QV2ljMc7dh01T3FMCTXDPFNrXBsk1q+DFxU=;
        b=J1W8dCjUL1dsvOeq2cRysYF7s/UIYz+/bkOrjOpbLU/y1hK82rjsdsq5kQsQnsuprE
         4mS9+bO561kRgomOajvCWbpLuCeX6LhUh3/sEqIUPpB87TTxY05kWfnBVyNo0Sog0vns
         zxJtuobOL2UHpDtmRObmr+UwtS4DbKDmn/1RmfUUqrWK6i23sOzLvefUxiWLrA0e9y/V
         8kJ0hHs65Voc4O6R+unXyui/Tw7GhZGn3H1mKqky/GqY48FaA6PCMzEfH0/ibu7MG+K8
         tQ9MKCzARoK8oyDIORS/VSAkARhQUEwYGRjK4NGcg5a38atgcbnwUJBISz2fK09kpBEp
         7fTw==
X-Forwarded-Encrypted: i=1; AJvYcCUCNioeYoXdlavDtAPQrQLOdxZXSlK1NSm9Hs5y/Q/rrHbK1mIR7Yq4Dj7fD/OPmMhxUfou2ct8lsla9mLBMK1ddClu8L6LjyyuSJmH
X-Gm-Message-State: AOJu0YyUu5ib1mQpA/q6cIgqM9qX+7FZTswKCvMRQ8qG5vGa185tzUm/
	izSBWesnsfDMoNwsRhmO+xfR5Ou47BF8rSc29XddjAazaIcg3FMZDJHuyS3ZojBuUMn8E2vdqZO
	fuDU4FZAasqEifQ5aRxiCDEg7RxpTfn9MlIqF6TjRQ9apWYmT37F5L0E=
X-Google-Smtp-Source: AGHT+IFtYdMhgryWzdomQCSC8tYxXzyfdXIUYNX82HD8z/KnQcHKQ+ghCeUabP4SxoSefeK7v0plabTaWXIqe1UgCvUuMsNeDBno
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:366:b4c8:2150 with SMTP id
 v15-20020a056e02164f00b00366b4c82150mr59828ilu.6.1710833185908; Tue, 19 Mar
 2024 00:26:25 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050fb620613fe6483@google.com>
Subject: [syzbot] Monthly v9fs report (Mar 2024)
From: syzbot <syzbot+list27b848ebc739cbe61649@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1814    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 273     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                  https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6
<3> 119     Yes   KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
                  https://syzkaller.appspot.com/bug?extid=7a3d75905ea1a830dbe5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

