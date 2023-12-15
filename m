Return-Path: <linux-kernel+bounces-400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28304814092
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EF01C220F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5AE46A0;
	Fri, 15 Dec 2023 03:20:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFC5382
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b77e8eec3aso32998239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610404; x=1703215204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQyEELprIDEbtTkUwA4nnT0Wu1uDLHkRLspT1Fn6XJU=;
        b=w0SLdcdEgCJSlWa4yKsJfwodoSN2sUGYcdO3mYADZzfr3HsYFqd2Lx5XSilG3BysXR
         f9wRLaWD9iTHiK/Y0Q78WtAbjSyVPgzBGwCFwnmxTSQRN9OLEpYaI5ReVgGx3dge7pZb
         LI/RgVXfIR2G/bWtFFUETTersJrzPF29HZ84M/FzsIwuCMxXws0LwJgN41j43f6qi2Wb
         f8jyKoAuoAR5JpXybsglzqmrw4pM9GsApG4nr9lhCRj2JuB0sn3KetH714gL1W4z2xHR
         psR8a4qG1rKlxzBI+jXeElQaXz9638t/U5fB/dBad5z+2b3Ws5JirRT116fTLLwOPJ77
         +GbA==
X-Gm-Message-State: AOJu0YyGVmbNY3/UZlhunOdlLyXFKJ38QcZfc5pTYUCAy36pPw3asvXP
	YU+le45rQBWhY1/B+1aKtYfewwX3CNTQxWkBoRZRW48JuxWR
X-Google-Smtp-Source: AGHT+IFSmETvZ2PGKq7WWyYsYOvKShW8hfRpSuc2mR/bEUzi09+1SVucE9q4C1zxr0q4t9qCRzcJUHC049ncKK4A2KARey/PGRpF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2720:b0:468:fbcd:15a9 with SMTP id
 m32-20020a056638272000b00468fbcd15a9mr184105jav.1.1702610404132; Thu, 14 Dec
 2023 19:20:04 -0800 (PST)
Date: Thu, 14 Dec 2023 19:20:04 -0800
In-Reply-To: <0000000000004f4579060c68431b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000544e17060c83e034@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_check_listen_stop
From: syzbot <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matthieu.baerts@tessares.net, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 57fc0f1ceaa4016354cf6f88533e20b56190e41a
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Jun 20 16:24:23 2023 +0000

    mptcp: ensure listener is unhashed before updating the sk status

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1279cb71e80000
start commit:   2513974cc3e1 Merge branch 'stmmac-bug-fixes'
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1179cb71e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1679cb71e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=5a01c3a666e726bc8752
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1119061ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110ca006e80000

Reported-by: syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com
Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

