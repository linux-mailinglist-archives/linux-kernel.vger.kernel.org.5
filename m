Return-Path: <linux-kernel+bounces-100828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22869879DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5FF1F22813
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4BE145B04;
	Tue, 12 Mar 2024 21:43:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61614534F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279787; cv=none; b=u5WNgAm13bUqBndr32UokEY4QxTnWl/Hoh/xlxcSFxzHSXml4qjgUJhMDBS4Zo1PDAgZax8YAF03/9kOA9H3pgf/6Z5rUEW3B1BqQ6avVlFpCaF7vNq6stHeyCz8v10u7ql83g1adxRBToSI9Iqw2uW9xVYjEvDQB/kIhbkz4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279787; c=relaxed/simple;
	bh=+ntyJa0Ew8nKgl61n+Nh2FH6rWw/YsnJ8ujp1FK4Ip4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZJh2g7IVtQazgObcuzBBOPzSZDDfl+7Qwp1oXOlzTNY4W+Xi8yV4B8LoBGBgmzE0nN6oeTvVX3SifGpPJ2QzjmWsK6nIRqwVmRRRRgeJHazo1vV/YGIaXxF+NVoHPOwthzuXon3gcFzdwC0ZMfY/ys4c/4/dESFz0q+NupR0gsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3666f119204so2992785ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279784; x=1710884584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPwkHRiTWni56jLRMYYCYOfrKQED61Y88uUu4x05NAw=;
        b=p6cb6TzApwrETqV1guWSI/jWIpRo2RKGzQOj/7DaANnmwbra9pTCotkerqcleD30UO
         b4cOSoylmqi1sKoO8vLfAM/nlY/eq42rqV3ay1Qh95xuu4p3bdBEfwLvXpCnO3VSMuo6
         anevcHynYfhwqamkpYaxhncWW8pfL8vQDY560XME2j4khDGQ82KZjdWf9ejWhsLaQAU/
         lB596BZ/3tfhiAYgQK+mtrFVp6X81xp63jlJSrlYiGbv0hngmpHmLaR93OfM7RpJ0F4l
         flVYWPbRAFroz5Sphm+ZsLgl2hAfxRKLwae3UTiJ3hZYBCb9ZWwVsexrVO+v/xjtuHwU
         D4bA==
X-Forwarded-Encrypted: i=1; AJvYcCXg7gYFnDwiskuMwqnn6UHYgqcyiZdj6LXZZ4Nj2KePD3Wlsjex+KnLZj10CF1tNy7OS2+8JctPVE8PN1t1h4Qp4JCZ8y89QWo/WBBA
X-Gm-Message-State: AOJu0YyP2vLDICrHJQdzyWAYkSG9OFqNJkD+9kSFxR3jzoM7RrLJtJeH
	CegPNbkG+vGQz3fWwwU+EuAoHjRdrLsHNcg53Qa+Ok9wIz8Kwwymxq2TB2eKukF3Bc+cLKcyzzV
	Ac4f6cDZXjxWu1L1Mt0m32zWQVwGSkoWvTk9AFb4WusrcG8Jg0MaB5UY=
X-Google-Smtp-Source: AGHT+IFOpyNj3FNGoLTzOFEnZ+tR7pSAuEVi60fFlN8TuPJlT3LzUp25kdsOJOotvBru3ani52Sg/5sSOVe3e3YqU/YqtNadiw2j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:365:fe0a:b366 with SMTP id
 e12-20020a056e020b2c00b00365fe0ab366mr42803ilu.1.1710279784538; Tue, 12 Mar
 2024 14:43:04 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:43:04 -0700
In-Reply-To: <000000000000ac8cda0603cbb34c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000634c606137d8b99@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in insert_state (2)
From: syzbot <syzbot+d21c74a99c319e88007a@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14342f8e180000
start commit:   f7757129e3de Merge tag 'v6.5-p3' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=d21c74a99c319e88007a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1202e640680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e949f3a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

