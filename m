Return-Path: <linux-kernel+bounces-50938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DCD848408
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601CA1C23966
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC5111BE;
	Sat,  3 Feb 2024 05:53:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E3111A0
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706939587; cv=none; b=AHP8vGefvWTrf2oD2ryz8CObO52STrfe2kKJCG024wA7Wj5/60exFxKn/QZSlCrB1PMjhi/y33hortez5H0ZA9nFTNKkqZpONfAjhZP/hFSl7IiC8XYu1bnFGcQOffW4k5FgJP4Mlx1oTU55lvEJPUbjJv6apM7uy1JkYZDaWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706939587; c=relaxed/simple;
	bh=Dv6+KwiTgX21+mWmSuUJZt1XNsXxCjL7pz/dy22/Tkc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u96+65Jz2r0/NIU+b8ua0Q7hMSBVsB/aDY/dkRCC/TsJ90A5ueHWsap2J2rQyu+NM0Z4hSRVfVf61Oub1fLS0Pmf0RzBccxlyXsdVzlSqVToLixn8CzFEhXZryqeKJYFcjv58e+s5st1/rK4XVHbCo7sG4Z1MEXHEeZjVAs3f+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3638607295bso21352105ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 21:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706939585; x=1707544385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN1bjJ/xrw5gRmVLyqW89zIenBgPzEcpb/Iao1rx7Xc=;
        b=b7pisrNADAkoAk/KHtLy2TIz1e3iNqu1ozthncCntMInSIHkI6TuKFK8Juv5w9W9af
         pI/xoy2tExc9Q+6hdP9yN+QT8Qkqvp1hA316G2+liL9s3Fb7vxTfeySeqYglmUq4KvFS
         oGlqSS/j98iZ8Jmmgdghfbcxla2aVX5UqiZZpJuPxpyZlj+jHZ3xGv/v6kGiFJTGCbjE
         7yENfn9sf3YHsHZf7ktWTD0fq/He2gI5Bs+0hC20xYljynti80EkYRnVyNXKMvFq5h8h
         6VHWoHSkZEK3J2UL4ZaZoZUPob+/qpqI5BdRkVo1NrgwEKb7AJYJllPlnO5GIU1++msE
         QYgQ==
X-Gm-Message-State: AOJu0YzdyroNrHc6tfW8KcEG55OBHfiwxd/inoRqMPMZyd11zdBsnNOB
	NjDoB/J+ilJpO+zV69WGcAcYCO9uGoaRT/rY5v1+ZqFDlMsINMG+wwS5sEOsUk4vds+k1mCynjL
	MthFuS+U9RjYOaOZ2ghqydMQY1vRrjo+7UcDgJ4BtnEoHMAMeOJkBqWA=
X-Google-Smtp-Source: AGHT+IHd6nRCKIhbV8RU+yQNq0fpsM65ciaGEXy4Qzaag5SF3JD2UbOjuZtA1ofZ62gYlRvGOOaHZpozRXi9kFbzTJlmJVcLgKcO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:363:7fa3:f0bd with SMTP id
 k3-20020a92c243000000b003637fa3f0bdmr582730ilo.1.1706939585018; Fri, 02 Feb
 2024 21:53:05 -0800 (PST)
Date: Fri, 02 Feb 2024 21:53:05 -0800
In-Reply-To: <20240203050828.427-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e4bbe061073d7e9@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in hash_netiface4_destroy
From: syzbot <syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+52bbc0ad036f6f0d4a25@syzkaller.appspotmail.com

Tested on:

commit:         56897d51 Merge tag 'trace-v6.8-rc2' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1373c28fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=457249c250b93697
dashboard link: https://syzkaller.appspot.com/bug?extid=52bbc0ad036f6f0d4a25
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a00b90180000

Note: testing is done by a robot and is best-effort only.

