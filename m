Return-Path: <linux-kernel+bounces-130839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FC897DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82799B2155C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF31CAA0;
	Thu,  4 Apr 2024 02:39:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49B3FC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198346; cv=none; b=hg1AUp2eNcbwXiHsGoCfVd5OPdN2Vb6b9JR1Vi2mtyuyrndMJ31rCFyEsZsZSaKUiNBG5jtk+H5KFx8K+Rg9X2zYOF0BAZ6WmtgIkfpfCv6thMjPmyT6AHoy9QUH9GtYhdji+5R6YuXwedsb4KdnyUlh98DOzYg8mmVkiAMePxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198346; c=relaxed/simple;
	bh=MEe0MzLGdJql/DnSM4nY1OscnovHyp03ahMc85LihZA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l6/NY9oXA1/+82zuo/L6n6U56IAkUX3V6qmxh/ek3S+5HdlPOrMW0/0/JFGrcC43TEe8I5h4/7ovlPUbdpFkSGKnBaTm9d6U7C53NnejkD9i68LbweG524h4TvP7f3bL4ydws+NWmtcDYmHN3WlGPEQUV1MzDNjOrjshQVEdJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf092a502so59246639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 19:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712198344; x=1712803144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlKfiMMTgxpZSq4XnNY3uaq1k86EbBK7PbjDB3tI9r8=;
        b=QzH00z/aO2SHiMqwjTj+5ai8Bawq033haZ/Dos3HVYYwkS4QaZDML/5Ro3Fv91vtfl
         a2WHoICs8TxTakHJ5ynbfDfopJOL0BY+/rknQkzVA/RVCiOQ4POA+7h07yKXENXfINPl
         WdJKBCw49B7l8CBRANPv4ybQ7n+fB3Ir7LDkgFLlGJcZdTb/O7xEqaXOSwsQ0ti4MmpZ
         QXanC0ak7z21NgoSlWuGQDUX3E/bqctPuiqnt1Dx/0UsfK2EyCmBjsj9uhLo/Sp1OQBv
         ab2Vz/LbzNJC9VP4W4i8KtN3eU/HIUYMRZdnlYPIR4nn111gcilMSHsu1IlZ5T+8aWJy
         qIgA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJyD+MK2RRnB8xsswN/spb5C+QFvyBlga8xnhdVQhahl8SX9iVOnwV6uXNjIhoXpmdFQ2tvcDeFG/sFla2Ls4WTxIWvdKx6P4G2Ht
X-Gm-Message-State: AOJu0Yzb/1BbecnyNUvwo00bzASVFIqe7VQCgaRdQGq1GleOjeb9nAMx
	O6YnuEQoA545XaQ+y9KjZSHVUhTFCbHjAZ8ugDk79byI/KtCfd2weoHsnwSjsW5wJu2Nk300V6h
	um/d3zceBhqF+BPfBVuhjAWnsjkc5KsWcFUfkcdJB7ui+7QGzQXCAnsI=
X-Google-Smtp-Source: AGHT+IHuTan0Xxo2bC5qZvf0CFkhuAachumAjCI2fZZZJk83+PP2hEcAPk3bTxFWpBEIk6HbbFpi72VKWPEkthNwCUf5zupPn/Su
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6284:b0:47e:db25:8eb7 with SMTP id
 fh4-20020a056638628400b0047edb258eb7mr48890jab.2.1712198344346; Wed, 03 Apr
 2024 19:39:04 -0700 (PDT)
Date: Wed, 03 Apr 2024 19:39:04 -0700
In-Reply-To: <20240404021257.4018-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019a4fe06153c3e35@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
From: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15410de3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153a4a3d180000

Note: testing is done by a robot and is best-effort only.

