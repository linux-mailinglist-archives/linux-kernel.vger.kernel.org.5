Return-Path: <linux-kernel+bounces-123389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E88907CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7681C27C00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFC1130E5E;
	Thu, 28 Mar 2024 17:58:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5A2E419
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648685; cv=none; b=B0pnXpB/1Oi3o1nvSyfMtU7kjsZcio6C/D3Lox8LmJmS4b//WCFylaF/Uas8SI2ukvcZZBaUdGTnNBNsoT/a63C10H+Rff1p6kXLr9ntm3Nc7uPMcnTiVMVBLiAik0ZUgJWoCaZNDLz6CY2LNQr7Mz9g95CR6sWiFSloGZHFIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648685; c=relaxed/simple;
	bh=e33f1zu3vbWvwYjSYF1ryczn/nFURhbslU5Hha2T5Xo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tg1d0A9+mJ/1xYcwuoFdo6mF28bk2DiPw3D9qdhsfXDDcRsC0ih37c6vrDZLmKxyJiVjWsOSmG/vyHCz1i7urfUEI/nHZiH+SVqzll6y/LsyvUCqNq3Rib2slNh7L5RQFVIrxY3zPy3bRxwxDKZT//v4x0bByNndFk7Ku5vjLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368a49f06f1so10011665ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648682; x=1712253482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLoI1Qo78EUgwensIP+N+szVawqwkOKBfwGvZdj7Oes=;
        b=E3DeAMhAu0zx5fEAP3JhQSE2MtxLDYtfxiQ8e2MEMBeBw/M+aw7/x7f0CtdEJaP9KF
         EiR4g/enp/tMpepNI29sLXX3K6OQfQEIoixYCxsaTtGpVZrAC5eyASxY8fjTD8atFgls
         oD7fr1U0+bxtRHFGdC2UdVfddha24DUgGv3wFt3i5wRwkQeEm4Z7OMS5hmd2BOvc4eFG
         z4jaqtHH/hgvo1lpOk7G840r72ojHWzWq+FP4wKT+v6I46tvJJt/TBs7xwKnTn0K67gH
         0Q1e5SItLb87RTXeIqX3VbdW8vnKUB3I+4vcg042TR6y9lNlFwwSY36wo5X5PswQCX58
         ZdIw==
X-Gm-Message-State: AOJu0YwmzlEnyFiJKXRqBeCSXMri51moI/YfnV/4Y1OIC+HuzJN+IoCb
	y0VJkpU+s0B/TiS9e7aX/LDJaN2njQpDP0VgozWgMdMl9CF8pmRCTcKhV2nQ9Fs+drfSZcPRNit
	7WoKbl3UsSgxI8xhtiYFV1PqeHSvOGi4zkZVE9hefFb3NmZN+js/e/fWwOA==
X-Google-Smtp-Source: AGHT+IFac7TwNbN4+qFYVsJ2dhsCE2VxB9t2Tb7QL1Bci+s98Cfo+2nh/FylayoHNO3uj0ePLEl2QSKbr4QVK5yjpVdxGg2XFBUi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d04:b0:368:a8b6:2a7a with SMTP id
 i4-20020a056e021d0400b00368a8b62a7amr52583ila.5.1711648682780; Thu, 28 Mar
 2024 10:58:02 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:58:02 -0700
In-Reply-To: <2f61db11-f3f1-4574-b510-dce42763863f@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7bdd80614bc433f@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
From: syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com

Tested on:

commit:         d8889e86 bpf: Mark bpf prog stack with kmsan_unposion_..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git interpreter.kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=10385eb1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

