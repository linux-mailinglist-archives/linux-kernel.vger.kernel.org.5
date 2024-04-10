Return-Path: <linux-kernel+bounces-137949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D0089EA32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A4928300D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE451CA80;
	Wed, 10 Apr 2024 05:55:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521F64A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728504; cv=none; b=e+A/XZFicwxheGof361dO5QXSiE7kDBLOwvun2Q9iTCnJgJjm3wMae3N1MIySA+fgPMdLYz7jTwQujGY/Tm67Bqd5D2eDnWsFkHvlYHG/ZunAiiZZOQ7xrFvkuPjTM49Zww3glcPkAF9I8YnJvN6OeQjd8pkUo5nmYxtL+/B+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728504; c=relaxed/simple;
	bh=XKFmoqBQ3aYCT/vTnRH7eq0c8XeBxPHMPKhb8wd44c4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X6WcORgvplGBAhTQTjRPXe5gPdCxa/ADunuJeo/5PXMFC+VUx5jRpU2ouYrAlqhSlx1EHY83Z7vHW/fNs9+wS6kTrGONMzZ1mCPytN8+Uk0rsJyFbh3+2UnoylCRjv2xTY8rHly9QtCuQhnwqyTwi1qv4suEXFuKZGQBV00u7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a201729cfso32740945ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 22:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712728502; x=1713333302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SE7fBbBjhAQTmqzw/vQJNTz5YtaAcqgHqBwF0555kMA=;
        b=foatqWzgM9iSAjJlb5r45+EHKybfPhv0SaFRQuOp3HiUI6LVKCkZEVN6NFfyi8E1Fh
         DJ5DXLDGHeY8Lj98MWM7qvhk3AKwwXaoZhIaoStpUpVRz0S3CIjWBL5w75u8kW6Gz7eK
         B6WXttw/aXD4+3O+bUdk9ezpzCLSYuIvtDVzGaObUpiqRZf8vQ12qIgeYInnvI4+AvfC
         S80UulNhdLcMHntEat03X0Tq4YzLVKX7CzjqYqx500cNq34b1WgUladiS9WmZFbgcyd3
         KGH+I/9Xdh+UfMlysQQyRogcH+SA7yVsT1LmcTemijm2Y2HwPjpRWC9Gd2kSYHj+Lk+K
         A6ww==
X-Forwarded-Encrypted: i=1; AJvYcCUDLNSY8IMPWoG3h+AyKS9dFOcDR1EUW6gg81OqaSP4vOtADKK+5ZYJwstzVLX3iGTaeCOONMr2oh0t0p6YP+17ysfxpCvXEkg5G1VF
X-Gm-Message-State: AOJu0YzTlgGPed4S9afcR26dvwH8PPgaJeh3UCvRQctK6EntVsKoBNDk
	eGAbzWA6g7gp67ggtswkiUKEzikOEEvNM6bwMq8za+WvS2dF+WuutpRUDa9B7NMQCCIIXhdwNH6
	A1kjuWrWfNrojh9riiL7Vqf8q/orn0PnmHeH+LH0nMCh2z5geG892y/E=
X-Google-Smtp-Source: AGHT+IHoVRPXjJSko/oVJk6XQLUlDlqqsMLB5B/ZQJNfS0Yri+R7JvKhiNMD0tH+lXe9qY5ESV4PFnlvfBQLZCQrs39UX8IZDVaS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:369:943c:d26 with SMTP id
 h25-20020a056e021d9900b00369943c0d26mr42136ila.3.1712728502732; Tue, 09 Apr
 2024 22:55:02 -0700 (PDT)
Date: Tue, 09 Apr 2024 22:55:02 -0700
In-Reply-To: <tencent_971B5DBEDDD41947CFF98DA0A5FB8D9B9207@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000009a1a0615b7aef1@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_listxattr (2)
From: syzbot <syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+01ade747b16e9c8030e0@syzkaller.appspotmail.com

Tested on:

commit:         fec50db7 Linux 6.9-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1451495b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
dashboard link: https://syzkaller.appspot.com/bug?extid=01ade747b16e9c8030e0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1613e213180000

Note: testing is done by a robot and is best-effort only.

