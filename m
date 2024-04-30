Return-Path: <linux-kernel+bounces-163815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C98B71EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6254E1C230F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C71D12C801;
	Tue, 30 Apr 2024 11:02:23 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0612C487
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474942; cv=none; b=WFGsbdSzDqaJJzgCm0gZZgDiE/H8xpGWg/scfsl8hfATWICiMdM0ePbNnxx62Vzf/wcR/EdUmFbjJQbAzs6LF74X8vYR1ySS5/wN8tnyYjVCQGcK7OvtBeJg+2PX6wKy9Ph4JxRAoPHoP4VSxz3GmT1ZQ+RpvY5qxsOCH70xVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474942; c=relaxed/simple;
	bh=3aQ/oV5Xqe4lYcMW7ZHlMIgcR6uw1+KtZHo0uDx65KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaGzIGXYBo+/G+WfnVe3DGsSWq1kn03kw7sxvl+h+za01fyw5CK1JN8p0LO1zTTmcIn8HD8UdEZ1Qyic+FJHYcPSzHHUvAjN4Ki8OkFQTdFJKYE0vlbsPCpttYw9+ehWoQL34XvBQ3KM6kfGkpRnnZu5JuaZzmOvEe7dsti22QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.41])
	by sina.com (172.16.235.25) with ESMTP
	id 6630CFAD00006272; Tue, 30 Apr 2024 19:02:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 49506434210283
X-SMAIL-UIID: CAA04C27511B4037B60B87A6B093AB38-20240430-190207-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
Date: Tue, 30 Apr 2024 19:02:09 +0800
Message-Id: <20240430110209.4310-1-hdanton@sina.com>
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 01:25:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    bb7a2467e6be Add linux-next specific files for 20240426
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c30028980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  bb7a2467e6be

--- x/kernel/vhost_task.c
+++ y/kernel/vhost_task.c
@@ -100,6 +100,8 @@ void vhost_task_stop(struct vhost_task *
 	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
+	mutex_lock(&vtsk->exit_mutex);
+	mutex_unlock(&vtsk->exit_mutex);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
--

