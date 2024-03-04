Return-Path: <linux-kernel+bounces-90763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B587049D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CA01F25A99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB045BFD;
	Mon,  4 Mar 2024 14:57:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F859168A8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564225; cv=none; b=lV7GFhtOvwLsEzVpPCFWJhtOvslLXW4oVNgait3kc1tLgBHvWnQSVRLyZlZ72gDMg0f3OC5tcPNm4+vGQfbKS2M+CUPhR1zzUk7WoLtNiY2MKXhvLu8cNBHlioh4z1wjijhDV3JBRCxqEP9cuwozGEqhvVnk/kV9aR7oG5B5GR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564225; c=relaxed/simple;
	bh=8w5W5AuNKak4mlOXIRJB5gpKmSQCcuLpdCTjoeS5X/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FsIcyXze8BEZoEW1oCqaxxCD0BpuylJFlUUfbVHQA1qZsp0GMIDi/UTHLdXc/UBWiHs1tLIbWidpE0NfVthnV/B9F5x+llJUbf+EAxZfAraKdjHbQ1yCZy8ST2mlXYgxmXAojvENtsnUwuyI5hfOgpilCvwv2Os8RBpdEEQwfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso410175439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 06:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564223; x=1710169023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idi0zgP3/OuB0K/4+v0TAEjqRPS/485WoBAtCefNTlc=;
        b=WL7Iorck3iFglMFFQij2wFYkwk163fwt6fHeKhxAGwNTaRRayZfT0oBktdifOwHQta
         DwdLrsHJqd3oU8hbnAV+uu1aryxk08l0K8ytRwCQxqW90uGcb0Lz8Za1jwP7Ps/2KAgx
         UDHgqJN4b/0/+PgG87i7HzSikmgAyDss4/jg0AP7yBHIDMzDLa+f6EkaglhCyZ430iIv
         /wYW+N9peOPYgEzFyY9nT6AW5CMuLOTJFzFS5ch4Y9KGuo0BL09ZmbxV0h2f6Qxlr2sB
         kFk4VnyLBQ+SmDjneUokt6BQBvxuvmsKlB99CrQcVQ2JBo2JiSGQfBmq5OO23UPXGDnG
         S+eg==
X-Forwarded-Encrypted: i=1; AJvYcCU7lU08VbmOq5SOALpqvSypw0IK8x+BjqCMSLcAWGi5b3NeRdflG5NV/pLBcwiXdaMDcd+hq6mjWLcUVMef3Xw7yLCCnnGwKd9RI3EG
X-Gm-Message-State: AOJu0YzbM0dB7vf8N0QfVoWcVYqf525hsaCqrJAJgzIKeIMcSOod0zhE
	0GfDO5xVWgWubmdVyP21WUbtL0GeMQLe01gfiKN6FGh3i1ViA50tTmBldaJ16OEq6Obcf0xlf0F
	CROIUs9u7+bKUMUfjgEeJ13kW0JKgohhHYYCbhFdPsJXsVa6QXqS3S7k=
X-Google-Smtp-Source: AGHT+IG3Kx4VvEI1nbp+oNk2RRA1dshZnobG1qoy7nsxUOiOtskEiqIbCoVQ7rOl/qNTMB+MB8PrsxM9+mejE+Sj9sjNxnjyCnej
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4114:b0:474:f9e1:6d6f with SMTP id
 ay20-20020a056638411400b00474f9e16d6fmr82556jab.1.1709564223239; Mon, 04 Mar
 2024 06:57:03 -0800 (PST)
Date: Mon, 04 Mar 2024 06:57:03 -0800
In-Reply-To: <20240304140702.1457-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f484a0612d6f0ae@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
From: syzbot <syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com

Tested on:

commit:         90d35da6 Linux 6.8-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=111f9306180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
dashboard link: https://syzkaller.appspot.com/bug?extid=b91eb2ed18f599dd3c31
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16594d6a180000

Note: testing is done by a robot and is best-effort only.

