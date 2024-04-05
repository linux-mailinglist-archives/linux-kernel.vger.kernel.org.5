Return-Path: <linux-kernel+bounces-133698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651D89A77E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B371C2165F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BA374E9;
	Fri,  5 Apr 2024 23:00:54 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49E339A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358054; cv=none; b=rcqwU5rl6HJGPqgOvEK99e0y4GY4vzvJXCnKlkRNFw24XifA/Nzvy9muaPd/KIs1ybru8WaMnZ2mo1c9oRpJqafquJzx+xHEusE6Lrqa+MGUp4NKHTUbqJ/7w3203dGEzVUw4kMsRNFpiT5a7ahBTv6meT/Y6/U7pv/kBY19RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358054; c=relaxed/simple;
	bh=fDaacRuJjZ0W6CSEWRuV5+rg4i4M0HC6nt/XMdAZ54I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lHoSMISmbcFSrQTbCC5JOBXqRhTKby2TFU8llUlIoBiTSDxNrvaOAxYSBmPNb0eHq6+/Ub6VYhrMJp1Zfcl7BMQuop2RaDSr8OcRwHI2CO1DD1/GZkkc+Q89uRK/M0mUBpj1NqWnN3l3QtXYvBTQwW+3Ux00tA2VcQsBEcvPcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.84])
	by sina.com (172.16.235.25) with ESMTP
	id 6610829B000035E8; Fri, 6 Apr 2024 07:00:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67406234210258
X-SMAIL-UIID: AA7551CE4CBD429480E43B05BE660891-20240406-070045-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Date: Sat,  6 Apr 2024 07:00:34 +0800
Message-Id: <20240405230034.1015-1-hdanton@sina.com>
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

--- x/fs/overlayfs/util.c
+++ y/fs/overlayfs/util.c
@@ -639,6 +639,8 @@ static int kernfs_fop_open(struct inode
 	 */
 	if (has_mmap)
 		mutex_init(&of->mutex);
+	else if (file->f_mode & FMODE_WRITE)
+		mutex_init(&of->mutex);
 	else
 		mutex_init(&of->mutex);
 
--

