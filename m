Return-Path: <linux-kernel+bounces-12629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162881F7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E00D284D75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944CF7477;
	Thu, 28 Dec 2023 11:56:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11B7461
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.182])
	by sina.com (10.75.12.45) with ESMTP
	id 658D627100007CA9; Thu, 28 Dec 2023 19:56:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 29396431457300
X-SMAIL-UIID: AEBE18E176FC4779AA7014AB7BFF9B11-20231228-195637-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
Date: Thu, 28 Dec 2023 19:56:25 +0800
Message-Id: <20231228115625.1757-1-hdanton@sina.com>
In-Reply-To: <000000000000f4faa2060d83f582@google.com>
References: <000000000000f4faa2060d83f582@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Dec 2023 12:51:18 -0800
> HEAD commit:    5254c0cbc92d Merge tag 'block-6.7-2023-12-22' of git://git..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155d5fd6e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/gpu/drm/drm_file.c
+++ y/drivers/gpu/drm/drm_file.c
@@ -287,6 +287,7 @@ void drm_file_free(struct drm_file *file
 	if (dev->driver->postclose)
 		dev->driver->postclose(dev, file);
 
+	drm_gem_release(dev, file);
 	drm_prime_destroy_file_private(&file->prime);
 
 	WARN_ON(!list_empty(&file->event_list));
--

