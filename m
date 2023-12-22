Return-Path: <linux-kernel+bounces-9278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C281C345
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D2B1F25847
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9C10F0;
	Fri, 22 Dec 2023 03:07:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F4EB8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fb2956a35so14556885ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703214419; x=1703819219;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4e0P1LlKrejCG3qxMmE4BUKBi2vj6JYqPWltFR3oFTA=;
        b=QZRbXxbJiA5HSFpSvQYlmeXIwEnCxmNXRpMpurw+0TS548+CJKcZAQrOhSx9jQ9FDX
         cLiNfapgywu81K9qJvaONC39O9sbix3TRO8++r+H2XJ3qbgnodgnsn8vavpQsRByx8Gr
         zsBb08fB+VoFTz50f0ytQ7rDz7d8nSm1OUqkK7jfgM6aY4I/Lj9CnKY8/lENTGwZooyl
         0pUuVxEy5Wl/AlsoMCc+DxU0QdxLdCSYPRo6plFw/DCUehMVXNvWD6GAdnISm/SBZ+W6
         vV+Yv1+902REBBu2kaj4OaeZJAhVzg2JdWi3YOvwFmOsJoxyS8bfNbCuInFsoQguakth
         CB9Q==
X-Gm-Message-State: AOJu0YzKi5/owjdMR1WhnI6mwe5vw29/kKIznos1/t3357tnmefpTips
	3gVdtfF6hV4SlhynhkbtejqFsin8J1BVIIYZU8JqolpFFsUH/qs=
X-Google-Smtp-Source: AGHT+IG0UTIOtgfI46UMTl6wbWRmI1MVdisW3+/43GC2Q4zx/ogM0DvsB6ce+nMOJd2zVwsIwfgRhmciOlAq5I0ZeYApf9JWfG+F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:35f:b16a:d0cb with SMTP id
 j3-20020a056e02218300b0035fb16ad0cbmr31397ila.2.1703214418898; Thu, 21 Dec
 2023 19:06:58 -0800 (PST)
Date: Thu, 21 Dec 2023 19:06:58 -0800
In-Reply-To: <000000000000e32f3c0609cb98d0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a3904060d1082e7@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in chmod_common (2)
From: syzbot <syzbot+83693dbba860b4f2e549@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [reiserfs?] possible deadlock in chmod_common (2)
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git aafe7ad77b91

diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index dd33f8cc6eda..cf219a998a89 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -100,7 +100,9 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			err = -EPERM;
 			break;
 		}
+		reiserfs_write_unlock(inode->i_sb);
 		err = mnt_want_write_file(filp);
+		reiserfs_write_lock(inode->i_sb);
 		if (err)
 			break;
 		if (get_user(inode->i_generation, (int __user *)arg)) {

