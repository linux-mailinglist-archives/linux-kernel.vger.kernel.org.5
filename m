Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88DB7CCF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbjJQVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQVoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:44:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49925C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:44:33 -0700 (PDT)
Message-ID: <20231017211723.409940426@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697579071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dYbY4CrL+bZF98vnVnxg6x/cq61iSItj/EIDVLdFSto=;
        b=shryNrX8SXoBzIt/6UU4O7MiWTa9lUA0o6FfHhvod4422RuYZkJLSb5z5NFL9wOPTgiQH4
        3zbdfLBZVmuIYG6POkR5LevsMrkySzqHpiMdgwE2eM3hGTr8JBrnzHPzY04rUoX5xkV2xE
        m1XIdPpKvqWu+o9SqJ2WOMyTNVIQCJutCNPWwKAfxxjNDIyb/V7zKJ6iOkXlnDpnluPONb
        scYYQ06UgFyZsgCz2w5MlX0+T/eUuIaVpngo39QZnNTX/EZE1Db2/tZiw5PKQ5L64/lr0D
        Pfo2fICMZsNsWf5+6RxJIkk+DKcwdOS6kXyoOo0k0jnB7brdcQu7nLVHxjczUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697579071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dYbY4CrL+bZF98vnVnxg6x/cq61iSItj/EIDVLdFSto=;
        b=DiCkf/LqqGNh4+tAoIlXd4nfwywAQr2m/dYnAUfnB4KxLiwt3Wln23rVGtNmjznZmGhSOG
        4rJBwaePWwQlivCg==
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 

