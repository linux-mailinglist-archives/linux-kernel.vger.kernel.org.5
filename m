Return-Path: <linux-kernel+bounces-70066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182585929D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D02823F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023607E776;
	Sat, 17 Feb 2024 20:23:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285167E0F1
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201413; cv=none; b=H7ZU6Bq6WRwSgyk9BKXCXGz0RDitTeVo2YS7RcpXUzODAtXwWgZI167n06phz7ZqrH/bGkDVOCjXd1aTciRcu8ODx/kOR9g7EUi7wwY7xQizv1fX1RZkGscFOiNhoV4EpVidLSI/FhtEaOwsH1vgxv5LwiNl0FHTcCxDVsrs2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201413; c=relaxed/simple;
	bh=kTAW1sktnLSWVrfYyqrvD64LyUs+9wYb1l8LNe5URCk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T/MB2mskhvwRZpu6TdRY61+18sh4DzEDGhBeUXxQzdFnwGa8gcMTpisgGLtmFQta8FNNS0EA0VGpy9Fw6HQFJaGJIRuDWD8Bedx7FhMZIhjKX9o/ZMVmudpDEPDwBD3HjZ6uIwPv/qUmFwLgDOhaeNY60EPBtBAn9hfulVSb91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651fd50053so3908685ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708201411; x=1708806211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fjjujJTwfLMMDU/prSg+dryb+l7luMm98htia3vVZ8=;
        b=OLsw2Oj5GGXTG8b9f6DkSQhLshsfKYBany3YJCO1LLc1sJfz3QxEx57eex+UkS+RXu
         fvAfVMUAU7VPQR8L1UMpfAlSwRNPZInN5Xr+Lomkb9XOdtRPRGpWneNqLlLnZStTBO8t
         b/Sk+vmz0KLJXOTHGyFlEIKCCD4PN3WMWjCI7sJsqZhPzDHiShIqHipniRBEYY6JXAuS
         6gnAA2azAdGDQrxU0cC+5NLHoFbNRgTrsI3WR15hE4Tv2LFzG+oHnz4sI4xg28LSOHkz
         DuOpM34g5SLT9vSleQGZndVO9nAv17zGbuhfOVt2DKr62c5gMy+7DY/veE7nnyACugqh
         05HA==
X-Gm-Message-State: AOJu0YxOtixvp1Ry+GrVLhGsRg3L3JwG6BenpmY/Ra0UWMkndbB5hcc+
	teRs0tLIgJkX7deLocYawPwc0FzMmuY3yjEzbnnM8k8TwsraMAmd7IqVEb0/TUMsDCJW6n1Qi/k
	k3qs9kGBEgvHQjj15dFzKDHpKE6EPvIbsdUdGC9Ft1CerJjDbOjXmaNUv7Q==
X-Google-Smtp-Source: AGHT+IGVI1n37rrJOz7vV/PPbsmPalkkm8mIuPxhRUf8PoRpJHoAWdLeh99JrE8UqjZDHDFe7rqaHkuhIBKULBsYrB2oLZYwAB5C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188c:b0:365:21f4:7030 with SMTP id
 o12-20020a056e02188c00b0036521f47030mr96607ilu.4.1708201411412; Sat, 17 Feb
 2024 12:23:31 -0800 (PST)
Date: Sat, 17 Feb 2024 12:23:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000550c79061199a23f@google.com>
Subject: [syzbot] Monthly mm report (Feb 2024)
From: syzbot <syzbot+lista19928a035a1d33d70b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 8 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 224 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  135391  Yes   KMSAN: uninit-value in virtqueue_add (4)
                   https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
<2>  7366    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  689     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<4>  645     Yes   BUG: bad usercopy in fpa_set
                   https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<5>  632     No    KCSAN: data-race in generic_fillattr / shmem_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
<6>  626     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<7>  200     No    KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
                   https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
<8>  73      Yes   WARNING in __kfence_free (3)
                   https://syzkaller.appspot.com/bug?extid=59f37b0ab4c558a5357c
<9>  36      Yes   BUG: unable to handle kernel paging request in list_lru_add
                   https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
<10> 33      Yes   BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot
                   https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

