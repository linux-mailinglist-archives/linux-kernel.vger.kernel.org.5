Return-Path: <linux-kernel+bounces-125967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B5892EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4904D1F217B4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AA8F5C;
	Sun, 31 Mar 2024 06:21:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6B8F59
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711866065; cv=none; b=dC4xv8MmnVqa1gBpg7HwKkSNoy8jA5RznWz2F1twQ+Ikp6ikQHdddayUIHaE+fSb5GhfwmrX14Ft8s0Af480xdMx3rs+PZE/kLnYMDgCSQVR7WtTG483ylXb+hmSZvtMac0fDpmlfSxvya0LIUJzKuEY54vVsUr6QpFD1PdYyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711866065; c=relaxed/simple;
	bh=k7w9gKf1/Faln8I5YI1/1Q+7u/6rkW9rJQj1hybESvc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jI6gvLhwmshNcTNbqM8FF3wGd0BpVYsZQldI1/OzpP7kA7DvLYA6OT8tC1TkwATjakwWeUuNAs1JyOBwDyFP+3WJSQ1HUwje801kYLM6/p/65eK1/7F1WNTHSUqlFz4QJGd60NpB7AcYc2KtCsYUVMc1N6geFRWHl8RQhpLITzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so317261839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 23:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711866063; x=1712470863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlswKLmOm1SDm4ReW4epLmoaNJKVXjDO0IpWKml69N0=;
        b=W+srjkOpqWXs2qoY/Ouq8qULRAKI5/LUjjgfzBnsqHzzxb6aJ+l2JUdtGtwjBVu5Ck
         PoaAcXPO2DVPexEdS87vQBCv8BaW5XDRcXy+yjRhtfRT715cu1KC4dqvuZZpTtphMjys
         CeGpHMqH6Z1QsDT08+FvyjYDwWqHcjq6lAZRQuxOO0urWtfXHbq2kx3bJYfiOHmbIlDG
         x3IiJONVX5h41PnFe677/f7ijROZz16d0iMsNel/6pSZujNFRjvH6zrnJzDxZhXsGK5D
         fN+jd8yi22bjmiQ4uGFXmh1ntJ303mNIxyg6APcuzcDwIGTI8J9Ih7ccwnZc/qbfHW7k
         wHCA==
X-Forwarded-Encrypted: i=1; AJvYcCVB6s9ftAexSj8b1rIoYfgRK24fk8UZy02h61n46bTVNhz7zXzpsS6jJ/9y+1XDAaJc518AFoSHb7oHaJxGe0k3jiXk1LAw1teyX/8i
X-Gm-Message-State: AOJu0YxvWEtv2hPPq3yEohaVoYXV7qc7RLPdnQZ7VI1FWsDdAmFgeMzr
	BAFgJW7OLk4XOp4Aox2HiNrlybbc2tGFjHxNrXMw7Ic54x/DdCeIbAzv309JW4kPn67xqY4B93X
	fpPXoWPFeif+trBpATxHnFSuq7kHUpkkmJpmNtDquiug0/8N2qO2KEhg=
X-Google-Smtp-Source: AGHT+IEyFXjJr0VpnOS1Uj56Zhn/+di/cCyhycl8AF7wIkBk/6D4mJmQ5p475M6lIC7GwdvKfSNggxYqRE7T4irlvaR1vOKr/WvQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14d5:b0:47c:1232:10d4 with SMTP id
 l21-20020a05663814d500b0047c123210d4mr301791jak.1.1711866063724; Sat, 30 Mar
 2024 23:21:03 -0700 (PDT)
Date: Sat, 30 Mar 2024 23:21:03 -0700
In-Reply-To: <tencent_CD333C9E9E1B544B651B4D250FBAE5BB1208@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1b0d20614eee073@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in lmLogClose (3)
From: syzbot <syzbot+c824290332add8067111@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c824290332add8067111@syzkaller.appspotmail.com

Tested on:

commit:         712e1425 Merge tag 'xfs-6.9-fixes-1' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10f2512d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb07c9738b12db3
dashboard link: https://syzkaller.appspot.com/bug?extid=c824290332add8067111
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121abb76180000

Note: testing is done by a robot and is best-effort only.

