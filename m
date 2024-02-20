Return-Path: <linux-kernel+bounces-72283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB585B197
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67041282430
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29246482D0;
	Tue, 20 Feb 2024 03:45:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B91C2E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400706; cv=none; b=gWdUko6CzieYfUuNlCkEBzEjutW1azwWFFsvCe8mn1+D1vH5ezFP/R4EO3WPY7okDxxIoyebuWsEsbG9H6OTUmPoDMwwPCBfwoy4upZ1EsKitfnU7XspET9XVnKTJvWnwLOvpSACdH4MoFQ4SEi7Xxxy4zyZqmSUyWKOQfDjvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400706; c=relaxed/simple;
	bh=xmyFZAec5FjBFbAISLAw3zuskOpWdADJK0wFURkB+do=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PnaG6KQphoIYphMH29NtoFU7U9VcgH2lSuLTPKAtCICXpfqznKu3XDCNS+PEeviZAAIIZZbjWbnQbKNq34PDAE91uZg2LnyM1iAt5DWQvBnJRmQk1AScAy8XgZhFYG5WEpPARceV5ULeWOeYmxnm8evOvJ7FssP2FIwaKii0y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc6976630so34327025ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708400704; x=1709005504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ecoVSgcB1w6bcuG1M5vWMwmXeoUT1km+D6SMzVY0Ys=;
        b=uCHIbzEgGxO7KUjheOIcVMoyWgAwlJ45wZ2vLTYlUvXUjEgxUZeLBjkhRX31/PupNM
         xDi9C/Vlmfv2wHAtMdutuzwD8ZMYLei/KE2On2Cfbgi/ukifnmp1IsddZdL1YquyW3df
         Gd1apdvnm6Ef6p5KJchFeDxvbrvGeXRr4zqbXwUUuNxvxT/ZHcGTN2Jh8jUDf2Bbe36U
         AeONxiNIRBJx67ZtGDuh9TNpaWE7OqK+7JmlBmILl+HNOrpQ2fADZtuJ06VKZ1Dmb2wC
         hpQy2fms1OZoNT3ebltHtghBz6gweV59UXvnz9xE3NIgjgrGWe7HwR0TPfdx2bvg/NXf
         oqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2C0EpSK1DST7kdeSrtNuk4cFfYW96wLRyG7J0oVe6k/CXeiH3ge09DvEjnT4XTdeeiBqVj8FNea88lorAZlfe/ygEnO0NZgZgby6C
X-Gm-Message-State: AOJu0Yyrx52LKg0vLxCNCssqZtvVJr2kwdOXSZpFpPBk4M54A2rRb/sJ
	fBkCP/bj//eoYnPlEOFugpwI3/M8yP3ZQmEOa3/wIb+1fCcmkFL3CpZnj8vPGAgW+Xd4iTCp5FJ
	0WJVZy7coyamFjqjzRR8wzrv1yG2Xb9rTIiAVJascsg7e2be2acA7qDc=
X-Google-Smtp-Source: AGHT+IF0bddvJaaauy4bxEvwiBKpaDuUaFT/K01DUz1IPmjZcUAja5T4PMTcDxtg2eLqhl3L/2R+emyikr9KF+SYjNRccZgUVuIl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4e:b0:363:819c:926d with SMTP id
 f14-20020a056e020b4e00b00363819c926dmr1079689ilu.1.1708400704571; Mon, 19 Feb
 2024 19:45:04 -0800 (PST)
Date: Mon, 19 Feb 2024 19:45:04 -0800
In-Reply-To: <tencent_6536044A2C75D97697660A3C4B371A963209@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021508c0611c80946@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in jfs_syncpt
From: syzbot <syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com

Tested on:

commit:         b401b621 Linux 6.8-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10b4278a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6a2287897dfeb9a
dashboard link: https://syzkaller.appspot.com/bug?extid=c244f4a09ca85dd2ebc1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16796c64180000

Note: testing is done by a robot and is best-effort only.

