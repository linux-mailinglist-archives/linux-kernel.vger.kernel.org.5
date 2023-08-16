Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5677D876
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbjHPCdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbjHPCcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:32:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9961BE6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:32:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6887ccba675so143576b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692153167; x=1692757967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pV77kiY4lplbobuhq+7ZGFpdFqoV57zLBDIEsyKwuZY=;
        b=H+i5NAo1ySA39MWlUAdOfZmb9zk23v9zbEBDCwuO5Ll171pZ+OSMphxz886kmXQ7hF
         3f8KiWZPr6ApQQlXswIctZrgG6ZKcW4MSYsxdoayxXa1Pca+yTib9u3SROBpGnqzUXE8
         kemkFOpCpcBhS1hcnQurSHaCPhGACJZ85+6PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692153167; x=1692757967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pV77kiY4lplbobuhq+7ZGFpdFqoV57zLBDIEsyKwuZY=;
        b=H+C1CVrXKuO0RMRCF3p8VN4XepbPabivOMHdUWJ4eYBMTgZ/lxXwXaX0xrp+4eJnKn
         dpqGegBvARNqir0opCO7Z4sONjUMUQaDnB/QkxaqM/mt6FITPihnw5sI4eL/hLqj9LZw
         4p13B+CB2q0ouFu8Ag6RS2z1OvVa/wlR0xxTAUR7GbMaiBXRHlQJZtk6iuTXmnNMw5Wk
         0DzaRdI+s7V1ZNvjCxKzgzXchvi2a9JRoPmklQsO7wNzw1sit3cMwfDfVmceytTkDGZ8
         tmd5VxbYpiCvOBqov4zn1T5NlqyoxYJa4qdpCZgeI9cX9jgQ+3/jjS1pkTxQge1E9lNp
         ip0A==
X-Gm-Message-State: AOJu0YxwggyXXSL1sKqGPBCEpyFAR5GW6miwthSFQExuSLVTyVM5Nfv6
        qQtKCvjPmZk6X46T8TEGJ/fqTg==
X-Google-Smtp-Source: AGHT+IH96ke2qK1QjECRRA664/uR9DJl0KDcMPaeRFfQgb6jkhyzLCcFDUfvGdfFac5/lW/eXwaQoA==
X-Received: by 2002:a05:6a21:3d87:b0:13b:79db:e222 with SMTP id bj7-20020a056a213d8700b0013b79dbe222mr629743pzc.53.1692153167000;
        Tue, 15 Aug 2023 19:32:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:1601:f73d:719a:8de1])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001bb28b9a40dsm11776487plh.11.2023.08.15.19.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:32:46 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Clark <robdclark@chromium.org>, Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock
Date:   Wed, 16 Aug 2023 11:32:21 +0900
Message-ID: <20230816023235.3798264-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__dma_entry_alloc_check_leak() calls into printk -> serial console
output (qcom geni) and grabs port->lock under free_entries_lock
spin lock, which is a reverse locking dependency chain as qcom_geni
IRQ handler can call into dma-debug code and grab free_entries_lock
under port->lock.

Move __dma_entry_alloc_check_leak() call out of free_entries_lock
scope so that we don't acquire serial console's port->lock under it.

