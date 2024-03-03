Return-Path: <linux-kernel+bounces-89646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3986F38B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D521C21008
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 03:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F4613C;
	Sun,  3 Mar 2024 03:58:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A117F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709438286; cv=none; b=BGNmnVGIgcGc7L4PSmkjE6IvNbtL3WrRckve3umQQ3FjyFf7CpAvrq3oHYJO+y8vaRkh2l5fB3Z0LO3HsakaUKbXo80Zx4McDUL7pKL6Y19qRxBmrGlGI2CWz+0wyDmFZxtD7BW/iQjdNs1AO8esvYyKm/tKFFbP/QvRj1H2VlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709438286; c=relaxed/simple;
	bh=lLtjhJ+m/T5OaBJeza9yaKGUsKPzX5WIjnCf2l1V8yk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FawJE7QdG6uRORiY72PmK5SN2WY5/VR01DVDm4ZhtAWr7kyOHsE/psogaL5AxpM6pCwZ2bf8TI0DPwZFk0A+SRvhpxj3W6b0wwStOxO9fK0I4qoTpQs9d9fHz2Qwgu/GNakObeJnVEgtWqIttFHXoZ2D8t5xfGnFhIZ43DJzh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36516d55c5fso41363195ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 19:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709438284; x=1710043084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xT/7qy/p+PGauQUJkuda+1eAr9LZP3Xz3iuLlfuOqrQ=;
        b=sb3M09wIWPlEDEos7WddiL5qeNbt0J3qA8ih5OaoH4W2Rba4ZH+EjdCI8TtKgjP9Me
         VniGAYDUnbNz0BuVpMvinPJvDA3HHwQ4K4kQGpCviHoXKMypVnshslYGfsr0DGATK21Y
         yYAzXZZL0Yu+nDgIXakzZ+0pDr5Ep2ogZhWTH5JS7YAyJCbStKTrCHpUrhPmag7W/5r2
         fUcpGCW16PG3ZvmPTUl9nb3UG1xIX6gux8P3Lg6E8lMOP+kXtBZNW2OpNZo3P3P3YqhW
         f3E7N7buJDkuYGmR3avesxQBlhVKsKHRJ4tYE7PNnJO7NmXLxpE8LcisdZPm05JM4Xeq
         1CAA==
X-Forwarded-Encrypted: i=1; AJvYcCU7dvRqBIzRVoLC6g8aBQA0bA4aICa/B16BjffXuGtfe+2gYbUtmF2hNlk1sYWiJIBxs+JbATXTqr4k2BLqZoWf8nHj3eC2nKTf6Bf4
X-Gm-Message-State: AOJu0YxDe7qe6Ch+IVMSaJejG37Cpm+ywIVq7wuMKIrmLeZ2rd/mSITH
	9hY3A6vkPf4c7FOd8u6K2Zb6kem+JVJNnT4FuSxBtnc8+2rWoboTGH4ma1eFGIYybQez+L+sR9t
	vo5tJlJ8XuxXRPGzzIfy/K2b2WKorZBQokqWKQVqYez2pSWyjShcuRH4=
X-Google-Smtp-Source: AGHT+IFzlKR4sF5KadTXYYWJHa5b3QWiIXKE92CVzCgTnRrsT2MEEImhAhOBV27iPE5V/LTjuFIrjdCHsgEOFwFzSKPIXKeXLuso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d90:b0:365:3701:56d9 with SMTP id
 h16-20020a056e021d9000b00365370156d9mr424476ila.6.1709438284739; Sat, 02 Mar
 2024 19:58:04 -0800 (PST)
Date: Sat, 02 Mar 2024 19:58:04 -0800
In-Reply-To: <tencent_8C9B67BC3CDF3618963837324B3874D17709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba44830612b99d02@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_cat_keycmp (2)
From: syzbot <syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com

Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13467b8c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=04486d87f6240a004c85
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161c0bba180000

Note: testing is done by a robot and is best-effort only.

