Return-Path: <linux-kernel+bounces-69918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3E485903A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23A7B21FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE87C0B1;
	Sat, 17 Feb 2024 15:01:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC97B3E4
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182067; cv=none; b=V0qGQiu2+KRwtfScK0AvJ/cwFG1o3soDANkr/QzKVDj/1wxWck7gIhHdhRaxKT4n6FCTeW6/dmiVfo+1oxkmZ7AFUhNunKZWvr3eFGgcW7nPIyBf5BHoGwxD8Qs6keh5enQPrb56g96NYBZH9QDWYX+cZAED4+yfC4ujLZiuhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182067; c=relaxed/simple;
	bh=v3qPHREL8y4lhPH+JqjQ41slZwMMdqVh6lqLROLzu/Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s3UKfG2BPVukAgqaBOiv8TwijN1waT24SsHFwfi48G3IhqVC5YvrVxbhnrTsurfFTIM4v+UIvHGl2C2sJUKq+ib2yS/2VrqvL+S1rJiCm725nstmr112uhggkzfsASKvxH/A5im1k6yTj9zGo39RePGh1p4Mg1V1zvTG9dnlxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3652275e581so374005ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 07:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708182065; x=1708786865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwNQueuYmB/11gbOG3QeCQx8po7ZygrhAL8Ov/WqAlE=;
        b=ejBcBUBPwHRelCHbaovQgkZvKZ10a96uVF1YXe9H+oMjM8HAywgz6CL+LGyTwxd7Uf
         u+6UhI8ScjSr0mo7plwmJT52pwOVyC/9p6YtRmCvA7iCzVgeroKB/4FqaqKGRnO4hMQd
         R7zbs4toiNZoskJn4Dw4BmhkP6jRndxjLsX+diicbkldRrcjQS0h+g7ooRHy9lFQB3ul
         diQ7+GXScBdq++YL5Xue0Qs+HquMEand4S6IrPPxgthmLDNytLsgnl1morPcCTr40u/S
         rFOFy6mobSuVkWRhnIw4Sx/MGdL27YcD3KZcYfgcqMrSGuPVWkum+LiIpDzCqS8Ob6Yc
         AQbg==
X-Forwarded-Encrypted: i=1; AJvYcCUuBPkUnB3rvJrLZuCU30cBlBZnfC23Wp4qH8sq3B0IFjaQE7amUt2RA49+iNSMeNUrZ0QJUWln1ft/Y0ano4q+sZXpxpSQiWg7+0Kx
X-Gm-Message-State: AOJu0YwSJ//fa7qLL7lUlH7PYVLTwh9qyfkduYtcVKs74FV+pxccezvS
	MzJFfrkNII4LIm3n45DquuYrsepZr595SYA8XbTR/Y8ZYR7cgP96Zo1iFCzG8KXfrAzEuOR0K7r
	sR/GQ0A/kgUyv0CfJFv37qzfv5TeSUdZODWHM/U1mdVqape3Zzlo458Y=
X-Google-Smtp-Source: AGHT+IEBdhWTaosc/BZRU1Ig+P68HanPIcYAdDVfh8P0PrL8wce8QOLRvgTXLmzncxBxXxBJXjNeF/KiKPKPxtq3e5BT7OxP6ZGq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9252:ed47 with SMTP id
 j15-20020a056e02154f00b003639252ed47mr647629ilu.1.1708182064966; Sat, 17 Feb
 2024 07:01:04 -0800 (PST)
Date: Sat, 17 Feb 2024 07:01:04 -0800
In-Reply-To: <CAMj1kXHQYuv2H5XA+abgj+Mw8xyxsoHARx2w-tT7jRrDLQ=EVg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031b790061195214f@google.com>
Subject: Re: [syzbot] [arm?] [crypto?] KASAN: invalid-access Read in neon_aes_ctr_encrypt
From: syzbot <syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com>
To: ardb@kernel.org, catalin.marinas@arm.com, davem@davemloft.net, 
	herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com

Tested on:

commit:         67e0a702 crypto: arm64/neonbs - fix out-of-bounds acce..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git neon-aes-ctr-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=122f4464180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4dde08ba7d52a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=f1ceaa1a09ab891e1934
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

