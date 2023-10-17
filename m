Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF07CCF36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjJQVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344006AbjJQVZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:25:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C7199B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:24:03 -0700 (PDT)
Message-ID: <20231017211723.409940426@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dYbY4CrL+bZF98vnVnxg6x/cq61iSItj/EIDVLdFSto=;
        b=XrXuI0THL3knM5bRR+KpTqKC0/OCz9xTYl/iG9jLlqJBhItBLCr82Jy7abK7AaHgxQJ3u1
        oOOXX8JNu70PXYDH53+mA6uMHKP4jftYtbzZreqGfnjp/ATImmbnDDX+Zv3p96L+a5dxPN
        RiLOVpqHBoxfo9GFjMmoNZK7PBUySb+a8aZJzj4Whf30YYjtE/fsI1mbrcTh0wkMpaxltX
        Oi/VBekZz/VfyB14V7yLiRJoy3T/2No398p8B0CAxNLpjs8E5Ohfe244zSnmePtgv/4v9Y
        i73C8xVmKH6rYSSJJjXtfuWFTxtdpKVVZs/0WmKhd7rkCsIYO7o67NzckvNF7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dYbY4CrL+bZF98vnVnxg6x/cq61iSItj/EIDVLdFSto=;
        b=IphzYFtD3IH8bseqEHACdUlZrsIk6HKGsPxUdz3QUv0Vih4VX86KkLYH8g6qCZ2sQaWOc8
        s5ZUpapzXoXZOoAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 26/39] x86/microcode: Clean up mc_cpu_down_prep()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:59 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This function has nothing to do with suspend. It's a hotplug
callback. Remove the bogus comment.

Drop the pointless debug printk. The hotplug core provides tracepoints
which track the invocation of those callbacks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/core.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -498,16 +498,10 @@ static int mc_cpu_online(unsigned int cp
 
 static int mc_cpu_down_prep(unsigned int cpu)
 {
-	struct device *dev;
-
-	dev = get_cpu_device(cpu);
+	struct device *dev = get_cpu_device(cpu);
 
 	microcode_fini_cpu(cpu);
-
-	/* Suspend is in progress, only remove the interface */
 	sysfs_remove_group(&dev->kobj, &mc_attr_group);
-	pr_debug("%s: CPU%d\n", __func__, cpu);
-
 	return 0;
 }
 

