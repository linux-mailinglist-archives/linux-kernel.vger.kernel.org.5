Return-Path: <linux-kernel+bounces-159355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EEC8B2D82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4396728529F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A16156658;
	Thu, 25 Apr 2024 23:20:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626484D0D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087206; cv=none; b=YLXS8RZYj19yFLv6dXJtNZbfr09BtA8daji22Z8OAN0KqDx9Rhy7UO4q1j5BpwL4IZtcJf1yOoXpUo7iky988ymMhPU5QL1RSLDI0vFhaKvYZFTvgQZ60hMoLuChbhlnXcZCK3N9xNZXN7Iwb0zDv1tYYn+OeGjbl//YqZY6PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087206; c=relaxed/simple;
	bh=xzK1Vob21ErSaLtkfL4z9yaWSZHnVhNHv5z4PJDnnF8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2s+uZEQ0N2405kejxNMYsnKnuiPo5C3Ikx1V7oYfr9644PtNvjvDRVU7DK2VHNTy7/hSkQS6zX/HXJ67erPzJ3lWSWPQR2cvULJlg+rT0828bIzaokr92a+ZvF1b8pKxieHLATMIOH4O0KOknbaovIDqpDq6YnJ6bXM6a5K8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b3738efadso16642175ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714087204; x=1714692004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB9Gu8tUSe6AAsZJaVMSGhlCOvsBshLr7iGacbDXhRo=;
        b=dUar0u6sopUun1R617904mIaAAj5h6pjvB22nME4gSYr2+zQyzt3FtdXRr2e7c86/U
         bEuaKk4XZmX76hvaMBC/rusotfRRqpCqVgXUHXDw0bykBKqV5+hvR0xPjVireDqIQkSK
         Mpx96X11h1kHxfqZkm4FmrjBjVBu6ctctOefx4bmXa6Rfom09APnpGDK2sKw6CmGMi6n
         toLcryXETHFizFWMcqjLvlMVrmGCc9zmgFGraEa7rW0dEIl3CEcpWcEVVl7dgfeuS2ns
         xEbNBDVSyhXqy/3AblZJdo3aI0cLIcpXL7UjXlQJxGmLPOEABqWDmM59kUrp7wjzfykT
         p+3w==
X-Forwarded-Encrypted: i=1; AJvYcCVu1SrNnXFDK+nD35vtf1qE49QfhvzlNlcA5EOdkOgUlEUF8org948OmhqPL1VtjAG6o/WPRetGrtx8vM+tAlaFViX34Vf9MI1WlFOv
X-Gm-Message-State: AOJu0Yx7iLxl03HFh+XRSZnXX72fJwXmEIKaVacW0hy0EWQHruYwlc4z
	akkx/hl1Py4Xcf/Gw7BMpHgAgJLpX8Pfj+hEP9wFgWeQvz3RQPWpdLuMYnuNZ1GgQgZDXyNGccE
	Xjh4K2dRAb1vsy09NkkhccTssYIHoiW7KoAJ3+gWE+nuFPeV68tbs1AY=
X-Google-Smtp-Source: AGHT+IFPm4Yd7TKUcqfpjEQw2ZVYnARKqk2ax3G5wjHt+VTSvXFJDYNragebXjZcUwJ4egc1wBJU7WTDAAaCywzngWnNr3egQlBw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4116:b0:485:549f:eed8 with SMTP id
 ay22-20020a056638411600b00485549feed8mr46320jab.0.1714087203887; Thu, 25 Apr
 2024 16:20:03 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:20:03 -0700
In-Reply-To: <20240425225501.3242-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6f1170616f406c9@google.com>
Subject: Re: [syzbot] [usb?] WARNING in wdm_rxwork/usb_submit_urb (2)
From: syzbot <syzbot+c6a1953c27ace6cc34e5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-....
 } 2638 jiffies s: 1161 root: 0x0/.
rcu: blocking rcu_node structures (internal RCU debug):



Tested on:

commit:         a160e120 usb: dwc3: qcom: Add multiport suspend/resume..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1009807b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe204286ac73e15
dashboard link: https://syzkaller.appspot.com/bug?extid=c6a1953c27ace6cc34e5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1622eccf180000


