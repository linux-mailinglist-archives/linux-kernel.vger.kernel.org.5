Return-Path: <linux-kernel+bounces-108734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA666880F52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D41F22D49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864613BBFD;
	Wed, 20 Mar 2024 10:09:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7833D0C6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929345; cv=none; b=IQ021jb6SYNT1VLhVz9T9qRy86UPO0aoRq8Tdis1EyDngebaB0g+91DuyXDU0Fwnb6h+JA+woKJdeJ2BqLJdCsw3nIO5RfaZcOkKK3e3CLjRyj4hCv5KvR59G/xAA3JMmmP/Myo/To+bluwIwUxRwj+21alw5xPSpeZLme65cWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929345; c=relaxed/simple;
	bh=QpwWE/mKcsUCOuC3lRRaq9XbbLi1Cf3WTQFxlSNUbXI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gDAO+SHzDhYI3/0QVmiV+T5Kk1KPpbXCdY/KJOEfTKtunk4vzVaY7D45Tk+8/PdBvghr/gk54eugrQhGlb5iRUAn2i5LemfHasOxLBUnO2R8v+5M4ckfBr9CiVPXT94unbt1uy8U7RiIre2f6NSNjTx6fJs/YKKJc9JNq0dRDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf3ec6a96so71799439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929343; x=1711534143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4gHWUJItj8Su4jYmDSdvgNOMK4l1iGxzZtDZnbOMaE=;
        b=SDBW7geHoIaGJ/rHzWi8D4VnysMr9C4ywToxEr73hli1psPUPFYt0oYC4GPD7v8u0P
         MlQxXl9Fx13gXds0xg9Ie3fAY/Q2mpYxlo9QdyNgYsOAPgJGUih1RovFmY4j1J3k0+DR
         zFoXuuy5SyL++X6dDOXtY1BC4umLmZEHCae7JBw7l9Reg0WC7wtLVUobBbV5zEQnAkJt
         s4CWBBqPi47w/Dw6g7epwLn22Catg6QM52DnNJKGFldvtWXnpXE7k6wfAT4vUP83QhuV
         ndIST87j83K1QFnEDewnd3Ia9j/9fIKrVrfB3oQBaUsUNQAFOkIWFW4at+CHc3HNFqbh
         1Ljg==
X-Forwarded-Encrypted: i=1; AJvYcCVQGXb1jV7l8o7vKxauHOBtss/7STrNQcEhpqIv4k7obEPJrptIPsvC45oIunxP7CRK/DiPnM1hO8qExz2k/MiY3TZqIF2vDNjw87Ii
X-Gm-Message-State: AOJu0YznVD7DrozXUFLoKuLaDgMjI8wFh1jHvk0h0HolG2fpXjOmF1Gr
	TZn7T3NLalGbAQoU2TiX4bkM6idxrqKutFT5PiSG8+ehCbZCGnV1LefZ+I2KO6vSmNIAh4GFYAz
	Xtbebfh/elLYzCAptlZWmy8dWC7s/zG8ZbRkb3ynrhIe0AoVj6C7IPRQ=
X-Google-Smtp-Source: AGHT+IGFamYj9gfbWuqZH8iPNbQYVP8KoDdHNZv5oMmxch+qyyKb3b45Y7IFNaWHP+4VUKDswVF5qrYdJ4cBZQUMmXacH39jUKG9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b02:b0:475:2758:9f20 with SMTP id
 fm2-20020a0566382b0200b0047527589f20mr85878jab.1.1710929342912; Wed, 20 Mar
 2024 03:09:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 03:09:02 -0700
In-Reply-To: <tencent_03A5CF0DA11232DDE15D9699184F920DD007@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8773d061414c701@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
From: syzbot <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com

Tested on:

commit:         114b5b3b bpf, arm64: fix bug in BPF_LDX_MEMSX
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15a0023a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=33f4297b5f927648741a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103be279180000

Note: testing is done by a robot and is best-effort only.

