Return-Path: <linux-kernel+bounces-165613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D68B8E98
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D82B21770
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC1179A7;
	Wed,  1 May 2024 16:56:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A81125B9
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582566; cv=none; b=S2AMGAOp/1GYY6SulMsGh7gRtM++LME+ll7+VrLfiqQibswYHcAIkU6Bmbxs55Nfgt+7/H8yhz+tRLEgHhM4p24Q+5sJormDV2qRYjDI9xu02vdcfADb4D+b9oDOHeoQq692OGPpBBO2w88cjIkObT6Nj+WT2NihdGVWanqzI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582566; c=relaxed/simple;
	bh=1XZHi0YzBLS47mbettJ83dDPGL16uhOqOK1tJN4dlpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+y/EA18J6u89HXxiaux52nLbh+Qr3eqPdrG+AdXu4BemL0j8ASJWmuD/+wxJySMDngqbYRCrfVabRYkGUgQQuxM5C/4BiMnV70bv6JJo3wb9T/41ezUdMQ/FKuUWzLIQJ6uvudiRluleLAgLxshMOgc1Ras5W4Oywbr2qO8VOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7def449f58fso1015039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582564; x=1715187364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL5zLFLZ9/A+euis3e08Nm55+lvX3+T3wPrxtwGnFpQ=;
        b=l1g30fSuilPjbr6F84RM7viJbksc0/08Du7tUf2+/2wU2OXt/6QowleHFaM1TY06kn
         N7h952PpwyPfpTXwzVG0wKmYR4PPHgnTWAPS63F2mkH7A/36mOksJ9ZF52hvPfgfhcWf
         UJDdIhOPEhpF991HSA/9IBl7mSb37M4fjCSNi+5qzxpyx+NVFi5m0CtLSuVjXudJwdpV
         j52qzjvbunBnO1SEtSzSOwxhVYQdWwEKl6NRI/Pb/hlHxKOsoRsOD9okAIhEWPpmKNcX
         I5tvFxBYGhTY3wxiVorPXmR5zu3Xq/ItbTtGtY3+7WTW3+EEfYDRZnztAGOLzjV/llXH
         LZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCXJriUbUpI4xJRiwIIlo0cSuTBwHyptYJxCQlds2HqNW/obmX5+d0I3jY3q0/XwsNffoPVFdOzKgv4HSbY9Omc4d6K7FSAjvMIo6LaU
X-Gm-Message-State: AOJu0Ywfn6IooWlhNB+UH4MBhRjCFNG5v4fJFzhqqUNxaJe0qgF9NdkU
	VEHSknnxdNgQw9ie/4NlUhO7aJB+FEdGiq4fSwRjaZfWFiqprSiNlMHR3MoK3WasCNc06GgsCTE
	MGt7EzhHjzh4IM2lw1Se/AsE0MTlMb4Rv4PfxISaltaVxMe3uZbNBwh8=
X-Google-Smtp-Source: AGHT+IEBjXreViAye+0kXgWGM8QAOQnK+EHu2cHJMy66fdP74jLwDb6XfrE99WN2U9+ggleDVkBLcX+2gumyBDoVt+kvePoHzc8o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8684:b0:487:5dce:65ab with SMTP id
 iv4-20020a056638868400b004875dce65abmr6872jab.0.1714582564003; Wed, 01 May
 2024 09:56:04 -0700 (PDT)
Date: Wed, 01 May 2024 09:56:03 -0700
In-Reply-To: <20240501121200-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa73d50617675ca3@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.christie@oracle.com, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com

Tested on:

commit:         f138e94c KASAN: slab-use-after-free Read in vhost_task..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a152a7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

