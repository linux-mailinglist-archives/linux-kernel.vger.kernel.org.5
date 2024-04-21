Return-Path: <linux-kernel+bounces-152446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC68ABE8A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 06:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77182281176
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 04:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5B979DC;
	Sun, 21 Apr 2024 04:06:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6184C8B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713672370; cv=none; b=rj+/+PPbh2ThDk2k/XrOWdQXrSdzuwAGdIgvJ8tm7vLtOmI+rQBEgQCXHHp4Y6vKsLChguBzqk7h3ECuYiJ/2BZjfXSqY0ul3QmBlYKWmewqwpvILKfglvRoKvo8iNAvekbrVc1tDI9Qc8EFCdXVlqILopCX37RaotmTuVyHGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713672370; c=relaxed/simple;
	bh=ivnupM3viXPGONEHVF7SgtTpM+1Bg7+RollTeSsoAcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S7FY8MKXRl9Tu0XGfszgDHPsHNdPxpeK24OhdjybZyUGGTdSCIQWYRbQcW/rgrTGGzfbIHAgliI3rdrA01RrSqU4Xh4mHZ6NXVQtVi5EZlrNFZMZIwPSCYaVkX3iOHAj2+HJvt6up4vuXN6t1DQT5oi9QJY380RS7sQnSdsNCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so437852139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 21:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713672364; x=1714277164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UU7nndG2AnvwqiWCSKJ6rau9gqHABbkSdqnDcP3B6EE=;
        b=pP9zA3FRFx809pI+VUzG4m2H75tqTbqFL4PNa776pZN9wQ0eAzjnxd67vzbaIOL7m5
         0jj1YoA7eb8HAQXJ/c1jdPhJgHyEqOcdw4JhYvJnGfQIRStOsULoDI3FHI02qpNEsRi3
         fn0BMYkv3PG7BfSHtbvnJeRncMc/gyrPRvfM0ChRw1lzRUk3IEHi5MSW4cW6BFt7LLdB
         OWrvnLzA5qz5JuQqovyEp7tF1108NXP2fsSrx9xrezFb2TTtNFE+V19mfaebgi+beW00
         xAtTm8j0JEtELk8G+HOlZ2a62fAMkN/sCMUzCUw7AjuJCE75CmK9jPmGlTWIVLPesTkb
         71cw==
X-Forwarded-Encrypted: i=1; AJvYcCUjrJroi/lYnCYeHUti2ikpzdrxetdJ/rq3DK07/N7YdU+tjzngk+qQPNH5hQJRIavgmTuYJaRVmby6Np21bxgZcPnuowqYTs56xFtp
X-Gm-Message-State: AOJu0Yzgci27WCJl7+OJBAbU85yyEqOtKQDiZ9hLXLTliUOvvhEjicJn
	WK2oOFx8DlErQlWFAkKSBSbPFAhjKtXDsMvm/pMYuLARG6HYQThX6L6soIquuT/oIYU3x6b4e6/
	uKGC0xmSXrBrZjkKgaxtC2QFmBxfjzcEn4w4xH1pn3QS/jzDmcE19rUM=
X-Google-Smtp-Source: AGHT+IHrmIgNYp/ns7pE6R2KqnJFtlVnW9sIUOTGXy0FKhzo9u5sqReX0dTErI4ygwlIkJAx+ytQE1wfPGIhgzhnWotOz+ClHbeG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4109:b0:485:30d9:5e7b with SMTP id
 ay9-20020a056638410900b0048530d95e7bmr30128jab.0.1713672364352; Sat, 20 Apr
 2024 21:06:04 -0700 (PDT)
Date: Sat, 20 Apr 2024 21:06:04 -0700
In-Reply-To: <000000000000c1fa0506166fdcfe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089f36106169370d0@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
From: syzbot <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kuba@kernel.org, kuni1840@gmail.com, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 77e5593aebba823bcbcf2c4b58b07efcd63933b8
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Mar 25 20:24:20 2024 +0000

    af_unix: Skip GC if no cycle exists.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bbda4f180000
start commit:   7b4f2bc91c15 Add linux-next specific files for 20240418
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16bbda4f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=12bbda4f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=f3f3eef1d2100200e593
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e53af180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128b1d53180000

Reported-by: syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com
Fixes: 77e5593aebba ("af_unix: Skip GC if no cycle exists.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

