Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9D7B51FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjJBMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjJBMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425CCCC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:56 -0700 (PDT)
Message-ID: <20231002115903.028651784@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7j90uOLtW2Wz9UtqDt1Dp/sqHiCZcf49IdRLgKDZvBw=;
        b=FAZjiJ692BNjL7M3QRIjWGOh9L7JutBy22k9ZlFOJfpicREccxMM2sbNeu9RVwIWmcfqym
        7zgvao+1iBLiMrEQN5NYriWwPexJc069HWuS19nlqUMMK0DymyZ8xna+5HaIra8cyuByD+
        FgGrlXL7jwF4I2F9q9bRKAxrEKPHcjOQ8WrqOVoi3r6hwkEGcS2vP5F1Vf5+4d8NlkAyi2
        /gtX1DhQsf0nCGgTM34qm4zDAHNdP9hHm0LbyAqNsMOxAoGGpzXkDfisil5qtrCL+FLz16
        qmHQh40Jtrif03klDVAv3vnux4ON0naJYIUH4ikQIfzGVoqJd5NA9ITkn/eRBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7j90uOLtW2Wz9UtqDt1Dp/sqHiCZcf49IdRLgKDZvBw=;
        b=TK+09Dsj/i8zlx64hwldIx+xmav0JdFReJ64MI2lZPzHncy/tailjJEa/JKQZqiAAHW70T
        8CXkEIk/QfKrynDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 17/30] x86/microcode: Clean up mc_cpu_down_prep()
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:55 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has nothing to do with suspend. It's a hotplug
callback. Remove the bogus comment.

Drop the pointless debug printk. The hotplug core provides tracepoints
which track the invocation of those callbacks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/microcode/core.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -527,16 +527,10 @@ static int mc_cpu_online(unsigned int cp
 
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
 

