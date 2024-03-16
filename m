Return-Path: <linux-kernel+bounces-105114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321D587D944
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F977281EED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19069F4E2;
	Sat, 16 Mar 2024 08:14:11 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F54D27D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710576850; cv=none; b=Wq0McALc+Jl8l3OFW6PddWrvyNKyneBspPCM/FGbRKvROIKkLDqFBq8GYusgkcUn3cqxUAzjBluI6sTE2cS8Jbq4+8gPkWsI2g7Ba211xAxNDNuvAU+7lTnYHfJpHCYvg/yGCt4sp3ly1+9WhbquX+IuFgqgnrQRY18wuOxRlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710576850; c=relaxed/simple;
	bh=6ooMEYug8biKx7VZdn3SdFzIEdqjcFYgiuy+RGh9MjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfXVoBxvEciCQ/t5g01u7qPd1EIJNF8EA8S1gjcTa/oc3u+eHSsL7q05+TzmlFtzWEVMncLJBQHFPjNVTIiwGIPiqVe5WBNM7ez/rUwEzRalq/a4qJMl17HHNbvMeVdth21n4ZCCy3tMSjzkekxcZwfzpEcEO5CST2fKyu/Ce2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.117.148])
	by sina.com (172.16.235.25) with ESMTP
	id 65F554C4000015EC; Sat, 16 Mar 2024 16:13:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 25764834210267
X-SMAIL-UIID: 5BAA67F2651C44A080140416A06F442F-20240316-161358-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
Date: Sat, 16 Mar 2024 16:13:47 +0800
Message-Id: <20240316081347.1763-1-hdanton@sina.com>
In-Reply-To: <0000000000002a81490613b2affb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

