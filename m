Return-Path: <linux-kernel+bounces-112556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F7887B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0E81F221BE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE81870;
	Sun, 24 Mar 2024 02:51:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8819E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711248666; cv=none; b=WMWBsow3HJ2q2MlMnotBO01KZcw9wg9ZKWh/c96wzBTB8QJXKnvxeIMsc4qM0PZQ2F5AFp4uKCBQvT8rGDL1cOJS8UahXNfcLHvYJUoA683e/wIFL3cyjYEgh9matFNAkgVpEBMCKWssPoV5conBBSktihk8UYKahaqx9TojmzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711248666; c=relaxed/simple;
	bh=GGX21EKY1DxGg5lM+IvKAfFuR1djJQaZasNApvsks/M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WKxUpPpnfatV9tTAUBWcNbZvQa4IKRzH8r2OEsOlUCcQWR56LnLclsxWwu9+3xb72GnVkbXL+mY9EWAnXLb2xbnUBF5U3xwbD7R9hac+3kJ/6vmFzyFdOB3jWWKCZ9myvYXhOtuNyCG1EP8U60Ub5tnvAUCxnSw23yC5GSUB1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cef80a1e5bso316522939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 19:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711248663; x=1711853463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59bhkrzAoJ+6qkVOS/b/c62pyhjPKklvf8CLHJEOdxQ=;
        b=onMS6t8DtNWHZsrTNneNcw16o7ItA4CF/aXXivAAkLiKvd2n2Ukaft9WlTCmf6RkAF
         eqXwqlP67ZjQhyTOyon7gdjHmNdDbOxzi5FUBLjtJYPnNXQf0w9AvjxCs8W8PvSy2B+9
         LBWFgPKX85doxnuXkAvcS6ID1sol0NCFj7Uqz79idOe5dV3RJXrXPlk64ZlMCFTYt0TU
         w4wOie7pSFmqzuvykthjlsagE5NvdocFnXp1lfGdFgOmPe81J1jbHg+XherrHvJZafvr
         ydaU1K92ajD0MqwLPuPD3pZn0qnhk+C3AGmiHnWgOCmZvIP9E/DLaQPVmTGup4e3cE2l
         8ApQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbD7Y0vRShz8LFf9CT6wgiPfxIzjXBFs54d8+P48LGiln5f8JdJIEXMxYat0p6uRt9o7qQ2QVUSpI8Kibi5NqHCdlo8mn3Vg12CVYd
X-Gm-Message-State: AOJu0YyXZlqFmmz8lE/8J/Pm2bqEJh/qMOgUvbHRLcWaXgN25QxALRKM
	RBLyJABgm1IWDa+Oha0zXj6C8wluDSVc+C91z5fd9kAaLC+f2vR/jB7ETN0nlpDOtDebwXj883e
	Y8fFu8DY2bVaTPdTXurSZ2JRRfVFd9apT1vj2d09QmkrUxRej5YmbwqQ=
X-Google-Smtp-Source: AGHT+IEYXhifpbtBJCPTB28Xg1XEaBRkaDiHM/LU5ym8ycpiYGmyxpA4jnMtT29Boq1imA9W3pYYZ/WNLYLtI71wwWWz4XxfCzTX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4111:b0:47c:184a:42d1 with SMTP id
 ay17-20020a056638411100b0047c184a42d1mr3342jab.1.1711248663188; Sat, 23 Mar
 2024 19:51:03 -0700 (PDT)
Date: Sat, 23 Mar 2024 19:51:03 -0700
In-Reply-To: <20240323224657.2722-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1254406145f207b@google.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
From: syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com

Tested on:

commit:         ea80e3ed net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12583185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=8983d6d4f7df556be565
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f9eaa5180000

Note: testing is done by a robot and is best-effort only.

