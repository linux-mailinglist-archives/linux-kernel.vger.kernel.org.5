Return-Path: <linux-kernel+bounces-86668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11186C8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A467C2890D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EB07CF0E;
	Thu, 29 Feb 2024 12:03:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD467C6EB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208185; cv=none; b=mbxh0MAvIH8zPatu4YnjJuzPksfDcSYP4js45RvKv07V9ukT85u3ijvoJnIUUjxXNkmzorQFycqIytAqAoq0sUqdzXthiR4dYpBxmZIKihuoKjTKg+GPQhxXBbLGMG8V3dQASaAkNz9dNUigkmEOwKCztDv3a18+aYsN0IatAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208185; c=relaxed/simple;
	bh=lMPSVS+Ff+eSQW5IQ85mCqgKGlP+/oKX/d2gKRKPGHA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q80w3VlR2i9APdGoe8bTdoSGRAuTrZtytVw+07mR2m1I2MxfJ+W3yJuFsJfNFdxlbTMTbZrmD8hmxF8SQUZvDmwvkDWucsqQhuIK/bRsiYBnwgKM0psf+wBOA04WMZTxPf64UB27nnqqhi+2IRm1R9U8QDc4FDr8cMxn4mBU8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36516d55c5fso9761005ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208183; x=1709812983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5LoiwdUnw920DyCls+ciMkCvcCeek+KtrhUqleK0lc=;
        b=JmP/W2mxNNO44zJL9+q9u5tenCQeo1mHP+4EFQj6uXLvk/QhOD+hqsNjxWxjEEnaTN
         PCRXb9dQy4j8Cjb5l4glPha+fR7iwn38Xxgb3bF+x3IAAEYW332H+yoRCHlDgDHeM83b
         tP7k8RcLdLvwaL/9+9i3VhB91zqLYojPsxnezpge9XugUiz3g61BUjIuisB+mBuKAGny
         +rl3yIP14AGErHdf/stjD1xP36r2FuQ9HG9TjDoJDyUw/VBBI8y3qAH/udRNtyMhbSnE
         5+j3sXPzpsLiFyDT+aSVfepyo3WGZiOhT6E6uuzZ5aKZVTX1vUWsxpOtOyDUoDB9JN4A
         4NWA==
X-Forwarded-Encrypted: i=1; AJvYcCWhr1ox6vGQ2U8DIeYJ31dQ4f0sTeOXPP0ozMq17qk0luFcEY5D8VWFjsJQ/CHGgekiNWCmkD0TDFzMO4C/FIug7gBsPa+JfnrwDaci
X-Gm-Message-State: AOJu0YwcLc6Gvw6He0r/LmXIwzj1Biw5Yym/WqCTfXdIe/hbER+khRxK
	iIgR2CSMOKqjhsrqW+NbywpcjgbZbAK967FwFpTDgooZTJy0dvYF0ZYT4ULb1abHy53p+q7vi8e
	M+uLpFd0HGXldS8GfqBIvc0r+JjM677pfksVLoseJNsPd4PVC9IbHsqA=
X-Google-Smtp-Source: AGHT+IGlMQBSji06sjVA7p1h0EG76dbjFPJxBDgSr8Ip/ElUl5cdzcJu1jbnps7xRJpnt3C9tbkzVkqfLrnkja0wM5yoYV+sKRwC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:365:2f19:e591 with SMTP id
 h7-20020a056e021d8700b003652f19e591mr151028ila.3.1709208183174; Thu, 29 Feb
 2024 04:03:03 -0800 (PST)
Date: Thu, 29 Feb 2024 04:03:03 -0800
In-Reply-To: <tencent_66D84A6C740977ED66023CCD3716963E3709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009afc6f0612840aab@google.com>
Subject: Re: [syzbot] [media?] [usb?] INFO: task hung in vb2_video_unregister_device
From: syzbot <syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com

Tested on:

commit:         805d849d Merge tag 'acpi-6.8-rc7' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=126f27f6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e412105d06db24c2
dashboard link: https://syzkaller.appspot.com/bug?extid=2622b51b35f91a00ea18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1429a7aa180000

Note: testing is done by a robot and is best-effort only.

