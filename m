Return-Path: <linux-kernel+bounces-44534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5C884235D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF54B284E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8366775A;
	Tue, 30 Jan 2024 11:41:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96A67736
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614866; cv=none; b=RUyschEP894RHnACdVIBlNcyg8mjKxctQx6c+xJSnlaMmMY/EzciNLpXOuAMGkR0RdGZNN3l3QGOmcr5IMK0jc0j7soBlRO+4z+k8a+tUyqtgteDfk0nnwUQrvdS87lLeGIr0q6fdAmlzsH+F7Vm85RLdVQFYmMX8lPnZGlPNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614866; c=relaxed/simple;
	bh=N8UXd0HU8Wyb0bjouFf34AqZvaGuo+t/lnNUTIkmuUA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HTAOPsO+D1G8PjLKS1iP62w8M3xtpLmihWWAEwczNU+37FOmqq3aQ9IfitIr3hI939QX97QLN8ixnp1ePbr7CRshAVjYZcE8m7zzTvODsHMA6RUnIPx+TjEmV+QlEJOu8qLJkOz74v6emb+FJEUOZQYoIV3XYPh6E5Z4LRrKFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363827f3e55so11289435ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614864; x=1707219664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMK2ZZYzp1i2IvP4Mygra1dJ946G5400ecODPcHRHo8=;
        b=bKDItY9t1ofop90izU6u1drHpLtUxoCfyW6nRT0S2mKr/61j0U6ghWW/7+Zbyt0Q38
         BUo9WL3B/2nTlWC1qQLErJRAtR8dRZIEjRd/kauAMJYd9TloFIFjZRaBX9iUpcQhl5n2
         +THF42il7QXRGHUOi1E7U6ZNGuRCigU5LQs36qiy9UMfNx9UpHPwqBapajPNS0T0i4st
         ivJs7auP+oilhM7IusKyiODuRkXRlk3DyzkuXsCp377bt/xK3Blx4WjwW12jVRYakZfw
         rkyYJWfniL+UAaj/zjk1WFxxUPO7dbYEZvvMjUecyKYFNJtuvsslZOhHvpzHWdIaYCIJ
         j8xw==
X-Gm-Message-State: AOJu0YzdeD9w6PdK6wMKkengEUrU7kiQYA2sXSJFsuGe9pkLwUPI7YUc
	pDT/ta7IfjjNGxGDWmN7DPeJLhiaSUoy6i5QkzWLTYgFTlIz03gT0DoGPptBb+MrubiA33qUIHe
	TgJLJx2wetGadzrtl291wB4rWvqXdwiAsp8Yw1/fXoLFEj+30nEXU2YQ=
X-Google-Smtp-Source: AGHT+IER73NT/AuOjF5IYW+0LiPfUNwY88jBROVrxUOes1N0ClbMt1HvsvXEv7KCcCJ85yX4RP6HvNj09FoBJqVw2mBkrx0JdOrB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:b0:35f:c187:ea04 with SMTP id
 y7-20020a056e02174700b0035fc187ea04mr1043019ill.3.1706614864258; Tue, 30 Jan
 2024 03:41:04 -0800 (PST)
Date: Tue, 30 Jan 2024 03:41:04 -0800
In-Reply-To: <tencent_185DA85DAC9919CFF40D99A5F00DFA121507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0afd80610283ca6@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com

Tested on:

commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1742ec47e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16171997e80000

Note: testing is done by a robot and is best-effort only.

