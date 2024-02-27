Return-Path: <linux-kernel+bounces-82508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765FD86858C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164861F2294E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222934C7C;
	Tue, 27 Feb 2024 01:09:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D646AF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996144; cv=none; b=Mw5o3ZWVVqD5C5gfr9uJODT8hcM7M8bK35ANnmyGazVyT/4L6GRtyJhZ0jsX7DBTufmDnM3acrYR3ZoanSrUaBXVlXPv1Jlodr5vKsu8P3RA8GzFao3GcPIkw3ph3hIKeubKnJQxuqjQExggIVgnAQeZOn6M0NqGmw8aKFlRVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996144; c=relaxed/simple;
	bh=kzoRrXh08bElKHfj1aPeK5wEZBKK/c9vqPFeUCMIWnA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oafhKke5pJp6TLJlcoYU+tK0pU6TaZ9oux9uDCVppAOkgaAawzfr5b87i/K3ek5JGwqlFHziD3ufvy/IIawM5DkFKw4eeDEwMENSVq5Go9Y0sA2An+6378r0Tn6uhvnKv8eTMORlBsLqKLwJCaFE1chyDUJBhUF+PzjNUEcPLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3657cf730a0so37934045ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708996142; x=1709600942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aktuv2KRKCqLRwq94WSyQgX3rAr6mzRgiYzRkrGsztc=;
        b=UwlGUxqyYJBhUMTtpC24qmD1L7ze2xaIG45+yOnLjC7Nd96rVYnNjJsWnmSJMpv1FV
         odMUPmgGeUhTc5pgbrkkQTFRUoqE3IBKdvu39Ns5q4GjdQY0sM6sUdUE7I+z+NyKMQgr
         YbVr+zIbqHvB/KjqKzzBDxB/4Du03qt21RqnzTEmAhxh+lZGWZldaqPzdzAq5aSV6IIH
         6iu41T4w51Fi5yqdBr58L3rH/4Q8qRfo2d4ODdfW66wdagox9ks4u8TkXPKON/W+xBwU
         CSU2UoCdotRAB5DEouuB3TmZBW6R5ZjBgJ9J+J0+MMqGFzwEGVi/HroLIDuCCzApGGft
         G2bw==
X-Forwarded-Encrypted: i=1; AJvYcCX75oLhdjOYW/y8rn0kiRVqKB3jrmC5TMPoKF6gPojYOdd5GL6H8HAUGwKidxs2TDYXv5sVzivaLifdBr8DflENmSfOSjrhirk6lUxU
X-Gm-Message-State: AOJu0Ywh+7g2dC8RGdCWe97W8T1mdoFOsx/o6OaVdsBC/qwhc6LF+OCU
	FCv8vmDJ5U0V1bSw6ryT3Eqis70vY5C1fe49eLJJwxrjTp4uKe/3Kh+uHehvW6UXt6NNtD7FjXl
	uhI2Nv57p2VnJbXG0LiyLMfSDRlmgtes0NR/f4O5ngLex3pztOOK6iaY=
X-Google-Smtp-Source: AGHT+IE1wkVsYou1Utkg829CH1m2uRacrTIEQTXsrl5dubL6Fav7LdHQpDU/SJebyUC6BahX5BA+F53OQcjQF6i4WPT/D5AWRTlZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:358a:b0:474:96f7:a3a1 with SMTP id
 v10-20020a056638358a00b0047496f7a3a1mr45049jal.0.1708996142473; Mon, 26 Feb
 2024 17:09:02 -0800 (PST)
Date: Mon, 26 Feb 2024 17:09:02 -0800
In-Reply-To: <000000000000cc261105f10682eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fea5b1061252ab7d@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in ntfs_lookup_inode_by_name
From: syzbot <syzbot+3625b78845a725e80f61@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ae7a30180000
start commit:   cc3c44c9fda2 Merge tag 'drm-fixes-2023-05-12' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
dashboard link: https://syzkaller.appspot.com/bug?extid=3625b78845a725e80f61
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16eae776280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d273ea280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

