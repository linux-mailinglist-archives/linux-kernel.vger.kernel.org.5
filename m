Return-Path: <linux-kernel+bounces-90975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802108707DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAEB1F24169
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208495FBBE;
	Mon,  4 Mar 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xld8KEEZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BF5C90B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571752; cv=none; b=rVLm/Y47e8NBsVpAtYOxf28wYHnrKNuJvr0qMHrS3LGMvYzRzTsajJ1du/SH9OlJHgoXOoZaoTal3e5Z9P56jeNnPsmvMyS7Mst8YntSAoriHdXg1TX4G17+Fjc4WGgXB1m8PsEgLrgfBnoAUv3PaZ7eC/IT1Qxc6y89btoYWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571752; c=relaxed/simple;
	bh=kmvnz27dzJcpiaOuri4yLruOBlg8ue+RnmBTTY2eS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clhsv8qc3X+8sMKBbJGs/WlCQEdZeRhe0IXz0EEoPDyBzFncxEOZs1jH/a/8h72ISpIKCdAH8ji6Rn8/0vm1SY+dqPY+3xB6yZ+BLny6ffnjKIo6bVj0qXBsVsNfJyzDpcjnSy5qK7Kfj1KGHxDKIaQwPkMYVWltITDgjdvPXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xld8KEEZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709571749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRb2G3rGVCWNmjR6j8Y0jK9sd42QWUsDe6AfIQJkqsw=;
	b=Xld8KEEZPRkPEC/6mFJDQDhrQC6SayvOg7VIkODAe06KgIUb3RQrUpTuA557+arveKujv9
	rWIdL/4CLzT6LKSIrRV233lokCmpBs3h0Avsn9AJbRgVefGM6fnbMIt1ZLUspXrrgPuEhy
	ONK3+A9xEdIX5LYbm/M3+/QRezvWohg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-CV9JIrSVO5yZt0lZPEsl1Q-1; Mon, 04 Mar 2024 12:02:27 -0500
X-MC-Unique: CV9JIrSVO5yZt0lZPEsl1Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a447baf1eb0so197040966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571746; x=1710176546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRb2G3rGVCWNmjR6j8Y0jK9sd42QWUsDe6AfIQJkqsw=;
        b=fAkZYLW6o246e2XCSiMsikwwaAJb5zvEi0xA0c5o7oqLx9D5XWqUdsrR1Nkq20jhDx
         t8j2mhWZwEBYnroSK2+HjXPwApDQxPlTfbNg4c5iUyfqK/FrM+WbJtIHwpSWhgT5fgPQ
         nbbECiurpa5j+vpS8PZSbwdsk8fFHtHMXkhpmcQN8oYlQVlM+65aR//6P5vmx0CNp10j
         AKs+AMR7vMo4SblKoxHXSiuMgvJT0dBwVohoOZgE/swTNnwzfI3XBt5OluIuMMuYYSYA
         9DqunXVFKyL4fv6fTEkw9iwlDJocR00CI+OI2Ayh/UVU5W+SoTNcghZVCvn05QB5/xZU
         45vw==
X-Forwarded-Encrypted: i=1; AJvYcCUF3v0dYsAWmxQB9hwCdixPutKJSazha6w3EEewA1LxJA/wyS6H5KqdDQjhtTTPudTOqpHEBAfQeEeGg7I7yL+rJO+c7uTcqbhaRNv+
X-Gm-Message-State: AOJu0YzmuaGFlkXBz5NG8VHjtbW3ehJqkEXzd+74aYvmFBtM4A2iBGmY
	qKDf0jz+QqwYmgPec/sWO+kyWZVoy69g4sIIeKuiKiYKn7/OZJqNOEbYPBecPnoKx67OhfeHoLQ
	C+mJ8aZ+RK1sS+FPGWcy8XHEQpW6x3M8SoK0EB4Apivt8CS9dPjM0LO21ybwo2A==
X-Received: by 2002:a17:906:34d7:b0:a45:29f3:6cc9 with SMTP id h23-20020a17090634d700b00a4529f36cc9mr2924246ejb.20.1709571746336;
        Mon, 04 Mar 2024 09:02:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEXK6MgN54UtOiHFSF4R6S0QqKf3vQjkdthql3Vdr45tKN/JnSK4chUqihHQ930YEbFsgjVA==
X-Received: by 2002:a17:906:34d7:b0:a45:29f3:6cc9 with SMTP id h23-20020a17090634d700b00a4529f36cc9mr2924219ejb.20.1709571745935;
        Mon, 04 Mar 2024 09:02:25 -0800 (PST)
Received: from altair.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id gl11-20020a170906e0cb00b00a448fab02easm3913637ejb.37.2024.03.04.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:02:25 -0800 (PST)
From: Danilo Krummrich <dakr@redhat.com>
To: stable@vger.kernel.org,
	nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	Karol Herbst <kherbst@redhat.com>
