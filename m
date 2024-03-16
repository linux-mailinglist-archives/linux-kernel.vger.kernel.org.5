Return-Path: <linux-kernel+bounces-105151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA187D9C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781E31F21A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AB517997;
	Sat, 16 Mar 2024 10:26:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE58E574
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710584764; cv=none; b=iPetO3KNxb35WrZP6ZZnGYB5da/hrqyVmXNc3R3TZX2vGrVZjQzjlnbcwfc7u8n8OXlSF19IOfvjTgoR6YySJf+2FEgoU9V9aBD2eeHIM1TkhdVJJBogCCk1704sauOvuYERvZS5GApNFLld3/hkqAD6G+joGrC78BDhnCF7jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710584764; c=relaxed/simple;
	bh=LS5piD0N5UI4DnYvG+MOh/IcTaDiEWobZyKZk4rkets=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EbLoXsz7HdbbuMyZ1Xw+83LVDNhS7bErWKgKibd8i2I173Ely5g4/DaUi2+3NIkeWkUZBYtajWK6Dg6wIe8gGUidxS6hIbmePZEi4u3oXSmqEe42lXmjoNGg7PoCqV6BGUC8z85wW5zEsfGTqcOGAXo8MKz4tiZ0Pp3V4wyuELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c49c867608so259256139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 03:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710584761; x=1711189561;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSxsOFPpmjiK0+R90s8gz03QLZffsiykhLXSqmRTt3A=;
        b=UW+Ij3kaDR+m7ax28+ZuM2rfNTZht6uQg+4QtcumxW59yVg55cN+ngbmNGcpCeWAh6
         FsS/F+okPv0gcJMHBP2l63bbOkz6EhEHcVG2AFKuHoUqgIyhERAOVzEwd5ZDNy9W6py/
         sNXYF/hp3fJ00N36mRptzKDVrOmAofHbugQ+hyKB+iuOi3ApqLjvT0RBmw5eat5QT+8m
         AoZiOXTdMbH2a2TOqyNoiEAcbRelsDb7Jd5PoPQ3/RmIq6BKU5zym/GUMJHXcIbDO3TQ
         lsWkWYxVshfhYgOzpITGKI7JWUdMrtXQF2tOOs+qHOsk0Yrf2qls3kxqPbhvUVehAgN3
         Nw/A==
X-Forwarded-Encrypted: i=1; AJvYcCWJRNbLMsvWpJjHb8BF7wZQsVWHK2jFaSSVNk8HQJC4MzbLMUD5qZDO2RU627Ffva2hFOjfHUbS9WYKxuCChFoT7nGqJKHtl1VBMdw8
X-Gm-Message-State: AOJu0YxV1QJkTOOrXYojOLSBELMPEeed478OIN/Ojf9TgIGdnt0E8KCs
	j5e88dhHruLx0xBSzZLOUK436rotNq1CJI3R2IKD7bbSkaD6CYXNx+AJy6U/B8nDZ9mHauAR/B2
	uA9ZMvsWdEfPCHXxSvTVrQcMJQ/TvEIxzxzl8beqHnIb58uoIEJ15TBA=
X-Google-Smtp-Source: AGHT+IFetWwE66+pTLbqrmWdS6j4MfKO01pUr3RYDeDV+dXBmHHar3doTpd6r4v/hjnmhX807j7ccOkYBtVyqz8ALJLEZ12j8A8h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:168e:b0:476:7265:9bfc with SMTP id
 f14-20020a056638168e00b0047672659bfcmr287133jat.6.1710584761725; Sat, 16 Mar
 2024 03:26:01 -0700 (PDT)
Date: Sat, 16 Mar 2024 03:26:01 -0700
In-Reply-To: <tencent_4DA6D5F366037E896283B2044DD771B76005@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014c9cf0613c48d88@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
From: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com

Tested on:

commit:         66a27aba Merge tag 'powerpc-6.9-1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14619985180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=f8e9a371388aa62ecab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110a1d66180000

Note: testing is done by a robot and is best-effort only.

