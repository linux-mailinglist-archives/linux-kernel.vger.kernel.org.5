Return-Path: <linux-kernel+bounces-109491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48989881A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07471F21E18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024928613E;
	Wed, 20 Mar 2024 23:29:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB61E87E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977344; cv=none; b=StZjIcPFpHdBuT5vQbYksTWOZKdeu3s1Ljd3BSZmd39338xF525TrqlEv3kbKZWlHaugiQ7av5q2BXmWl6u94MCcO7dee8+9pMKnIzcYD//uzNhzk9NTIptcDy5QuRi5v/K2H9FiKzhvFY0mfpBX5558gvNpCKUfmpqvy7JdqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977344; c=relaxed/simple;
	bh=zy1Y72W3t9QSpWbHN8e6bNQPXCS7E0R2Ez1/rnsoSoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=djF99tcflxV8xKPc8iBGcq+98UKrTnbuypWKFO4sH0ZrKIIFBej/B2Sky2QfYQ5vcEvdOmjxCmZMUNFJxfTBEi9pZP2l9X5ZZM2D0nFkYsfWXqV6KZMkWi/GNt/pF6xI2jTYhsJ7yJRFh6ZLaXPNWHzoNOQiqAR3PPyUkkHLxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbdcfcd458so37596439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977342; x=1711582142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QS3EAHIRsxSuOO543/NuOi7Tiw7nBf3IFCtq/QcVjcg=;
        b=HN5CvCBfSDTF/qrjPJrrQhVGT1fccQhnH8N+/ZJWYrewCrdhpEQpLb8/KYoPVpwG4q
         dk/Phh9Gq5XB1spBAo01nFnnwjyD9fxmh9Wvm9Y4BEk/cmYEOM1dfFK9LIVgX571o7w/
         Didz9rnMdK1ZZjqsEI2Rq1KyZkzuVrDvTBh7G0AytI02Uazv6FmJ5AUD4q7vkFjnN7k3
         kFFbqjhQ0JqiA+kr0aw81IE8Ye1ubIWY5a0PlsvdyOwmoe6pzbguRdPpeLPGpY6Eh8nG
         KtexFHU05x8eQq24D2NtQAshjQxo2SehFMA7VixUZe+oO/wWHLr5O1zLQQ2OehKz6BPn
         qp2A==
X-Forwarded-Encrypted: i=1; AJvYcCUOPu1LoKwG/31R7xn0XltpWkd0Pu+81JAwcqkipRMKZsBirir4jzBwU9DXFUkC82bUr9znmv2RoGzLpWNJrAEprYjNKpxN3NYI0oB4
X-Gm-Message-State: AOJu0Yy5+/klPU25/nRUZ3arE1lynrbdHe/W0E/ukY0Hsooc4K2K5Njp
	YQ96sQCVQ3SQiAxTeVAnrahpVkDIMPOIqY8RxDwvs7/CpYd1T4T4lqIqDsYx89ymP0MXmENs6cy
	bSeUlVGieMcxbL5kvNUoSXW4jQ8bLkhLbT9kCyQMsrDvOjdjkLfQEyAI=
X-Google-Smtp-Source: AGHT+IFn+0pzzuZWtbAOt4c4OW9mXKG/s+qCEloIU1nWhDCPYy8J/v5ByEqxdQbakLDdHzxDcXQ+9qxkAwnTT5YADIWFqToB8JTx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4090:b0:476:f1d6:93f4 with SMTP id
 m16-20020a056638409000b00476f1d693f4mr436887jam.1.1710977342346; Wed, 20 Mar
 2024 16:29:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:29:02 -0700
In-Reply-To: <20240320224946.2298-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5a41906141ff473@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in hrtimer_run_queues
From: syzbot <syzbot+f311e026553fee3459a0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f311e026553fee3459a0@syzkaller.appspotmail.com

Tested on:

commit:         ea80e3ed net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=131d7876180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f311e026553fee3459a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110edef1180000

Note: testing is done by a robot and is best-effort only.

