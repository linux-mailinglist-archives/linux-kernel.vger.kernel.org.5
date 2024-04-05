Return-Path: <linux-kernel+bounces-133701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008DB89A784
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35816B25937
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6236121;
	Fri,  5 Apr 2024 23:03:09 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305225779
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358188; cv=none; b=GwWL5EZJXO8CfLCmx7cqu7OzYwbdF0J2zO2C8KgwzB88WnqvSQc02WNclHOwGvqjD3Swx9nTABwSa81ZdrzqMogaNCS032TTRKjCF3lUoNQdPmpFajzy2WFtgOCgCDC4MjANhGNMZXAF/ZxQXAYNKtXJJtCwPeb0u+Pog6IoNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358188; c=relaxed/simple;
	bh=yp8bXWKt971m/CugiQigGsvhT8uE+bI43VycNG+dneY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGu15HgWjpK6J6gDzyXWabz2boBmyMCd9KRDJr/h6qgPP1uKLPlHc6peheoIbKd9kVMXcrBIx6yTIKmDMHupFDKAJNckbxY1UVq9SueTO15HWDfosvz1+99jB3wQ9QUbJ3IQRqK5kB863tUsUHrgFqn0DJEv6bIV6tYMlo9Y778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.84])
	by sina.com (172.16.235.25) with ESMTP
	id 6610831C000068F0; Fri, 6 Apr 2024 07:02:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 27287034209900
X-SMAIL-UIID: 0F9CB25F9C5A45A8A2B4265056941BB0-20240406-070254-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Date: Sat,  6 Apr 2024 07:02:43 +0800
Message-Id: <20240405230243.1067-1-hdanton@sina.com>
In-Reply-To: <00000000000098f75506153551a1@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 11:23:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c38139180000

Test Al's idea.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -639,6 +639,8 @@ static int kernfs_fop_open(struct inode
 	 */
 	if (has_mmap)
 		mutex_init(&of->mutex);
+	else if (file->f_mode & FMODE_WRITE)
+		mutex_init(&of->mutex);
 	else
 		mutex_init(&of->mutex);
 
--

