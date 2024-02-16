Return-Path: <linux-kernel+bounces-68051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B95857557
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24E31F20F29
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689812E71;
	Fri, 16 Feb 2024 04:26:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E611183
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708057564; cv=none; b=pF1xGCX5N26M6MpBSob+ncIC7kgQA1KqJ793Qw/jdZelpcBgY6E8wI2zPezaggGNN9FgULWkWoGpgeDw/YkFjtAON3c5Mh52vrSz6pImC+MbNRivgXs7Nf1ES2FCZNEf7BGsFISr7+26tF07K09lIbnZenUVAMh0gFKjs4FPct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708057564; c=relaxed/simple;
	bh=g8AG7UkQRdnemdoxHInzP3dqX7eqW6drsRgVT5oBlC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CJASLLBnhRi3ra2liBjo9PTDc3bNKv9N1S+/5Gw/4NY41yWXUpPkPsPKMMo6nx4/8SOZNxQrpMyqbpE3ygKxhCn4ccYjJwCCkBqrBpoQYVxvEJmhhEzYWjc6R+7vO2s/5dLio5RF2pD8paKcpHXJNiUYmyMwprIaFWf2tKouDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so114546439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708057562; x=1708662362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysmM52JwrybNyva12P9uvTW/b3Xdtttj2bNX5IRQUto=;
        b=dqWHX9+mTb/AviMoRDqEz2RrYIxcjpe2QGm93fbGBbBfXAlljvMHgYTKkuz5WEmLM9
         ZyQOrCgsIe9zL7T+ekzUQ4PkCLQlX0A0flzzQrjGjzSuADVO5BVa+mAKZ7uDXjp5r172
         NXar9STaz6fOQ5BOahwgaIm2okAxw+Dk2JK9GHgqe1LXGUw/LHn7mHMBcYW1sYgQtDUG
         nXj7j06/C0LCIKn4qZcF30Q4Qzys6S1cMCQV1QEwqeX9S/Eiaf2VaCkeyot1BaLSli8+
         YNMWW752AGdbJtPEDOJ2i/I9wgnOwPIz7ZocOYIUs8yDYc8/4tMM6ApEfI1Ju8kNZLcH
         V+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN3dRrn21t4GgMZ9U3J8wuoTfQr9dqO0wHbmFlb1PxUcNw/5a0dDI7E+scX+GORKIfGwcL1i9o4VmMI27XufgMKP0q33wBXmHxOanX
X-Gm-Message-State: AOJu0YwOMV5HXkfPp/1NTxx0hSzu9js9oO77+CvfPrTQZEMyH9it/GXW
	d1GDR5LXCHCOWEdAomCs+GmdeDeOmvn46ZambQajhxaOmeqAp6blja+sE4Eg2aRr5KSNtZW+mOl
	JkmSntDEVnouT1jWwuthNXZJmDiqcuzPHB66Wd2VZVRSc2XSfEYu+l6A=
X-Google-Smtp-Source: AGHT+IEORclVQ4x+Nx4CmS6n9gzeKsX9MnOQSpvMXAdae3fLjR7MjHNlSNaAod+B9RLEut/yyb/auDrZI8CBMXJnk4KGPpsbDD7S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4905:b0:473:edc2:9589 with SMTP id
 cx5-20020a056638490500b00473edc29589mr33539jab.3.1708057562542; Thu, 15 Feb
 2024 20:26:02 -0800 (PST)
Date: Thu, 15 Feb 2024 20:26:02 -0800
In-Reply-To: <000000000000d8f8c20605156732@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000457fc50611782483@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_discard_allocated_blocks
From: syzbot <syzbot+628e71e1cb809306030f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tintinm2017@gmail.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e72f42180000
start commit:   7ba2090ca64e Merge tag 'ceph-for-6.6-rc1' of https://githu..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed626705db308b2d
dashboard link: https://syzkaller.appspot.com/bug?extid=628e71e1cb809306030f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111acb20680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112d9f34680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

