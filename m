Return-Path: <linux-kernel+bounces-152237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A490D8ABB3A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330AFB21956
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC9D29D0B;
	Sat, 20 Apr 2024 11:05:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30128DCA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611105; cv=none; b=iWmGWbcbRIJdbvMuE+n1J2NJ8keTBBPuVicnpp/+jx6+ScFR/DB/kI1TspdrIHN5e+1nYMgahj3xxSMo/tAGHpVHS8qY58yB+akc2kPkdp/28shrrY8Sl/QC682XSOpIrPMTNt5/zZE5iJYAQLn9RkmtbhkOqXoy24hFd5T09oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611105; c=relaxed/simple;
	bh=s27xjU6RMPvfYBmkk7ft79miI0KqGUXUlJx7W0BFBWM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tNKynKzvYrqHBLkbJJvADlOFDCwBxWT8oZ8N/NeOz70WEAFpzxLiHFe5EnnGfDnC50YxPOwAS7t6uga/sKmPILuXcBp1AgDeA7Z/AmB5ekjprgaKc5oJY5/xemOx12BL5uB3sEz/B8IWYIETFz5G1HkuktzsD+r3Z72kMdjzhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c05c86944so5649705ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713611103; x=1714215903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7yBwfO66aHRa1O9L8HvVyvKH1lIkd1DRxqnowucHIE=;
        b=T/c+wan8pGABLq6kW+ejdAiv9S5j2qLGDYQPJBOpskJpAyz38jD+d+T+6fg1IQqdPU
         Gg3/80DGZFyh/MFSDN1EdZDX+O6j02Uvdy6SNbHvwoq21khecg2RiSwyqPsAj7MQ5Tvd
         8wCkVnNPt51L6xmCrI46M6kLyuvw+6sQxr6f9cSt/eNOAjTFHhyr+6cvHy+oSAditS8T
         Y5GbUxhMADc3296jgfCbX5m3UDN6gAISP0IaxRiQg9m1tDp/mi2YTwdlyj4b2scLOmsZ
         Tun9l7NFAGapz9Q3fRXqkVGguFCVvzHaUmBbdJh8n07gstlXdCV16f6kPphgj20yfQRB
         9T+w==
X-Forwarded-Encrypted: i=1; AJvYcCXfwJR9M0fjr9BfSl6yvfl9YJbu6BuX9RO6+nSVtctqmr7G0uy/sxWBeV0CoSVF9HKkTtQRb16TwEMGMCTkMUGwWPIWIf2CoDYd3ovb
X-Gm-Message-State: AOJu0YzzjFYc7csOV6xTxDCMLZHqb6uZgXxGC+Jm7DQy46lKHWNbY5K+
	dMFtz9H4ihfJnytK7h7rw/5CdgSv9JzioA8YA5T/FevOJ40cr29qjqOuJzf6ucrmuRjgDgCmPjr
	DGtXByKq9krpyw+8u0X0tqf79O26dG0N95Cc9mWP10YyKAP7kNs2b2WQ=
X-Google-Smtp-Source: AGHT+IGB/32niRDTyR/zhkffl/x3qMTy7ZqvWF2/VowCteX1IAeq/8/uNnmDt0iYor7nG+cfLEc0nQ6RnF5XV/gx2fSNQlSWchCP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2144:b0:36a:fa56:b0fb with SMTP id
 d4-20020a056e02214400b0036afa56b0fbmr316784ilv.6.1713611103032; Sat, 20 Apr
 2024 04:05:03 -0700 (PDT)
Date: Sat, 20 Apr 2024 04:05:03 -0700
In-Reply-To: <00000000000089deb205ee0ddd58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000146a6a0616852ded@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_chunk_alloc
From: syzbot <syzbot+e8e56d5d31d38b5b47e7@syzkaller.appspotmail.com>
To: alfredidavidson@usa.com, anamartinez@projectloan.org, 
	anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	dvyukov@google.com, fdmanana@kernel.org, franklinozil@usa.com, 
	inquiry@usa.com, johannes.thumshirn@wdc.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123666bf180000
start commit:   82714078aee4 Merge tag 'pm-6.6-rc5' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
dashboard link: https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139f64ee680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da37d1680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

