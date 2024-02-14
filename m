Return-Path: <linux-kernel+bounces-64715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543C28541DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC194B24E50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FCCC153;
	Wed, 14 Feb 2024 03:44:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFDBC121
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882246; cv=none; b=Vc4hYhlRaBb5cxcM+EdRyIcQY3qzOJ9wU83D4eiyCC4C6rBxn818ApXOYPZovuqtXeJOCvHv4VNXn7YVQyFtdDwP9dYtdoa7h3O8pZcmg5L5WsZuKPQRC98rnJ9tyEpw3slHRr+al4mq4Hd9uVCB6Bnhn+sNaYkBX67i65NhJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882246; c=relaxed/simple;
	bh=bK5Oblg1JdDiXcPLjPkbigMQcnWlc297eAj555n7Tww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pGvH9qCtcbJzVXqS2O+UpfNAselxDNN44MuGLjesYZwi5VG6rzcut1hw/fmQur4mMy0TGUTW3HrMe3q+n4Pr6BIG+nN0r/o3y7uARSAdkAdB7IpmF+EanyvmEl9VKlZ2mTdkCOd6PzoAZf+8otLft+D/kllwTKRgt833mnvLqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c488098701so2733939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707882243; x=1708487043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAl8MR/0K7MEBHbipfuihwvE/KRORao4H7r54AO0VL8=;
        b=f5pHgx45IXnokbjs6xFXQBLX5MHcqHFh4Yp66ElGWLr4aKcq7mfiGdpF1Ve1zfe4cl
         4/n1chBUJxZqe95FPhcDONnV4PU42O4Ttzqiq7G3FA0ALRaEQi7AlzeaGVe2jCnmlHnV
         ECmPwgQWH+2CIxcG2t13vSqtMlLeD4lyCY7CovGRl2UVPJNUU8xpfYhI5K7N7WPZZtou
         TByJs3o9q5hiPY+/PbD6pjPWdZ7WFQJw2q1iwCeyTiHc1LGqjhs3M8jRFPlkyJFgnmcF
         lV/J91ew4m8h25XqMYvzfo+nkg4zE7LzRzQhUJ0RqQMBcuxpuoNb8rZ3m18hWBZA7DDX
         Hyaw==
X-Forwarded-Encrypted: i=1; AJvYcCUK09AJjx8aPIFa8vJrdPZ/Yoy3hGr55lu944cLEzYlV6wwuydO1K7UGijO1l6CScf80CbajFt1jOdHrF0O3/laR7Y2S5GJSzSOqABZ
X-Gm-Message-State: AOJu0Yyb4ie0quGlijcMGyGCVWCJ5lC/2FrhnDLmPzCZcopbGJTftrRE
	vPpYFXdgkGhk/Ppy5na7UKWOPSCY+5WHCYsSL/YqEhZwCb2ZHicSJoAhL8BDA86Pt/P6xUTGhwR
	Uv2EEM/x7Q7u7e285aH2CYPvUn9fs0qWvOcsgsPed/6B64z4SOPSBFmw=
X-Google-Smtp-Source: AGHT+IEkwCe3K/JjpZUbAuA1vF1fc1+lUuzoMlYtDYsvgK/i0J7cQYxaZzAcdocxi3fP9E73dwHqqz82qE/iJdbQTcb+ppiBq7l+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4411:b0:471:2951:8985 with SMTP id
 bp17-20020a056638441100b0047129518985mr13796jab.3.1707882243700; Tue, 13 Feb
 2024 19:44:03 -0800 (PST)
Date: Tue, 13 Feb 2024 19:44:03 -0800
In-Reply-To: <20240214005553.1060-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000743d8606114f5251@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com

Tested on:

commit:         7e90b5c2 Merge tag 'trace-tools-v6.8-rc4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11135a78180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d2ba14dfa6c1908
dashboard link: https://syzkaller.appspot.com/bug?extid=ebbab3e04c88fa141e6b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11eebca4180000

Note: testing is done by a robot and is best-effort only.

