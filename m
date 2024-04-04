Return-Path: <linux-kernel+bounces-130832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2C897D9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8251AB24F86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2941B285;
	Thu,  4 Apr 2024 02:13:17 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54FDDA3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196796; cv=none; b=leqE0TY4O5cSOOaIgw2Zbu8jH+cy/o53a9NApHPlyb9kkR2/2wCEtuOxbPiuIBxQoGaZYCK9jEDIo+8Iv4t/ZG8f5qha3QtPdxJ9luCrSom1wiLQLCSUswOJwu0CmGt0XumjeiaskJeShrM12XnUfWp4ZloZ3+CDuAE1eMw8rOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196796; c=relaxed/simple;
	bh=z7BkxFJVzxOf2S0RNFaj+RkUoL5NLhpfjuXiSbRfpcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QsjOp9q3XDWksr67rdkADhGGFUoR6pZWC6Ph8ew0Cwpo1xt7uTalzXrFv07Pk/m/XTVVaprWzLl2FY+huxc+ppJaEAHEHvVJNh0/+kfgcGYFvK1LeMmy/IxO2qGgnOzoqDy+wlVNnSwmembw2wQ+ajCvEnUpXR/LVidjWvDASQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.253])
	by sina.com (172.16.235.24) with ESMTP
	id 660E0CB2000020DC; Thu, 4 Apr 2024 10:13:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9655045089351
X-SMAIL-UIID: BCF4CD0B993E4605825F83FBC34E4B36-20240404-101309-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Date: Thu,  4 Apr 2024 10:12:57 +0800
Message-Id: <20240404021257.4018-1-hdanton@sina.com>
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

--- x/fs/overlayfs/util.c
+++ y/fs/overlayfs/util.c
@@ -1159,9 +1159,8 @@ int ovl_nlink_start(struct dentry *dentr
 			return err;
 	}
 
-	err = ovl_inode_lock_interruptible(inode);
-	if (err)
-		return err;
+	if (!mutex_trylock(&OVL_I(inode)->lock))
+		return -EBUSY;
 
 	err = ovl_want_write(dentry);
 	if (err)
--

