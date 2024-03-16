Return-Path: <linux-kernel+bounces-105124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768FF87D963
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0664A282237
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3AC10A2B;
	Sat, 16 Mar 2024 09:11:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F26AA1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580264; cv=none; b=Su3qU/7tUxkPLAOZb0mWWk0qQCKWMgCNmbs08b6MKGI0oEWbmzv8tCsNe0DtNA6T6EbGk+hWdUPOPWKuQE+T5323opPGUzGHUcm8FGerW7XDAW28FV5l5HA5EBT/XTg93wVya8eJA7t3E5Qy1eALEP1omBVrONUXRLMtdx45rCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580264; c=relaxed/simple;
	bh=EI5sJYLaI2i813yl9Pox+03jUM0aSna9cHlcYTaryfk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CyVxRCPOi2MxZZQ2JRt5FRagleI2ShnP0Wt0Hrw8AZuAm561eGaXeFN+A+Lza920slIW4Rh8UBKeYmwwfiXVbYWQyd2Ak/zjFAhne1r76HhLzat8Dqdr+MLgJ6clKu9UiWADMYs3tz7aUGfFXBVNxhfkXRihhKBJ76Q2e0nf1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c85f86e4c7so240641539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710580262; x=1711185062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIc8SsIakUlkr+pIaFx6nnyRp4QtafguxXfQ1iO5ahc=;
        b=eZx5UXIr0vqKYXLivtJH0SRsa2p5uaZHBYOLIL1vHYvCTvhZj/ijUls35M/mdHDARt
         cPkonhAHs/rSCbDOHcVTupWzS5PML8CZhpwQB7uV4fvWf18PzDCPwDI9plMHBrfZ/Nr4
         ixW8u6EifpwlKcZyW5Pptb6F8DBxcG61HdkrigmcCsVJQIvn60Cy5jAA33eN57439EMK
         9PrWC1fSbKZy9Dxn3GGYx4xJoUFMUnFbS918AQdftIJqNNLRUAhSysKyH16RqVLTUKyG
         WqcOaBVmY1pTBkxle40KGykJSrYiT4/duE+ptGl5eN+D2W0qYVDpizrubozY0/JxfbIq
         ikIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSR36zPKvC+YGqeazbJEXY1R+i9OO90jZXevc5296KEmcBa2ZUfiT6XUrEY/3Q31VMduKoAmcxr1ZH/rdNwaHxqH+r8LjB6JfqaTN2
X-Gm-Message-State: AOJu0Ywks34XWsjR0SP6wVAIGqYDq1h/KUOJ0y7PpPuqb6jB7RTpeKYb
	yQs7Yn2oUglmtc2BTMG+B3+LnlIvpy6gxtUHhPqsSpAWbfigQlE6/RALpylGkqiF6MLC9gYODu/
	FRIWizHcnjCLsAt2DWq3w49mSXOO0tzsk5ryaOMmSRu1rWn6iDZ572G0=
X-Google-Smtp-Source: AGHT+IFRla4H4ajzvVAELcsA7cR0v8Bb5uBSXfpW9cfqsum+wpJugZPMKvB0Bkp/icv2QKSy+Mc+NBVns6VXEw4xm66qLKZ8MWfv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1413:b0:476:f2d0:7722 with SMTP id
 k19-20020a056638141300b00476f2d07722mr235175jad.6.1710580262592; Sat, 16 Mar
 2024 02:11:02 -0700 (PDT)
Date: Sat, 16 Mar 2024 02:11:02 -0700
In-Reply-To: <20240316085211.1816-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e993950613c380eb@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in snd_timer_close_locked
From: syzbot <syzbot+f3bc6f8108108010a03d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f3bc6f8108108010a03d@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=142f5185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=f3bc6f8108108010a03d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ff06be180000

Note: testing is done by a robot and is best-effort only.

