Return-Path: <linux-kernel+bounces-133928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3989AAFE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A26D1C2149E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9334545;
	Sat,  6 Apr 2024 13:03:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71134C84
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712408585; cv=none; b=RN9xfK1iIaEh5Q/137Oy53jzBOrSs8YNmy+SD4r5eyYzaCmY7WzSUPY3dCQjwV3LHRPzP2GmVRUV9EBx82kscbsZfjiOyBHCmeR/uezfPi639Y7j//IcL20809czRYuu97rdsWusqCbdOo5w2Fzq3cDV+KP80Vj2bmA1vNybo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712408585; c=relaxed/simple;
	bh=akYG5fHbEvlX8+294h3qjWwgq4BmMh3iJIepoFnBBjE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CYo8/i/Lurmx5WvTHOK3KitIErqWJNaR+cQSVFjLujB89iEbW2edzSH9PUjrJeMX3R0plAAu54e0D1psH7+0OGSnRv1bXff9DvXMf8NljG8EzDesQKINhmqOfiZJeKnwEndhgRYg42y4XwFdN1y/3jEY7OUn4HXJo5ITqYBZuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d34f49058fso262473339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 06:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712408583; x=1713013383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0X82Rj5lWgixirh75cU2m3QA+kML2vq5txDLb/q5rvY=;
        b=XGLXKNFfWNmNj4GIAuA7NmedfRUJMD27ldIFzO492rVsjcBDxMLlclpoR/D3vPJkZH
         5YooT64j/YFueFkBEomkjw9PYf7L6kvYdaPA/7kcoijB5o1RNzmed9t2tgZNxPouBFsQ
         Vgfy+apq43HzpfND7Q0r1qHg9uJFLHvWOUsrabgKbMVFePZdGZaM0ZSX1z+594hAgOGN
         q0QDMCl2Kebpwj0YRowYWSTYTcIRWG0AbtuLoPNs8QleeT0UwNW/ic3TjrIlPHOyyMi1
         XuElhU1CKjtCVOrPg3YUnTHCz4CyZnEH4YDFy/TpOAJPbqQAZBsDWkAG3/9RQJDNSdXe
         08Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW+pETGiG1Mxvsr1CgorW5+D05byBRaDSQ9OyOMTtoUKbsoMOw1xL0MvTSKpDG97AayWBQxntjZMy2JaezOzYPJlJV6z1X+1djSTZV5
X-Gm-Message-State: AOJu0YyY8eLhyYGTVeAvzUnPUjh/A/AbWWkTACt3pP65sjR8ietlmwR5
	Ad7FAH9/E1WU6p9ujAmSW+zw9QtmY7r1vjw0mk3pVlFAa8hWHZI5kRbgH5J0Cwhc/aQaNdeKKtP
	wx1rhbhqCuO2oBfhRHyQE3/xCODhkWYyFNLdvVRHNBh6tqjtebWqdPE4=
X-Google-Smtp-Source: AGHT+IFqrXo4VlbIHVm6Ein8B9C375rMoIUlWLWOwpBMW4ETLfF9ZOagc1T9FexfuM2WzuYMCisi99hehnA5s/i0xUxPnCNr/FCt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d95:b0:7d0:3aa9:94ee with SMTP id
 k21-20020a0566022d9500b007d03aa994eemr155018iow.3.1712408583140; Sat, 06 Apr
 2024 06:03:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 06:03:03 -0700
In-Reply-To: <tencent_C1E376696F23B004491777176886D9D37905@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f066e06156d3149@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in l2cap_sock_setsockopt
From: syzbot <syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11b55605180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66b62423625ca66a
dashboard link: https://syzkaller.appspot.com/bug?extid=8a1d152fba6b41f760ae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c06aa9180000

Note: testing is done by a robot and is best-effort only.

