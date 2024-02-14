Return-Path: <linux-kernel+bounces-65115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B509085480D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37789B20C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA418EB9;
	Wed, 14 Feb 2024 11:19:23 +0000 (UTC)
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B418E29
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909562; cv=none; b=gx1Eg5w9kbeDBNlSkb/oZyMw4cNbHKquf7rQ3NwgKDYn3wi1onveCf+4P8HiSkMssJEkpsknIfnsz5BFcM5oqnq1GqAlgVCv6M2Ziolq1GhzMCxliLpT9J9tu/fQYRNsSM4SEv4H11QqeHfWJV+PkGYsZ+wHwMQx2ETFiWmqzBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909562; c=relaxed/simple;
	bh=7pRM/z/Nx2dQ49wkrz0DDi4NO1K8IHniDf2OX72hTgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=typVOU5V3pFCG6t3XUO9/9Tg9O1p1VYGph3PT6WakxzNMAkSK0HoxscsknKrWX6ZlNFfVyRJr6En/W7f943QgMCFSH61i0m+9T7l6iEuBxqEpiYNBmd1hmTHMbQcQKQqlR7p5H0JZCx01gZDFUTW13/7lS6rptNWSpVXOkCDtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65CCA1AA00007F4F; Wed, 14 Feb 2024 19:19:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1969236816240
X-SMAIL-UIID: E43C9AFA91454432A01EE2325C44F0E7-20240214-191909-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
Date: Wed, 14 Feb 2024 19:18:55 +0800
Message-ID: <20240214111856.168-1-hdanton@sina.com>
In-Reply-To: <000000000000ec4c32061143ec95@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 06:08:15 -0800
> HEAD commit:    c664e16bb1ba Merge tag 'docs-6.8-fixes2' of git://git.lwn...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fcdba2180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/gpu/drm/drm_atomic_helper.c
+++ y/drivers/gpu/drm/drm_atomic_helper.c
@@ -1849,7 +1849,11 @@ static void commit_work(struct work_stru
 	struct drm_atomic_state *state = container_of(work,
 						      struct drm_atomic_state,
 						      commit_work);
+	struct drm_device *dev = state->dev;
+
+	mutex_lock(&dev->master_mutex);
 	commit_tail(state);
+	mutex_unlock(&dev->master_mutex);
 }
 
 /**
--

