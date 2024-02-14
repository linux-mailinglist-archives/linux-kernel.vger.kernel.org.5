Return-Path: <linux-kernel+bounces-64713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76B8541D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC51C21FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49BAB654;
	Wed, 14 Feb 2024 03:40:03 +0000 (UTC)
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0839945A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882003; cv=none; b=k7+uihQKmfjGWwqeBpwjqbHG/AR2FtvBFVPmnCkijTKij39SY88hP/ITM1y73q16XYvcvFshhb+AMzQfBsaW1ULhFtWEAvXmsJs0GFS1e3Dv3EpvIpVL8F9QD/U/NJrxy8PIh+V57NIJMc9Eez6K5cNqOz2zMUjIRuk0CMv9yIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882003; c=relaxed/simple;
	bh=BR6PWRQuzdXJi9gufSKWPm698+m6vSpa+PVFocD93wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4E/4mKAfeuJwi8ajWowv+Ud7GcL5YpMvv5qHi3dgRa2eTZ1riQteenEEnmKwdKVmv2EW88eZx/Btmtq2NTV9ml8vwzPlA1SxoRT+kNNvA6/GdPK78CBRyBd8CGuzLPC3D7wIHRO5Ac+9L8UD3SQJRTuumDA/zkRtq/voSJ+0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.24) with ESMTP
	id 65CC3604000060FA; Wed, 14 Feb 2024 11:39:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2109161048592
X-SMAIL-UIID: 7327D8FC310C4E8C95B87A560E04ADA9-20240214-113950-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
Date: Wed, 14 Feb 2024 11:39:37 +0800
Message-ID: <20240214033938.338-1-hdanton@sina.com>
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
@@ -1062,6 +1062,8 @@ out_ctx:
 	return ret;
 
 backoff:
+	if (state->commit_work.func)
+		cancel_work_sync(&state->commit_work);
 	drm_atomic_state_clear(state);
 	drm_modeset_backoff(&ctx);
 
--

