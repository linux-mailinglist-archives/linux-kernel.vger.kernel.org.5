Return-Path: <linux-kernel+bounces-73071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE385BD21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5141F22731
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F456A32D;
	Tue, 20 Feb 2024 13:27:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855046A00F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435625; cv=none; b=j3X3de5x/HMxJ9b7oqdCDx1DABQnxRfzcDbzLlvfm40l2N4B0/0ceeZ5+voP+P6fe+vYJ9vBEru2+I6+IhdsNulqZDBadaA9CsWn7W9qOyYKiEsED05tOIZz+B8OvdExS/Jh6Mhn8QmXipTqGioTonmsnZklR9jYYljshfv5UxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435625; c=relaxed/simple;
	bh=LUp60cI27gmwzvD4ul7wi67IhkazIGTfbtSdgtvHhuI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U18oNXEfRa22m5BnZY7sO+u0YwlKy6aGYign+hqHC9Gg4+grCZ/F7wxW/mT/lplNL7nHHbZmsusbFn1vlORHiRT0tiJD8lQnwpAzLUdBbYGWCvoRGUPyDGlPKsYFmGPiLveY6vPZ/xXu+pV2n4FZ/2DzTDH61wnqz4UtOBnE3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c74b778213so164880539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708435623; x=1709040423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbWn6dvbrSMkD/mLtOgyuBN0PAax+RFNEc2opnSABXQ=;
        b=cB99VGl7PBRBlJMnsvbA/E9baXKpnTYqhDKrq7MVW5dorFAHbqOKtU5N07nMgigZIH
         AX6FLRf9NmkL1Cv4N30voI+u4omM8GN8tryMopIUWjdFbK5BLrKErXwdKiLAAEmSiVxG
         KIiyRWsmTdqmypnZFnZ32jUwGqqq4s0MtAMJPrrsFe8Hwq9/jeA9W4WZiOaoxnkNbKOP
         8sqfh//w6CR7y0/WtXqJVCIbNqgRf/IDRLUgshWeouzI3OKfMkTzciG5Z6SSHvoJIAWl
         eSHTJhD/SPpKDEBqL0XNVohxB8DAeSh2QcMwiI2VBqxQO3+n8oghYgTkq25i+oQDz67s
         ppnw==
X-Forwarded-Encrypted: i=1; AJvYcCVKDJrA4IYOhryFAKDEaALhpAYk7hD7KtnXeuO48A6nDl9LnM6/8dWcp5BjBw5Pw2y1CiGE4NVoU3CQxpJW52KfhsFQsCwVG2te1bbx
X-Gm-Message-State: AOJu0Yx0swwIz2Dh1GGmGG1Ac0FiZp0hPrfJMdk0S9K4a0jFKKCWusns
	ddiiLGtHptZ1a1+QSr4SHtiwb1Hhk2zjaNR/hsHpcIAq5CsztncerB0wM/X0FaodbGBWBlqNYZ3
	qvicEPYdZR/R6fXkHm2kRA7E2Qo3zcbTaAwMF/7MecP5BWoIjlMkO0rY=
X-Google-Smtp-Source: AGHT+IEjTMEQGJ2tN7cYYEEuEQnHPrOT+fbpz0s/jRVa3mPdN+hBTq8kBWOmytI4hDJ+PNVtSYR9zKw0iLfGoF9PPMcD01k0yQnr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:365:177f:6db6 with SMTP id
 h11-20020a056e021d8b00b00365177f6db6mr871600ila.3.1708435623653; Tue, 20 Feb
 2024 05:27:03 -0800 (PST)
Date: Tue, 20 Feb 2024 05:27:03 -0800
In-Reply-To: <20240220130510.GC19387@breakpoint.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007837ac0611d02ac8@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com

Tested on:

commit:         2f3a4818 net: ip_tunnel: prevent perpetual headroom gr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git gre_cap_headroom
console output: https://syzkaller.appspot.com/x/log.txt?x=15ad41c2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e8d9f850f8db45
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

