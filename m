Return-Path: <linux-kernel+bounces-75891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32985F05D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869D5285BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18418657;
	Thu, 22 Feb 2024 04:10:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEF1799F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708575006; cv=none; b=Vsn1a3IEkZJaQMSRD/alctIgb2mqN7p2Jtazu6wdlJ9WtKqK7VZgRuJYVjqsa/+ZPNH9EkaHKqDRKYCZidDBoaFyqfw5EhyYxByYRwkkx97Fvsk+0KoOv10Ho6IkKChTntHY5XZd9bQCul/nFGoMFVk6wrfDNzx8DiHIbt1+GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708575006; c=relaxed/simple;
	bh=RpQ78JYbCr4J0IzFxUwj79GxLUE+cJykeDGaMHfIkw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J/PwlCNo9FjugYkNIEMUffsg/bvRL5F5V5T2BaRz2pcnKZVhMDrPd0CPxNJ1KGBoXYIoV0GO2hxtUm30QMBIeNJ8aTB8Z2m9El26WKudgBohvwfG3fZDmRL1USUCBaMS3Zbgb5KczgCf6gbdKXO2zY0Og/FyRyGQYJjj+i1rtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651fd50053so54541035ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708575004; x=1709179804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iq4hD270Un3mb1S2S/CLZ/PalovGVFLyqwhhhDvqF8=;
        b=c/JQaAV/ixwdoIkaw7mvtH+9UmmoAcTXW8/Hjm8gG+k0PR0r88jMTplGCWjww69Eik
         ITugPF7decnpjoycRIv1z9+gXuWy4zIcn3yUVqLchilDD6fYc9/deD6y2rJuRqUs85jf
         n2/3Q/r+tod0j9gCczAqqCcrRp5Wj5UDCv0/Cs9ysLUwf9TYeekfxCd454kwv1lp5iew
         5rYftgmH3QVD0g88GFTxeudqekCM6UXAA1hFIHn8WZhid66l2jcovTXpUVi9LS5EpOXl
         CdX51ujItgtfJYZK8tFMJJYruwSHq9AmQAb2o3MkAP7mRup/Re1vZgxkrYVd6SHIrXxj
         C6uA==
X-Forwarded-Encrypted: i=1; AJvYcCV5XALBzrRfX2YPCTjGm5RaCjHeSyj5ixJ3XRbis3PDcj3Eflg3aQKvLgTe4XJb7As0uyQIUyqRD8spLGRKFTb1rKuiQURXoUcCSsDe
X-Gm-Message-State: AOJu0YxHDM7Zr1cLLV2QZvVFqKMIEwGuwskHt3sYg00CJM+tlmr0UnLq
	gjR7ayCN4g+MyP3hCJYNuRCZ1a+rDvyMhsRb6PfrssArVamRsocP71MX2Rrzve+P3tmKbE7Pva9
	H30k0ESurgs0+nVGJEX29xc97oR/ykIN3ZIOUDv/6J6z1958N0H8+IFw=
X-Google-Smtp-Source: AGHT+IG61ns0G8RU8y6WMxKCq+IFGk1UNtxZtxko0fYt3DwzURs5w91m7q7WiJKNdj6SzTHzJQSQWvQXQwXQ1HmwwJ/W736AhhMr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be3:b0:365:1f8b:d103 with SMTP id
 y3-20020a056e021be300b003651f8bd103mr1236519ilv.6.1708575004142; Wed, 21 Feb
 2024 20:10:04 -0800 (PST)
Date: Wed, 21 Feb 2024 20:10:04 -0800
In-Reply-To: <000000000000d95cf9060c5038e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031b4140611f09e02@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
From: syzbot <syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	eadavis@qq.com, ernesto.mnd.fernandez@gmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bedb0c180000
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=41a88b825a315aac2254
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1552fe19e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1419bcade80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