Subject: [PATCH stable v6.7] drm/nouveau: don't fini scheduler before entity flush
Date: Mon,  4 Mar 2024 18:01:46 +0100
Message-ID: <20240304170158.4206-1-dakr@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug is present in v6.7 only, since the scheduler design has been
re-worked in v6.8.

Client scheduler entities must be flushed before an associated GPU
scheduler is teared down. Otherwise the entitiy might still hold a
pointer to the scheduler's runqueue which is freed at scheduler tear
down already.

[  305.224293] ==================================================================
[  305.224297] BUG: KASAN: slab-use-after-free in drm_sched_entity_flush+0x6c4/0x7b0 [gpu_sched]
[  305.224310] Read of size 8 at addr ffff8881440a8f48 by task rmmod/4436

[  305.224317] CPU: 10 PID: 4436 Comm: rmmod Tainted: G     U             6.7.6-100.fc38.x86_64+debug #1
[  305.224321] Hardware name: Dell Inc. Precision 7550/01PXFR, BIOS 1.27.0 11/08/2023
[  305.224324] Call Trace:
[  305.224327]  <TASK>
[  305.224329]  dump_stack_lvl+0x76/0xd0
[  305.224336]  print_report+0xcf/0x670
[  305.224342]  ? drm_sched_entity_flush+0x6c4/0x7b0 [gpu_sched]
[  305.224352]  ? __virt_addr_valid+0x215/0x410
[  305.224359]  ? drm_sched_entity_flush+0x6c4/0x7b0 [gpu_sched]
[  305.224368]  kasan_report+0xa6/0xe0
[  305.224373]  ? drm_sched_entity_flush+0x6c4/0x7b0 [gpu_sched]
[  305.224385]  drm_sched_entity_flush+0x6c4/0x7b0 [gpu_sched]
[  305.224395]  ? __pfx_drm_sched_entity_flush+0x10/0x10 [gpu_sched]
[  305.224406]  ? rcu_is_watching+0x15/0xb0
[  305.224413]  drm_sched_entity_destroy+0x17/0x20 [gpu_sched]
[  305.224422]  nouveau_cli_fini+0x6c/0x120 [nouveau]
[  305.224658]  nouveau_drm_device_fini+0x2ac/0x490 [nouveau]
[  305.224871]  nouveau_drm_remove+0x18e/0x220 [nouveau]
[  305.225082]  ? __pfx_nouveau_drm_remove+0x10/0x10 [nouveau]
[  305.225290]  ? rcu_is_watching+0x15/0xb0
[  305.225295]  ? _raw_spin_unlock_irqrestore+0x66/0x80
[  305.225299]  ? trace_hardirqs_on+0x16/0x100
[  305.225304]  ? _raw_spin_unlock_irqrestore+0x4f/0x80
[  305.225310]  pci_device_remove+0xa3/0x1d0
[  305.225316]  device_release_driver_internal+0x379/0x540
[  305.225322]  driver_detach+0xc5/0x180
[  305.225327]  bus_remove_driver+0x11e/0x2a0
[  305.225333]  pci_unregister_driver+0x2a/0x250
[  305.225339]  nouveau_drm_exit+0x1f/0x970 [nouveau]
[  305.225548]  __do_sys_delete_module+0x350/0x580
[  305.225554]  ? __pfx___do_sys_delete_module+0x10/0x10
[  305.225562]  ? syscall_enter_from_user_mode+0x26/0x90
[  305.225567]  ? rcu_is_watching+0x15/0xb0
[  305.225571]  ? syscall_enter_from_user_mode+0x26/0x90
[  305.225575]  ? trace_hardirqs_on+0x16/0x100
[  305.225580]  do_syscall_64+0x61/0xe0
[  305.225584]  ? rcu_is_watching+0x15/0xb0
[  305.225587]  ? syscall_exit_to_user_mode+0x1f/0x50
[  305.225592]  ? trace_hardirqs_on_prepare+0xe3/0x100
[  305.225596]  ? do_syscall_64+0x70/0xe0
[  305.225600]  ? trace_hardirqs_on_prepare+0xe3/0x100
[  305.225604]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  305.225609] RIP: 0033:0x7f6148f3592b
[  305.225650] Code: 73 01 c3 48 8b 0d dd 04 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad 04 0c 00 f7 d8 64 89 01 48
[  305.225653] RSP: 002b:00007ffe89986f08 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  305.225659] RAX: ffffffffffffffda RBX: 000055cbb036e900 RCX: 00007f6148f3592b
[  305.225662] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055cbb036e968
[  305.225664] RBP: 00007ffe89986f30 R08: 1999999999999999 R09: 0000000000000000
[  305.225667] R10: 00007f6148fa6ac0 R11: 0000000000000206 R12: 0000000000000000
[  305.225670] R13: 00007ffe89987190 R14: 000055cbb036e900 R15: 0000000000000000
[  305.225678]  </TASK>

