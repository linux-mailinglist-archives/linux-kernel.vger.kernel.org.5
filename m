Return-Path: <linux-kernel+bounces-89615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D849986F316
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769791F220BE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D505381B;
	Sat,  2 Mar 2024 23:07:26 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87454177B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709420846; cv=none; b=LSF14zHrHdBFOCbfVyQ7OVvZ0k9i1GzAVAsjLyK1PLAYsjL+5dBw7sSwDA1Gn/D3W1+OlMSn2m5x/euYQvGtFAUb2eQHA2gTEM6bWXxaO5Cax0ggHbkTbfQUabtuRFB0r7ZqEOpHf6BKGxdi4aHkIdR9W28UbrNoPDtSJ/KUcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709420846; c=relaxed/simple;
	bh=kMmpu9BevaypKn4bsM/m7Lhl9NuSpJuv63crYZt/sP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGecYPY1AV1yM4NU6Gdig5SYRVCzBtuC3OQYN5weuZgGxuYgq7ZLGY2n/oR9SISAof2GKexsr2HcH24zvSskcHXMwAtP/Imhsfgbd17EpoGBiKKNE3GRGdBJWvrx/x6bFfw8fhI+BeZJal80o+VwPxdEnY0Z3c0kwi1sFy8d9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.240])
	by sina.com (172.16.235.25) with ESMTP
	id 65E3B11E000076E1; Sat, 3 Mar 2024 07:07:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46954334210493
X-SMAIL-UIID: 35C5D6B528BD41FFBF29E1478C57ECBE-20240303-070712-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in v4l2_fh_open
Date: Sun,  3 Mar 2024 07:07:02 +0800
Message-Id: <20240302230702.1207-1-hdanton@sina.com>
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
 
@@ -2899,6 +2904,7 @@ unregister_dev:
 	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
 	v4l2_device_unregister(&v4l2->v4l2_dev);
 err:
+	video_unregister_device(&v4l2->vdev);
 	dev->v4l2 = NULL;
 	kref_put(&v4l2->ref, em28xx_free_v4l2);
 	mutex_unlock(&dev->lock);
--

