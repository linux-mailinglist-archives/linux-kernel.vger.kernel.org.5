Return-Path: <linux-kernel+bounces-162162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE68B56D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F388283025
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F12D4CB57;
	Mon, 29 Apr 2024 11:35:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD04501B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390506; cv=none; b=CMOxW3HjKq5+bbNLtmoDSrz/sL95ZYYYuuGFB0olT6OLO5vRHCfDYOXnSbMkVyGv0lHOrmi0Mqpmab49yqOmkB8zzTZhJQF6wtSa156pDrf3Uc1mu65CaDd4QWbfARb5nQAWWTfBzoqMnQl+WYAJ0JPK1fnfZtTmUubdo3ANTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390506; c=relaxed/simple;
	bh=5t/XWa1xxp1drVwkM6GSsAal/xvZvXJEe4y56QZM4Xo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m4Xuc6x8qY/UvKQKfWJcZOmwNLfwWGFR92eELacTUq7gnJs673eNyORFQo9P0cK3SDq4hBDQh4bAUO3BMi7BKvFAKcLeQq4l3pTUFjv8hTMip2vd7abBmu7aixJyb3HNL6sZtBn8pghSrWI31y7QrJf0pKBwgUqnxrOUUcEB7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c520ec766so4273415ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390503; x=1714995303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cXQJdFCWylrOntncVLmvxxqgHLe2rkg1CCfhd+D3aU=;
        b=Ku/gyvaf9Fsh0x0CoxF6LmRBi61nV8Vmf9+Jnepkb6Se8vTi19LL6G5YZbsjKlZjAb
         wqe7vwv6TlLOuXayJ46rj44jOs0Q+da/+VwFI/VmJLvMBaBglHLf0UJ35wnxANP7diKs
         1knSNe9dYglqqg0PNCHuZSRLrGg9ZyrExEVa3GobHka8ivgK/dzwkHk+8FI6qK1jzt6D
         SoWuYXQWrxcrXQChqMaaZzZ3nC5QhEFFtq9vtlrHlPINg+q/pI4rrVNW6HoZtU6E8/wk
         8eOTK6jgNC3tmKZvlHDAZXRT5BOl25zT8SoQWB4EPo5r0dyK77BljTVJ2EIzzB+Fi9hf
         LKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlu6vpTMxwSMyI72ZlrdOZD7CjN5lMCMPcu+5aCWwhyOPzkzu3KkKiK3qWCroCoHxmfbzk58IvsgvRnOfX8vTKtQpHrlvCehZe/tLE
X-Gm-Message-State: AOJu0YyckXZkv9e5Lq7No91A2JziOP4enkrXmBKOZU+97udwaXrpNeig
	izjolM0hzZHsGlFdYjT6XqLBRTt31pM7JlNgd89ao4+rMMdXLRtKIcJA2syum9fPwOvGfxpFY9m
	lCL7+S39eSc9ruwalNp7d6XR9kYGaa1gwOD+KDcChvZG0V9Y4SobGs/k=
X-Google-Smtp-Source: AGHT+IFsT8TSPTeMi2QnsVakORE4NzYAOCftb2L9YWW8qgT7sHuOuEia2cnr2kNtV1w1lg2ChK96C0kyF7Eo7cNDXZKS+ZvF2Vb8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8792:b0:482:cfdd:daeb with SMTP id
 ix18-20020a056638879200b00482cfdddaebmr436213jab.5.1714390503362; Mon, 29 Apr
 2024 04:35:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 04:35:03 -0700
In-Reply-To: <20240429103928.4166-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5a11906173aa4b2@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
From: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>
To: andrii@kernel.org, bpf@vger.kernel.org, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com

Tested on:

commit:         5eb4573e Merge tag 'soc-fixes-6.9-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14b4957f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=83e7f982ca045ab4405c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13471b80980000

Note: testing is done by a robot and is best-effort only.

