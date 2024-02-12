Return-Path: <linux-kernel+bounces-61546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F161F85138F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EE92877A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2214039FEB;
	Mon, 12 Feb 2024 12:30:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC839FDD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741004; cv=none; b=ukUReMoXgXptZm4q3fsqj9CCs8f2QMJLGQ6YkgtoPXWoCWcihAeDeLpxceRK4UKHPN9jEiV3apFtyApJz7m5sWs5fiFITlXouRxdmLRazi56AGCLQM8j47LnQ1ukkcjij7Jf/l5Zt5DtoxTw1FbqyagROdkEbQiBmkQ0MXBaM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741004; c=relaxed/simple;
	bh=hpyZCprjqXuJo8g/11yqn5y+f06MqIR2VAPz3pQKDKo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VnmjzjALXPlgcwq1GZUj+Ztcp76ejpGJ5jqcoQreH3nem5Y4Vh2hxu/vKuMZkvUd385thphIj3u/xCRiCwEP/Y82ayq38eL+uAmEBZ3HD2mMz1a2yaksJuGsO+mPUwyZ9sZOZ7el9Co0HkV2BelJ+iya2oZ3m1N5P3uf0arWGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363abe44869so29932755ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707741002; x=1708345802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaxicENdOZ7/KN3nJBrWWncXH4X6xxUZkiYnRhUUP5Y=;
        b=E2mSFVNllMZ1xtjq3sSv4oR7F3qFArMGAoW6FjxZ6aWiVVWIKladBhKsyOoRbUagpN
         GZUnraZh9rF3gQ0U2q8TAiW3E2JLIgx0umPMjxj/c78MrBb1jv3qNcpbv8Kpdw1Wf0hm
         ZUhWBqwWimT2PPsOHLWchJpgZ8zW1zK9KTfYZC8rhV/EIhkI/g5I8GEodu0bTI+LWiCi
         9Nz8gth8/nObDGh+3UY8F3ZkcrLGt6e28pYtA/L6wea4zMxQk943BtE2zNN4mOz2lkYh
         IZjM1OSZojwURAzDE1EMol+06OmyD1j6Pf337zXPQrlRCkgFu8KgkKo0YjLOAtuswqEQ
         J0NA==
X-Gm-Message-State: AOJu0Yyi8v1ymKrrIAeUbwwu2uZW6vDHIN2NfPfl1faxBNyOdiYxOH2b
	TJh39GdC/CO+Qh1aPjcf1WrAGepjS4jujykFdh+B6QgF1nv0CtaovDVyEj47SRlrvSwPitowbTD
	FrzHrMEU1zETrg65MbvNKoM/XUKFaGkrLc3TB+gFGa14C0621VeVR3Nc=
X-Google-Smtp-Source: AGHT+IGy3lodr0+BmwoZ3FcFVTynKcUa2LRTZ8mEp1gi7+E5msbgs2mp9WB1ax9VBqQZ/zCCmI7aanwKQlrcDsHNLT725rrJZ9U3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:361:9a73:5a8f with SMTP id
 i7-20020a056e0212c700b003619a735a8fmr593157ilm.5.1707741002578; Mon, 12 Feb
 2024 04:30:02 -0800 (PST)
Date: Mon, 12 Feb 2024 04:30:02 -0800
In-Reply-To: <tencent_9E786E6C4C2DF96F4097BCEA5AED66CEBC0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3c50a06112e6f7f@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_convert_to_umode
From: syzbot <syzbot+0d7a3627fb6a42cf0863@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0d7a3627fb6a42cf0863@syzkaller.appspotmail.com

Tested on:

commit:         ae00c445 Add linux-next specific files for 20240212
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=154105ec180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4eb3a27eddb32a14
dashboard link: https://syzkaller.appspot.com/bug?extid=0d7a3627fb6a42cf0863
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160d0724180000

Note: testing is done by a robot and is best-effort only.

