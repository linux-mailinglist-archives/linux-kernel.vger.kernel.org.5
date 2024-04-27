Return-Path: <linux-kernel+bounces-160999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF838B459A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9892A282486
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1A43AA2;
	Sat, 27 Apr 2024 10:44:34 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922A347B6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714214674; cv=none; b=ssE+RYtnwLt7p8Z9lSYmQHjMCPvXoqMn88jBM/CvyxXUx/b9jXTEnv8nl3anCTsie7nwRGJXdBKiCwAupYA8KTzn3BOItCIkc9d4x7G852elHvZ8djezngyJlaYARy/EqSn5GCaU2OeXUn8plFmf4evFQ2FmdG0HmKPGeBmR0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714214674; c=relaxed/simple;
	bh=f5LFMIxtIn4Rb0vSwTaO9c6vSDOK8fB6BXUCWnoX2BM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia567cOeQriRJra9If4K+J3PkRw6ZKhzzOOSPpCACWvuW+goikGXbdDRsox3Exn4JI//v2+iyTIDsK33UtoS/y45T7f5hxzk9pgBWxSmEtoJhx55vt7tpsuKuWTRfGlS3MZsbdg+WuUUpYZ3sK6a5ldeJJFFJgPRfBm57KvrJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.155])
	by sina.com (172.16.235.25) with ESMTP
	id 662CD70600001F62; Sat, 27 Apr 2024 18:44:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 43268034210304
X-SMAIL-UIID: 23A085A6FDF24E87B8BBFAAE0EA0B55B-20240427-184426-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sat, 27 Apr 2024 18:44:25 +0800
Message-Id: <20240427104425.3926-1-hdanton@sina.com>
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Apr 2024 05:00:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12499380980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  e33c4963bf53

--- x/fs/char_dev.c
+++ y/fs/char_dev.c
@@ -377,6 +377,9 @@ static int chrdev_open(struct inode *ino
 	struct cdev *new = NULL;
 	int ret = 0;
 
+	if (!igrab(inode))
+		return -ENXIO;
+
 	spin_lock(&cdev_lock);
 	p = inode->i_cdev;
 	if (!p) {
@@ -384,8 +387,10 @@ static int chrdev_open(struct inode *ino
 		int idx;
 		spin_unlock(&cdev_lock);
 		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
-		if (!kobj)
+		if (!kobj) {
+			iput(inode);
 			return -ENXIO;
+		}
 		new = container_of(kobj, struct cdev, kobj);
 		spin_lock(&cdev_lock);
 		/* Check i_cdev again in case somebody beat us to it while
@@ -401,8 +406,10 @@ static int chrdev_open(struct inode *ino
 		ret = -ENXIO;
 	spin_unlock(&cdev_lock);
 	cdev_put(new);
-	if (ret)
+	if (ret) {
+		iput(inode);
 		return ret;
+	}
 
 	ret = -ENXIO;
 	fops = fops_get(p->ops);
@@ -416,10 +423,12 @@ static int chrdev_open(struct inode *ino
 			goto out_cdev_put;
 	}
 
+	iput(inode);
 	return 0;
 
  out_cdev_put:
 	cdev_put(p);
+	iput(inode);
 	return ret;
 }
 
--

