Return-Path: <linux-kernel+bounces-64668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA5854145
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B12867C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0A10A1E;
	Wed, 14 Feb 2024 01:32:59 +0000 (UTC)
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FC10A01
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874379; cv=none; b=mvBUYmtHkybFa1J7vsdjEmX0EdVxcB/u++Oy/0I+cMuna7Tu0G1OrNFT7MIjcG6xGnpYBoBKGNTzmvS04OTD3HVG4DpL4fIYUAn35DpHMa5wnwisM92To6skiXGt1j5Ia8Sz6x1l16DK4KgrHs63P2KUN/mJkHDurlaXvIrWyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874379; c=relaxed/simple;
	bh=m4XzW5h8tG6+LTD1DuY88CyilhHCLsGjkwVfYphz6Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBhrjzoY2abR+82C5UnkqUOGot/7A7vcnzLe/tbLs+qKGMhauS6nHAuxZB+pEc+Vu8+uYktnIBC+xL6fMQbJpdPou3EHhHSFpAdIMi1uPbYn7YuUGzeJ1yumhouIMX+abZ+ygMgwxUxIpmZX+G8HGT9MrhoV9oVEUBlCJOUEOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.24) with ESMTP
	id 65CC184100004974; Wed, 14 Feb 2024 09:32:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2070781048725
X-SMAIL-UIID: 03ADE51C0E9547A58CCD3DF26916023F-20240214-093251-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
Date: Wed, 14 Feb 2024 09:32:36 +0800
Message-ID: <20240214013238.304-1-hdanton@sina.com>
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
@@ -1062,6 +1062,7 @@ out_ctx:
 	return ret;
 
 backoff:
+	cancel_work_sync(&state->commit_work);
 	drm_atomic_state_clear(state);
 	drm_modeset_backoff(&ctx);
 
--

