Return-Path: <linux-kernel+bounces-56396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851784C9A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DA1C23118
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF271B295;
	Wed,  7 Feb 2024 11:35:03 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5F17BDD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305702; cv=none; b=u0ARhYxoLIyjg9p5NFwciUdHO8l3Gda2lUTdzSbFK8yQ1EQhB2f4p/qZVYVviqchlMOkav7cnLA3mGtcmR7lKqZ0NPU4+SxtQHW/JXv7kTls4YGDJJ6ajo71daBQHp7n4XQyhJ8LzCHYEpXuuBVzDwZ3nwzZVbHEAz8cB8ApuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305702; c=relaxed/simple;
	bh=J3gmjqC6OICga7l9JAVwJzioScvKMPfnt0ZoXjkRroY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKr+2Y9nwy4a9rHHnR8ie1JoaPQoo+kfjwMk1y6h2LcrhMZ6IXXUsZmwkCg+vVV93Y0W4QvXRH/EL9Y7yXKIwRypUqFNaS0EwJdCBSIUNWn4vMGq1AhYM+40yTKx1gxAi4RNmf8Z4M3F1ZuzubRBXBZItkuW/YuMtCN8XbB9aXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.212])
	by sina.com (10.75.12.45) with ESMTP
	id 65C36AB600000BBC; Wed, 7 Feb 2024 19:34:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 12302531457858
X-SMAIL-UIID: F87197B1741F4EA9A2260134DB820B84-20240207-193420-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+cf1afeda4043ffecf03e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [fs?] KASAN: slab-use-after-free Read in comedi_release_hardware_device
Date: Wed,  7 Feb 2024 19:34:05 +0800
Message-Id: <20240207113405.999-1-hdanton@sina.com>
In-Reply-To: <0000000000008eec060610c6b378@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 07 Feb 2024 00:44:22 -0800
> HEAD commit:    ed5551279c91 Merge 6.8-rc3 into usb-next
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d42d8fe80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-testing

--- x/drivers/comedi/drivers.c
+++ y/drivers/comedi/drivers.c
@@ -1034,6 +1034,7 @@ int comedi_auto_config(struct device *ha
 {
 	struct comedi_device *dev;
 	int ret;
+	static DEFINE_MUTEX(ac_mutex);
 
 	if (!hardware_device) {
 		pr_warn("BUG! %s called with NULL hardware_device\n", __func__);
@@ -1051,12 +1052,14 @@ int comedi_auto_config(struct device *ha
 			 driver->driver_name);
 		return -EINVAL;
 	}
+	mutex_lock(&ac_mutex);
 
 	dev = comedi_alloc_board_minor(hardware_device);
 	if (IS_ERR(dev)) {
 		dev_warn(hardware_device,
 			 "driver '%s' could not create device.\n",
 			 driver->driver_name);
+		mutex_unlock(&ac_mutex);
 		return PTR_ERR(dev);
 	}
 	/* Note: comedi_alloc_board_minor() locked dev->mutex. */
@@ -1084,6 +1087,7 @@ int comedi_auto_config(struct device *ha
 			 driver->driver_name, dev->board_name);
 		mutex_unlock(&dev->mutex);
 	}
+	mutex_unlock(&ac_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(comedi_auto_config);
--

