Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D3D79C8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjILH7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjILH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6DB2102
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:12 -0700 (PDT)
Message-ID: <20230912065501.838955709@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=29AYhkI+1B+aP2ulSjBZYvwAxHR9z6zN13x7VQxgXac=;
        b=o5K9GLXM3XJpdsaGpiBbbxvmmBIEGDFBMHADfwXSBVH3+l+2a6D+OMu0ia1mVRFIBR+2/W
        uqhaCgGahmSxDrsgnpSSfKNZgh2/GoQ9wgUxow4iRFVmePrffytWctRvaSFsl+96+kX74g
        zlJgwaZvvgCQmI6EiyN6ZGRhVwjXgtKyuA0JdnL86v769V7k0rqWg+VX12BZ81XK90BKrx
        UDfvQWrLaM5X5TCNsxvuQju+uFM5ejimEM0tmkqd6UFbmMKHK4NoN//og2uzek166vUZS3
        SmYm44zVjymVBgVX0RHw8UiGBGFkOnvzrc5lpTvDA2aOkRo55AUu6Zu3sgCdLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=29AYhkI+1B+aP2ulSjBZYvwAxHR9z6zN13x7VQxgXac=;
        b=KBTh1d6SrsaSukcbTTTJGUkoMfBfIkLyuLjz/8JnxI6kpyDX2Zvx2BOGrpl8ML2w5Q8AHK
        rbusKTV3I4h1YaDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 17/30] x86/microcode: Clean up mc_cpu_down_prep()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:10 +0200 (CEST)
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
@@ -569,16 +569,10 @@ static int mc_cpu_online(unsigned int cp
 
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
 

