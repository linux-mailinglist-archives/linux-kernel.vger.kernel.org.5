Return-Path: <linux-kernel+bounces-163153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237028B6666
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6831F232A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C0194C7C;
	Mon, 29 Apr 2024 23:35:52 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF35194C70
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433752; cv=none; b=XPlYhqlB3nQYzcUqdTYWUHqJ59l20Gn2S6ij4QrtKuA8TTKxT7aOsmVywHnCiFrAe+rHGinvvGMDTxBWIl6neshePazBmQJ1RQ+zJGadcpYD5gOrT8ruXd6T0OfBEgFlviTMFn4vg841vOn/eS24dkUmjkroaoEOj7jpKQ20Cjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433752; c=relaxed/simple;
	bh=SEcWS2mHmTTxTS6hfMC/1gKe0GHL8Q/oFBbfcQXiUnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrHL1Oo5KL3CarvI8Q6KRNDsBcgwU1vyulxEGshnP6vn3EuT6QoI7JJHXEzQO/XZWlVw6i6kaWY0dqlxAij2VcYL6pMqz5Hl3sKtEGR0D9QT/f4ya2/LxjomZoE7fdWdUSjDU6VInGCnNxaxKQelzlmjgHQ1r4Y71wk/YJUvfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.41])
	by sina.com (172.16.235.24) with ESMTP
	id 66302EC700007C73; Mon, 30 Apr 2024 07:35:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 17088145089350
X-SMAIL-UIID: D81D12D696E54671BBB1BFC205BA4E20-20240430-073538-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] INFO: rcu detected stall in snd_timer_user_release (3)
Date: Tue, 30 Apr 2024 07:35:40 +0800
Message-Id: <20240429233540.4243-1-hdanton@sina.com>
In-Reply-To: <000000000000fa00a1061740ab6d@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Apr 2024 11:46:30 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1039c208980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  e88c4cfcb7b8

--- x/sound/core/hrtimer.c
+++ y/sound/core/hrtimer.c
@@ -51,7 +51,8 @@ static enum hrtimer_restart snd_hrtimer_
 
 	guard(spinlock)(&t->lock);
 	if (t->running) {
-		hrtimer_add_expires_ns(hrt, t->sticks * resolution);
+		hrtimer_set_expires(hrt, ktime_add(hrt->base->get_time(),
+						   ns_to_ktime(NSEC_PER_USEC *200)));
 		ret = HRTIMER_RESTART;
 	}
 
--

