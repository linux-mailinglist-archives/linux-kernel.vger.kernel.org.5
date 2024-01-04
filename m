Return-Path: <linux-kernel+bounces-16193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30303823A70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254091C24B44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC74A35;
	Thu,  4 Jan 2024 02:02:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DE1FBB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fd87e7a04so48295ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 18:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704333727; x=1704938527;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkBZt+cJe9CSsbLvp8nYImZh+jjmiG7w16VVgl/Z6io=;
        b=tZTRutu54P5X/bZ2a+NM/SiSshgm2aR2q6wS0TSyNr3k0XZhTpQ1/rAMsj47O6v0Bp
         URa6okKn7/Otk7FPcAOQhAYg64+QHVKPBqZOm943Xqr8WrXIyMPVmRdHrUJZ4IceWZYn
         vWluHvoTTwPz8Wbas50yEFwZ6cJe2FbRi5EcC5+wgs5JOtqbiqVRTQkMgI00cKX/nk5Y
         22EVjyMmQwDuCq/ISR/SY3vQSndUP7jcWku/7FcHBRBhB4R8FtXh6p/4vZby5ALdztlV
         kf4YGW9fHgngZkxv2GSRxiy1cPlpRIkYzP4TKwdSqDGo5HtNtiQ5RgYtSiDF/FuLDnwU
         Aw4w==
X-Gm-Message-State: AOJu0YzYud/l2wvyh0vdxjU2f+l2G2shp1cyUO6M4QnMh+zIYpLF3OUR
	FK7wl/4J3b8WwI7yi5deGkku5/8EoN8x6NImd7k+xdACjYeG
X-Google-Smtp-Source: AGHT+IFfv6RdAzd8APK4ZvQJnNCX1qY/ZFYz1XbmG/kEkEPVEKsRMAzfwiIH49DuVoTIzElQLvykLZ2Jq46DQqj2RviGrtInflI0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:35f:ebc7:6065 with SMTP id
 j10-20020a056e02218a00b0035febc76065mr3325495ila.1.1704333726999; Wed, 03 Jan
 2024 18:02:06 -0800 (PST)
Date: Wed, 03 Jan 2024 18:02:06 -0800
In-Reply-To: <0000000000008aa01105ec98487b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000606eb4060e151e5f@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in filemap_fault
From: syzbot <syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nogikh@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ad26a9c84510af7252e582e811de970433a9758f
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Oct 7 17:08:06 2022 +0000

    fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152a3829e80000
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172a3829e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=132a3829e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11013129e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c68929e80000

Reported-by: syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com
Fixes: ad26a9c84510 ("fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

