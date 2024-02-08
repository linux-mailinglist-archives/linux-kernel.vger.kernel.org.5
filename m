Return-Path: <linux-kernel+bounces-58737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CE84EACE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C661C22846
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921314F5EC;
	Thu,  8 Feb 2024 21:48:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28C4F1EB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428913; cv=none; b=DSmJuP3dBjjGcmOY+n396oQUXfAVhoHJvIbKKpfUPsLlfZk/2m5U2n2GoQ2bXSsaIVqtfICj3oWTZF62NkaTud1yAB1mXq3ySjpZofRQY9RS4nef+Ew+nHOdP0BNt0olbyKqe5z4T9nEnvSkhIOYuoNys41Hdwpa3zsaNGIq/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428913; c=relaxed/simple;
	bh=x5X/SpXcWWm2drcgwtU8g/8NQadRYVVVLQ/7tbIX2x8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rxhSviuxdmUGfBPlGIqi+Q52MBzJEPOL9r9Cq5f8crLJhh4+EWamOI8VW2Mmz7qXn3rOrlwA4anLTFS+m9ahd7dRHoS57zo86cGyzLGDwsEGJBV68IpCtAvhP2sHlXY0a+/CXQBh12dxu0au1873m84+Ropa4xNzky2AFnH5sgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-360c3346ecbso1724505ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 13:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707428911; x=1708033711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcy+RP+3gbw7fm5zCL72DPRbjcLix4B+pCNRB7ycwkg=;
        b=KSIwY4615wFtWCDyJ0Dy5c0Uhe1cHRmx5gAlSRkjTpFeJ+2Z6hBdgCg1lG0JSiy2JZ
         eAtUwFMOHJLNHREuZsNy7y49zaw15jL58fbbNPcgdHhKBQlLcqbgjzJlk//Dyx6PEibz
         7FdbU7iW6li2CNMrBibafoTXYFcyTVrlFwX/b7nv74KMmqZ/vH64GZ8/F+KaWBR3imJX
         vqMVVlT+LCxHBQEtigTxzQ9Vwbt3PMvRbRCl9MlAcbVSDqnYsh/bupH1TuWgVsmSzNUs
         kFk5hLd3JWMFQFc9gQ0si5BNWWwkICtiCBgU4Mh3oJ+5yOVPYVrt4EFMcyp+tcoEOXNk
         8deA==
X-Forwarded-Encrypted: i=1; AJvYcCXawsroYKhxMagTtLwcG2ePTIjPukRTz4bpnFLd/eQPEep7ci5hy3ie7tVYXppgZ0cIEGGCvOeEfz6r1Ey3XSPmvGfGjT46ymTZzvlr
X-Gm-Message-State: AOJu0YxohCR2dPJqSB6tVmehkHaFL8gKpEQg+waMTzD11Udm3KcOIAGt
	ksZ5HmqDSnXco7somnE4dd1pj6jiEC0BXBIQ/p0h9EV1Q0jp2Sy8yKYMgxmbQ9lt6UWsz89t7gk
	Uk0viLcs/DcvL7IDui/tqhuMZ5f1E/W+0W0hH8TDPkyeAdEo/2Mqq1L8=
X-Google-Smtp-Source: AGHT+IFtte76dKULRywQHjdaJAxVanDStW7HCAN6er85mHH1lSIM/J8p9GOwTK8goVs8+X1JMOEuYkNw0BKCgSWTuzSleIkfJafB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:363:c1c5:79da with SMTP id
 j25-20020a056e02219900b00363c1c579damr43586ila.4.1707428911094; Thu, 08 Feb
 2024 13:48:31 -0800 (PST)
Date: Thu, 08 Feb 2024 13:48:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9aa8e0610e5c55c@google.com>
Subject: [syzbot] Monthly bpf report (Feb 2024)
From: syzbot <syzbot+listb6955cf0d43f0daabf0c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 0 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 205 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 164     No    KMSAN: uninit-value in bpf_prog_run_generic_xdp
                  https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<2> 34      Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                  https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
<3> 5       Yes   BUG: unable to handle kernel NULL pointer dereference in sk_psock_verdict_data_ready
                  https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

