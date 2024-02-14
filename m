Return-Path: <linux-kernel+bounces-64815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA8854330
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2419E1C21B94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A02111B7;
	Wed, 14 Feb 2024 07:02:12 +0000 (UTC)
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317311199
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894132; cv=none; b=KRFp3M9/JPQdQTzQNFHqSuQlu/JZEVvabltHD4oKRML58wMaSQUycj3adyODQ0b/tcuq6P+kE0yG6Ou/bsHkpSkyChqBwpREfpNS9MmNTXEdKylbpQRH48LrCcYyN0DwBRtZr8dt8VA69dqYKuLQoe97PyHKrV27vimehLjSXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894132; c=relaxed/simple;
	bh=He7xFnKcfSqJp/WOWklUsFXNcJA4+NjJ+j1XqjPxHMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yx2ys4nPAF0TVHcElwy8CQFWJ3sHJbBUM0Eex4aro6IT1t0gaMkiDE/mfK9E9BqpQLq3sw9K7oU3HplRc1v7b+6A+qg0Pc9ezAJK3XoUWHKItgptcyQZsg+uIl0xeTwGSx0dUFdmEJ0vsCDsc0yngzileq+J4BpG089oNEdTmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65CC656300002C93; Wed, 14 Feb 2024 15:01:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5365116816084
X-SMAIL-UIID: A1C2978FD1754EC383A97214542DE265-20240214-150157-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
Date: Wed, 14 Feb 2024 15:01:44 +0800
Message-ID: <20240214070145.360-1-hdanton@sina.com>
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

--- x/drivers/gpu/drm/drm_client_modeset.c
+++ y/drivers/gpu/drm/drm_client_modeset.c
@@ -987,6 +987,7 @@ static int drm_client_modeset_commit_ato
 	struct drm_mode_set *mode_set;
 	int ret;
 
+retry:
 	drm_modeset_acquire_init(&ctx, 0);
 
 	state = drm_atomic_state_alloc(dev);
@@ -996,7 +997,6 @@ static int drm_client_modeset_commit_ato
 	}
 
 	state->acquire_ctx = &ctx;
-retry:
 	drm_for_each_plane(plane, dev) {
 		struct drm_plane_state *plane_state;
 
@@ -1051,21 +1051,15 @@ retry:
 		ret = drm_atomic_commit(state);
 
 out_state:
-	if (ret == -EDEADLK)
-		goto backoff;
-
 	drm_atomic_state_put(state);
 out_ctx:
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	return ret;
-
-backoff:
-	drm_atomic_state_clear(state);
-	drm_modeset_backoff(&ctx);
+	if (ret == -EDEADLK)
+		goto retry;
 
-	goto retry;
+	return ret;
 }
 
 static int drm_client_modeset_commit_legacy(struct drm_client_dev *client)
--

