Return-Path: <linux-kernel+bounces-89423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A939E86F023
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BF0B24BCA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB01428F;
	Sat,  2 Mar 2024 10:56:36 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D2111AA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709376996; cv=none; b=LEoWmGXGpggYxIhXMIY3z6pKt2vgM/A5vOmi8CBg2AH8Rh+K1gNWnHKSZvnrFVlRSZUmxX5aDGwWRjS0u4QxKJcQS/QqU2Lmbp+WIrY/z0/5TR/dx18oVprzeangHTlguKFiNYzeRECpwSBmgBMpvt5ZOZdqh6Y3WjE7eiH5Dac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709376996; c=relaxed/simple;
	bh=hZFOvbQPEDGmTgeovQ4UwGsq5+k0H4RphcUCC2vd0eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFUKkU6Rzx51JjPKTLlNge3lcPvly5o46geOWQrZbeG4loLS7H79GTQkjxoBRJam/gxXiunaQ4uwPsWzj/4LFIcCwkLEgjqIY4yaYMe33pvwaqgAEn2w35PNghT21GpIZQEf7zlVJiSJUpCwu4GSgS/d9vNyOadAGy4F5EZe878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.109])
	by sina.com (10.75.12.45) with ESMTP
	id 65E305D300008B1C; Sat, 2 Mar 2024 18:56:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 16710631457660
X-SMAIL-UIID: 1159B31607ED43CBBF2940A7E6D7CCBD-20240302-185623-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in v4l2_fh_open
Date: Sat,  2 Mar 2024 18:56:11 +0800
Message-Id: <20240302105611.1139-1-hdanton@sina.com>
In-Reply-To: <00000000000017937c05bb617f1d@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Feb 2021 07:18:22 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    291009f6 Merge tag 'pm-5.11-rc8' of git://git.kernel.org/p..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17179dd4d00000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/media/usb/em28xx/em28xx-video.c
+++ y/drivers/media/usb/em28xx/em28xx-video.c
@@ -2152,6 +2152,10 @@ static int em28xx_v4l2_open(struct file
 	if (mutex_lock_interruptible(&dev->lock))
 		return -ERESTARTSYS;
 
+	if (!dev->v4l2) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
 	ret = v4l2_fh_open(filp);
 	if (ret) {
 		dev_err(&dev->intf->dev,
@@ -2161,6 +2165,7 @@ static int em28xx_v4l2_open(struct file
 		return ret;
 	}
 
+	v4l2 = dev->v4l2;
 	if (v4l2->users == 0) {
 		em28xx_set_mode(dev, EM28XX_ANALOG_MODE);
 
--

