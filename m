Return-Path: <linux-kernel+bounces-159920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674748B3637
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994ED1C222F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53721448E2;
	Fri, 26 Apr 2024 11:03:03 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C0139D10
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129383; cv=none; b=mRoIiZ/L4lESaXeJqQvFvTvyL652+uhc8i9zPB0MJV8CvTMu+YnnN1/mMXfT/yEmSNHiciLFEImTim+YY+pjxTvfF6Oi8fTZxgpwMmKbCzwtCuzfXK1YnQadNxNQBnpKiV1w5kVdfLOSLYYuCkUKrXlLtUoXHjRhZaS9b6BO9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129383; c=relaxed/simple;
	bh=SKY8NIXn9wTOCTm1F8TUSlwijVfID6it5MLVkFT2Ars=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akfg4v6czekvXZwciWV5KipUNJgo1s6nFpGvEa/bXn+7K2OspkqYVLeQpimz7eMwh4hgCrxJcZI6dSEBZLn/sQLYhfMF0AUPpvTMJr2sZLZoiZzhThKztljncGpu18Dx4OuvPz4BE11hptCaZCVIWcf7AkMO9fNNqCb3ZGgwqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.235])
	by sina.com (10.75.12.45) with ESMTP
	id 662B89B400003792; Fri, 26 Apr 2024 19:02:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 78058831457764
X-SMAIL-UIID: 432CAA4E330142D89BBD018D7A4A5C10-20240426-190214-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+159077b1355b8cd72757@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [ext4?] possible deadlock in uinput_request_submit
Date: Fri, 26 Apr 2024 19:02:15 +0800
Message-Id: <20240426110215.3361-1-hdanton@sina.com>
In-Reply-To: <000000000000cb5a8d0616f8872d@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Apr 2024 21:42:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b59430980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  7b4f2bc91c15

--- x/drivers/input/misc/uinput.c
+++ y/drivers/input/misc/uinput.c
@@ -311,8 +311,11 @@ static int uinput_create_device(struct u
 	struct input_dev *dev = udev->dev;
 	int error, nslot;
 
+	lockdep_assert_held(&udev->mutex);
+
 	if (udev->state != UIST_SETUP_COMPLETE) {
 		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
+		mutex_unlock(&udev->mutex);
 		return -EINVAL;
 	}
 
@@ -362,9 +365,12 @@ static int uinput_create_device(struct u
 
 	input_set_drvdata(udev->dev, udev);
 
+	mutex_unlock(&udev->mutex);
 	error = input_register_device(udev->dev);
-	if (error)
+	if (error) {
+		mutex_lock(&udev->mutex);
 		goto fail2;
+	}
 
 	udev->state = UIST_CREATED;
 
@@ -372,6 +378,7 @@ static int uinput_create_device(struct u
 
  fail2:	input_ff_destroy(dev);
  fail1: uinput_destroy_device(udev);
+	mutex_unlock(&udev->mutex);
 	return error;
 }
 
@@ -901,8 +908,7 @@ static long uinput_ioctl_handler(struct
 		goto out;
 
 	case UI_DEV_CREATE:
-		retval = uinput_create_device(udev);
-		goto out;
+		return uinput_create_device(udev);
 
 	case UI_DEV_DESTROY:
 		uinput_destroy_device(udev);
--

