Return-Path: <linux-kernel+bounces-68061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C385757E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA69B1C21F81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C012E47;
	Fri, 16 Feb 2024 05:09:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77363CF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060144; cv=none; b=FZeEQV+kAly0M5T8TitJDCmoHTLnl+yPDzhhP6BUGYFsy0qIxocq2kCMSqg/EpmuwNlQvBaJacMictcaxxnNeyaMkGUof42pE/MrAsYPaH2ki49MkffEgJpZJb/ov+30edpPLp/in+TtZ9PEPnsKXRjA4TYF/QBxQ6LVNJjkOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060144; c=relaxed/simple;
	bh=wCalr+RGfCd3MOKT6vGikKViCzHrRjs3785hEL8BHos=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A1IOlcujgoj4y3u5E1R4CFRzM47XXsksC9JupUeQNL5sgaHR4HfLh3Oh3Nf4pTwQNbM0bw00ftkAIFKezb2DnaQarlGNtlDjs8ZMwQdoXbK3q0nxum7BlyoNo8U3dqswHXisBpvEja0YddBTN1cZZi2LMXip5LxZAJ71CMUxThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c483441d49so142423839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708060142; x=1708664942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYWcCWYav/6fI02C36KBTcPBqg6aHBYuapXAZyLv5yc=;
        b=q4B9MUe4yxRERtCvy8JuCdJu5lDYexZACAuPT1YJTZ27tYLAkIWex/ESrHaRX/lR0J
         uC72tYbLoMBloKnilS2J8xGeph5ng60YqQwPz41pXMnIAu8kTSnKuE0vHwnBxuQJRc+X
         84+JdFBd7CrenCsLyuUfUxxlfQh8ZJjolBwKkcMJZb+NbARDDNNBT+gDCu218hf1ERoA
         ZXMLCT2vdNhSTE95xdgfJ4B5j+K9L5m8mAdfxKTbkwdwhYdA6rDLzn+hIsJ09AuX29AQ
         3E17m1VXFiqbul3dM+bAenWhyoM4RKbJVaiPP3V+10InZqqjg30Lv2dbgoRu0SQUfzFx
         Cy+A==
X-Forwarded-Encrypted: i=1; AJvYcCXL7zKePod6UN4oi7R5C1DdwuRKKE6wjYOTEVGVlvJ3Lp0u5gWrP4zWtNRAUIId5406KzuLeNe53F4QH+VJySM0I5Xji70u9E/ZFqDl
X-Gm-Message-State: AOJu0Ywwyu0kiN1bD1PEg7wRSnUAZWAL3lW9lJkcF3ViBOxEsXGpjdv6
	EZc8TAHh+0gYLm3+jT95AsBbpNuzCAe4jPkxXJlDFc6wXVBcukRvQR8LaBLbDelv2HCih67Qvej
	nlrCD0EQENQY7O/C4IflkfHLb28mpIP3rWae6yp5XDoqxbv//LGNkumk=
X-Google-Smtp-Source: AGHT+IGI8U4+1PBo8aAWjDja2dsSZuva29MnQ9PlL3wGCgYlZwh8M65KTjR82e0Mg+ALQuEsXWw/haV6ztwBGAOaNtMzwz5MbvcX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4805:b0:473:dad2:bb3c with SMTP id
 cp5-20020a056638480500b00473dad2bb3cmr59506jab.0.1708060142655; Thu, 15 Feb
 2024 21:09:02 -0800 (PST)
Date: Thu, 15 Feb 2024 21:09:02 -0800
In-Reply-To: <tencent_24D4467C09AD6EC92ECD4C9AA7FF46C89206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ee070061178be16@google.com>
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (2)
From: syzbot <syzbot+ce750e124675d4599449@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com

Tested on:

commit:         88bae831 usb: typec: ucsi: Add qcm6490-pmic-glink as n..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16675a78180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28a3704ea90ef255
dashboard link: https://syzkaller.appspot.com/bug?extid=ce750e124675d4599449
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e33c1c180000

Note: testing is done by a robot and is best-effort only.

