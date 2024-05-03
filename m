Return-Path: <linux-kernel+bounces-167588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E525D8BABA3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6C3B226E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A27152DFB;
	Fri,  3 May 2024 11:34:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953C152DF0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736045; cv=none; b=ENb3UGsVnWkLEqPY4DwqHocxXYpi7rgVTcTEKaQVI6xdBqvCNsUSSuGtYMvezRehdi1FEX32ez7NTzNd1k27ep+4RW/TGW3k4bDWWB22ntfGKI7H4twD5SeTw6XdBWiPkO940Ab+i17uQC5a89koRucHjHFMln72eSNOdPvfxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736045; c=relaxed/simple;
	bh=0QRcbB4NbODfEff2mqjjyLfkZCbztXT1gNxbMpmFjhc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RrBt3CMp5xztOGkcKvakcV65ERrYbn25tD77iZNRWYO2No1N1qKdjvmGuxYrJ020Yzs2AOfzKoaLDYyJZRDWctvrHmj/IPOaigbNc1HGLTappXq6PrRuwKqXIcZemIKYvR+4wFhfB8A86JYpQvXKj9Qj7PBYjSsdkNSXyukB/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dea5889eb7so780290939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714736043; x=1715340843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYX3yrJFiKDZF351JkQ7FZtXiiJZok6AVk8TXfhJRhA=;
        b=BWUWeWpLVIYII63IzMUWk0qbCpDjN79MP8T/JdMMLHt1YQiRlZmExb9KghPyX2nioY
         HfwnlvbS9+BDtfmOBX2xlF5zdBwLfrp6bA18fE/KUv7BCUQlHvurDB8hHnRa7ubMWaHd
         HW97pcR9VUxLQPfACOQzWi2aNz6JZiNRt891+h+WIKVn0gkk/3ZTOJs3T6PPJSuASjxW
         ByKpjrXjmJvhohI87wFLpZ9faIM9D7dJuW7gdFSVrnG9ygu7Lq4PEt17rsTzeqpVlRww
         yaqDXGABiJ0iRdZzAaMoI6i85lgAricEizI+OGrJtTkThZS+3HvpJ5soe1F1+tXATzIH
         3WJA==
X-Forwarded-Encrypted: i=1; AJvYcCV/g5JKOt7zdrGZOSHf3aS2KDLZ4h+75j61o+95tMdZGIRf76LkFF5I0GI+ERqeDOrv0+PhzhXWzd7n7yqfY+wc+PQztcEO5oV2elpS
X-Gm-Message-State: AOJu0Yyv21XAGYKMntAN8MyW1V+YQues8ux2WXIeZLcWwwzCiYHl7Q6A
	rVJ5/MAdv3ryWaQE3SbvxTUJ/1bN6jDXFGOsuFpdLzeminymo7UuVJEu+PxMep/QBHdsRUvGWCJ
	k25YlWMiHUkY7rbkl+k9ys8p+vu9hUohivS9mI8/I91mCtNQixg0wVs4=
X-Google-Smtp-Source: AGHT+IFbkJBWPUbffTldamcTbxcuRPEVoZQG/tMqcpkt99uKbx23cEO9zZZqbADRRIFqaLhwoz2bm923ZD0ZI0J+ZVxHxTdOnK/S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c9:b0:7de:d86d:b7de with SMTP id
 o9-20020a05660213c900b007ded86db7demr43659iov.4.1714736043732; Fri, 03 May
 2024 04:34:03 -0700 (PDT)
Date: Fri, 03 May 2024 04:34:03 -0700
In-Reply-To: <4a780cc4-3081-4a48-980f-2ffe31be1a62@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c53eb306178b1831@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in sanity_check_extent_cache
From: syzbot <syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com

Tested on:

commit:         e106036e f2fs: fix to do sanity check on i_nid for inl..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=13da0b54980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=74ebe2104433e9dc610d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

