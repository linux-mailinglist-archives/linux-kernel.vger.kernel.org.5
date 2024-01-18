Return-Path: <linux-kernel+bounces-29638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF357831126
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93185B24720
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F23443D;
	Thu, 18 Jan 2024 01:56:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F722573
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542966; cv=none; b=oEpg9KIxQwK3shC9Ei8XvfLZJWglJpf/A5hM3BuxsVKTr5LuPHg8GK8oUgFG/qDwnSfNUbHGTcNj8VuTAVcqfTsKTi0TdPEBpDbJ8xjKJrUTaioqNSU/8519Mr3AxGDiv80K6o2cU2wEaZoPwHebio3qcGJkkMWcGmH8UbT7v9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542966; c=relaxed/simple;
	bh=cqzuGTuPXJyqeV2p1WVhqYyXRz2ROdNcOo9+hbl1Ezg=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=u15FptUoZtdg0BYPpJ3SAtZ7FeQsxNDKE1pOG46r4ykBbxoQWVXPM9YzsY4LLai88mY2GRIWGRRbCCBekyorbasycMG2UA2Xlg6AmBc+FKaZ5GCpybAskewOncFhl8ToRVf09OHXtN2BVs0oycDjjkw63le9YjtIPsUqwYSsENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3606bb75320so1795375ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542964; x=1706147764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+isiaUm4b4vTjPEwgS7lWb1kJGWABJc3JCA2x1+RHtE=;
        b=AfDBxeacLepyLiVWtzNA10f0G/BstVAQV6CDoJw2mvQUXuGJ89gqvYQfkGUnh60m0R
         0ClQIi+PLXbtycKZCvNPxR2kvTHQB2tB4a/fi/ka9yYpw+QcVooPoLlbic3+Tg6EHUg4
         mnl1uGm03uZn0XkGyJTxIKS/t0CST8NefVyl9z3gnFkRDymFMlUuaxxVbeMPeJ3N9qx+
         V8hMiGdLazYIoZrEfq+9wxqifIQoFdL9LjvOKbXKaUaRrnfcargKhBlsoGoD+7KZ220T
         780zDDUFNMKhi3Nb9DGCHuk13veqx43e8cO7oLvEWf87yecskROpF2ym8ede1TzgKJRf
         UKEw==
X-Gm-Message-State: AOJu0YxE7nNT4tN5o9161sKwqt8JEG/E8Wjq2vOeljhevMpngWeX96DF
	q+IwtR9FexXeS8cgQz5dHbL3vKfxc7Mo1s4DYZ0zA+H8N6mHm5BM/Ktd75qkc9oNDHKeWFK6qpR
	wqDZDkzxb/xYRXOzIe936cR4M7TfmTgkTZSuhwEVfvEJpx5QY8a/nWPA=
X-Google-Smtp-Source: AGHT+IE93Ulj1TWfLoIpfotLqR/Nzm3SZyhi+7VP/Xw/LDh1R87Ca4Fume4TIlijzNmsF4hNQWkufqH4OoeuuXPCqG/OFshbSDWp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:360:134:535e with SMTP id
 h10-20020a056e021d8a00b003600134535emr32282ila.1.1705542964578; Wed, 17 Jan
 2024 17:56:04 -0800 (PST)
Date: Wed, 17 Jan 2024 17:56:04 -0800
In-Reply-To: <tencent_7ED368C373A96E43A20445F772B77FC6CF05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d8f1f060f2eaadc@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in btintel_read_version
From: syzbot <syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com

Tested on:

commit:         943b9f0a Add linux-next specific files for 20240117
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10fab583e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12af1d067b6a6d19
dashboard link: https://syzkaller.appspot.com/bug?extid=830d9e3fa61968246abd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132f7913e80000

Note: testing is done by a robot and is best-effort only.

