Return-Path: <linux-kernel+bounces-133855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6189A9C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AD8B22004
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019932375B;
	Sat,  6 Apr 2024 08:24:12 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6ED22EF3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712391851; cv=none; b=a5dBkJeAYiamksvvfbx9c/TtwiLxqjHZbqF1qj5bSZmX86ivKbmkPYIJ3KGW5Sx4wYSvg7xtyNcgybqCJfXbibpLT98vtQKLj05wMSvIcpnzisUMHkBGqI51gCsRg1eufNot5Slqd5Msrymp1MfiCig9V6gAkd25tgtM3qNluF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712391851; c=relaxed/simple;
	bh=vAWixwo7e995eSdMvUu0IcKXw879jWdaZhHvrFCIg1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PH3uVvV9WkzjyyDD6LAs5lE+9CEn+pXmeOBV0EWDJLwSO9obwktiBId+kiAIityAXlYMqsmj0ah3UqI5mu/aWVKPEUhippKrvFa2gQKyAQY0muBkQ9OHL+PClPC77icGsjf5ASBH/YDywR6VKwSfMH+uRKlJ49vTpR/2Esw1aiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.84])
	by sina.com (172.16.235.25) with ESMTP
	id 661106A000003800; Sat, 6 Apr 2024 16:24:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 17011434210497
X-SMAIL-UIID: 4DCA658DD71A499A9295E829AB4C4239-20240406-162403-1
From: Hillf Danton <hdanton@sina.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	amir73il@gmail.com,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Date: Sat,  6 Apr 2024 16:23:51 +0800
Message-Id: <20240406082351.1213-1-hdanton@sina.com>
In-Reply-To: <20240406071130.GB538574@ZenIV>
References: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com> <000000000000107743061568319c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 6 Apr 2024 08:11:30 +0100 Al Viro <viro@ftp.linux.org.uk>
> On Sat, Apr 06, 2024 at 12:05:04AM -0700, syzbot wrote:
> > commit:         3398bf34 kernfs: annotate different lockdep class for ..
> > git tree:       https://github.com/amir73il/linux/ vfs-fixes
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c5cda112a8438056
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Note: no patches were applied.
> 
> How about the same test on 6c6e47d69d821047097909288b6d7f1aafb3b9b1?
> 
JFYI it works [1]

[1] https://lore.kernel.org/lkml/000000000000a386f2061562ba6a@google.com/

