Return-Path: <linux-kernel+bounces-72492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8630E85B42F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349D11F221C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894D5BAF4;
	Tue, 20 Feb 2024 07:47:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EE5BAC3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415224; cv=none; b=jYuuNq/kkppXxo5XkvV8IYVuIOjN8cH0chsCODTnA1nzgNEUSkVPrJm8dOPRFMh27CYA//1eeQgnhfld43BLvQ0F9FKfhy3azKVgfwFjzyL569Xirx7N8LxanGlcLOLdLYUP2gcM2/J93tNDdG30mY3yw40gUCPZIQOzcPhyJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415224; c=relaxed/simple;
	bh=UyghdDdQt8LeE8qVKcEYuM52drM9gzvwkN/6DEfD8gA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XUKUiKgk8AT5YSoRskten/N/qpn0a+Bk+Z97OUtR3uLLDzyAKyZx1dUtoYC7+jIxPGujigA7F4fYmQfSBymMxEiPsP1tppljGUGZxAq7TH7uOsz6GRnfOVSZs7u4uw1fCAGDZaOu3W6gMvY5fCipLoQoa4h5ss9E8EzPVc6vfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-365026bbf10so49511515ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708415222; x=1709020022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96YyssBLVEuIDxLuNIzHnLn7KDYGyEAAcS+NmmhQL8A=;
        b=Wzd3NoO/aoEfAT8KTNhoCBw9+BHijRGKnfPNmn0mI4vc4wj2e1+KE6LarKwiMj8csk
         /I30EhUSfbKw/erK6cIUZQ9VU3gSRpx8p/Wi3vh8P2sHYc3WIAZna7UesPMELCp1HD65
         Y0jCRlwQuE1Kel+v/+9X72IPBDMbiwx7LSKNF/VBTSlni+bxxecnKc5/q7KsfhOKciNP
         OmNjOWBw8dh11bgQZ40Vuth2qDtzNKlStoP6IOwKFtygHjIEUCGwPQo6lpRa+yNbMpLR
         UJsQ+A5X7LBYMmQLO+4+nossECf0MlVnikK7NawB7F0xDjKaS02c7CYneTzYpNzKHf3i
         SeAA==
X-Gm-Message-State: AOJu0YzW7ER8Z2nHu+Mv/ihvpOacDIkxyOe6Pf8s+YQGxXf8vpo+vSUg
	7nb1t5zYVwUeZZDfZiHS0wA25zSGvGgzzhybpRYJ7oXrDV+cMDz74leX7lKB+GqlH1sjL7Xrfgw
	iFOHVaXsLajrwDyubKbYq2H8JVsWu7eFAta23tzxJijt27WgU4U1EI9dImg==
X-Google-Smtp-Source: AGHT+IGpPA0C0WCJsN+ZEoBLeZJxpdIkRH7YilD/bzmr8Bma5uZ69Bjz4zEZrUqDZ+8SyZtffu0BsiOp2TINKD+UKh0e0pXK/Aaz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be7:b0:365:1611:5d5b with SMTP id
 y7-20020a056e021be700b0036516115d5bmr845403ilv.2.1708415222475; Mon, 19 Feb
 2024 23:47:02 -0800 (PST)
Date: Mon, 19 Feb 2024 23:47:02 -0800
In-Reply-To: <20240220.161605.1886801832131178688.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076f3f40611cb6ad1@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com

Tested on:

commit:         5bd7ef53 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=109763d0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3f069371247b697
dashboard link: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1536f362180000

Note: testing is done by a robot and is best-effort only.

