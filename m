Return-Path: <linux-kernel+bounces-69915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066A385902F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427C61C21C95
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E794E7CF09;
	Sat, 17 Feb 2024 14:55:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D57C6C5
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181704; cv=none; b=HkZFi8zV/PI4q55cUzTXH61OFa6rTHtYdvwlni1QrC3gO3pRQ99wRPv2JcmdXQnJk3h2GuYCcKmByznUJqYC88LgeCAUTJM3HQRBDcv4lnShJ0w0+Ai+2T7YGb7n7ByvqwE8Wz+5tDFpVu6935R43v/wuuynccEek0uUoQxLBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181704; c=relaxed/simple;
	bh=WVKY6mV506NYY5lllafZQPS/zjBkD2UQAn8RDigrfjs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s5H/Qpxo6l/XhCnBF0frKwyUSWFvGPrLyCGmBaO9a8ED4+2f8a3s57p0+v6M/vG7GvfAKBP3Z9xOXWKp3t1Zv/56Q2uGvl8cdowAeakfo3cKeyYhh8t44FuXQJe1mwuOG0Qa7JnEH3VMEekcwvu4FMRoAwiZRiFAQb7FYUPV/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365026bbf10so23199275ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708181702; x=1708786502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r08pkwJbEFMcVD2+H2obM8s0FRORd9p3iWPj1Rboc4g=;
        b=xGMr0RGRO9T13jKw7gVcifsg/Gg8C4AF/OqHCS8bWF8YyXIsk775ryE2Xq2Me/+Z4v
         Y7JcVblPRQRtnsBteCH+gV8BM96NQ8YlKv/BzasSLOmln9k7fintaJzyOBkEtH2F14Fo
         b8oWO3QlBogwIvnhgjiYWCyGGtd0897wjk3j/2grtmblM3ATDh3xcDi00t/QTpxC0mAf
         t32VkdEc+c2MjCeSSMwxzWO9IbYEEfTPQi7+DiGHsq2kY03XDFHkvuheT7B9jvIm6Z4h
         tNqffJFWkisdeCon8mUVjALuclE0aQIhzQ4plhy5GMCBPX4Ya5WOv9DPt5KPfOFaBZV/
         mckw==
X-Gm-Message-State: AOJu0Ywa4rEpkdqgrTWCIZIcLQGKlXR779xPXDwjP59+ysxLcAGtXZC6
	rCriVpbfCwhW4viNDfJIBQlUK7pbig6sInfip+42XmPmqIs6yE1gmlPBVANmXOWnbhpowQn9w06
	YTvzSCqiP7GGYScBL/t6IQwkGnaL1kZWC5ecdrg1u9T6Z6r/Jwm+HACMZ4Q==
X-Google-Smtp-Source: AGHT+IHckb3l/e25xeNqbOwEmf8UBeG4ehg51eZp86toQW05bSYmOsQqnE9B4ESnV71hjla3FteeRja0qEi5fwT5xMgFHEpazjMB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b81:b0:365:1212:3f0 with SMTP id
 h1-20020a056e021b8100b00365121203f0mr285132ili.6.1708181702399; Sat, 17 Feb
 2024 06:55:02 -0800 (PST)
Date: Sat, 17 Feb 2024 06:55:02 -0800
In-Reply-To: <CAHpthZpJeO1JGpOS3h_7n-wu28pEZuxo-SVB=x=OJKXpZ71Brg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000955f8c0611950b18@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 9f8413c4a66f: failed to run ["git" "fetch" "--force" "--tags" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "9f8413c4a66f"]: exit status 128
fatal: couldn't find remote ref 9f8413c4a66f



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9f8413c4a66f
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3f069371247b697
dashboard link: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111c98f8180000


