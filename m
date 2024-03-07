Return-Path: <linux-kernel+bounces-95394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803D874D23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8639B2112B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AA128832;
	Thu,  7 Mar 2024 11:13:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21786AC5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809984; cv=none; b=lb9aOeRAtdCnBY3UtJDnrfM32ga2W+Yj02kZ7hTxHefQBQIFkCUsG3cPwSzfUy5qYyIpqQr7RhWes3SR7AWD4TuZe+idp6nSsl5jEnz2oYvgae3i7YysQXyIj8PfMlduoMW38ZumTb48pk4GjaqdISlDjCNXMckon9mkAgr0o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809984; c=relaxed/simple;
	bh=yv41owbXv133hve6odU/CNw7rEWPt8uIyDiS3AyVLSs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NJrAWZlcP9VbACO669ekiMc2Xey3IY6Rgom4DPwUsTkSwWZvQZQ1k4jsEC41kbOzAglM5fHLOhknQQdHDPTBoEFEh3Y6RhtXwaCgCBRrvKyDgv1jM2qiJ9FmZSIBG6ZmQZPRSHe0cUzsDim48CukBHFVjCNs5RdcS8bQko1TeOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7c9831579so98420439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809982; x=1710414782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZu25r1BI++AxMvkNkxKwJHVQJbUEx48B5bf08VvrTo=;
        b=GD1k+FvdNQ9td45UvC2Qm+g87GM2C6OfD+HPjXjP3Px2vOXoMq5A8U65m8NCX/Qbw2
         cW3JS36WqJlI0576DPwcL6Trv9mCHVJ5Avrsp+PDuwJOrfXaMf0HetZGI5BzfcIqS6NS
         lipxIuLguhvkvj7LFTpY73qLnP8TfLsrXzVLQajWz4R09Sf1jKhn5UVbGBYqCbdGvXfR
         naxLg+hDLYHTSYI618HbRheN4PklKp8S8Zbd/7/F24MnAxm3UOiuY3CWQmRCQ9yejk4c
         mWxtVYxnZ142MbSxnjvpJuhma/sTIYlSqch1LujbIGv0XzcNOoWqrqaJwSOu4GN+gPqY
         P9rg==
X-Forwarded-Encrypted: i=1; AJvYcCVIpctFXX7ObLRE4hhKpLcxbkI6qBtP6Y5yaD4Od4YgljZwVERL/JcCU184iSXnrI7TJPvVgqzeH/AixAYimX0zHQaWLIXuqQ9iZ57h
X-Gm-Message-State: AOJu0YxoJeDZ9KqoHlr3NVUpGtyg8Vq2FXYq0NDIC8HJAvYroCpqX9Fz
	srzJDYeKRXlit2hH6xTIaBmZq3dA1Ejld08GODpxz2GfdlKyagw/3BQ9xM1acWBx+9M8w61tPSX
	O9ilgv5vdM2zgfLPfwYzVEmSlwPVGQjK0s5qrwSSIeuasxeH9UNqFQZo=
X-Google-Smtp-Source: AGHT+IExgBaCsh5qtK7rNOT7hHPlrDMMm/jBJiefAQmRhCgWO+lKoqH9wZyvndsQIOEsJpD5Cc4G4KIR/24amNWZ81WbP5aKSM7k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4120:b0:476:992e:6473 with SMTP id
 ay32-20020a056638412000b00476992e6473mr171773jab.3.1709809982408; Thu, 07 Mar
 2024 03:13:02 -0800 (PST)
Date: Thu, 07 Mar 2024 03:13:02 -0800
In-Reply-To: <20240307104857.1530-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2ad99061310283f@google.com>
Subject: Re: [syzbot] [usb] INFO: rcu detected stall in newfstatat (3)
From: syzbot <syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com

Tested on:

commit:         67be068d Merge tag 'vfs-6.8-release.fixes' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1345b1fe180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
dashboard link: https://syzkaller.appspot.com/bug?extid=96127c74434e19e4609d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172671a6180000

Note: testing is done by a robot and is best-effort only.

