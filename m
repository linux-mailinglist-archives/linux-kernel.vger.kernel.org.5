Return-Path: <linux-kernel+bounces-108481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA6880B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870421F231E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355E17BDA;
	Wed, 20 Mar 2024 06:12:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B19182CC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915125; cv=none; b=YbwaxTxGAGsRKmLmHZsGgdpIeRIv34m2jz2Z8l481MJ1y4YKhAM0fP3SJkedPfJzuWGL5Teb+1c6VYN2iqq3F590DkSfCVa26gN4TBb288/x7wTTUur3UNuJfavNA4k0ka+NnCL1qvsZbVxFWHQp392SCq2S7VFuq95Xbu8PqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915125; c=relaxed/simple;
	bh=Fg3+p9aGxeQZ/9oyVfu/Bs1KEeita6s240ybpqDaibU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lBdKt4Sm6/kVVwf2db46g2OSNI7Jqz3DJdA6e7wCo90JFaWs757Sk5/IsI17lCGYW62VncEo0ckspJMLtq+zNluSoWGM+4FPcEWgsD+WYhnSpZkFXZAg/cw2CiOAJmbBT0PSwzWSJXwLqhkUwD8LyN12m1klfQAkPxDbz9HXlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso457703039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915123; x=1711519923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGhV+BjFTmT2BRGB/4pS+DB4I2X3ipzTIt7FUzSRHWw=;
        b=eiTzfFqwgp3hyookbNalnqgDjGwXWOmpebazALAZCUcD1nc93XhHXuWOyPfKKYcfmS
         cVvZtOLLU0EtqEqWqmEYuThRoiCz9eBvnH/XyYiLVyfKe4twN3W0/PaDkEs1Oj+hz9if
         1pwwZwQws65fuX4KYFrC2vdHcN8PN6CcTEcPz3WNqq4ur0nZ2Ys8CbX85dbvt/r2DGaC
         ozZsQ7+8pP5U7XADnyTziKAAFfb02cwqb5Pi4cxkNQ91OstK6277AcWD0HbYjNiwR5+J
         klRygQNxSWz4YAh0DdkoqIRECa6iRZBoCsMlDfJALA1o6X1WIlmcYBa3BEJAmbAYq8Gu
         FslA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5oYi+Gp4BM8e0HJMKd/O65ssZ+gjW+eQm0VYyIlLKGniKfv4tkzej9rq7OdWUZbZYtMjz0XoUTSrwSLRkiRIHobg5uPUQZzvHclP
X-Gm-Message-State: AOJu0Yy9sbZQCoSbWdsk1EXJsH18r7oLmSkQOrbo52MIkBzfmL4NDkP6
	nxxScB1thvxqujDRuy/EpBoV/GeC4XtCL6Yc+f6Q9u9plCqhYTLNfHe20S6IeLUT3tbnP33gbXH
	T+XzWw19P0SfFK6H+pSH/p1eSiuXCw+6TLimhKQUjJp5wBOrKCGxacus=
X-Google-Smtp-Source: AGHT+IGU/qjjRg+iFnh0XV8rbPxCgFHKjyUJ7lfwD/79GZ3RLd9rgNbteeYz+Ih6Qhu6AEfq4m0FCpckZ5ER9pr5gNHc8NbD+0BD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3423:b0:7cc:ea7:4f0f with SMTP id
 n35-20020a056602342300b007cc0ea74f0fmr347660ioz.3.1710915122555; Tue, 19 Mar
 2024 23:12:02 -0700 (PDT)
Date: Tue, 19 Mar 2024 23:12:02 -0700
In-Reply-To: <20240319185946.GA1134281@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f00030614117851@google.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
From: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	pbonzini@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com

Tested on:

commit:         52998cdd Merge branch '6.8/scsi-staging' into 6.8/scsi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b1f286a7e950707
dashboard link: https://syzkaller.appspot.com/bug?extid=70f57d8a3ae84934c003
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

