Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078477A239
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjHLUCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjHLUCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:02:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C8230DA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:01:36 -0700 (PDT)
Message-ID: <20230812195729.045205660@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qicvq4u13+GKL+4eW6ZEQQqFYpQClLZfFC5XYmTA1Qw=;
        b=WUbmRsjME0IAcJ4TLm5gjoy8Ty3xcaF6PxdgNtVB880OoxTkVwhgxR2q+4zjxyk/QbaAPR
        0tf3jBHmptrq0GUk6cZgKiCv8kyIEZro9zYLPkP6ViRUgvsU2l8bhMD9o/ZzrziLekICTR
        4VQifYJca2l8ayroOa1Vmr5vmXF/q2/Fx6LgSzEaS7lyWe6ege4JDuAkdG9K7n1cBA52ab
        5ZwZ/F1eSWizadFafq5kiy2kKNmqvZPE0LE7xTgcuBTlmPE+DYPboW4b33XqcVHvAyf2zk
        p/hDR4ir5KydRARjipJ+3vfaL+FLtwx9AGLwnRgCHnbUyWqZk3uPzzktpbY5PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qicvq4u13+GKL+4eW6ZEQQqFYpQClLZfFC5XYmTA1Qw=;
        b=mzhA71ca6pVqzUGne+D9zbgGgsVnXwpF596CShNBBizkycEUD6pPZen/+ymh6Hmye4LeKC
        sr9RHbNTRtKqfGBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 26/37] x86/microcode: Clarify the late load logic
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:16 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