Trimmed-down lockdep splat:

 The existing dependency chain (in reverse order) is:

               -> #2 (free_entries_lock){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x80
        dma_entry_alloc+0x38/0x110
        debug_dma_map_page+0x60/0xf8
        dma_map_page_attrs+0x1e0/0x230
        dma_map_single_attrs.constprop.0+0x6c/0xc8
        geni_se_rx_dma_prep+0x40/0xcc
        qcom_geni_serial_isr+0x310/0x510
        __handle_irq_event_percpu+0x110/0x244
        handle_irq_event_percpu+0x20/0x54
        handle_irq_event+0x50/0x88
        handle_fasteoi_irq+0xa4/0xcc
        handle_irq_desc+0x28/0x40
        generic_handle_domain_irq+0x24/0x30
        gic_handle_irq+0xc4/0x148
        do_interrupt_handler+0xa4/0xb0
        el1_interrupt+0x34/0x64
        el1h_64_irq_handler+0x18/0x24
        el1h_64_irq+0x64/0x68
        arch_local_irq_enable+0x4/0x8
        ____do_softirq+0x18/0x24
        ...

               -> #1 (&port_lock_key){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x80
        qcom_geni_serial_console_write+0x184/0x1dc
        console_flush_all+0x344/0x454
        console_unlock+0x94/0xf0
        vprintk_emit+0x238/0x24c
        vprintk_default+0x3c/0x48
        vprintk+0xb4/0xbc
        _printk+0x68/0x90
        register_console+0x230/0x38c
        uart_add_one_port+0x338/0x494
        qcom_geni_serial_probe+0x390/0x424
        platform_probe+0x70/0xc0
        really_probe+0x148/0x280
        __driver_probe_device+0xfc/0x114
        driver_probe_device+0x44/0x100
        __device_attach_driver+0x64/0xdc
        bus_for_each_drv+0xb0/0xd8
        __device_attach+0xe4/0x140
        device_initial_probe+0x1c/0x28
        bus_probe_device+0x44/0xb0
        device_add+0x538/0x668
        of_device_add+0x44/0x50
        of_platform_device_create_pdata+0x94/0xc8
        of_platform_bus_create+0x270/0x304
        of_platform_populate+0xac/0xc4
        devm_of_platform_populate+0x60/0xac
        geni_se_probe+0x154/0x160
        platform_probe+0x70/0xc0
        ...

               -> #0 (console_owner){-...}-{0:0}:
        __lock_acquire+0xdf8/0x109c
        lock_acquire+0x234/0x284
        console_flush_all+0x330/0x454
        console_unlock+0x94/0xf0
        vprintk_emit+0x238/0x24c
        vprintk_default+0x3c/0x48
        vprintk+0xb4/0xbc
        _printk+0x68/0x90
        dma_entry_alloc+0xb4/0x110
        debug_dma_map_sg+0xdc/0x2f8
        __dma_map_sg_attrs+0xac/0xe4
        dma_map_sgtable+0x30/0x4c
        get_pages+0x1d4/0x1e4 [msm]
        msm_gem_pin_pages_locked+0x38/0xac [msm]
        msm_gem_pin_vma_locked+0x58/0x88 [msm]
        msm_ioctl_gem_submit+0xde4/0x13ac [msm]
        drm_ioctl_kernel+0xe0/0x15c
        drm_ioctl+0x2e8/0x3f4
        vfs_ioctl+0x30/0x50
        ...

 Chain exists of:
   console_owner --> &port_lock_key --> free_entries_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(free_entries_lock);
                                lock(&port_lock_key);
                                lock(free_entries_lock);
   lock(console_owner);

                *** DEADLOCK ***

 Call trace:
  dump_backtrace+0xb4/0xf0
  show_stack+0x20/0x30
  dump_stack_lvl+0x60/0x84
  dump_stack+0x18/0x24
  print_circular_bug+0x1cc/0x234
  check_noncircular+0x78/0xac
  __lock_acquire+0xdf8/0x109c
  lock_acquire+0x234/0x284
  console_flush_all+0x330/0x454
  console_unlock+0x94/0xf0
  vprintk_emit+0x238/0x24c
  vprintk_default+0x3c/0x48
  vprintk+0xb4/0xbc
  _printk+0x68/0x90
  dma_entry_alloc+0xb4/0x110
  debug_dma_map_sg+0xdc/0x2f8
  __dma_map_sg_attrs+0xac/0xe4
  dma_map_sgtable+0x30/0x4c
  get_pages+0x1d4/0x1e4 [msm]
  msm_gem_pin_pages_locked+0x38/0xac [msm]
  msm_gem_pin_vma_locked+0x58/0x88 [msm]
  msm_ioctl_gem_submit+0xde4/0x13ac [msm]
  drm_ioctl_kernel+0xe0/0x15c
  drm_ioctl+0x2e8/0x3f4
  vfs_ioctl+0x30/0x50
  ...

Reported-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/dma/debug.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f190651bcadd..06366acd27b0 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -637,15 +637,19 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
-static void __dma_entry_alloc_check_leak(void)
+/*
+ * This should be called outside of free_entries_lock scope to avoid potential
+ * deadlocks with serial consoles that use DMA.
+ */
+static void __dma_entry_alloc_check_leak(u32 nr_entries)
 {
-	u32 tmp = nr_total_entries % nr_prealloc_entries;
+	u32 tmp = nr_entries % nr_prealloc_entries;
 
 	/* Shout each time we tick over some multiple of the initial pool */
 	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
 		pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
-			nr_total_entries,
-			(nr_total_entries / nr_prealloc_entries));
+			nr_entries,
+			(nr_entries / nr_prealloc_entries));
 	}
 }
 
@@ -656,8 +660,10 @@ static void __dma_entry_alloc_check_leak(void)
  */
 static struct dma_debug_entry *dma_entry_alloc(void)
 {
+	bool alloc_check_leak = false;
 	struct dma_debug_entry *entry;
 	unsigned long flags;
+	u32 nr_entries;
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 	if (num_free_entries == 0) {
@@ -667,13 +673,17 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 			pr_err("debugging out of memory - disabling\n");
 			return NULL;
 		}
-		__dma_entry_alloc_check_leak();
+		alloc_check_leak = true;
+		nr_entries = nr_total_entries;
 	}
 
 	entry = __dma_entry_alloc();
 
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
+	if (alloc_check_leak)
+		__dma_entry_alloc_check_leak(nr_entries);
+
 #ifdef CONFIG_STACKTRACE
 	entry->stack_len = stack_trace_save(entry->stack_entries,
 					    ARRAY_SIZE(entry->stack_entries),
-- 
2.41.0.694.ge786442a9b-goog

