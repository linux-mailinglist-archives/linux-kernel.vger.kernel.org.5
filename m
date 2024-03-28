Return-Path: <linux-kernel+bounces-123382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B88907A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AC7298B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3607F487;
	Thu, 28 Mar 2024 17:54:00 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500FBA53
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648440; cv=none; b=kFo2UG3X+lpqHBPJecPucryPfQck9ZoO5hpTXwhnXPziH1EgObzTziQYwtjpvqGFcwD1a8vD3VCM9pfeE7FcFphmFNymGUIa8RaNZMteD8B8JX4jOJC35XQQYfV7tbwWJmGHUB6+lXcvFJO2g4AaWmuujyfN6hgCSu9CZLVWpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648440; c=relaxed/simple;
	bh=uD7lnkomkmSg8JCXL0Iuo7sCZReryyNqtT8v/xSOq70=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ior/uBARbW2naDelbvueDMnjDVRAGoD2G9vJN8vwdp+XPpwjwxdKZvouD9RMzES698+z9gu9kI+Qs13M725wve/83TLPPgTJPKKS7bn4lPlLr6TTPLUv4MLU0fY/dJCXMHu+TO8hWVzQvkLADa6uwtlYNcvhISDYEySwT0u9q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso117966039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648438; x=1712253238;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9EYU7AJ+Exp+XJ8IbMPR769miCw2zXKMTxgWr85+aA=;
        b=EuC8tu9FGdtXXA7i9e+hd/IS0ytJaoH39/7GmYj/AUzbgS6g3ITtj7ATlzbNcDN2/2
         qZ2dAIHStS+rn6MTqhT6kdxiLOowaTB8hiKI71957A3fd8uKsysdcqGNq8oY5EucF36y
         8iJPXg0aCQyroTobryZ4K/Tm5/e91bPgOqfBArlBdr7HrbXIgEwrtkz/tMJiVR3vPIoI
         CxLK5Gc++AE8I3zaycl9JpFVYld/3tk84m42e6cdUkBUNR3YX2ftOQaVbkdSJxNEfR09
         F8b023PwFKZTcK0ld4oxt3Fq3ZCaq8rTr3BaEUYDBeO+iAMVjRpF+42F4MKD8nYN3EXf
         jabQ==
X-Gm-Message-State: AOJu0YxsiXrPBpHoFYS9vuom5rSLpqQNW71C54g6mUqjCFxYhnwCTH+p
	woi47u/2C4Tnb6ZMi2jje6HtCVbInLzEiHPKoill1zcG4kMnCuqv/mCU0sjeTDXGMKtab7lsxHu
	QcR3V7flxQ946s8ZmqY7nYLLIMHMpywsinPfkkIa/QmEUxKJcjt2p9KTxyg==
X-Google-Smtp-Source: AGHT+IGjWLuR8PPQw8BWyLo79ONXmKXHpktErlT+M4pn8SRAwucGa7HIsMauPP4CbQWHbN7UgEnxp+rbUG7p/bIBWJvR6zqdX14i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8903:b0:47e:c4a2:f774 with SMTP id
 jc3-20020a056638890300b0047ec4a2f774mr90632jab.4.1711648438054; Thu, 28 Mar
 2024 10:53:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:53:58 -0700
In-Reply-To: <000000000000aacdcb0614b939ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002196c50614bc3573@google.com>
Subject: Re: [syzbot] Re: [syzbot] [fs?] WARNING: ODEBUG bug in bdev_super_lock
From: syzbot <syzbot+9c0a93c676799fdf466c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [fs?] WARNING: ODEBUG bug in bdev_super_lock
Author: brauner@kernel.org

On Thu, Mar 28, 2024 at 07:20:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d1c4f9180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c0a93c676799fdf466c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16577eb1180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106fa941180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9c0a93c676799fdf466c@syzkaller.appspotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.fixes

