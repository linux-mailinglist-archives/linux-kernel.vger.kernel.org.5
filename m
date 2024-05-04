Return-Path: <linux-kernel+bounces-168446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A78BB8B5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153D5B20D51
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA58A50;
	Sat,  4 May 2024 00:29:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6B629
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782547; cv=none; b=iv3T0/RPDUQ3XER1BWzDXw7zqz7hJaASHlb3xrXtiiQGAfJDEPlC1z0wkWgh9/z4t6XTrDgVln/4s+/X5838fkE/MOi/icJKXv1k6RbsWYT09liHsNJPUh7/wOC3yvjOi772gYcdfeu4pfuxjxresvsyQT6uF9cb/u72MHkyncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782547; c=relaxed/simple;
	bh=PSu/U2rEr9Crn+mdTayQQje4O/D+NQcQSkn5x554Ggg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qdzcljKZKPjXqAeA7DXioG1ktPpK/5HGZOHkH5zxq/z9yZPiIp8zkrNBZhXCCQdQzKNwwvErpN3WCTPvZ7OuHtW7IiHTmE3xYj+09U9dMQmojOV5kB6vsYXXC1lJBLwoCJdedX5OqAMgn1AZyPhPPKDHVymsUl6zoqWOdPAZJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dece1fa472so19777839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 17:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714782545; x=1715387345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asD/7hCmqzKw0GIMHRL0JAdUwek+LTvD3ZFoISBMKCU=;
        b=tpiyueE8jRu8og12MgCcDYEQmIioFNvUAh15ZJ9PUtoPRgbvoSi77V3T7mbpVrBrRa
         mhpxCEoBzY8+sCQXiteAadAwJ3+FZwj7AgnKDlXGQpxtEsPD3b4JZUBks3MvHFjg4qf2
         eQqEnp00Iu3ilk9AE5Eor2DI/RwYm85Fwwc1UPlTateYMArkfWB6uaOVczRH+GXMNB3T
         9opbGww1mOztPcEnIajx2FbgQ53VoIPWW9ppWcAlYpRLUSLXe9fG7XZ6gPYv/4EPhF10
         sCTPdrOW6cSO0hsfzHQjrz2dbGh2sExpPCTJXVjgU8O71KckuwG5v+uY0ihMZ+JZOcPt
         lHJg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCigM7wFbKfVwXtXsl3FrZ8kjx9NzvUotiRHh9NPAb817uHfuxkuJX72Tige10xXkREF/CxsnhLdaibm95WSyaJY8T4pwqnH5cDAm
X-Gm-Message-State: AOJu0Yw36aUDxaS4YsE1fIvDCRxiXVgesPXHQtJ3s4BKTT+dqJWdTCnX
	4MeTpzOc9nVSZa+xGD7UG4pNRHZwowdLKc/yY9VsAPVgltnH+3HfkRHinO6tT1nwuBPg1Qo9l88
	m2yHWA/a6qke4m5gT3FAXtEHwXbdMdsUYNi+o3ODSIWBG8QMn4NNCQkw=
X-Google-Smtp-Source: AGHT+IFUwj5spljY2Iwert/KmKUdCcRSfzV4oog2DeoNjyjIG8PlI/59PayICbggpDfu1obeBgkmG1QeiTxDIT2A1jG9EXs9UE/1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8c18:b0:487:5aca:1a49 with SMTP id
 jl24-20020a0566388c1800b004875aca1a49mr139772jab.1.1714782545529; Fri, 03 May
 2024 17:29:05 -0700 (PDT)
Date: Fri, 03 May 2024 17:29:05 -0700
In-Reply-To: <000000000000367c770617901bba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e6133061795ec44@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in __closure_sync
From: syzbot <syzbot+7bf808f7fe4a6549f36e@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15745bc4980000
start commit:   f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17745bc4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13745bc4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a7c31f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16109450980000

Reported-by: syzbot+7bf808f7fe4a6549f36e@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

