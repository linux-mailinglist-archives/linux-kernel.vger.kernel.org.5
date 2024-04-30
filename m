Return-Path: <linux-kernel+bounces-163180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D98B66D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2182811FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC063D;
	Tue, 30 Apr 2024 00:21:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98D161
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436465; cv=none; b=pbx8WsAXdCFNDQsLaQw0feOe6Io0KlLWmM93I5QEvfW/gpz3VFClUy/4L7j6Cxk/5g4JxpmKRa4crO9IltaO5N2luK7WL8DZPPq8w6h+i94vTVFI+par9tuJZvspvl2XTDdSp1xiyG3OZOOvGXRusZAU9gxW3+Ned1gIW82IIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436465; c=relaxed/simple;
	bh=hkFCJrzVk+OYhAHIi6ndtN8RtrkgxEbcgdhbaM78VfE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dq7Cf0Zb/HjHXgPuToM+A2nEYZjHdOZoy9yWO+iuGcC0so+IQA2UJvnQ723AJlV4kX6ABCfRXNkzukakcPpDv0tsLcS04Qw2MNQ/chIrkPZXifiYe3sf0nq5SdiUbB9BL0Awp5++uxmM8v+YpvQJW2OQxoN97Tyh4oquXKq+scQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so568872939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714436463; x=1715041263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wb+9hSlrRGtQn5Ej1oDKacUkmAM//6I/dZ8+ohpavzo=;
        b=pQRJzOqciPZK1fl9DI5DkiohHxx5v82jQ6f3EHR/WGYMMmrsxqXYP02VEs2Rge/fOm
         f3xH//8mqyO/Ye0u5jDKimROYdjiaF5DZiLYynj36b6ck0v8DMU12x8Wo4pDw7t/ZcNs
         aoE4dWAsS3XAeUoKl2eKBKXKrjnyQF4vBAgLd/mf2EXKHmYQXCAoB3HnE0SUeB1VKhES
         uMH/Y6gKGYxpXvSCWrt+jE5gtoXbzakGsTv0mI8Y6QqqamcgFuDbGrScj+YC/bVyoB2L
         HJQMauNNpPVqpGMdf29b94AYSdTAi66OWBDXHSdkJ/pyKJzPPtvBmytIQWtdXU3XYsdi
         /TGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5cWy5cYY/9MUxTRO2T73KKIBX/W9EU39XSFRUJqtFrw4KE2ZCyz6uKeBDxO5hnwV/7agCFcbiPon9WdHdICR2f18hUJHv6mb8tVel
X-Gm-Message-State: AOJu0YyajNLrX2aRk7myVmo+xgqsUJBLvkb/b1L3yktQ/6FGJG4PIq4V
	yjnAqJQIiDFr23V3oDLk2F4ZVDNWognFOGN4GL1v8/VJvlw5bBvADkQX8UtK4s50jcEmFyRORL1
	eR768On/LBDgAWLV8Kb0OYoUcKee8O/v/ddxDTBUZh88mU9G4PhEED80=
X-Google-Smtp-Source: AGHT+IHv/oycYTpSOMO/jQqHqd5OaQue2bZh+UiUopeV4JpeMEqDGIsLpN+zxtraig+TL/8gC1mTuPqfi6AHvQRaAqPIUOZ+u3RK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ed:b0:36b:fbab:9f14 with SMTP id
 q13-20020a056e0220ed00b0036bfbab9f14mr438460ilv.1.1714436463441; Mon, 29 Apr
 2024 17:21:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 17:21:03 -0700
In-Reply-To: <20240429233540.4243-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064c7a50617455865@google.com>
Subject: Re: [syzbot] [sound?] INFO: rcu detected stall in snd_timer_user_release
 (3)
From: syzbot <syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com

Tested on:

commit:         e88c4cfc Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a0ca40980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=43120c2af6ca2938cc38
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11eaa58b180000

Note: testing is done by a robot and is best-effort only.

