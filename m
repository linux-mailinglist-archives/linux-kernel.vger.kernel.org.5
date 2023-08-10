Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FB77806D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjHJSjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjHJSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:38:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20E230DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:38:08 -0700 (PDT)
Message-ID: <20230810160806.045993293@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qicvq4u13+GKL+4eW6ZEQQqFYpQClLZfFC5XYmTA1Qw=;
        b=hfrWNLOegUu4KFmmwtUdNxRRybdEpP40zi+zNifw/u7YhrlTyhYln9MRheJssnIsYwKGyZ
        54kuHgELMhgTvWRZxZm8oBzH7f1TaSCbHQf/p7qrionCMxiHtDAYb6rSIWKCgn0CQtYetN
        381sTQUk64k2jzNZxgJIqOYMEPY+B1oooRW2pLaXPAt1UlWXLVxUylJcTTeyHnPzL1PkJI
        bsy1Ly21NOvL/slioHOJ4Jkqu6AJJD6RIbXsIN0D37suB6usAsuCVROzg4llKMJQQqx1Vl
        rQ31lunOk7BQBxz2g5HXFP7oxHCS6mfpezlyB18tw+8eB3hDcFbJTRgIJgdvAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qicvq4u13+GKL+4eW6ZEQQqFYpQClLZfFC5XYmTA1Qw=;
        b=PnsBdyNWZmGwqsq3lrJu4HlEKmnNvODRRntf8X6FMLk/xD0/y1JAa6TwPifvJ2gsAqh4LM
        3T5eNkpQziSmB1BQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 19/30] x86/microcode: Clarify the late load logic
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:54 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

reload_store() is way too complicated. Split the inner workings out and
make the following enhancements:

 - Taint the kernel only when the microcode was actually updated. If. e.g.
   the rendevouz fails, then nothing happened and there is no reason for
   tainting.

 - Return useful error codes

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c |   39 +++++++++++++++--------------------
 1 file changed, 17 insertions(+), 22 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -434,11 +434,11 @@ static int microcode_reload_late(void)
 		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
 			old, boot_cpu_data.microcode);
 		microcode_check(&prev_info);
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 	} else {
 		pr_info("Reload failed, current microcode revision: 0x%x\n",
 			boot_cpu_data.microcode);
 	}
-
 	return ret;
 }
 
@@ -471,40 +471,35 @@ static bool ensure_cpus_are_online(void)
 	return true;
 }
 
+static int ucode_load_late_locked(void)
+{
+	int ret;
+
+	if (!ensure_cpus_are_online())
+		return -EBUSY;
+
+	ret = microcode_ops->request_microcode_fw(0, &microcode_pdev->dev);
+	if (ret != UCODE_NEW)
+		return ret == UCODE_NFOUND ? -ENOENT : -EBADFD;
+	return microcode_reload_late();
+}
+
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	enum ucode_state tmp_ret = UCODE_OK;
-	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
-	ssize_t ret = 0;
+	ssize_t ret;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret || val != 1)
 		return -EINVAL;
 
 	cpus_read_lock();
-
-	if (!ensure_cpus_are_online()) {
-		ret = -EBUSY;
-		goto put;
-	}
-
-	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
-	if (tmp_ret != UCODE_NEW)
-		goto put;
-
-	ret = microcode_reload_late();
-put:
+	ret = ucode_load_late_locked();
 	cpus_read_unlock();
 
-	if (ret == 0)
-		ret = size;
-
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-
-	return ret;
+	return ret ? : size;
 }
 
 static DEVICE_ATTR_WO(reload);