[  305.225683] Allocated by task 484:
[  305.225685]  kasan_save_stack+0x33/0x60
[  305.225690]  kasan_set_track+0x25/0x30
[  305.225693]  __kasan_kmalloc+0x8f/0xa0
[  305.225696]  drm_sched_init+0x3c7/0xce0 [gpu_sched]
[  305.225705]  nouveau_sched_init+0xd2/0x110 [nouveau]
[  305.225913]  nouveau_drm_device_init+0x130/0x3290 [nouveau]
[  305.226121]  nouveau_drm_probe+0x1ab/0x6b0 [nouveau]
[  305.226329]  local_pci_probe+0xda/0x190
[  305.226333]  pci_device_probe+0x23a/0x780
[  305.226337]  really_probe+0x3df/0xb80
[  305.226341]  __driver_probe_device+0x18c/0x450
[  305.226345]  driver_probe_device+0x4a/0x120
[  305.226348]  __driver_attach+0x1e5/0x4a0
[  305.226351]  bus_for_each_dev+0x106/0x190
[  305.226355]  bus_add_driver+0x2a1/0x570
[  305.226358]  driver_register+0x134/0x460
[  305.226361]  do_one_initcall+0xd3/0x430
[  305.226366]  do_init_module+0x238/0x770
[  305.226370]  load_module+0x5581/0x6f10
[  305.226374]  __do_sys_init_module+0x1f2/0x220
[  305.226377]  do_syscall_64+0x61/0xe0
[  305.226381]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  305.226387] Freed by task 4436:
[  305.226389]  kasan_save_stack+0x33/0x60
[  305.226392]  kasan_set_track+0x25/0x30
[  305.226396]  kasan_save_free_info+0x2b/0x50
[  305.226399]  __kasan_slab_free+0x10b/0x1a0
[  305.226402]  slab_free_freelist_hook+0x12b/0x1e0
[  305.226406]  __kmem_cache_free+0xd4/0x1d0
[  305.226410]  drm_sched_fini+0x178/0x320 [gpu_sched]
[  305.226418]  nouveau_drm_device_fini+0x2a0/0x490 [nouveau]
[  305.226624]  nouveau_drm_remove+0x18e/0x220 [nouveau]
[  305.226832]  pci_device_remove+0xa3/0x1d0
[  305.226836]  device_release_driver_internal+0x379/0x540
[  305.226840]  driver_detach+0xc5/0x180
[  305.226843]  bus_remove_driver+0x11e/0x2a0
[  305.226847]  pci_unregister_driver+0x2a/0x250
[  305.226850]  nouveau_drm_exit+0x1f/0x970 [nouveau]
[  305.227056]  __do_sys_delete_module+0x350/0x580
[  305.227060]  do_syscall_64+0x61/0xe0
[  305.227064]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  305.227070] The buggy address belongs to the object at ffff8881440a8f00
                which belongs to the cache kmalloc-128 of size 128
[  305.227073] The buggy address is located 72 bytes inside of
                freed 128-byte region [ffff8881440a8f00, ffff8881440a8f80)

[  305.227078] The buggy address belongs to the physical page:
[  305.227081] page:00000000627efa0a refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1440a8
[  305.227085] head:00000000627efa0a order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  305.227088] flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  305.227093] page_type: 0xffffffff()
[  305.227097] raw: 0017ffffc0000840 ffff8881000428c0 ffffea0005b33500 dead000000000002
[  305.227100] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
[  305.227102] page dumped because: kasan: bad access detected

[  305.227106] Memory state around the buggy address:
[  305.227109]  ffff8881440a8e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  305.227112]  ffff8881440a8e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  305.227114] >ffff8881440a8f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  305.227117]                                               ^
[  305.227120]  ffff8881440a8f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  305.227122]  ffff8881440a9000: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
[  305.227125] ==================================================================

Cc: <stable@vger.kernel.org> # v6.7 only
Reported-by: Karol Herbst <kherbst@redhat.com>
Closes: https://gist.githubusercontent.com/karolherbst/a20eb0f937a06ed6aabe2ac2ca3d11b5/raw/9cd8b1dc5894872d0eeebbee3dd0fdd28bb576bc/gistfile1.txt
Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 50589f982d1a..75545da9d1e9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -708,10 +708,11 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	}
 	mutex_unlock(&drm->clients_lock);
 
-	nouveau_sched_fini(drm);
-
 	nouveau_cli_fini(&drm->client);
 	nouveau_cli_fini(&drm->master);
+
+	nouveau_sched_fini(drm);
+
 	nvif_parent_dtor(&drm->parent);
 	mutex_destroy(&drm->clients_lock);
 	kfree(drm);
-- 
2.44.0


