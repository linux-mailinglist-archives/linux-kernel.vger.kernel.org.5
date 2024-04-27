Return-Path: <linux-kernel+bounces-160974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D88B4550
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D701A282502
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2245C18;
	Sat, 27 Apr 2024 09:18:23 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50641C7A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209502; cv=none; b=rlpw3bq/+5VObuqRp3rkSCVQQvZc5wXTWCQbRxcsgDsl64aJP1OFJ2a0oFwU5J7PXVH6YBCK5POmP+Y0aa6UipQTEhDpw9n4VjRji5E2CnPt9g8jZMMWWklJPWhuRZKbEdbjs42PNFQnK1NLB8B0Ztq0TlfOn6TDezxoQ7I2N4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209502; c=relaxed/simple;
	bh=Ae1HlMl01OgfnK8gTYPqMJ88tOqqBJRj3YdR89v+Aic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXcvcUNle7SIqaOiI1V/qXLtmDZh16S8dR5z7yQ0FBR1YPFwjLp0P/7ghc0io3NdI8Jz8G85XdKCnbZKqP/t1t/9bp9mo+lOHuP/XeKB5xB4cywg2DvzW6j2xj/lhQvr4Flas3NoTUvr/0lROKCGlIJpGaYOXpzdGrYFX/1UVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.155])
	by sina.com (172.16.235.24) with ESMTP
	id 662CC2CA00002B3C; Sat, 27 Apr 2024 17:18:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 51680645089239
X-SMAIL-UIID: B78514CD79F74D33B07B87E548984C76-20240427-171807-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sat, 27 Apr 2024 17:18:05 +0800
Message-Id: <20240427091805.3855-1-hdanton@sina.com>
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
@@ -387,6 +387,8 @@ static int chrdev_open(struct inode *ino
 		if (!kobj)
 			return -ENXIO;
 		new = container_of(kobj, struct cdev, kobj);
+		if (!cdev_get(new))
+			return -ENXIO;
 		spin_lock(&cdev_lock);
 		/* Check i_cdev again in case somebody beat us to it while
 		   we dropped the lock. */
--

