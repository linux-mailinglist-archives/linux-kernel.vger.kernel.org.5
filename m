Return-Path: <linux-kernel+bounces-46330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24744843E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5766D1C285B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCDA6EB62;
	Wed, 31 Jan 2024 11:17:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75228E11
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699827; cv=none; b=hL+NnQCbOdfMVtC54sbsfUDhGrHEnIHX8zjZD6Sgs+KcVD9OsFXiZEydVh59JEsD1HvA26lgTBtBOhiltRnA9r+FETs2Q7LWKyiPCFXI3gir428mNhk5Mubc84gMAUDTYhVXM62wx8MCXj5y10SZln8X5fnfJ+X07iry8zOJVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699827; c=relaxed/simple;
	bh=L+QnCjnL887B7BrRIhtZ0TPT9qAj8r39GthSxIeoOyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zh8Oyl224dt2p2zvnkspClrJLIT0JW3ashcrcdDTiTazIkmXLpjPPwrYlBOQPJ6LFhf7ln1iK+gXvSNuphp8SHzu3vMZqzVYWGcA3OJwh9NwVqMcA6tSPNQpXy/hSTyEuweXEjPVERrQwKQgMi0MGBrwRh9zxZIvaRdiF5A7zhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3637aa8a40dso20687205ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706699825; x=1707304625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6c976If224TYeuwzTSuYKEv2LPA0nMDbHWz8hCyihE=;
        b=NyHoBqGMQHiqyaFrbJNQChpI7euQaWBYmpmntV21j8ihwtm2x4K/8fOKgSmKMBxMBR
         K84iZLk87gNxQVRvpaNMWxp84lCZc4RwEYKt9KOnIc9qhTD0VxWdwb101sAafnljRaH9
         YXIXE0ahSezMrGuMjmiRvyaw0pDw03PBtcUsU/aw+QSOkkGZ0r1y/WGXzV2LGeKmFzhn
         wSGZpfPpfadnOvDukHnmh4z8WBjW7eVGmanCngRIojxkAByvnV7AfO+usFEIEtQLqgyK
         l7qgvnImCYPP1XtIP+uN0D5XDZzEI/eomFjicBgktMZUzahhU4iytbyZavuQDTg3u7rt
         AsGA==
X-Gm-Message-State: AOJu0YwwbZ4scSewR2xJogOLyQer45xerAPu0LCy+LmjKM1RGPWa8q1T
	TNUtHQe5Y3YagFhl8dGwclxexenxoQbNSYrAkNY9u/5F0BbUZ3HE7NDSS4V+6KNYgUn3/cFr8gI
	S0Rfpo/ad4yqv1FeloCwcRo6546Wg/OPyajzSS4u5vIOkYLt6vb2XCTI=
X-Google-Smtp-Source: AGHT+IFP0lv1qI4rBu3ZRWPdBMeZQhknUNUj5MbszY0pqDASsotFmOnrd/REEEbZLUpCq+7tQs4ZgMBdYpKTuRIDh3smo6YkTot+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1807:b0:363:819c:926d with SMTP id
 a7-20020a056e02180700b00363819c926dmr131935ilv.1.1706699824966; Wed, 31 Jan
 2024 03:17:04 -0800 (PST)
Date: Wed, 31 Jan 2024 03:17:04 -0800
In-Reply-To: <tencent_7E79026C382CE16C5C96ACE81EEE26CF580A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce367506103c045c@google.com>
Subject: Re: [syzbot] [xfs?] [ext4?] general protection fault in jbd2__journal_start
From: syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com

Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6172fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0b9993d7d6d1990
dashboard link: https://syzkaller.appspot.com/bug?extid=cdee56dbcdf0096ef605
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17477cb0180000

Note: testing is done by a robot and is best-effort only.

