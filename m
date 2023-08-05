Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5098770EE7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjHEIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHEIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:50:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D1244B8;
        Sat,  5 Aug 2023 01:49:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so4691976e87.2;
        Sat, 05 Aug 2023 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691225397; x=1691830197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90Kecdjbn+Kx7JcQv6zFEPJdrNxFYc2udM53qQ5WfuY=;
        b=g46bkqSwkdUJ9GpgS0GHcaHKVdUSDrZs8I+bhix8qL88Jv38/zD5cfVFsyYarlqoZF
         Vm353NL7cxShUrl9mLWe+WovO5H9pa5kFEZmtlw6hjNTaMQ3rmPUMdZ2EG7DuTjnzIzn
         TFBhhs6mTjdpesoTLJoEyi0mukNUj8Hz3ofA6vCi9h8hE7eL4bgTuAbrWZqcEWhFo09S
         z/k1tNd9tlz+Cj+Cx91RYTFG+Exqvp6Uha3IAnKPWQWQw1GG0MQe43rxnGBklZiU22Fc
         +FzYg+blNNStwTr6s7r9Q79IjDpRvVA3foz46UhB/WUr3jc0NwqrroSXr26lPGs2LF0G
         vqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691225397; x=1691830197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90Kecdjbn+Kx7JcQv6zFEPJdrNxFYc2udM53qQ5WfuY=;
        b=aEgrnKA0G9FHn37mWzZD4Tv3webYdLiZIMmRGlVgoW4Gx7gHW49/OuSiaXPSMPqMXK
         A5W7n4TQCemZTeTc//TTY6DRCxtw+Eu8ZjsWPdAkb4k4CsFgnhmJp82HdBIrnqtZFRBB
         zuUoGhq/6Lye6MilZr8D+A8JhCL71ddhVKPcofCOJ+EZzakFFDJAq7NdrYNbevTP+mYT
         0AmYZ2e/L1SGgR2zXs8F5mFQXtlSILPEnCiUTXA4XQhMn9nNthhg1fPp/qoxzzlnHrg4
         imU3mX2OJ4jGJFKWWwo8VUnJqjvalZ5rPkl+JdrtuxjWaUzIx+SSQ9WsYN9whCCz1GcN
         FlbQ==
X-Gm-Message-State: AOJu0YzFtzbsIMC1jOOz+W5C89QQrG6fAO9CFDjDiLCffVDplTk5/8DX
        kKGXGaMDMHehc+ewVpgLaVSu2WGLU9RNkQ==
X-Google-Smtp-Source: AGHT+IE5Vc1oWKUHNcneg9WCCNHlo7IDXDYkiSNjc59uMXHzGcnlzUey51FbZaJ1YWjYiqYrUwDMSg==
X-Received: by 2002:ac2:5e64:0:b0:4fd:f7e7:24fd with SMTP id a4-20020ac25e64000000b004fdf7e724fdmr2125339lfr.64.1691225396744;
        Sat, 05 Aug 2023 01:49:56 -0700 (PDT)
Received: from localhost.localdomain ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id w22-20020ac254b6000000b004fbad341442sm685868lfk.97.2023.08.05.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 01:49:55 -0700 (PDT)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] clk: fix slab-out-of-bounds error in devm_clk_release
Date:   Sat,  5 Aug 2023 11:48:47 +0300
Message-Id: <20230805084847.3110586-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem can be reproduces by unloading snd_soc_simple_card, because in
devm_get_clk_from_child data were allocated as `struct clk`,
but devm_clk_release expects `struct devm_clk_state`.

