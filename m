Return-Path: <linux-kernel+bounces-109555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C3881AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7652BB21A41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966D1C2E;
	Thu, 21 Mar 2024 01:54:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4F1851
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710986045; cv=none; b=hvtXQUwUhMwuxf5UoXgmJ88M44D0Ro/rEwbqDbTKhS/8vLWWn/x7INHg6H70UZhMx2CtkKn+3iV1+s1zJELcoATsDx3PvBuy33usRjO5GFivuZ3ICT0djKBMRfPZHmQG/2poIO44MsA8kY4hxAPExwXEr8diQFx/gQE1gGGuyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710986045; c=relaxed/simple;
	bh=tk2FEpeIIFWyfveyU74wr/FUXwuQLrVtmrZ2u8VkTdw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZUZAtkXKvrJeZHaLrmidjloCpqg7Kn/pbqtZweX3kb9yQfgxefbIzI/3Ydc4E9Lc28nan+1ReAnPHfOHpWvuwUnvMy1AxMcBOjM1SGSPayLDZM9GoauYZp/hcnZCSaR1viEeO5PqBjY6325O0ZvMtyDxXTh0UlkKBJ3x16gxPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3663022a5bdso6184375ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710986043; x=1711590843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxiohCLy0VRBU3p0ZMz5/eIklbAClJeKe2l9L1dHV98=;
        b=K66X3Nx9RjQ+lee8WhZVrd/ML+Y6v+goX6QFTVLt3U0WKm6r+21BPL9/sWh+s4K2aH
         6vD9AM4PhzVDeWn63TlKlLZuq5uSepO+/ZL/7bHWJ0rud4wvrKZqAypX+IF1ybYU5ntd
         8dj21/+SnxFTFsTmvIuoTBzjgKtJVscrL1HFc3IthNpO0ulHhQ9hoLtOdfo98u6lJUKL
         6lfrZx3v0Lg0Z/Yc/ZyWrZrwaGOmKgRSoUDgD1F7uQPss654H/p1ErrF224IIZXYcsSj
         5UgJF+H1GtfwvbYgGrAz+fSeY/3VJS7cBsyk60szw0Q5g7xrYMFmPoavmjdO6ooaoxZz
         ZEoA==
X-Forwarded-Encrypted: i=1; AJvYcCUZW9+L3+/yAcIsfg+W6on6q7TOZ9Af2e/rGV+/lVVKJ7m4jULCSC4E1A6eaz/SU3RB7AqFbubgBJxqilhtgSjbAxMCswLidyir0uja
X-Gm-Message-State: AOJu0YzP9v2+PO3SQ6fRmYyM5y3uKB6e/+RYzOQeJ40FqL/HKO2RHrjx
	NnKXH1mIOu8kYBSedTY/UpOYcRu2GfIB+m1dSbBfH4DkYaGDYY7kxdOPpWLr9FkHcDm8tXVRWtE
	LO8aswQfXeWp1AkqMFQq37MArNqDcG/uSYAQ0505FiwEPc5jY7rGTqNY=
X-Google-Smtp-Source: AGHT+IEFDZRU7cJZhu7OqB8rcrJ1a8ByYA2BCE3WRLMvS6OxS83VUT0YmieKlJGDoZ65hzytvVChYUMPJdrviqkqBQMoySHUFKUD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:366:c679:e5d8 with SMTP id
 k9-20020a056e021a8900b00366c679e5d8mr424582ilv.6.1710986043364; Wed, 20 Mar
 2024 18:54:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:54:03 -0700
In-Reply-To: <tencent_164B6A74DD764D66063CFF36AE96A2372609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054ad49061421fbf1@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave
 (4)
From: syzbot <syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1268783a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=18840ef96e57b83b7fea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10928f15180000

Note: testing is done by a robot and is best-effort only.

