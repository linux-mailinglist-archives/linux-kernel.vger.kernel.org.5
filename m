Return-Path: <linux-kernel+bounces-59111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065C84F166
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEE41C222FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789594176F;
	Fri,  9 Feb 2024 08:34:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE462EB14
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467646; cv=none; b=kf+R6d0EZu6d4b3nUPge4taAwjqnlUQXYOHScFMmI3fLHVKWom8bQnPrHEshQ2Ekmef3tMI5eQvVU7LzsCBhxQYusQZbUc64G/xIQUZcpXbt51+XgtlaIhgH+ebXxuSXHnzpGiGmbosh9SPQLKC8qnm9YxvBo/cEVr1ITA1lJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467646; c=relaxed/simple;
	bh=6oNdwrYAYp+HvdSkmFuxuRPRfjAjBbCdV+ZRx6MLuO4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ew+fVoNVcSOfjOvqNnIBBK1KregsleuLQDSjuBLey+nUp7S8wzNyMvm448v/9SroYz/cx4W20+HdcVmBvtk2hqT5+fmPu9QuMEu8pW6cNOVj5Uy090fiiKr3VnuPuSKvB76gikIHudju5mIYaJ7h8Yyx9ZlHivu0JvaVIzKFOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so71549539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467644; x=1708072444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uQdzd1q+pZO2YSYICuPWo0JeDe4svkU+fNfEaS6Jpo=;
        b=kDLUFm19GyL79QkERFxNMWV/lVI6ph9VZUFuX1YbtVd9D8Xw1dGkzmGnTR+RFd9vgC
         ARH7kLOf43fvaXZ27HXDV/+KchDUYaTwb3zumBAz2+Yy1wspba4geENNb0IU3uCn7yF9
         tRn3d0+UpXf6m6upnM+EnLWQipv7tzeNymgMuXnnYA1G4OHJsUabQrI7WFsg9gW0uSvZ
         TFgx/LM/Cx0zlblXr6u3bfQg3YmR/BJqUNSmu3YgBCAUCfpvnxynD5GQFzvMLL7XooFq
         7yB6DA3ZJRdGrPl4r9VhpwofMIWVPnED4J3dqgbSD5kq94CghlddO6HjEIO0KprO9ZJx
         m4uA==
X-Gm-Message-State: AOJu0Yxb2FpdWl4SJgCe3UtfufPzElTyXuK567Oqh68hSwL0KTKi30DT
	KspP2RrjhteH2kra3k3YTIJf4JoFaSjwVah7J+pnorrP9Z4Ci9WGjvXB6c+9EsTEJafKdFcT2Di
	k8CCgCFaoag/lj1AiwMgKpUF8DqD3qkAJydZ+WE0IlTv2Y9aMMrGkudE=
X-Google-Smtp-Source: AGHT+IGDZBeNxrOyEmKEmTa8XQpv8dg6ZTBq3GW8lsfeF3qS58phZQvgRVbeea1jE6TDj6qyjg3OV6rI39FI26/jnrGeuG4OoIN3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c93:b0:7c2:c966:7bc8 with SMTP id
 i19-20020a0566022c9300b007c2c9667bc8mr29645iow.3.1707467643857; Fri, 09 Feb
 2024 00:34:03 -0800 (PST)
Date: Fri, 09 Feb 2024 00:34:03 -0800
In-Reply-To: <20240209081128.112-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060b4cd0610eecaa0@google.com>
Subject: Re: [syzbot] [media?] possible deadlock in v4l2_ctrl_handler_log_status
From: syzbot <syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com

Tested on:

commit:         445a555e Add linux-next specific files for 20240209
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1613d304180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=9948f8e188482c5d1a3e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11aee120180000

Note: testing is done by a robot and is best-effort only.

