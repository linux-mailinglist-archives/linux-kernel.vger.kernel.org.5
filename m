Return-Path: <linux-kernel+bounces-150641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D58AA22C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38B428313E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF1217AD8B;
	Thu, 18 Apr 2024 18:40:59 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E916FF33
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465658; cv=none; b=Tb1iAmVGLljqTrhX6uAs+ZXvgw74i4Hczo5HanbcGCzGRonlUSbtHFdZVnAjBGHFmX676+q/Nv+hozTmWMJTGAtBGFRDBd3f1MzmkiZBiymYfIiTD00uXPYsYGB/iDsjeEQ/keKgVJEVf2DhCVZpWmQoaJ2T4GDbFqOm64pfGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465658; c=relaxed/simple;
	bh=PLi09W1rNlgq0CkziOOhr1uUqdpSWC3ucJvdak1fN6w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=VkCIwGNcbuEu+P7mCrotT9kvcy+c76S8uf6z5htl8Vg5pwwbMo0zdFXKn/5/6XyL/57SoGGkmHptKueO0LyZM/v1FI+IB2RRF9bZM/GUzCQCEIj/hB31XKF9yG+YxHY1+jjI7MhHdrYqOxZ+g7HAPHUKEN9eeeMBsWlwlS08GQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da41da873bso41503939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465656; x=1714070456;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOwcddqa6mwi7JZeav1q9HSZzPOAEu+pdUMsfp+gy28=;
        b=wxkfwCLwpvxD/51lhQjA89ObfCkd1ybnxpr//2i9efYTUkeHV1tKilJdsSyCvAQomN
         7P+TA1vk/GrY1GoUcxdz1FJgyK3IA41/0iapSaiFAr1+qBx4jXsFkewBLE/vsoPsnlxB
         3CZZfKY/uuxREpX6hSVsG4eglxWu1T9XulFhYKwf/LvcHkKgqKvbQPZqybMeFl77Q4wE
         +s0tgM9OD8Gvt727iKzz6nYzeP1yKK/AKsvWQxnIaBZ3h1wNmr2uZgAF9cwJAtWolMZF
         u6WU8BWYkruS3sVO6P1l/bXn8HZ0Dfag/xSEH+dqLUWHnSQna3RskZ4PHw1wQn5JvWwJ
         Stfg==
X-Forwarded-Encrypted: i=1; AJvYcCXOYBtf0mDPO2AgpLxCSeTk4FzjkYrulJfv8GzACoVo+U0Jny+iLjbqeKx7HEpQryBKQ/T2OT2y1N4VMf/duwsKytQN/HuclAvnZUOU
X-Gm-Message-State: AOJu0Ywh8+b5FNgC2wgtD+JUpjdq9HEpyTjG+THIQUDqML1imUiejy0T
	rbtPx/JQ+T0cfvA6I6x/NAHu3lIxIr3TJtsvpcBeKZvc7AOO71//gMbd2RGuwfPn7eg591ux4+c
	SzxYKjoKGOOmsMO3dfeda1AUNOLDXN9URDE9ji/3a9SbY3U1LXybvCKI=
X-Google-Smtp-Source: AGHT+IGl1aanp6Vw/7ClivD3OeSGLsAnH4vX8UjpN/F6TVzEJOU4sVidHGM/oJsSqXeeQfflk4MJkn0AyFLFWw60v8jtzYs3r2Yr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:850e:b0:482:fa6f:78f1 with SMTP id
 is14-20020a056638850e00b00482fa6f78f1mr238772jab.6.1713465656116; Thu, 18 Apr
 2024 11:40:56 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:40:56 -0700
In-Reply-To: <ZiFpM5SnIs_2MrDr@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c497aa0616634f10@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
From: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
To: vishal.moola@gmail.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On Fri, Apr 12, 2024 at 06:32:33AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    11cb68ad52ac Add linux-next specific files for 20240408
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13a6f483180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=727d5608101b5d77
>> dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/4e90f2d3b1ef/disk-11cb68ad.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/d886b454e2cc/vmlinux-11cb68ad.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/ed94857c6f92/bzImage-11cb68ad.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git

want either no args or 2 args (repo, branch), got 1

> linus

