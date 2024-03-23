Return-Path: <linux-kernel+bounces-112366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43C8878F0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDFB1C20FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7B33E495;
	Sat, 23 Mar 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+oqKXW6"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C801B95C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203350; cv=none; b=ddRoIIFbuw39atiVCfG9OV1+aTLY8g6GqQX3xecLshewNOZX/Z0CAnXGrn2L8f2MDRXMC00AgrTFxGhgWgrw9OvpfIbHaB24XCSnvUztHSGbvgiVA8EtE7fAkAlIG5c7NJcezvaBe+AggJ5BxntzRtHG58uJ8x5Ie4So5hMJGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203350; c=relaxed/simple;
	bh=nMsZHOHHUsErMq1eXFha7P+a6ozFoPRny59WUBoRJ9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oHHz4Igwi/pgJAdDbqaK7fRRX4UTgx/Uxrb6wTjKdtbMP+4GmT7T/vi6i4/GVpVjjnbvxKAPU5mTmH3pSu8JH/DQt7QBtGs1AoMJwKX7axrk4ynlZOODYtdRI9gdl7zu2B4ypVkwoMAV2lJIUC6eSbgfrTsGHWKgp2C1Ib4+66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+oqKXW6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e10a4083so3473387e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711203347; x=1711808147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q39pmMHfSXy620p4ACbgyFL1kmjGFJZhr6o67AZsyVU=;
        b=d+oqKXW6pvvH8HeMYe8+UEll17jsBC1PxJqmphWPP1TYZwuKpmUfcKaiC/8n2VmlfP
         M++9OBvFaIJlsN2kt5lStnfMVrU8vf1z18F47G0DQgUwHL31BIkcmX+XVsVI9zNuqjeK
         9HMhKIPNiRzAOIY65ZSJcQouJFkklHKI37cd3CoIHd8Ii5d4ZF1JOytZf4pUMybzLKfo
         4/KNoAu4pBiV0ZDITJsEJiWFgr00OBTe1uNt9+VxHWZqew10FxKSQLLMQzTgcyPNyilT
         0b8/T5BY2wJr5aZ6EsXaA/ZIv6J2hvrGdhVr3JFKfBozlAl9tGx9JbazZaZckoyheX+L
         55gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711203347; x=1711808147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q39pmMHfSXy620p4ACbgyFL1kmjGFJZhr6o67AZsyVU=;
        b=UaE1/0VUXVEtaZ0TmUQAALDNV+sKHhqKtd7kp8yNSzD72MqfjEnar7BEnnuyfMFJ6M
         bWr3TtrOPdFqWUuNCuB/qF0y9F57ou+5hfSckqrL2U/IyrMzIWGOKbdECasNGYEjxmzU
         yhLCxeNKmrucXbTVsQaTL+cCNmndY5Z+zCMqz+hdcmmguHUb9ZNcPabti5aDeALWy/6d
         VVK9ZzThdnJIfF0jCaTWWYdwvJgQ/+BHXnWfaAT4XMfyXvpRQIQSQFrHYwBif1GW1DHp
         HsxbiFqKVXN5ygMnLzt2uwJnNC5WcLhxvPh8C4RbRijYY13Bujy1t2HV9VSamf4A+3vT
         fO3Q==
X-Gm-Message-State: AOJu0YyxoG/eED8uTCg4fY3504Bjb6ujPEdI2Hp8zMexJq/TJc4pq2m+
	w2wERNF4Pb6IL17g1XK1aNSO2ZT5qqivqiNIqQ4ovnR9q+6/Cw5WC6xU/Q1V
X-Google-Smtp-Source: AGHT+IEOcvSOI+g3mDtFgwckNpK2y/h8PWX/aXFX85Y+t0cl7kJaPnDU9DVeAuDHV8jbkyf237PTPA==
X-Received: by 2002:a19:431a:0:b0:513:cffc:e74 with SMTP id q26-20020a19431a000000b00513cffc0e74mr1445334lfa.52.1711203346804;
        Sat, 23 Mar 2024 07:15:46 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id w3-20020a05651203c300b005131c5285f8sm306892lfp.107.2024.03.23.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:15:46 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if vmap is not init
Date: Sat, 23 Mar 2024 15:15:44 +0100
Message-Id: <20240323141544.4150-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the boot the s390 system triggers "spinlock bad magic" messages
if the spinlock debugging is enabled:

[    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
[    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
[    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    0.466270] Call Trace:
[    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
[    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
[    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
[    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
[    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
[    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
[    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
[    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
[    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
[    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40

it happens because such system tries to access some vmap areas
whereas the vmalloc initialization is not even yet done:

[    0.465490] lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
[    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    0.466270] Call Trace:
[    0.466470] dump_stack_lvl (lib/dump_stack.c:117)
[    0.466516] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
[    0.466545] find_vmap_area (mm/vmalloc.c:1059 mm/vmalloc.c:2364)
[    0.466572] find_vm_area (mm/vmalloc.c:3150)
[    0.466597] __set_memory (arch/s390/mm/pageattr.c:360 arch/s390/mm/pageattr.c:393)
[    0.466624] vmem_map_init (./arch/s390/include/asm/set_memory.h:55 arch/s390/mm/vmem.c:660)
[    0.466651] paging_init (arch/s390/mm/init.c:97)
[    0.466677] setup_arch (arch/s390/kernel/setup.c:972)
[    0.466702] start_kernel (init/main.c:899)
[    0.466727] startup_continue (arch/s390/kernel/head64.S:35)
[    0.466811] INFO: lockdep is turned off.
..
[    0.718250] vmalloc init - busy lock init 0000000002871860
[    0.718328] vmalloc init - busy lock init 00000000028731b8

Some background. It worked before because the lock that is in question
was statically defined and initialized. As of now, the locks and data
structures are initialized in the vmalloc_init() function.

To address that issue add the check whether the "vmap_initialized"
variable is set, if not find_vmap_area() bails out on entry returning NULL.

Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22aa63f4ef63..0d77d171b5d9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2343,6 +2343,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	struct vmap_area *va;
 	int i, j;
 
+	if (unlikely(!vmap_initialized))
+		return NULL;
+
 	/*
 	 * An addr_to_node_id(addr) converts an address to a node index
 	 * where a VA is located. If VA spans several zones and passed
-- 
2.39.2


