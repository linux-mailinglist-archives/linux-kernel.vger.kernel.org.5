Return-Path: <linux-kernel+bounces-144062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2B8A4161
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E571C20DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F0225AE;
	Sun, 14 Apr 2024 09:03:10 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB017565
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085390; cv=none; b=hy5kY313UVXPV+ZqM5tXYwAse9gHWdMkvpcAfueh9n4VN7P+CeA4kVBCLDGA6IhOfidIIn4iI0CVj3WE0cILiYffSQSsqSrjfucXENaooBs9XesbvI2PnpLlQhiFLuHqi19rBwVvTq7umYA0T6jk+xpgKJmQMt6vBaY87ZGwd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085390; c=relaxed/simple;
	bh=RSBB4Rc3N6JqLPK4yaV71FN7b7LX4nmoJudDO9PGz4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dctXCQoS3xh/LTsDJFtKZ6Hl1PzY5vsaz/pHgT+1pAKjuy+BilmPlffviKHkOZt7ALjBl4VXwNa5qiY0vkUSDpc+uuFLsfg+xOxw7skl/kSW3seMM4/evLLsfu8Eayk6UmgJali2IrJ2Vnj9kz8ArxJPg6wATFQuq0D/k/FhkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (172.16.235.24) with ESMTP
	id 661B9BC20000521A; Sun, 14 Apr 2024 17:03:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 52239845089245
X-SMAIL-UIID: 70CDC4D05D104D6DBC8368B1C436A20F-20240414-170300-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in pvr2_context_set_notify (3)
Date: Sun, 14 Apr 2024 17:02:53 +0800
Message-Id: <20240414090253.2294-1-hdanton@sina.com>
In-Reply-To: <000000000000bb465d061606e827@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 21:26:30 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    a788e53c05ae usb: usb-acpi: Fix oops due to freeing uninit..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120ca915180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-testing

--- x/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ y/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -26,6 +26,8 @@ static int pvr2_context_cleanup_flag;
 static int pvr2_context_cleaned_flag;
 static struct task_struct *pvr2_context_thread_ptr;
 
+static DEFINE_MUTEX(pvr2_disconn_mutex);
+static int pvr2_context_cleaning;
 
 static void pvr2_context_set_notify(struct pvr2_context *mp, int fl)
 {
@@ -152,6 +154,9 @@ static int pvr2_context_thread_func(void
 
 	pvr2_trace(PVR2_TRACE_CTXT,"pvr2_context thread start");
 
+	mutex_lock(&pvr2_disconn_mutex);
+	pvr2_context_cleaning = 1;
+	mutex_unlock(&pvr2_disconn_mutex);
 	do {
 		while ((mp = pvr2_context_notify_first) != NULL) {
 			pvr2_context_set_notify(mp, 0);
@@ -163,6 +168,9 @@ static int pvr2_context_thread_func(void
 			 pvr2_context_shutok()));
 	} while (!pvr2_context_shutok());
 
+	mutex_lock(&pvr2_disconn_mutex);
+	pvr2_context_cleaning = 0;
+	mutex_unlock(&pvr2_disconn_mutex);
 	pvr2_context_cleaned_flag = !0;
 	wake_up(&pvr2_context_cleanup_data);
 
@@ -266,13 +274,17 @@ static void pvr2_context_exit(struct pvr
 
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
+	mutex_lock(&pvr2_disconn_mutex);
+	if (pvr2_context_cleaning)
+		goto out;
 	pvr2_hdw_disconnect(mp->hdw);
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
 	mp->disconnect_flag = !0;
+out:
+	mutex_unlock(&pvr2_disconn_mutex);
 }
 
-
 void pvr2_channel_init(struct pvr2_channel *cp,struct pvr2_context *mp)
 {
 	pvr2_context_enter(mp);
--

