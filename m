Return-Path: <linux-kernel+bounces-29712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0FC831238
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F7B22ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD95D53A8;
	Thu, 18 Jan 2024 04:47:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4433C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705553227; cv=none; b=kvSirAk++qkNvdzW83Q2G9+jpK6yxYIC4ySXucpHRRJJTIWTuZV6KtpVBN3+BdGmSTKBn80tbre6gmmzf5SqlYwYDx2PH0HqKpFT3TUHhL3UeiFDdBsXmPH1Nu+EJskOf9+UryBxJnFBeN9KmEXjxL18ncWHJX5kG9NIYlYRyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705553227; c=relaxed/simple;
	bh=Q75w7nD4kKcQBLdkK7LKAfVYbQplE7hzg5drjIwxGA0=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=gQhFMa5ajfSHVCo1Q1BhcN6xUcmrE8rb4m4/bpgfJKbOrG92xaLLF41piys1jW6m3jTlE0tcKyGPLQSfqyUwB1jg2OTkcQ/CUWF/+HvXWZyRXpf4S70Px+tJYT2Gew6Ykos/NmYUFazDg90LXGgPC763egyMtU56zDDoy0ddsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-360a49993dfso79927885ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705553225; x=1706158025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymoVARgRYWdIms/xo+octeg0XEPb8BZOwxsFtI4Grg4=;
        b=v6VVSqE6ztbYikOee1C6bFDBRfLMxllQP/ZNr0WGTou28Ty9nIlE6VgwEgl12nnprC
         I4EtH6LAMb50twKAr8kWgGnH4O6eIRKgn5Q9Yo/mXNpEZClrDWPncaqhpzyw9Si7sUh4
         rWNvXvOWXVRiXTobxEG//cTO+O3Qaqbp1mPDp7nKqcYWpsefx6lLGflqqrJGZcMvpE6o
         zKkiLzyHsUl8LMMYP1lDd6y3vfuUc+yWGEpx7Aqd62EhRPiB6UvQ5a5XRlyHSwlHYNof
         GmwfDHzCYkLww4Skrt2bizQCCDHlMmVkmoAAQ7KGXF1pkdnEL+u1fEcG16V1f54tt8mD
         qB7g==
X-Gm-Message-State: AOJu0Yy7Cu2q60+S1GiULV3IesNv77DUq8BKdjrBa8vmpgS7yb+odqjn
	ZBAKAlAw44S8D77q9Yl/jf+1j+K0kg6qD5IInX+F+Oys++9Wgi45sZOBiNtSfAZCf9y60is1eZq
	WWW8sfmlIjtkBTueVO+WMc4jea9wGRqQjDfKem4DuQC/O/XpreU2n818=
X-Google-Smtp-Source: AGHT+IEH+woEwYdSe7g/Y57PZBA4qKJtYRxtNII4slp4OUaaC4bIxOSd7vASigIipTBSUTWvRb/insfrES6MdicNCz7xcfOqIgQP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:361:9bd6:9dab with SMTP id
 h10-20020a056e021d8a00b003619bd69dabmr46284ila.1.1705553225166; Wed, 17 Jan
 2024 20:47:05 -0800 (PST)
Date: Wed, 17 Jan 2024 20:47:05 -0800
In-Reply-To: <20240118043359.1367-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021b4fb060f310e4c@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/core/filter.c:2162:23: error: invalid operands to binary - (have 'sk_buff_data_t' {aka 'unsigned int'} and 'unsigned char *')


Tested on:

commit:         296455ad Merge tag 'char-misc-6.8-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1049e9dde80000


