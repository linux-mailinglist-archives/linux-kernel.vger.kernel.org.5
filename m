Return-Path: <linux-kernel+bounces-87037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F186CE81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BEC1C22097
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA66CBE9;
	Thu, 29 Feb 2024 15:55:31 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262D6CBE2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222131; cv=none; b=dvKqtnydagpkscMPeAJC95Y4xMjikKYbacJMT7EtLKdFydDa/0+tlGNf0IendJDut4wTauyhsqUzxE4CnwZT5QoUIpOavlJh1CLKmwDsDVKlbKfrKovdQ0KY1MZRFndnQ9f/yCW9AXetPCuvkdteMCdYn864BWXwh1PnLAOIANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222131; c=relaxed/simple;
	bh=Wg0KR+YB92BzscUOjTcaSFeJSwPfPXMz0di8ejVw+Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qOq0ayjecda3p61wPJvsvBDFvG5OJtqB38m28KAR7kTnEdg6m712s+79dWG+j30YtbDig4rfWQA/daPSp0IC3CWIXisQYW5Tk3lu/Cl0eyBtyPwFSd0YMOn0ojS4WtRHbO0WKmcqcgFz4DrwArCP+5vBLDexwlrD278qwx8cEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4129ed6f514so7780315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709222128; x=1709826928;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0rzp+hpyABdEwlThr6+E327b1ibC9NKieyhhIEwgDM=;
        b=Kt86IGfJLaYhERN3C2QPl6txkhpJY05d/k9WzUdEfffdSQjz1iRogh3PKEKKJGeqER
         pE6tmBGU5vhI/KmfDZXMplUVs0FzCSBZe27Hi3NOmby6iLjg7sldwZ8bKJ+rTB3NgpMb
         jDt/33HLvuaSuTt6OgGBb3OIm8TeKCwi9rWpQVFpH/dib2mi8akTanqeOcGnfY1enYqv
         u3E4CwqSW2s21GbfdIwRUiz050W5us8vuPVc74JCVJyApjhYkysB7ue8EDEcaS4CCgTr
         7YnQnrj4AgxgQ85iNXwsHhu9iN4ajeX+fQ5LsEnTa1scIOk2fWYPLCS+6NvvGEnorXdi
         a+aw==
X-Gm-Message-State: AOJu0YyDPJhdawSiZTs/c5TugKplLPmYbj6QKLjGtPN7XWEYFq/ge2f1
	cDK2hqPF64ymr+bAqrwHVZaqjzDqE2pUKsxBsVuKNieH/NxOcjuesGS3jhUq
X-Google-Smtp-Source: AGHT+IHGjqqYyTgv+rYklRRu76ejHgvKTcoRtMLkj1v359Ect7tzTtqzdsSXHS0+l0wz6FswZu/Itw==
X-Received: by 2002:adf:e488:0:b0:33d:82a1:626d with SMTP id i8-20020adfe488000000b0033d82a1626dmr1964657wrm.38.1709222127557;
        Thu, 29 Feb 2024 07:55:27 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id q13-20020a5d61cd000000b0033e11ff6284sm1525506wrv.12.2024.02.29.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:55:27 -0800 (PST)
Date: Thu, 29 Feb 2024 07:55:25 -0800
From: Breno Leitao <leitao@debian.org>
To: peterz@infradead.org, bp@alien8.de, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: general protection fault, probably for non-canonical address in
 pick_next_task_fair()
Message-ID: <ZeCo7STWxq+oyN2U@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been running some stress test using stress-ng with a kernel with some
debug options enabled, such as KASAN and friends (See the config below).

I saw it in rc4 and the decode instructions are a bit off (as it is here
also - search for mavabs in dmesg below and you will find something as `(bad)`,
so I though it was a machine issue. But now I see it again, and I am sharing
for awareness.

This is happening in upstream kernel against the following commit
d206a76d7d2726 ("Linux 6.8-rc6")

This is the exercpt that shows before the crash:

	general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
	KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]

This is the stack that is getting it

	? __die_body (arch/x86/kernel/dumpstack.c:421)
	? die_addr (arch/x86/kernel/dumpstack.c:460)
	? exc_general_protection (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:643)
	? asm_exc_general_protection (arch/x86/include/asm/idtentry.h:564)
	? pick_next_task_fair (kernel/sched/sched.h:1453 kernel/sched/fair.c:8435)
	? pick_next_task_fair (kernel/sched/fair.c:5463 kernel/sched/fair.c:8434)
	? update_rq_clock_task (kernel/sched/core.c:?)
	__schedule (kernel/sched/core.c:6022 kernel/sched/core.c:6545 kernel/sched/core.c:6691)
	schedule (kernel/sched/core.c:6803 kernel/sched/core.c:6817)
	syscall_exit_to_user_mode (kernel/entry/common.c:98 include/linux/entry-common.h:328 kernel/entry/common.c:201 kernel/entry/common.c:212) 
	do_syscall_64 (arch/x86/entry/common.c:102)
	? irqentry_exit_to_user_mode (kernel/entry/common.c:228)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)

Full dmesg: https://paste.mozilla.org/RiLnt4QO#
Configs: https://paste.mozilla.org/XJ9wbdRp

