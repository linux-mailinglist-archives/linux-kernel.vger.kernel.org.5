Return-Path: <linux-kernel+bounces-143640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553E8A3BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E671F22293
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390FA208B6;
	Sat, 13 Apr 2024 08:58:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42814265
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998686; cv=none; b=U2xWK3K8q5Md1z1eNhNj7Ow3kbDiTIWOxlpIIamXOD2xhyTbzGBCdkTAkUWCjRw6VUNixMyJRGCCkmTWtyQB76WiCvp93m/ltkCx3oZ2k87/OIa/RTfnpzKIe3JlzKdxvMDe5O413U7B6BP28HMu7WfWAiMZcMzcz/RVj9VlOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998686; c=relaxed/simple;
	bh=KIfnyfR7vYYdcwapDYh/BTV5MWSExVwJa52f6U/e9lw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pWMdiwGwTP/CZt5mxdLl70wuzuVatEIZdPls6jhTAfseAU+exRjTLsuJ460gcssolULIuBDBFJjp0IBUXJeFCQgRr6kHf9p21PkEJKgmxn+RoclyAEcwp8HWD7k0bUpsZsIvefn/vcj/FVrX1HuaoM2KVGZaZNAu3wMuwHik7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso165477439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 01:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712998684; x=1713603484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeiumxD2W77agYk5SZK5cVx4YsslJs/nsVx2smQ5QmQ=;
        b=r5zGhsGI5YCisc/EHH+FRAVhsD9sM5rW5WklLz99wBz8NqNrungmBWaX3a1yMIclsg
         cLi45wz59HPVDB5zDc99Vjj7JTTCq57qYqSOMjhhKHxmfCuFZFzqz2heU2Tew54+FtSf
         cXK2IVb01EZkBD1xw3RASJSacAo+6OKew/z7CVLDy1Q2hpDJcgow0c9+Kj2q1GrvxjZj
         Ve1RQzkyML+CuG7BvXY2+XZu9+/0/Idiekul35wT2J3oz671c1D5I4SVQ/5+eBgphUQN
         483RLzW9/xZWWZukX6O5gKlGzK6vbpKl+0PL1eiyxlwQG+DTWHiEJcfDU00vRNiZ7DcW
         f+jA==
X-Forwarded-Encrypted: i=1; AJvYcCWy6Yvz97DOIXccE4XjBwK0w2bTkcrYNKOm+RwC/R57jLxNFkY3iDD2EQ2C1pMY+WtToddN0uEUrOhylwenTPruSM3J4xhYlSiN1PrE
X-Gm-Message-State: AOJu0YzifY5wlAigDhUeFHBfkR7tcRTE7kuSytbT64OY18DH8FbRBlF6
	WpKICwfS40Z3EW2ZvRB0eQdpOmQ5LyZsh2w/UVYOqcgjtWk+Cf5OFmQitmuWAJbn9aQ+/YnlX20
	FNicxC0NTxFVcQiwDB+zYiwQfybiS50xK832z2/kNqXV7JbBIED88dmk=
X-Google-Smtp-Source: AGHT+IEoOIyYUcirD1veAnTrzTF2ffLJUxDOAtgseUuzBuijmXiPpCKUzqSSskYi7UJYvovHGUVtetdoO7alhYeiewgCeWppe8+V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8528:b0:482:d9d4:b0a6 with SMTP id
 is40-20020a056638852800b00482d9d4b0a6mr109163jab.5.1712998684788; Sat, 13 Apr
 2024 01:58:04 -0700 (PDT)
Date: Sat, 13 Apr 2024 01:58:04 -0700
In-Reply-To: <CAOQ4uxhJi_YT=AZOaJGH6tt9kM7kUoAF1uzVqfGBXjvc8S78Ug@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b9bda0615f69622@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
From: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
To: amir73il@gmail.com, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com

Tested on:

commit:         9e589786 fsnotify: do not handle events on a shutting ..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11cdb161180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9995779c8305f57e
dashboard link: https://syzkaller.appspot.com/bug?extid=5e3f9b2a67b45f16d4e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f52d33180000

Note: testing is done by a robot and is best-effort only.

