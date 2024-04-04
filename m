Return-Path: <linux-kernel+bounces-130791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDF897D24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3547C1F29AD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549046BA;
	Thu,  4 Apr 2024 00:43:17 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580B37E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191396; cv=none; b=GaA32e3nin21c1Ri4rQvdkMfB2UL77nRMUvWoCllkLG0G+4+sCk6PD9PEq+nKq5zVIfMsvbxuL/0/izJlj17cH2fZDJIXoZc9WxW0LzF/n22q7Qsu6HFhElpA0JMq6hluXSO1sTdhOBX9hRvt6Z6cJvm5gDJy2YFfzMbw1EX7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191396; c=relaxed/simple;
	bh=Jn7jihx5ZAEU7E/WxYZQsSS/l5HWKas8Jpl8onMuOeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixwIeHCzYIlM9YiB6020mHKXlWQWv2h8TrN1oUVqr38aPjykn6tc3x946eYGrAVv58lPE4y0DnLvEqwTO5nell7PbfaiKjWEwkF1xDDjyVVVtwpFSJIYYgNA3AjeIeFpCGdior/s5/H+JWhKtoWXFm063Jry6WdkB8LSplI9FTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.253])
	by sina.com (172.16.235.24) with ESMTP
	id 660DF79A00002F0E; Thu, 4 Apr 2024 08:43:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 89645545089384
X-SMAIL-UIID: 0BB6AD394806450287569264996BFAA2-20240404-084308-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Date: Thu,  4 Apr 2024 08:42:57 +0800
Message-Id: <20240404004257.3933-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/fs/overlayfs/file.c
+++ y/fs/overlayfs/file.c
@@ -204,6 +204,7 @@ static loff_t ovl_llseek(struct file *fi
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
 	/*
 	 * Overlay file f_pos is the master copy that is preserved
 	 * through copy up and modified on read/write, but only real
@@ -220,6 +221,7 @@ static loff_t ovl_llseek(struct file *fi
 
 	file->f_pos = real.file->f_pos;
 	ovl_inode_unlock(inode);
+	inode_unlock(inode);
 
 	fdput(real);
 
--

