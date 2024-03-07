Return-Path: <linux-kernel+bounces-95355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F2874CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A846B284303
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6633A8563D;
	Thu,  7 Mar 2024 10:48:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC2DDC9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808484; cv=none; b=fMozZEusCIesB0BcR1f6LMMD833sFa/i0o5Vv+MnCOOBJ+BkAfPO+FXgbMJKEewv2bGOPsh/Nc3wVtyDzAZGTejBAzoGFt9P0OBEgAAEiqXDSI6Q1GQrUROH5JuAg0aqVgn7e8fjqsVN2Xoon/IKWqjkpO5BIA/A24rOnleeO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808484; c=relaxed/simple;
	bh=9KGCatYC229aNh0OWgqLot1Lnq4ZeGuvndsJAZdKFLg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dCv7nZWUAu/maRjTvzhAMXMSevE8EDbqlQfMy9xKzAUz0rBB2W0lSKD5Qv2Ug1Rwf5SS8enSb/4c9ky4+SnO5BKLStT94SKJ1O0XryDsk3xFtmX8UNafkt65tdTJlThKT2XNPnzxDNMfRrE1izAiJyokZxmxO+CroBlhllizfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c836b4779fso83268239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808481; x=1710413281;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxJ45xbplTsTjbS++nJ4Oyw+Ah+NZEzhb2g/R41yRG8=;
        b=FJZXlh7q/lHHSxG0yC4EJgrR9/sjMvs+Wq0rHjOUhnSe5J83VhPrq53VoGnyoKcc+9
         M063MRurmI0+VG27+03MtRUsf1r04iSHe0j7lLOxaOKpSlpdvVBFGmqzdsdwLkmadpMs
         mIhI5yCKuaJM8BvU6t+AJq1gzkZZOg+XaS1rPePQlHurIPtYoQ+n7+9E4/ZVXylLYE1U
         YPCzma3Sa1pnBhQxfijE2OfooNoMdorNo/sCsHrShkum/E5jslzDqVLzOMLXuzMC6USu
         jd7+/h8k4JJEn06/5zKydzYTbhn5YARZ+la2rPwE+KOTiPNKIP+RTfVq+64uhufNCU95
         wQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXolh8BTcfIH4P8GMbvph3CvkqzulSchh2UyvM+7SlO3NFJIVGueXd7DDBS6oBGVfOD3qAvYp9F9Te3mZn+i2NALgjtNtbLnopn9Wld
X-Gm-Message-State: AOJu0YxOY1BzBHXtxO5IzCEftHf22shtt60mgNc/c8O9hNh7ODWNsKuW
	09WaTIM4aTjT8+MaWa5fD9dg21EfDCjEY5BL5l6Co2ZllR6tTtqOOEwRTrLV0cPREaKJvpkwMe1
	y1BeitHDjpx12POk6P0dhZLgDtr48EnlCp/vX9imZEMKkjjqS1GhFa5c=
X-Google-Smtp-Source: AGHT+IHzBc/xdf8+nTvp//OuQZ8DnTD+n2J0KhSg9bUPwbUSBSxi1My/eHoNjruTY+za/qypojKx7817/uxUstKyG7h/16Yx1O+b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a7:b0:474:edd2:24e4 with SMTP id
 m39-20020a05663840a700b00474edd224e4mr490314jam.2.1709808481781; Thu, 07 Mar
 2024 02:48:01 -0800 (PST)
Date: Thu, 07 Mar 2024 02:48:01 -0800
In-Reply-To: <tencent_5625D5BAC1BB7F334E9E261B494BC71B3808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030d6eb06130fcfac@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
From: syzbot <syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com

Tested on:

commit:         67be068d Merge tag 'vfs-6.8-release.fixes' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17c7bf61180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
dashboard link: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113c02ea180000

Note: testing is done by a robot and is best-effort only.

