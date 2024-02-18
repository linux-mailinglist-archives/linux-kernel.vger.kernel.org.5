Return-Path: <linux-kernel+bounces-70553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CDC859919
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019EBB21229
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73671B47;
	Sun, 18 Feb 2024 19:36:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3B6F511
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708284965; cv=none; b=AeLAJrV3yiYkD7SFcE/hYXb9LF2URYqGrSiU9M6j+4ESQmmEFDNOYPziMcYwrGwG6D3GWrS5eBN4SU3+XvCUKrO1/O/R0BbpUuNmWryhA8E05KnHOWdorfGFWCH++r0hWr0po72mp1x9pWH6VTXrODeYos8xwS31GkKp1wVkvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708284965; c=relaxed/simple;
	bh=3FX4rtGdKWDOzhksBPXgjGi3CFyV5x/Dl113EV0q9qM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AZztg8nFvRGKuwoQ/o1955c76DSycFjHn7Ym43tgYpvem15KTvNQ9hBDFXYcEPDT6oQ6bdhzkikm/etHUaWTEi4Ma9yij6NdV4BapTc/M4usYnE10JFlkE40k2d0g84s7EJNeKEKZTDrSnRldXH57Pu+qodYQlGPgq4GGeK7lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3650ac792f3so17015765ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708284963; x=1708889763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VjE8fPbReWrcIR9LUQJ053LQQACtWBbX685F4g+ltc=;
        b=F/KBvtZMZF2nrl23VzAi/m25J2/8i+FYfFf6Dvuu8uPeHigD+LC0VoZglrVNE++EJj
         RoX4CkJRVnJbU2he/FbRUzba8+CM3DXe30Pnsa6rwQz1NKlQmcyAklw16SMQjJZUYYEh
         /XCGblf7+QkvGqa5Y+m9IoH7w6vmJDUvQBFlBkzyLM3mEywp7SVQVRZfR0cfz1nVi0wj
         4uskOp0QDFNtdTLxBVlDtmrEklFhrQyoCP1huJbH4XPZjon5jwGDJB4KryBp9LVLYfKn
         xj2PujbPg/KLI0shiTrxguR4tONwrJ3GiQ5AKYIWYHJ4acDlF7uOmPPJcsXbebiUEONf
         b7xw==
X-Forwarded-Encrypted: i=1; AJvYcCXizPDSG7KW5hAcCdi0cjxmMxssij9sLkVlffnIlVW7OLDXHoAimsQgajK3N0Od4XwdePLNAxuOUnY3Md45uC73iOhpuAMmY4jtVXXR
X-Gm-Message-State: AOJu0YxSneItoZb78eGuPasPiIFHFbSR8nO2Q3Bm7a7ggG6zbGqF/tJI
	enbfkYrWTqaSpKZmtI/CW0Hd86p1thZhlYQuMIKQesEndpse7VMD+CbSV8VtvPKg4ByvkvLnQYT
	Q4fXSuTXfjXyQf8kvJN2Cy+zfOT56yT1tArv2vJN6uxZcq7jELL0aCXY=
X-Google-Smtp-Source: AGHT+IF4So7qhdMKtZscBnCFO7cz0QMU2cVZeGgVgDx6aEAicBGXOfuVRrpdnDybQ7dx23IBtYxxe/9lylfo0cVkGE6dXfexrIM5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:481c:b0:471:647b:47b3 with SMTP id
 cp28-20020a056638481c00b00471647b47b3mr97325jab.6.1708284963017; Sun, 18 Feb
 2024 11:36:03 -0800 (PST)
Date: Sun, 18 Feb 2024 11:36:03 -0800
In-Reply-To: <20240218190032.39987-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000655a600611ad164e@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_stream_sendmsg
From: syzbot <syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com

Tested on:

commit:         25236c91 af_unix: Fix task hung while purging oob_skb ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=151b970c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c368c5806a3ee9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ecdffc180000

Note: testing is done by a robot and is best-effort only.

