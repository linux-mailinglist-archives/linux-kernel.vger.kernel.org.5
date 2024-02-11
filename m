Return-Path: <linux-kernel+bounces-60689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB80B85087E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D002828F9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0D59B75;
	Sun, 11 Feb 2024 09:55:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FC59173
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707645307; cv=none; b=lrA7dajpLLYxPmLBSH8i1kPgMuvVtW6elpbjBAmhzverlCPEhNi85JLwmgcXggbGtocFKueOstMRmK2PXcia2H6Nr2HVHWVEXaKN5UsfwvnYm7oF6+DskvfOtMQNSrIWQaquCXtZAYPRbjApkkfG3LfDydlv+QmDJ8iXmzv8MVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707645307; c=relaxed/simple;
	bh=FamyLudsSv714I4GPKAWQ7S6nKsf1K3Kuh25o0PUvSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZPjNBsvOa+3qibDoYqMhhZYIpTJEx7zJOlaUGAdwp32x8Fix78ZGgkxmTt4WenNzSMYtV8S1cOkAjv7k9EZ/TsmVd6mZrI+2QdEb7U8g5bBAUxGaPMF2S0q6Kmar06QEI7L+bhNkIBz3y34ZZGosjjpmxinDcZLj88Nt8OLA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363e7f0c9daso15249625ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 01:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707645305; x=1708250105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XuWyRbY4wXt2Mt6STUVYn8j1a+Yq6fdJoZ0a9NfJrs=;
        b=tpmbz/8bCUv0tPCyH+ljY29l8byvA5Ejyb8HGyRBYJXvLvLZWnKFVWfw3HfRXDTpmD
         81TSqVbJce6AKSBtCsN+SMZ5Uuh2i5ro6A25Veq6FvhIKsyjtm0fAV7hprO1RJZIdFyY
         UrK0lbIDvl3VFQKHIzYHaclhZJW/GzfovXGCsFD9CDBXalwgZmDpntCo9LNQunDMnvBs
         kuYW2mOl84QWDIj78Ck71Y6Td9oJnfetrWnvGe5I+KJvDtzYdg3JYzHRv5l1TEuIYXI1
         LW1Zlu3WH2BK2LLfeIQHJtTh/3HpFDj5mbBlzgrLCOoT3SS4qtz2z+cQK2BsyJLU4K/B
         MTuA==
X-Gm-Message-State: AOJu0YzaY3eEpCthlHo3V/LDXHs977o2L5/AUSxsYjugd10U0lTGyb4b
	d72XxjArrH4brfdLGJ58tuNMKQi2aOAFxckCku2ZwvkD23rt1P6XhaVOa9XdjBEJF8hFs4h6qNM
	NoW6r5MfB5oXMS56hCnXPaXEjUxxb5djswNxrIgR/1RsvDbm7DGuamzw=
X-Google-Smtp-Source: AGHT+IG3YZniosI/CpDU94Ng7pPafv+1B9bQ4XnJzYI/F435oR3FLGTsEkP6RQryGxVbCbrAEGkfujP1a2FR0BA29P31HNaNZa0p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:363:8b04:6df7 with SMTP id
 q14-20020a056e0220ee00b003638b046df7mr338025ilv.0.1707645305395; Sun, 11 Feb
 2024 01:55:05 -0800 (PST)
Date: Sun, 11 Feb 2024 01:55:05 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4a29506111827e7@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	william.xuanziyang@huawei.com, willy@infradead.org, wzhmmmmm@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Thu Dec 21 16:53:57 2023 +0000

    ida: Fix crash in ida_free when the bitmap is empty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fc6ba2180000
start commit:   b46ae77f6787 Merge tag 'xfs-6.7-fixes-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127837cce80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12779dc8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ida: Fix crash in ida_free when the bitmap is empty

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

