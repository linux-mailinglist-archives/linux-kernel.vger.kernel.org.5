Return-Path: <linux-kernel+bounces-156018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6538AFCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1332842D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AB4437D;
	Tue, 23 Apr 2024 23:35:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135212D7B8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915305; cv=none; b=n2JwSqpFlb+IDdjChd6x5WNF30j89SzUpvsIHMeTW/v6NGkPaEBSwfnArVKGUM7qQQejIucyv8uIn/+9sFeLHHO7i8GSldv/UvTI1+9nOkMnQg+qgGx6qnD3Q7RubmJptS8vwoyZG4Fav0n6OJt5ezPks37WOQdpJLChacKMSUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915305; c=relaxed/simple;
	bh=9ih97yL62HUGKVyj8n8Ste96IFo1+X1KxU08zI8Y3Qs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DaUJRd6N90oGA7GelFAM7AAKkLcwimq86tyKj8U8Tl7zmxb1gd2mIhT0CWUcFT8qo8spJ5TX4SI6GjvtBRj31YYIy7mxbGTiInpXNzg/09abBoC//nYVTxuPq/CmLuwYQ+vuUp7cYI9RoXSJr4W1OelH7sqqQuI6yXrkSRzPzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso524505139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713915303; x=1714520103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b95qhLXKHHgT3Jg8/31nDVZv9Zd0KrHEsXh95liPGbE=;
        b=HWXSKbiUYbU7TVMxtc6d5cPY5/TJbSCFbMYKM3SCiJhRiP0JAA5ApONtdwNTZNuSQ3
         O7dypOz7DhRIsK+2HP5wIzrK9rBoh2blQEJgW3mWic4MgcelVFVUs1qqyhXFTV/2fHGN
         MLHBPCGxOnC/eX+Q5Ljk1HvZ3Lt+0UgcfoGWbO50O9UuRIrb3/RVLzvDwaIZ4A5N/Yhq
         wVrnkebB3yu5fTobotT9fMmzinzk30lC8SApnmK6k6qg4CDxPESl+sjK7cvUcnpxKDxd
         90tA4FDvp+Mst85aEYLur2DfhGCNnjdqGlIzCh/gfWEGf3PsussN50Xn6Rg6pJVFSygU
         Hvqg==
X-Forwarded-Encrypted: i=1; AJvYcCXO5hslVr0XncriV7OuMAzCzDTeplLD+t/wj8goNuh9+9HeZOSqXpPX8qyC8ZR4hT17zHkbd3S5f1Qzul1Gg1lpCXmU9ryd90hOXGhD
X-Gm-Message-State: AOJu0YyiY/AxE4pAflQzTGgDqoO/jAUBNAD2Q8Me7s+iJKWHwPEvCCBk
	WWpNTs3nKgGQYhIO5UTvLCq0bV1/QuyFabRDGVsYz3ddr3sh9EjORwo/OVzAtZuNAGvIFknepIw
	rKYhvefqHkSgOdHtnRIiSqR2Lyq8iSMpp52pTTO/YHNgrAu1ZGy7eH18=
X-Google-Smtp-Source: AGHT+IFQPZasv4KD6F5zLfb8+ePJDMKOzbwneN76rrPU9bcIZT68ZSO91Ax9ZurvOT645JhaNp2SkXfxjg/AC3GATZD0X9vfl7BC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cac:b0:36b:1302:3272 with SMTP id
 x12-20020a056e021cac00b0036b13023272mr98915ill.6.1713915303292; Tue, 23 Apr
 2024 16:35:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:35:03 -0700
In-Reply-To: <20240423224608.3180-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4049c0616cc00e4@google.com>
Subject: Re: [syzbot] [fs?] WARNING in netdev_queue_update_kobjects (2)
From: syzbot <syzbot+41cf3f847df2c5f600a3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+41cf3f847df2c5f600a3@syzkaller.appspotmail.com

Tested on:

commit:         3cdb4559 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d33610980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6e826cf3c9c6ffc
dashboard link: https://syzkaller.appspot.com/bug?extid=41cf3f847df2c5f600a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1609eb73180000

Note: testing is done by a robot and is best-effort only.

