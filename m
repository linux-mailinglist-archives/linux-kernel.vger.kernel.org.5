Return-Path: <linux-kernel+bounces-160168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994808B3A23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDDAB22342
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE703143C56;
	Fri, 26 Apr 2024 14:35:49 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F65125AC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142149; cv=none; b=SA+In6/Nb4zGeiNfEaqyk+IFqLfE0RjEcCDsheQictyy0ch+PhMkrvdoYxxtJufGKw5wHFQaDxtwEhfobHl7H6niGrkKtewUEcxvIN2iGiJk6hg8iB0FgPYtGbh5481SHunGaB3oazWUyDa7VBok7gGJV1sirApfS7twtIEQJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142149; c=relaxed/simple;
	bh=XcywKQXQ+ShWMiZYmOI/DDzq8C2zqbgG8/mDbMkS7Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5mz5+XJTJDMjvvU7/11+LemzE1xVtRxXXMclmfcf7i7IoD82zqtQlGpFOUwYEkatDM41XG9FHY8yRmDOJnbBmJ7/7Xf+zlIEuL4Ao+GOCcpNc0JyAlS0nQ/S+GPP1qmFofe7360RH5xTwzGjEHzTWf1eSNoVK++nlgOZBaU3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.235])
	by sina.com (172.16.235.24) with ESMTP
	id 662BBBB700004E76; Fri, 26 Apr 2024 22:35:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 99961545089293
X-SMAIL-UIID: 28A97E2CD4CE46ACA5E90971B9068196-20240426-223537-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+159077b1355b8cd72757@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [ext4?] possible deadlock in uinput_request_submit
Date: Fri, 26 Apr 2024 22:35:39 +0800
Message-Id: <20240426143539.3478-1-hdanton@sina.com>
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
@@ -157,8 +157,6 @@ static int uinput_request_send(struct ui
 		goto out;
 	}
 
-	init_completion(&request->done);
-
 	/*
 	 * Tell our userspace application about this new request
 	 * by queueing an input event.
@@ -175,6 +173,8 @@ static int uinput_request_submit(struct
 {
 	int retval;
 
+	init_completion(&request->done);
+
 	retval = uinput_request_reserve_slot(udev, request);
 	if (retval)
 		return retval;
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

