Return-Path: <linux-kernel+bounces-56359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3784C935
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B6C1F256EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD25182A7;
	Wed,  7 Feb 2024 11:08:58 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446618054
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304137; cv=none; b=KI/XVGZca9jch6+rottVdMEkA+uGDvda0yWMIn/gZiVBjBstIznPPZWqMkpKn9lDiDi28Px4StZdVwNpvWnQJS5+90CvrL1YTs9AiAl2mpC3QTwa8MBhK/+AbJ5Gnzqe+GNRCnIp/VcapW+kRPQgDDtBUZd1Qfv08w+ZUFz/+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304137; c=relaxed/simple;
	bh=fSkGu1grBMmUs+bEAKUTAl8fA3smrFicyaEfve5sDiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYSz6InyjvE6rtGbkRXwH5V4lN9IWMPgT8lojH70h7YwXCsSP0NxJBkyf+WKK55u+zPQf3L2sHKS3qdPOurucX7l8mcMFWHz1F8NMvvVTJ4Vw3lR1XNmDnen/mW9/MYHD/QWLZPNqYlRWceoWmKYpwmW/hQLdOG6T4fALXIudho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.212])
	by sina.com (172.16.235.25) with ESMTP
	id 65C3649600004B49; Wed, 7 Feb 2024 19:08:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 25631334210355
X-SMAIL-UIID: 2A2F7888B4C648ACA50BBE55DBC3BC60-20240207-190808-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [media?] possible deadlock in vb2_video_unregister_device
Date: Wed,  7 Feb 2024 19:07:56 +0800
Message-Id: <20240207110756.936-1-hdanton@sina.com>
In-Reply-To: <0000000000008b96230610c6b3fe@google.com>
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
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1603629fe80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-testing

--- x/drivers/media/usb/usbtv/usbtv-video.c
+++ y/drivers/media/usb/usbtv/usbtv-video.c
@@ -963,11 +963,11 @@ ctrl_fail:
 
 void usbtv_video_free(struct usbtv *usbtv)
 {
+	usbtv_stop(usbtv);
+	vb2_video_unregister_device(&usbtv->vdev);
 	mutex_lock(&usbtv->vb2q_lock);
 	mutex_lock(&usbtv->v4l2_lock);
 
-	usbtv_stop(usbtv);
-	vb2_video_unregister_device(&usbtv->vdev);
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
 	mutex_unlock(&usbtv->v4l2_lock);
--

