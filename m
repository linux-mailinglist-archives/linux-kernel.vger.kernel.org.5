Return-Path: <linux-kernel+bounces-105395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6C87DD51
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7642813E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC8E1BF35;
	Sun, 17 Mar 2024 13:58:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D501C11
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710683885; cv=none; b=kno8Qh6UDEh5a+VKOZ+H9KoJ23teux9Qf7fqT4of+jPGwlDamfD/RPr6Ssd14BL7/6M+4SXyr3UlixxGAXZmrNCbkMlJeEMqT4U+xCEaAnRFLY0g9TEuoa8XTXrcJnvQM25W6MMingJ/9jOsgZSIHBizx94zsnRnXBza6lC0xxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710683885; c=relaxed/simple;
	bh=L9G4HDohrXQuIakqxZZFzidXl1q6Qm9FtmslfgpyzRk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cTRmul5NQJBxuggewO1+blTLTd3IB4+pwmv3X3Jga+1WySgdVFZgGtcfpDQkeIpIoV73Y87yYx8mBuVRwAMNrDKTvsZ0riOkVugNCq5+SAia4h87O+upGruOssQfKDeLNSyRZLe+Hzu5SbktFvRI7KV0IHsS8ZNNawenSe+PH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc044e7456so104674139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 06:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710683883; x=1711288683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eD5+B9KN5f6+6XpRxSKGiUG39g7Rk1aFKdCD3iKDsCk=;
        b=torsgMeIOe2+LPOHCxFB8nLIepQnuJavZ17Q8AYS2l4o37Gf6CWz0Wg7tsLPtlGvMD
         MVZndRWZYFHgEyiZATe96mUdyZnjTndtbMt9o45xGMBPRegj0ZwZW3+rzx7YRQitegpT
         Hb2iU78Udc33RCf3heJ0j7Wye8GPf1LfiUp3oOVKvJuIHPG81X/14eDzCZpC1Gk5gCfX
         graH5NzCD4EtyF5De2MQpfqRlCCC5R/3QguddtzQeO1QGomErFF3nVT2Q+oA38+6bnQR
         H/DLCuo4WKLCd/V2XDcktZEgt+wYbK12y7MZT+BGbJL6T45BeKijKNo9ZZGmmF3OJrmi
         lK6A==
X-Forwarded-Encrypted: i=1; AJvYcCUtwbbBnloOskaqzrVFFISLJNa8qsMhSyZ3NVLmxgplUbZBhQhZIoS1LiS+TxrgFGpgHrdNoK9jh2USsdtJdj+X3Rx5LMGskSd6Q6Fp
X-Gm-Message-State: AOJu0YxlOhfLLTV3k+JXMugjDjGUhQeXBCUFf1tWhvHvhhQ/QWX87tV1
	MqI53vX+layVAwjo9NvyuUT9+a/naEcU/SiUOWI6g76cwCdQKR4HeOoM5ItlFzZbg30w0U8tqRS
	IJDMaw8bzzzPSM7YkEiLkcUCXN0kG7FSTKQXtNCxRD/YqrdO9vj8ELuQ=
X-Google-Smtp-Source: AGHT+IHPul9WGgkKqm7B8jSCs3hOp4iNttQYvYYPfYn6tt6kgff+bf7Kr/d5QUuiKI5Un4eH0JnQ1vAaB29H+fcRR2HAvVFMlWKf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5ab:b0:366:b26a:ecb0 with SMTP id
 k11-20020a056e0205ab00b00366b26aecb0mr38488ils.6.1710683883125; Sun, 17 Mar
 2024 06:58:03 -0700 (PDT)
Date: Sun, 17 Mar 2024 06:58:03 -0700
In-Reply-To: <CAOQ4uxjdGyN84GV7rA3FTWYzvSTTY6+bza2PvHn2mNpHTPfxFA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d50840613dba1c2@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_copy_up_file
From: syzbot <syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com

Tested on:

commit:         a8d73a85 ovl: relax WARN_ON in ovl_verify_area()
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=14d627b6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2271d60b0617d474
dashboard link: https://syzkaller.appspot.com/bug?extid=3abd99031b42acf367ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

