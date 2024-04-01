Return-Path: <linux-kernel+bounces-126477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8760C893878
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F480B20F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73D8F6E;
	Mon,  1 Apr 2024 06:46:13 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FFB1113
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711953972; cv=none; b=kdoA+86xRbuMXCamMsMlBv4Y1oVEe8l/1hkTQlTJ03pA00YpaN1xpQwJo7doTlnT9jtXe8o9x/8uhosgaBHLQR7FCPj+cHXBrLpE9d97X8OCIILzutr6inQVCyy4Q5zRJZrqRh6/TD4GjCVZiMKVkexbM5WWn43Nu6zk34nldRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711953972; c=relaxed/simple;
	bh=tl1vN8fFb0/Vz0vN+unGzixhxvc68Srm4LbCshnhKQw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DN2fxGG2YODMchSk+cshe0hxProoITGY/ku4vmduPBYVSKRyqCsH7h/FxnU8ecf3DGEv9n+dBoR5F32um+JtqwNybjk8+TAzDYPhpU8vRS5uXPIVtSmj5lqj813zJiA1+MPLL6Xug7jACastfhBdkHqWR42zcvSUAYNNUf49w6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-369b59f2547so3684815ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 23:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711953970; x=1712558770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pby83MlY0XkssxPCJzUArMF2ixNrubj91LLN/7UnyX4=;
        b=oKL5kxv/aPJwznPXRWgr2kGYE9887dLeT6SvIF/Na1YzhozoGK4hOjvLqRTWnYJMno
         t+huYWUwQ27OC9ZknHLQhsymjS+OT2qaUjc9+oSdzWWQ0E0IvXYtPkPmu+Hv5v8EFOxX
         hSnYUyPvzHYWhzAAftNzYlQ+/QSte2Y2fJLWinh3YHtNC7t4KIzi/5lYt7FJh71sUK8K
         dqojyttUqQostOnAK3djt7N8uQJa3OObqzw2oY1wi3t8Y12mvY73o71HjfoZb4VgiNEY
         9z3EX5D//TJVcJ7YIPOw+XohIt5meS17yKReFlHotwuUZ5l0b29SR+MgbU56tR9TvBlG
         UvBg==
X-Gm-Message-State: AOJu0YxHqDfT387CVH7RYI37ZTribVchp7wusb5tbk+rI+2pBNfOktet
	7tV6ngrla0eE950pg3ztD6CZlbikH8vwKXtvK3XKLWdoWVwBQLDHMuXBzo4Az3lF2pbN+4tj6LA
	0bW2bOmAVJqdlesARyGeckWoypqx3jcC5AEuDf1JVTVKAV8gQcHGmUTi2AA==
X-Google-Smtp-Source: AGHT+IHeU/0FuWV4UV97gsAiCJJ6x078gE0gj0qWaUFmiCZ9x5/+qK4z6oCkku5MWPyyFV253uirenvrDJkWGih1o5PgYd6QcXK4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152d:b0:368:b289:38b2 with SMTP id
 i13-20020a056e02152d00b00368b28938b2mr485272ilu.1.1711953970304; Sun, 31 Mar
 2024 23:46:10 -0700 (PDT)
Date: Sun, 31 Mar 2024 23:46:10 -0700
In-Reply-To: <0000000000003ad27a0614fa0b99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045aaf30615035889@google.com>
Subject: Re: [syzbot] [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
From: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d44efa0d0611..07a3c1d2c2d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5676,7 +5676,7 @@ void scheduler_tick(void)
 
 	sched_clock_tick();
 
-	rq_lock(rq, &rf);
+	rq_lock_irqsave(rq, &rf);
 
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
@@ -5688,7 +5688,7 @@ void scheduler_tick(void)
 	sched_core_tick(rq);
 	task_tick_mm_cid(rq, curr);
 
-	rq_unlock(rq, &rf);
+	rq_unlock_irqrestore(rq, &rf);
 
 	if (sched_feat(LATENCY_WARN) && resched_latency)
 		resched_latency_warn(cpu, resched_latency);

