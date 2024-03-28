Return-Path: <linux-kernel+bounces-123453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0988908DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8874E1F253DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2809137931;
	Thu, 28 Mar 2024 19:12:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFB2B9A7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653125; cv=none; b=fKv7l91FnuofcgtYozbjajkbD9RftJHal9XlItdUrC6hIdoDfp8TSJN682p1QxzMYMJjXE5JXut2c5dzFZSrnUael5ShTsmhaX+/5N7WqDdRp6Wl4/kO92tQYQZZozDd2kPVhObR5qS9JoNCyZO2tl5f/z6xEnGuYflv7N9qUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653125; c=relaxed/simple;
	bh=isKCXuY72yWQzJLXP0Js+yDQWJTwX5/faWnfRDvfWFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f9hOxn6C7UFndTRY0FaLOpBBTfdBFO8Y9GSqTTLRpgBIG5rVhbWzOlrs5m+ze1PuTtUXfJqL+JGzTMYzKWp4r6xe8rqT3iVlLze+8cy1tirun1W7zwHkTWdT9Al3zCr+tbYpPzZLrnagVL06dGkr9GYbRVoSrZJbUEi5MH1uFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36696c9cb23so9596535ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653123; x=1712257923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWT9KuAegNLVfJjqAlaRw3hu6Cgsmv1M1mWe3K5+52s=;
        b=ZWCxBpDmlnrQGR1iDz9We8xouRxRETxlHAK0MpPNKiP8nYxMPO+KgySKomp9rYpwYt
         HasYPDYh1SbQT67LtaVLBbsfxcP0+HkL9ZOPLw7n45DAAYqeWb77DAHcl5U4ZRX3+7kJ
         7+yRdYF6qGVw+9ogz+RmgZd0o+qnrCoJYwsidPU0vedkh6+PfG7LZW7lkNQ7JX9dttNm
         cL/aBgcTGk4u9PQ6cvMdulRGrvmg6Zu7d1cMrewZQrq4OAE63/dPxAgs9hPNJTV2q9dL
         Yu3hj1OECvmSdruII5TA70q3X1dHwCUg9psSDenxC2WGrd5r+KsULS8+X/sSv9nFVtdM
         2rdw==
X-Gm-Message-State: AOJu0YxolSEaA4+yDpLKbcTxfOgnLFBVMaSpsvAg6eHyzQd//xhxWFa4
	n/Jjvt1Qo1Cjho9IfapU77fCaua6MivG54qLq2pzhB5fNrACq7hOxeYsyunCef7aMXg1nr8Oscc
	y8idAt6OMBTnC7+XLkYNLZTs15y+U2GoJOfzpb3of216C+HeuWPpm2LrVQA==
X-Google-Smtp-Source: AGHT+IHC4PQs5jKRrWRDhfF+kJvbGO1BPSa4ramkNeg2o8qgp/z9rPY2OXhbnLw8P27qiIRrBTGam9W2EUyZ9SCFksUACxhoUAju
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:366:94e2:f17b with SMTP id
 i10-20020a056e0212ca00b0036694e2f17bmr1992ilm.0.1711653123350; Thu, 28 Mar
 2024 12:12:03 -0700 (PDT)
Date: Thu, 28 Mar 2024 12:12:03 -0700
In-Reply-To: <1921e7e8-3c43-4f3c-9709-874b37ea9c81@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006576fd0614bd4cb6@google.com>
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
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=155ac345180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

