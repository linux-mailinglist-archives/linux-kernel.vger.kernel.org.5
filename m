Return-Path: <linux-kernel+bounces-130794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E37897D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289021F234F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB89450;
	Thu,  4 Apr 2024 00:48:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D3746E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191685; cv=none; b=Bmv/dtRuE4an1euL068j3ApHuWXnnBZDi2au0IyS/E8B8SJL8etKikT65frl8BKZJTJusfwSMhCAgXpgkMj7D+b6Vi05G20zh875R5Bc3BOjX/KH5jMYi7NYlnvlXN7F236e9nIoBr2sYNDq/u298N3xMLACCZS7qwY9QWdkR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191685; c=relaxed/simple;
	bh=V/IkkmlSgnCdY2OQuempFA/lObSzj4HvFjiswkAAexM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CkoB25MNAkmecCo39I4OJuactKI4GL7C7Zk5BX6QSsZP9hZOrlXjfq8UqYKro8Sli7SyZhGlWpGLNL+jm+muUFuhOzMyRwmtO/QO22VyQaj0gDYvfkQR1HnyX5tCFffD0gWebTKiO3pQgeH8SBOfgZhRYH5AXoQrohbASrA3xjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc764c885bso51457839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 17:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712191683; x=1712796483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqEt58zeisua8ol27uiaSQz7crIi9GUPLBM9sTseYKg=;
        b=uGLekeUVSMepoiX3xwqjrEbLRWmrtSRHphK3q09nzIgTWgrWoU00I8A8AFOv5mUWiw
         feDqpVKQ13CXWcToB+3HSjAOvXQsHRuyHisxCdRaNvcNoaCh9yxK7bPHP0CSubs6XBI7
         fC/3e+Y4tLxaczyxFPX6cctPTpm48Z7eQPQ5jkQiFYTGMhtY7iV6oricTnSvcQ3GUKgr
         xd+rIju5wZC4qLMcJOc4QoZE4744hIXbuPd7GDL9JLrsySdUWKHSidZEx+SkVgaCMWMF
         t/szEubDy35Q5hHsRRh6Dhm8Y6R2R4G/3WGhziKnxYgYjAxAGnSNj3XvC3FaqRMFwX05
         qpeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzPwmiSn7oiT/W6Dd3rUq4KRHmA1KoJKrdo81SqHobhxOB4yXMuPoAugnjq3Hz+VRUEWlHoDwSHya39fpDgkFcveY77YxSK5x5ppdU
X-Gm-Message-State: AOJu0Yzu3imgYeKOgYIfCJm9vsvD+lIjzEgDodBGZfTSEVVLMLOTGprn
	Y/E9syubImszo8sMmXccVgDDtKwT2eUrp6jukNujW3nW4+OuOuOSsIDE7G3UgJJN7UIAQGlAj/x
	mIhAspWdK70Ek67P/DUzu2eAAA6OCM5nizmVuK6Tk7w8a+y1CKPOdOsM=
X-Google-Smtp-Source: AGHT+IH6IzauDBgm0B81tKQ4/kOnmRZNRB4pQUa/3tFWdP1LA2h1OrGBBXk9h4k5n4enW0neiFuNHTSdMfW3MJDmY8ByNLVX9f+B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2182:b0:47f:2226:38bd with SMTP id
 s2-20020a056638218200b0047f222638bdmr41221jaj.6.1712191683337; Wed, 03 Apr
 2024 17:48:03 -0700 (PDT)
Date: Wed, 03 Apr 2024 17:48:03 -0700
In-Reply-To: <20240403134454.3792-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012b1e306153ab1e5@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
From: syzbot <syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10fceed3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=ee72b9a7aad1e5a77c5c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132ad4f6180000

Note: testing is done by a robot and is best-effort only.

