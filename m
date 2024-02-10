Return-Path: <linux-kernel+bounces-60172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44A850106
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD701F26BCC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD7B1FB3;
	Sat, 10 Feb 2024 00:17:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E2184
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524226; cv=none; b=HiLBBfivs9h04x3Ed/2h/IPyGDeTA/izEB9hD00DK2OP4E9Q1JLv00y/vlMjyq7asuwRYzIPkSfeok1vgER51Y+HCVKwGXb6zbtiPi7MeHRtc0sRbz3hhFoiIklBTWQSDD45Mj06cY9WwtTnfSkBuSvbMlBo53WCrCKXkLARD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524226; c=relaxed/simple;
	bh=4ge+/WmzvR0J9ejhrGXr1W+09OnA2O5Y9YuwoewWnzY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DKJZv6ZQ4Hp3wQbaijL2LKZ6t7n+8SfpMCjjkZg3d35RPHyB4EQAJTqFT4fNX0NjLT/dnhcgolR7fPO3hHxwvyNBw4uP0OmfzHqsL6IJB/au38lMoQMaq2o5uxC15M6sO/PDkKuQFwEqcv6brlGJ300XRSDO4eQLMoP6B/xEHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363cff2c5ccso12249845ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524223; x=1708129023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rH7XWE+1Uesz6zBrfYb5Ze0RvaWDz5N+5wCoQa9ttkk=;
        b=cSBIUK4Y8gRpO5OsvCzShD+UsWAzfZMQSXs0RBKroO3QFtzXg0FKXgBX6PRFmAGX+H
         vCfSQNTxUqVb5umxmCBF1AjmtYMFAoyyVQIwbNrqazjHcmSgDLxcoAS1v3TDwQfrk6/I
         rYH1X2g+e5RWfwdYNX/U1VZ5czyUqHc4jOlGISV5CvWoTquuNIY171vcVAxVIMn0Pkh2
         YLytBsi+qlpR5s2s2ABGmm5y7aspNF8f8/7XVlQODj9PXeOqVHzZHqAKSyLW4kTPBYa2
         ZnNXTS5+5fjvOa6QHmIoAh6DWqgsRRfjBLac0idhb5ahxG6FamWj8xSsuZt2wpO0AqPq
         DAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2DHxjFHIkfphlCKlzqYEAzDjxyGUu46OaeKQWgQ8nL6IVbv59l7o/5YQ2JaV2RTFN41o4UKRAKAkN80anD7ASo4wzCZSBmdsklWhe
X-Gm-Message-State: AOJu0YwXG6Tle/+aSWvNpup3OQEAlYF581kt3cWekbyvFlnl8APcH0I5
	IqyGpIv/xKgA6azr77pDJ5LtRwvvyFgDkPJfeZSSK6kXhINuIkHakt8xLUz5qigtuRROLbHTpZN
	quyR+jlBbE/JFWLRVBxmIpLcfXTI0MPwqyPn6bboPNK2LskXOfUSvsR8=
X-Google-Smtp-Source: AGHT+IHaSCpSBmrGWfp4RAWRiVgNaUBDrl+UwAAOt5yahbYipkZfIVgzW/xl8ZNcd1Dq2szhLGEgZjca74TYQxXTUaIL35YpvPpK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc7:b0:363:e134:a158 with SMTP id
 x7-20020a056e021bc700b00363e134a158mr36517ilv.5.1707524223738; Fri, 09 Feb
 2024 16:17:03 -0800 (PST)
Date: Fri, 09 Feb 2024 16:17:03 -0800
In-Reply-To: <20240209204745.89949-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd2b640610fbf6f1@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_dgram_sendmsg
From: syzbot <syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com

Tested on:

commit:         1279f9d9 af_unix: Call kfree_skb() for dead unix_(sk)-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15c46df4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=878fbcf532b1a170
dashboard link: https://syzkaller.appspot.com/bug?extid=4fa4a2d1f5a5ee06f006
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16376320180000

Note: testing is done by a robot and is best-effort only.

