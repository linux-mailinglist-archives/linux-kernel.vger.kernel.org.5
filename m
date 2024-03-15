Return-Path: <linux-kernel+bounces-104992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D2987D75E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27221C2129E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990395A4CA;
	Fri, 15 Mar 2024 23:34:55 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4C59B6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710545695; cv=none; b=VnAp+NK7phOfd0KXdHx0g4MnEnzGG8ywvpBJlisdqATI6h3L9UD1Dcmaohe24KmCWgnMSId66UNqTEsqgmmfLtx1K9qa4okd5AwLdM1nKcA6Fg+sP7P9rshBS448KDuW13Pq6uQ8UeuGDKR9SMOPcmJkmJd6F6B9zhJQ+kiCOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710545695; c=relaxed/simple;
	bh=WvtZgpGG4+0uCyv/Jq695xZg3iYzS3bFg/Bpk5voH6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAcXso5LTgvm0tfIRKyGNVcL2EJ6juizC29bqm5OGi7Its8nH+aX0o0WBS+NeEw0dLLAiMJ2NtWY/ENnw37XNqSE5UTTfVBHpOOklijMQfyZePnNhcIJylKTVj4FFDpHFtaOKL1+gAcgDnmgB7+MVHKmVGht3tNEiIYFXIZbcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.31])
	by sina.com (172.16.235.24) with ESMTP
	id 65F4DB0E0000291F; Fri, 16 Mar 2024 07:34:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 84599045089525
X-SMAIL-UIID: 236CAF3798BB4151A15E9B30829F3535-20240316-073440-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
Date: Sat, 16 Mar 2024 07:34:29 +0800
Message-Id: <20240315233429.2554-1-hdanton@sina.com>
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
--- x/mm/page_alloc.c
+++ y/mm/page_alloc.c
@@ -4816,8 +4816,9 @@ static void *make_alloc_exact(unsigned l
 {
 	if (addr) {
 		unsigned long nr = DIV_ROUND_UP(size, PAGE_SIZE);
+		unsigned long pgs = (1UL << order);
 		struct page *page = virt_to_page((void *)addr);
-		struct page *last = page + nr;
+		struct page *last = page + max(nr, pgs);
 
 		split_page_owner(page, order, 0);
 		split_page_memcg(page, order, 0);
--

