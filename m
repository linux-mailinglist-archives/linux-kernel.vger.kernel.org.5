Return-Path: <linux-kernel+bounces-89632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B4C86F345
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 02:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C031C2108B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E179E0;
	Sun,  3 Mar 2024 01:44:15 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7EA79C0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709430255; cv=none; b=gy6JLe8vueQCA6xs7RkdzQfpBobPTG0GOaZDbTX0u96tPc98FedUc8X/okafhZnqWyMxhJnpMWPQp9UHLVds8hZI9FswWkpw6XgmgcdRII2tuIKgTKjlO29HxLzndE+ftjTPZD7JJoYN/nWO48E9Jx3/emAOKMs73kHMVhm9+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709430255; c=relaxed/simple;
	bh=tFrOzGMReNirfvPT8Shq4btg5sWH8BlwDrpPgcf66mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8ISJCfkRE0RsTVNaeNrtod2QQWNzQOXaCf6hze+ub4vDTntgoBhrEDATDmcA2WYyqXrBgUNnGw0p+FYeCQz78j/Gy/anjljSmA9lCzh/qwRLIfsR99GyoGnufUEV1k+62XyP5PaKqNSC6/lhDXrwCfxl+MU5at8NSA8Ua8fX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.240])
	by sina.com (172.16.235.25) with ESMTP
	id 65E3D5DF00003A16; Sun, 3 Mar 2024 09:44:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 61779034210450
X-SMAIL-UIID: C01EAC6C337044F89B2824896C6FC87E-20240303-094401-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in v4l2_fh_open
Date: Sun,  3 Mar 2024 09:43:51 +0800
Message-Id: <20240303014351.1274-1-hdanton@sina.com>
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
 
@@ -2376,10 +2381,17 @@ static const struct v4l2_ioctl_ops video
 #endif
 };
 
+static void em28xx_video_device_release(struct video_device *vd)
+{
+	struct em28xx_v4l2 *v4l2 = container_of(vd, struct em28xx_v4l2, vdev);
+
+	kref_put(&v4l2->ref, em28xx_free_v4l2);
+}
+
 static const struct video_device em28xx_video_template = {
 	.fops		= &em28xx_v4l_fops,
 	.ioctl_ops	= &video_ioctl_ops,
-	.release	= video_device_release_empty,
+	.release	= em28xx_video_device_release,
 	.tvnorms	= V4L2_STD_ALL,
 };
 
@@ -2788,6 +2800,7 @@ static int em28xx_v4l2_init(struct em28x
 			"unable to register video device (error=%i).\n", ret);
 		goto unregister_dev;
 	}
+	kref_get(&v4l2->ref); /* put by video_unregister_device() */
 
 	/* Allocate and fill vbi video_device struct */
 	if (em28xx_vbi_supported(dev) == 1) {
--

