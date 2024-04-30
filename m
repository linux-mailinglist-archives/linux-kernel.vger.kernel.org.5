Return-Path: <linux-kernel+bounces-164228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E48B7AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190FE1C21AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6314373A;
	Tue, 30 Apr 2024 15:04:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B777118
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489445; cv=none; b=fELCUMUPJk1MrigM+k2XyPNi7D+kTJ4KwXbLQchz+zKhshhqV1EJdyIGXnmpyJNqtVLFRKEC8EqnSJdO0m1ZiovjbXMCHf3eYCsaHh91p+MhRh0Wly5eFUD7we8ZNofP1C/CyxgmCSRkN3MxwgRsSq6Pwv22kKOeTTzLUFYBeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489445; c=relaxed/simple;
	bh=g+eaDs/HNr91gYab7fvFMZUmUzQXEdyjAn6OH6gxOuM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=okzuJTD4+CnzbkDHz7e1/U6MvHCJ8nXPChmQQHu8D98z5cqE3uFpB50pG+hS5wlXa/kymS/C44H45+XXKQaWlLFZuQnhrsMlQ9UNdj2HEUB7z4dl+R2p5bvD/fjxQPfjyYWsKFNA7tteA4ZaIQZ1nMVdQpePfjMLVGhgbPKp3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dabc125bddso630337939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489443; x=1715094243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXCBsJ9VpJqP069pIpVcCX4AQCkHuzifZjAsyl3v/7A=;
        b=pTIxPqvsNOTC3akNOFaoTkSdm3QqqpPfpzftW4QDHUIJH2JTllLs0IwcpBOsB7WUHY
         5ecqeXLxPEq+4A1IuJXhVyyfKBRHxiea7DT/xxqjRCu+QCyhk/vaOFeG2ybJC392PPHe
         3jTawbY1RAvY/LhLbZD4LLzwTU/ssS7AJi6vEW49460RKzKvNifOKhzAWXBw8f9BfCXQ
         UP1wV9DTJi00oU2MrYzsXXrnzO6bgq+oGGgTVO/mDI2O7ZvIlQCwJDl/haRwAYWAaHLY
         rbXN0Y5Rja+eTA3b8ouCreM2CBZkaE/ZAUXlIpGWQp3MrLkm/uvh8E87bDNzshARu2jN
         PtFA==
X-Forwarded-Encrypted: i=1; AJvYcCVaR65J4CdQbJvxPLdmiaaRtiGOklsM5aSu0Q5plYSVW/pDLWivWI1jBckZLM5alQXXTDU55BB+i9VAKpaiJNayvlU7TE6OfD0P5Jko
X-Gm-Message-State: AOJu0YxW3jvoOK1R50cS50efLD2Jo8YTmkNNGOtGhGyTa01Aee2D+CfS
	xrQ+IWEzIOMk6TKqReIs5D4tJ9fzdeMDOnqHcERI7Puv6YL21FEvU5Dw2Gry1txpgpnDXVMMccL
	xBvyd5+DH3GhbFT3siqd9Uu2AEeKHIvQg5QVXdjZY7HfgIQBzTV4uMrs=
X-Google-Smtp-Source: AGHT+IGkd8oAm76xqllvXiuSWamFxZZiYiLXM1NPguwb9PwGX3UzuHCPrjUn7xv8FxEBtfkwICP8m65fHvN8Z8HUb/km2DGAfMWu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a9:b0:487:ea0:dc07 with SMTP id
 w41-20020a05663837a900b004870ea0dc07mr1194901jal.0.1714489443214; Tue, 30 Apr
 2024 08:04:03 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:04:03 -0700
In-Reply-To: <00000000000072c6ba06174b30b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bf5be061751ae70@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in mb_cache_destroy
From: syzbot <syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, ritesh.list@gmail.com, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
Author: Baokun Li <libaokun1@huawei.com>
Date:   Thu Jun 16 02:13:56 2022 +0000

    ext4: fix use-after-free in ext4_xattr_set_entry

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1011bcf8980000
start commit:   b947cc5bf6d7 Merge tag 'erofs-for-6.9-rc7-fixes' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1211bcf8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1411bcf8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=dd43bd0f7474512edc47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d2957f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1620ca40980000

Reported-by: syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com
Fixes: 67d7d8ad99be ("ext4: fix use-after-free in ext4_xattr_set_entry")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

