Return-Path: <linux-kernel+bounces-104442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F9A87CDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B56928206A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE3525760;
	Fri, 15 Mar 2024 13:14:14 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4A1BF3C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508454; cv=none; b=boPG17vky92+OHi9d8Km+L6P2gj6UoaqydN17851Ma0Omy4845xbHuLkw6ORjtwz8k/m/Sp2SnOVXEuHzBfoW/4gVMxklXH3z55Uqc2O7O5IH2my3+djb0ZiJ04dcUfZdrntHyB2pNbnYCt5S3CUGSvTYraYSfHNHoWyCWfwBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508454; c=relaxed/simple;
	bh=IYJsJVb1B+OkPrJEvMcFveSOBi36A+2UgMgMymfMJdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4ZR1Zm0Hj9XYH86a2EXVa+Gl9R2UhJJMwgVzOD4xp7NXWwlZ1h4k/waDTKtgOSXL3kL/WQeqByWXyZ9NHsx/3iXB5TXYjk6FyN/XXDgQmjb6bEI6WhrjNd5aFashiIZHPqpNly+BjNOiTHeANmwAO68RXLsxM/6UNC2Lw1hDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.95])
	by sina.com (10.75.12.45) with ESMTP
	id 65F44972000022CB; Fri, 15 Mar 2024 21:13:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 54374831457846
X-SMAIL-UIID: 6B082FB0F3C74AE29C4570FF4A4DB8D3-20240315-211326-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
Date: Fri, 15 Mar 2024 21:13:14 +0800
Message-Id: <20240315131314.2471-1-hdanton@sina.com>
In-Reply-To: <0000000000002a81490613b2affb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

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

