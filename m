Return-Path: <linux-kernel+bounces-133809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BE89A91E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC68F1C21449
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339311DDF6;
	Sat,  6 Apr 2024 05:22:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248819479
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380924; cv=none; b=FotyjJufMHRdgPlEUulu/PBnuycxOkwSE4JuMkJGH3xbYiK/ZVG6fbsDesjeWbR49MdJE0IAEhFwr19qJPk5nU02s9PRWn4UG+V0tLXIEIKKFQXzXMigtltUEZXpEas6Fq4WYkg1pGwND2dV8v9ieCJ5MmsHzXxlJfCeZFUzxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380924; c=relaxed/simple;
	bh=/ShBSzsDsIy1nIRHLF0JRwNUrp13oo/gxJmBA9gxzvU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J3jJRENSyQcxIgulmAQFFJLqSh1GjbuwzxGiRPlYZFmQruY3wyHxfPmuOZVMaveE35MSJyiAur4OXGJVVSL4m0F56IqhiPLSwEKb9zc2jJxPPpl+B6COfEMZxsvDUwWcT5SqwLFr+Ft2Jq/qUJ4lflEHpQ5MjKKttVN8AFxsvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so323182439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 22:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712380922; x=1712985722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IshTEpsAMnjmjMc4RLrugnhne7oKjGH+YMoy5m+jGns=;
        b=vwpl7yyyez8/lCKDS8sC0FHBFRf5kwoRDTm+5rw5AoV3Nv/9E30Xa9QmnDdiKvKICD
         t9sAwbOpnjDx2Yr37XO635hi27sfYEA73gzKk4YY4zTNoUaToBCcZIR3aw93tm1alY5b
         1OefIBf34QU6UyDdfD6eBFG4ruv2i2l7l4cxMPd0Ra//pS+eZuRrhsUZc3HX7kXAvp4W
         06+aK/xkd2lMze5TtRVfWuIKIIuzKJ5xsQJ87S2l/pdps/BItp2VD2HtGTvllU1p7lS9
         Rh84YSjlhEJx5RnrE8dUb04/3xE/ToHBHabH617WQaW230QQhgQaaVmvWrBSIo8v69YG
         C6jg==
X-Forwarded-Encrypted: i=1; AJvYcCWL4377n0AT7oRbH8G1OOpcJp4El2XxReLvigZ6XM5bl28iJAInvVdNxHnlIFnjUJ3z9ox0/RmadGs08okET2ppn/Nlp8T5M4mF5OUi
X-Gm-Message-State: AOJu0YwLq4I2KOYXkDcKp8S+MtIMMsT7RbwCD37siDXCmEOqRurZSdC6
	FBm3oUawGP72slhX9ggrhOXu6OqnRJ6b9V5PsKynkfsLGPJH4gY9eqQu0EWYblzURxS3cxo16bl
	HZygWcYs7Q0zMpLVmsrH+sqI8GB5kBz6OP1QL6mY5uLPC/3xmbO1bPbE=
X-Google-Smtp-Source: AGHT+IF72dcWSck7M3sskOmYjDu1n4+OwxFLhZR8b52M+++B4wA+e40iVG8DSrhh+oVxeCnqTF/M6AzdZu9TIt2ly4k0lfYhNO/z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1411:b0:7cc:31f:f4fe with SMTP id
 t17-20020a056602141100b007cc031ff4femr134308iov.3.1712380922612; Fri, 05 Apr
 2024 22:22:02 -0700 (PDT)
Date: Fri, 05 Apr 2024 22:22:02 -0700
In-Reply-To: <20240405094924.896-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cdf66061566c086@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_sock_setsockopt
From: syzbot <syzbot+837ba09d9db969068367@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=170f6fc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=837ba09d9db969068367
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122093e3180000

Note: testing is done by a robot and is best-effort only.

