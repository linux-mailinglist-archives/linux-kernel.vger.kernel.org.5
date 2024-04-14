Return-Path: <linux-kernel+bounces-144114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE18A4200
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A2B2818A7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4036122;
	Sun, 14 Apr 2024 11:10:09 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD923759
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713093008; cv=none; b=m83sSoJJB+O7xpzjIV13+ZdLSEg6nBO3rJUlmcoYduSgo1pLlzCj/vezh6oPJF0tQt2jj/sHTnqtRHem0M76XxBTBkwAbS27vFTyQBkugIiHKFS2Y0zvKuoNtTb7eZdwsx8sPQrYWe1bKaF5Mg1V7ZrABmWBxGJeHWvaRi1qIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713093008; c=relaxed/simple;
	bh=iEOovjeJVke7CuMsUPxD22TNehtL+umeD2dfzmth4KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbsi06NYK7znTsBqYvUrthj4hMcoO0rHwlH0ci9CrIKkbVXaaWUJsdY2QZ5rsShig4RW1sV38PD3hK1jSYpigwQTUQoZJv2tXj4HjmbY+2VIl0gvcd74MYR+Zt+wY9z5SMdT7t811gHd07RxjBLVilTbI9V2i7/vZ8/6PHqagEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (10.75.12.45) with ESMTP
	id 661BB98500009651; Sun, 14 Apr 2024 19:09:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 37509231457776
X-SMAIL-UIID: 62D27C9574674C78B216D7D4E5272FB3-20240414-190959-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in pvr2_context_set_notify (3)
Date: Sun, 14 Apr 2024 19:09:52 +0800
Message-Id: <20240414110952.2437-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  master

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

