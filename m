Return-Path: <linux-kernel+bounces-144037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1DD8A411E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144682818F1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466F21A1C;
	Sun, 14 Apr 2024 08:13:38 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206C15E9B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713082417; cv=none; b=faU9ys0jUfIZZwBttIp/rXmQ23s+u12T/1IT1b1ZoiX9G4iXBKtqu3mbasgT9+zEKK0OZUajfKY7sGoi90Jh6s+vMAZPtSkxJhYB5czJc+4+tHCQtOLBdJWAcRCYBUg+xDP2GwqQi4S32JaqRvF/ZMItkp2lIdzzPvICV1legeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713082417; c=relaxed/simple;
	bh=F3xf/pt6R7sYZi9bhyJuL7dyI8Pd/S5TgPXnODBOn2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raNu8wHAC85f2zvKvbHDWJRr100+EsJikGQ5zT+8RgicNc6Hi0SpyVFsOE8HqCK8LJTBGO8gtKpk1Cry/YWQRYwaLIWTbs6oi4NIbYR0il+Uz6niBBtP/R3jeZuvCirmb4y4J/bs2mjeFDO3UTy3EgdMawMnH351O8djZU/60l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (10.75.12.45) with ESMTP
	id 661B902100007286; Sun, 14 Apr 2024 16:13:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82475831457606
X-SMAIL-UIID: B99C2C28A6B146038C15D9BC2B83E70C-20240414-161323-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+faf0acea764965b3e59e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (5)
Date: Sun, 14 Apr 2024 16:13:17 +0800
Message-Id: <20240414081317.2137-1-hdanton@sina.com>
In-Reply-To: <0000000000000457ff0616069d07@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 21:05:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10431e13180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

--- x/sound/core/timer.c
+++ y/sound/core/timer.c
@@ -409,8 +409,9 @@ static void snd_timer_close_locked(struc
 	struct snd_timer *timer = timeri->timer;
 
 	if (timer) {
-		guard(spinlock)(&timer->lock);
+		spin_lock_irq(&timer->lock);
 		timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
+		spin_unlock_irq(&timer->lock);
 	}
 
 	if (!list_empty(&timeri->open_list)) {
--

