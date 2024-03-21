Return-Path: <linux-kernel+bounces-109523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA168881A81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706D5B21958
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516FF1C17;
	Thu, 21 Mar 2024 00:42:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AA7E2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981723; cv=none; b=nSRPWUFcDHzeH3hZGze6Kfuu55Fh9kVEnyaCkhcVr2oSfgdHpud8b9kvd0NVHHS5soSUC6pYpixeqLS3GrtTIewRq65lEM0rG2Va4f7qZGOo06jcwKhCAA6VMokiNPMFXkLdfXWDOJ0UXy/iorQSo3gePsuzRuiAC28R0apK2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981723; c=relaxed/simple;
	bh=kO7jbvn8A/hTbMp4BNsvXA0eX83NzewuLpw2YPWntrc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XhKWDFJ/IKZ1ZD70R0lUTjtWi8CAUFvcnkEvaY/2d+KRHmfLKUhp9PXO0EEYEZatuwXFz/0b82qxHyHdVBZjj/Pljp5R6EWgc1rFRoEufqdKjSQU5x+1YmCGKH95ozfsGkWHKWnYd8SHONLVdBDCkXGoivUv1UufDv2JJmfEV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc764c885bso46323639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710981721; x=1711586521;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shYxr7zjZjUq73sf3wN3POMmxo4UECGgpC15E9mSfh8=;
        b=CoCHQLxrE9WhKmIFLYGA1QLPtlcF1BKngHIUhOcdivhnHki6JZNt+K7ono1MCW9Qfd
         b1HVLZmzS1bi0yEEQ4sh+CwxNCAxRX1eyRy0quLN6LjL/IyC3FIYg0WXRyRM+mwHm4PA
         Y5+1zCutST5QjwFO/a7VWKtmemVJ13f0GYfKY9IkId8inDdni1deQVdquw9UzmWyC7eD
         U88JqHJ4ZSFZ9k0gKktKwFFQz4DecF7mNaOAAMCRKXA+Mh+wqaSZ7chul4uhhQQq4MeU
         1eyCNSIHIMh/YiShxjEPZmFLV9AniWNH1zcSwwVhRMHQBVdGJ0scxv5cBYqQWhRO9F/O
         jcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW79qWZKkwTe61rNNs1QxxjpK6ZYye/RVDkHzgqMWvtYTZy2vxJ2ONfpollnGNqj0PRaAK+3wJL3mBM96R6CJoo08TEVcz8YTJcKDRq
X-Gm-Message-State: AOJu0YyTS1EZYbJeW5RcQanQWMEk1ZiR5MTtbnE/jd30RwkwvTrUhMpm
	RMadFGYOIm830AV8oskcaL8agUo0jYLJ7udC/5Du1/P/0Ku8NmTFoYV9Z/D9RdjtFzYkdj4uuzw
	R4mOHHExtvJKYKy6LsGmCk824JZplo74JvkeUBJoAZYdEc7QWqiO5ns4=
X-Google-Smtp-Source: AGHT+IGTMiSmyljQaNzD/pK4UL1D8y7/Dyzmtwjm78rq1CCbMBMKHOcRotOR8cUY2K1J64TFlvpetbhxsj5lgDCvVYV9zyV/XMnA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641d:b0:7cc:1019:a69d with SMTP id
 gn29-20020a056602641d00b007cc1019a69dmr286923iob.0.1710981721547; Wed, 20 Mar
 2024 17:42:01 -0700 (PDT)
Date: Wed, 20 Mar 2024 17:42:01 -0700
In-Reply-To: <tencent_628EA5EC0D8212135DADDD9699154FD18D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bafba4061420f95a@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave
 (4)
From: syzbot <syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file sound/core/timer.c
Hunk #1 FAILED at 409.
1 out of 1 hunk FAILED



Tested on:

commit:         23956900 Merge tag 'v6.9-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=18840ef96e57b83b7fea
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d8023a180000


