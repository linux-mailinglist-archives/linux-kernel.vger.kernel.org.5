Return-Path: <linux-kernel+bounces-57352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527684D73F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586801C240A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EBD374F7;
	Thu,  8 Feb 2024 00:36:28 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47110374E9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352588; cv=none; b=htF4ezCiQ+PO6OtaldPke/6LRg5exghB1WfecfVlyvZHt/1SNDOcW3OJJJ6bpF7VELUkEGexRYZJKaMgWZ884f4bbjNaWwzbomDGD/zZBaLY055EhfSi41T2+r8WoLu+URJfA6P/izMimJ/EseO5T3rW9PaWbsydjwTIsz86j+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352588; c=relaxed/simple;
	bh=UmYgeuLFcmvAjuPSscWwJ1l6kQ74viUsiFUh4j4TXgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiY56NwiVzDS690Q3GvsioJk/FWumVd4+Znp9ApcaE5FFsIUWlU07zJErHWizTyK3pMTPMhjAsW5Dq7+nJN6MlrT7qhw/vE3rRCCfXxPU0V8UJdVHuVF/XrlJ2n8n2GfHw2vFnyLQ6p/TT2zMyfkSFG3wSrfhxWAfKdIXUGtlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.238])
	by sina.com (172.16.235.25) with ESMTP
	id 65C422000000143E; Thu, 8 Feb 2024 08:36:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 54660534210238
X-SMAIL-UIID: 88D052FCE47E4AC1B815518E5E014986-20240208-083620-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
Date: Thu,  8 Feb 2024 08:36:07 +0800
Message-Id: <20240208003607.1129-1-hdanton@sina.com>
In-Reply-To: <000000000000edf6a306105afb50@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 01 Feb 2024 16:13:40 -0800
> HEAD commit:    6764c317b6bb Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102774b7e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/gpu/drm/drm_vblank.c
+++ y/drivers/gpu/drm/drm_vblank.c
@@ -276,7 +276,7 @@ static void drm_update_vblank_count(stru
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	u32 cur_vblank, diff;
 	bool rc;
-	ktime_t t_vblank;
+	ktime_t t_vblank = 128;
 	int count = DRM_TIMESTAMP_MAXRETRIES;
 	int framedur_ns = vblank->framedur_ns;
 	u32 max_vblank_count = drm_max_vblank_count(dev, pipe);
--

