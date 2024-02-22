Return-Path: <linux-kernel+bounces-76890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDCD85FE39
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E736B1F27ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96315351F;
	Thu, 22 Feb 2024 16:41:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F61DFD9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620064; cv=none; b=DUhAzU+yb/U+gSUmOmbPj7QxGeI6fHuzl/695QI6Ju0smen//0rbr1wF5vSZ/TC4owWcJPYAPNmxjwYfseJHMQOBHvSgbRkpd0eTdYOh2wne2VllMMY1dVVcji0PZ9HLRMqUsmhZhSAdOI0KTHwee8AfGdD26i9Cuv2ZG6RR034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620064; c=relaxed/simple;
	bh=h0qkg4ybl7Go+iMCC/iSGyWd+Gh2Kh3DWutLW4fCA1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gqnwPV7tAidNLJK8V9gBpeQqcNcYYMbro30DLskr3nOHD6wCPL4TwQVEqD1sKGszGDKyDZonHDAga8PY5xNMZC/pKDFlSDxp/hi7hONk5rKTCbUSd5Yz0pJru5sPNCbg3zSA7WK9mEPWxlbdulyGuXdBLLBrw64KtN/HKl4nq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365256f2efcso22675925ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620062; x=1709224862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ5aqp9fdqY7o36k7fIAo7ucu2og5S19dbPdW4xD16g=;
        b=OspZPbkfQidTF6ySi6pPi52dsIRo9cZmEYKH+QmM+uqgo4hdxZszmmgRHrPpIDceIX
         m8a/Iv0Pkrb6porcsfkk1umkxur2RwxvzOTaPPE+oDRBoyfcBG99emnGseZUDCHg/V8l
         KN4RPkPs7trWPFeZzu+RrXRwGMCR00eRvobkD6K0qgsnHjo+At7oCHloGMluFKdpPATD
         cqZ1SNjvjSnKEPFxfBW2s2j8T6e4BQywQHYqSOI+hNR6eGjO7OziJKmsTkGmHC05Yf1R
         6UGQ3kyFDO2ILumCgF9mjaiDc+RnRcqrrOwuNZnmGeo8wAzanclEMB+D4ENwn8BcPYzf
         UQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtxVklTnkL/6p1SPLhX9LCMzarA7YytIR3mlZPgPmFCmjROOWYYg5dRHY4jMTxrUVXw41qfpdfCBd5+aWC5yhbg8h/4iRZaYS0SlqL
X-Gm-Message-State: AOJu0YzxUbOp389Jjm6Rv+5vZGJRVktcJ2B4wGaTuplItoe8+Ox/HWFu
	MDAYSwjj+aj3B4t0ESMgCK2ADSeSzJ94jQAiRwGd2PZ2nuFj8rHjQpz8/T4Na0RCFdAL0PS3+OY
	Dx8kTp/7fRMm699k74FSaMjQAWvi+8HI0Y+N80rbS0jW3jjQbqrdw5Ic=
X-Google-Smtp-Source: AGHT+IERfkQLLE1RjmqYWtZVQ/b0Z/t1fbVmJvDFARmZmYdz08jGgp/RbcQ9MJCC4ZNoa86l5tdCtIZkeRqBGdknpyso18exPKPE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9252:ed47 with SMTP id
 j15-20020a056e02154f00b003639252ed47mr1821068ilu.1.1708620062699; Thu, 22 Feb
 2024 08:41:02 -0800 (PST)
Date: Thu, 22 Feb 2024 08:41:02 -0800
In-Reply-To: <00000000000034d16305e50acc8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4b9c60611fb1be8@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in do_journal_end (2)
From: syzbot <syzbot+845cd8e5c47f2a125683@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	bvanassche@acm.org, damien.lemoal@opensource.wdc.com, ghandatmanas@gmail.com, 
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neilb@suse.de, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com, 
	willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f6c4b4180000
start commit:   69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=845cd8e5c47f2a125683
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f68684480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142a1eaa480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

