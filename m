Return-Path: <linux-kernel+bounces-56350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53D84C912
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585382879DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC1E17BB5;
	Wed,  7 Feb 2024 10:58:30 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E01758F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303510; cv=none; b=SaW9LypwrVgInwD/MB9VgFC6U9xvBqp7z4957/VWpTfUtWgbRuJllmjrxcEiwo5yQnyHQqIpXDziXHcBxHJI/8qQ0MzF8BXd7fY1HV3siTI9SCO49VruTPgZnZd3jwXSnoql1N1E6N+3z7pXfuPZJhypfqYKqaSyhgnYfGSnOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303510; c=relaxed/simple;
	bh=7WYqO2xx/IX07ptPd9srWb/mOinVwENW+JtzCJBekQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bmj00O3G5R3sbgm1/ph3MCo2J2G3boM6EICC5yP3qzxUt1JGOBzY+cUUB+cFYTHv0DvkO/c2XTzbnRqxyN37pa+nFlFa1AQs2FsF9WO2gK3MkDcZaYExdfCqwbXUXijQnbttfx7DugKjh8e8Pb3bD59a1hRmuFSZvRl4Oay86fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.212])
	by sina.com (10.75.12.45) with ESMTP
	id 65C3624200005926; Wed, 7 Feb 2024 18:58:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67679131457836
X-SMAIL-UIID: 029E8C1AAE774A028D3F891D75FCB4EB-20240207-185814-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4bbc13a207327f82b3b0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ceph?] [fs?] INFO: task hung in ceph_mdsc_pre_umount
Date: Wed,  7 Feb 2024 18:58:01 +0800
Message-Id: <20240207105801.878-1-hdanton@sina.com>
In-Reply-To: <0000000000001524350610a52994@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Feb 2024 08:43:25 -0800
> HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1255e7c4180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  076d56d74f17

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1999,6 +1999,8 @@ static int try_to_grab_pending(struct wo
 	 */
 	pwq = get_work_pwq(work);
 	if (pwq && pwq->pool == pool) {
+		unsigned long work_data;
+
 		debug_work_deactivate(work);
 
 		/*
@@ -2016,11 +2018,12 @@ static int try_to_grab_pending(struct wo
 
 		list_del_init(&work->entry);
 
+		work_data = *work_data_bits(work);
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
 
 		/* must be the last step, see the function comment */
-		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
+		pwq_dec_nr_in_flight(pwq, work_data);
 
 		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
--

