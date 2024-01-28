Return-Path: <linux-kernel+bounces-41495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B883F2CC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046251C213B9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474583FE4;
	Sun, 28 Jan 2024 01:57:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6221870
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706407025; cv=none; b=lebSRrIQx2WVJygzev6xe/V1RIxi4uRk0FaNEfuZntNIZmn38JQiQQ6CTLRmqumGktBJM2iy6ZjE+KX0v1Bp3f8O5DSnEobAq4nh8rgm2auov08fVPj7PcvqhOtySoHPWSfIQo3v2m9NaABFpv/SHRVPp6yD/02jtHnwVlmh6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706407025; c=relaxed/simple;
	bh=V+GAjd8Lml5y1XoTxNEuHT5WQVdZ9Rzj6DZ8JzsEmr0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ekCC5qkCKtEVaSbKHKIIecI5XbgYKf62YXl52Z75inVa3bvgrZ2JaYIDYCPHKvADvbaCb6Kc2GhVixUCPolI215AScHSk5kQlAGxYRbyJwKacgFgEYTlM6wjttOYSeQykNqe3BH3jZWt3Nrcwbw64khroo8ndF1EgTFActB4Uok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3627d99cbe5so7378925ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 17:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706407023; x=1707011823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwxdzYEPbsFuO+TSL8DKdjJZvhazGlttvbnyxJ7rcOk=;
        b=rGS6chA+O0CoO8x7L24RqaEQX3ZdU8rTjGVNziR2QsxZk2Hhkt8gNKNFLAm1ZxKNTL
         bnfNR/ZrhahP6sfiyS26qbxQ51O+VCJFc6B6F8O5aTeCdZ9lw70LlfF0GAxfS7zw2Bcz
         VUTb9wfEvaEh+LkpIG15PkEDrHqH17MqPuHAqNZspNG2/xg5VftLF12pPuWmUYl9aXCU
         ZBDH14vBeJJUTgMWfrE1JJvkaL/6MlKVezzBBAsYUUlNvXzGjKXmpYLa678Z9M4a/2uf
         iLeZY+CImV4dsmxsSbUznSSXvmSAqQBblWDqf3skiO7PLtvPuIW9/chkJxo+Uqho8kxQ
         Q9pw==
X-Gm-Message-State: AOJu0Yxj6yCIeRMUehkhBJCpsQbnWqR7+XtkIbZgad8KSBS06EAWb2+3
	I7GtGtOMhPsgfjFbDs68xiNxpJEzgxodswxgWXPvvRh83h4yHAw2FsjDecfhB+uuKQP8F0vvtsp
	yc6q5WOTcyaXd9/ePkvCziHNoAMNyCGVBmSdXPC3572ilTqgln9GmfS8=
X-Google-Smtp-Source: AGHT+IGIsY+fMOJ0iyEu9vfmYTToKr3Wef5yEAsQXVlhDr+6lu2vJj0cPpbE+RJLYb7ZvpWo457ot7GIknMwxDxUZO/evxFsZ7EA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:35f:a338:44ae with SMTP id
 cd7-20020a056e02320700b0035fa33844aemr285298ilb.3.1706407023592; Sat, 27 Jan
 2024 17:57:03 -0800 (PST)
Date: Sat, 27 Jan 2024 17:57:03 -0800
In-Reply-To: <000000000000e9e9ee05f716c445@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bd31e060ff7d8f0@google.com>
Subject: Re: [syzbot] [udf?] WARNING in udf_new_block
From: syzbot <syzbot+cc717c6c5fee9ed6e41d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fe39a7e80000
start commit:   10a6e5feccb8 Merge tag 'drm-fixes-2023-10-13' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16700ae5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f897f1680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