KASAN report:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in devm_clk_release+0x20/0x54
 Read of size 8 at addr ffffff800ee09688 by task (udev-worker)/287

 Call trace:
  dump_backtrace+0xe8/0x11c
  show_stack+0x1c/0x30
  dump_stack_lvl+0x60/0x78
  print_report+0x150/0x450
  kasan_report+0xa8/0xf0
  __asan_load8+0x78/0xa0
  devm_clk_release+0x20/0x54
  release_nodes+0x84/0x120
  devres_release_all+0x144/0x210
  device_unbind_cleanup+0x1c/0xac
  really_probe+0x2f0/0x5b0
  __driver_probe_device+0xc0/0x1f0
  driver_probe_device+0x68/0x120
  __driver_attach+0x140/0x294
  bus_for_each_dev+0xec/0x160
  driver_attach+0x38/0x44
  bus_add_driver+0x24c/0x300
  driver_register+0xf0/0x210
  __platform_driver_register+0x48/0x54
  asoc_simple_card_init+0x24/0x1000 [snd_soc_simple_card]
  do_one_initcall+0xac/0x340
  do_init_module+0xd0/0x300
  load_module+0x2ba4/0x3100
  __do_sys_init_module+0x2c8/0x300
  __arm64_sys_init_module+0x48/0x5c
  invoke_syscall+0x64/0x190
  el0_svc_common.constprop.0+0x124/0x154
  do_el0_svc+0x44/0xdc
  el0_svc+0x14/0x50
  el0t_64_sync_handler+0xec/0x11c
  el0t_64_sync+0x14c/0x150

 Allocated by task 287:
  kasan_save_stack+0x38/0x60
  kasan_set_track+0x28/0x40
  kasan_save_alloc_info+0x20/0x30
  __kasan_kmalloc+0xac/0xb0
  __kmalloc_node_track_caller+0x6c/0x1c4
  __devres_alloc_node+0x44/0xb4
  devm_get_clk_from_child+0x44/0xa0
  asoc_simple_parse_clk+0x1b8/0x1dc [snd_soc_simple_card_utils]
  simple_parse_node.isra.0+0x1ec/0x230 [snd_soc_simple_card]
  simple_dai_link_of+0x1bc/0x334 [snd_soc_simple_card]
  __simple_for_each_link+0x2ec/0x320 [snd_soc_simple_card]
  asoc_simple_probe+0x468/0x4dc [snd_soc_simple_card]
  platform_probe+0x90/0xf0
  really_probe+0x118/0x5b0
  __driver_probe_device+0xc0/0x1f0
  driver_probe_device+0x68/0x120
  __driver_attach+0x140/0x294
  bus_for_each_dev+0xec/0x160
  driver_attach+0x38/0x44
  bus_add_driver+0x24c/0x300
  driver_register+0xf0/0x210
  __platform_driver_register+0x48/0x54
  asoc_simple_card_init+0x24/0x1000 [snd_soc_simple_card]
  do_one_initcall+0xac/0x340
  do_init_module+0xd0/0x300
  load_module+0x2ba4/0x3100
  __do_sys_init_module+0x2c8/0x300
  __arm64_sys_init_module+0x48/0x5c
  invoke_syscall+0x64/0x190
  el0_svc_common.constprop.0+0x124/0x154
  do_el0_svc+0x44/0xdc
  el0_svc+0x14/0x50
  el0t_64_sync_handler+0xec/0x11c
  el0t_64_sync+0x14c/0x150

 The buggy address belongs to the object at ffffff800ee09600
  which belongs to the cache kmalloc-256 of size 256
 The buggy address is located 136 bytes inside of
  256-byte region [ffffff800ee09600, ffffff800ee09700)

 The buggy address belongs to the physical page:
 page:000000002d97303b refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4ee08
 head:000000002d97303b order:1 compound_mapcount:0 compound_pincount:0
 flags: 0x10200(slab|head|zone=0)
 raw: 0000000000010200 0000000000000000 dead000000000122 ffffff8002c02480
 raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffffff800ee09580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffffff800ee09600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffff800ee09680: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                       ^
  ffffff800ee09700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffffff800ee09780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================
```
Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/clk/clk-devres.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 4fb4fd4b06bd..47d1e3d0d32c 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -205,18 +205,20 @@ EXPORT_SYMBOL(devm_clk_put);
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
+	struct devm_clk_state *state;
+	struct clk *clk;
 
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	if (!state)
 		return ERR_PTR(-ENOMEM);
+	state->exit = NULL;
 
 	clk = of_clk_get_by_name(np, con_id);
 	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
+		state->clk = clk;
+		devres_add(dev, state);
 	} else {
-		devres_free(ptr);
+		devres_free(state);
 	}
 
 	return clk;
-- 
2.40.1

