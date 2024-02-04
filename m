Return-Path: <linux-kernel+bounces-51608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C69A848D2E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54B828250D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D1F22313;
	Sun,  4 Feb 2024 11:42:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECD22097
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046926; cv=none; b=WCP4wT2UxErK3n7JR1AzBLoIu2MSvl8AKmbatrgzUgaGesXZwJMq7uxbEQ7y3oHHFe5jm5gHSZP9SG5pARIYIEoA+ab1RH8R/2LeZ6ULQkPc5pmg0uPgj3qQpFMU6Y699JwKHejThGV03iHCoZk0R5GCFYbaMJoiG12GFXAE+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046926; c=relaxed/simple;
	bh=zWNtbawhO97+/az0aYcoYsKYUPp/Li6b+6rYG0USGPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hSXRxDJNB4NOzDRR4in/3yzeTg8uAfzByV8XHTdZ5vbLNGdRG5IRyUmofJ3g5Q1kGObyDCrGApmNwwHHM2G8fLDGHax2tJw7OKH1P1OOT9SWNE9YDpiHduEALbMtjYx2408s6LTcrXiIc+p8x42HXmcC7K3TfVqOU4ig/bOr1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bad62322f0so397221039f.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707046924; x=1707651724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDAvzuUSXR1LOYc/eEUsfcBlDixjaSJLsbifNywNcw4=;
        b=od2teU2xsHMS/RUv75Arp78iAgdkaPQL7ZUv9Ql+3y2UBv17CpT/XnwFAHdUrNQZyW
         ve6JszHd9VxaoPLC4iy5d57b/SzT3OGFSalxZhg/yrRoK0f51orAWiNwLAIVJLa0jxol
         fOTO6UmcPWySPHkqXsbdh7rrnmBme9mUoVmBUPC2HhnH+Xm588AnR44J9AuuCXIxKp+m
         q4h4jB87x2EonYDoVAYJ87delSeWFiphxOGpuEsrom2+JVozn1HnYWhrZ7piWmg6v9r4
         Yy87zko7JuJzfkSwzcMe9YCdnRZKQD2J4B5qVu/D1VBXeTnSDo76kKedllKQCjxmFGtm
         /7Fw==
X-Gm-Message-State: AOJu0Yxx85aRh8FTKG0/oiYD7eI1eQr54V4SGYUUavKJd5SrifnJLoKX
	rcBweBmrf1ZUoDC5EROg37WtfuqXqpc2AW+DxSj4/8tr24z1CHO0obueHjVqiQjEKNFdsJ+DziB
	bULV1cRoLgfeH3rCsuKpwPMqpeb8dO91BNwW/CaR4OUbB+cj7avcWZaw=
X-Google-Smtp-Source: AGHT+IEL8HE2LuSELKSy/ULWZ/DRnIYE9iLjr5p3FKgTvuvKCoe25aB+Mb5KVdnxVqlgkerGg+dAbIWwMAAabbyb+mmm/tvS5Huv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:363:7ea6:578c with SMTP id
 s14-20020a056e021a0e00b003637ea6578cmr845881ild.5.1707046924497; Sun, 04 Feb
 2024 03:42:04 -0800 (PST)
Date: Sun, 04 Feb 2024 03:42:04 -0800
In-Reply-To: <tencent_562545BA71BB31330B9E161B694BE61B5308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cbc3c06108cd5f8@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfsplus_bnode_read_key
From: syzbot <syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com

Tested on:

commit:         076d56d7 Add linux-next specific files for 20240202
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15872d7be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=57028366b9825d8e8ad0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d0b18fe80000

Note: testing is done by a robot and is best-effort only.

