Return-Path: <linux-kernel+bounces-156114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B458AFE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2328DB22340
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA910949;
	Wed, 24 Apr 2024 02:01:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE1BE58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924065; cv=none; b=TBsrs3OmoDu3YUSTmt7uwKbafo9fYtojXH1YBRqE/LxAIuHshSJxpLIZGwnlr5QE4DAmmDsG3TuBoVWDxRKQnRE3kdM7rYPnlrgnW29U8VjZCUWfU752ec19oqSIRqNJANGip7GPsou8c6Feum3hB0lYnAakF38XkRa87XBlI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924065; c=relaxed/simple;
	bh=TUP9FkX2lJl7zbsImkQch4ciYMMyBDiJtF6VqMtpXM0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e31HwqgaVb6UhZATRDFBERXZMEOJjgMJs3KUerAQGcnS+VLzJZ6T+yoUynSewkKiu4JdyU2/+ESYV0/qyBPiaQyGu75JkXyGd+LVvmDRy3RCbhj/D3PQXag+LRR7wyRhoVMlDaqxxCl/2wG/PzlPD6OdSI1z16pwsdbDSv4lbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a1c2b7172so3693085ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713924063; x=1714528863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ifim8rK+5Cn5AylRfbIwtbU4eq2GAjVjQaY82cuTstU=;
        b=W1aFxu0u/RzN/j1oG2NVjgWBudZRK9OmMYBdOAST8/MdVfj5WswM7307NO6XK+F+dU
         817eZpsA9vORwG+1+9tzRszqMcVPAV33wPQTeGr5OnOV49kVo+PMAfqMIcTPsT7EL7UG
         BvfXRMBUFidqRhetKY7LViwr8KSu8hu41tmisR4yNenXm68966oUlYAsIe0bns2NDV+N
         v28ZpzVDmsy8Wgh5zqCDo7B5AudEDVmnadRYq7yuQtHPSwZIz9GEWikLBRxovgeyyhpp
         5EPQrq28bVxPjYUm/NuhsgsHEzDNvNSu5O6qFatluW+0b9Oo0Bcec5/2z9WsdCBj1xvK
         u8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4ylvMzfT+50hor5eofI5lHQsP1lWSufAWMOCRWMsYSjYYg1jVjjY6e4fNMmVkVsGuxnc9HMRtJu+HPJxDqCZC2T3eD96osrejCdxi
X-Gm-Message-State: AOJu0Yycl5ifuK9A2auPB7WA5F3A4aizFq229+N+P1CIV9BdRo8WTVOE
	aikAM0Mozy15eD4trK6iy/DdrYIYeCeWQ1x33aJSipmNxliL7qbGiY8RDb9xmSokKSKRS4VvhUj
	EO9mQrdJrR+moIkc+YEevy51krtpkRnopgYWSq3JZyY3rO1ei5sPkaxY=
X-Google-Smtp-Source: AGHT+IFb2GitKyqtyomAW5D/rDPBgckqBsgxNNOhYgMZPpoxfwrLMRBdrlj7GvDWAclxs7KfwPhmIkStqRgo4TlEKYioi51ypkQv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cac:b0:36b:1b8b:75f4 with SMTP id
 x12-20020a056e021cac00b0036b1b8b75f4mr165809ill.2.1713924063116; Tue, 23 Apr
 2024 19:01:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 19:01:03 -0700
In-Reply-To: <000000000000f1761a0616c5c629@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f450900616ce0aa5@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
From: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, mhal@rbox.co, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 47d8ac011fe1c9251070e1bd64cb10b48193ec51
Author: Michal Luczaj <mhal@rbox.co>
Date:   Tue Apr 9 20:09:39 2024 +0000

    af_unix: Fix garbage collector racing against connect()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f440d3180000
start commit:   4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=100c40d3180000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f440d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a8fb4f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ceeb73180000

Reported-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
Fixes: 47d8ac011fe1 ("af_unix: Fix garbage collector racing against connect()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

