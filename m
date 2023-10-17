Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7100F7CCF39
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbjJQVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbjJQVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:25:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179119A9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:24:04 -0700 (PDT)
Message-ID: <20231017211723.521532582@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OcSOc/XQeQCSpMT+2YS3SG7DHGO6SXxO16x4Tum9Ox4=;
        b=ZVO/K+jO6vRqem1k1hMH9SpDBFqQjuQrCMF2QpUZi4WM43scmzoClcnA3dSMgh8+7M83sa
        DZKOJQaunLrl8GDvzipwl5lEADch8TrjOhzM1KAOI8K04nVrtKBjuhIAz0OFbtooF/EpE6
        txw9YrZwJJ0tuWo5Gbxn1zU4Vr7UVA75Dm/DNaQ0HanWMZ0TNs1AVIfyKzlhdTg+3QeoU3
        TwSyKzAeCACzBCVwUKnvOFIAD3G9yp1E82zZj21TvVVGbljxSdM4y6/vktgnnyg2ReOIvx
        2Q8JOzdFcakO/dvyBR2ID1fyQXupr/ba1ber3zsABiULANNRFvow6eDrnqvSbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OcSOc/XQeQCSpMT+2YS3SG7DHGO6SXxO16x4Tum9Ox4=;
        b=bv3tw+1v7efKmyC72N5dUlDQ8Sy0lfikRX6ofHUeQBFJC1KpQN+niGRw3vt3fohxlDllGb
        pM1qW+gEE3Ceo+Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V5 28/39] x86/microcode: Clarify the late load logic
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:24:02 +0200 (CEST)
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
   the rendezvous fails, then nothing happened and there is no reason for
   tainting.

 - Return useful error codes

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/microcode/core.c |   41 ++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 22 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -362,11 +362,11 @@ static int microcode_reload_late(void)
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
 
@@ -399,40 +399,37 @@ static bool ensure_cpus_are_online(void)
 	return true;
 }
 
+static int ucode_load_late_locked(void)
+{
+	if (!ensure_cpus_are_online())
+		return -EBUSY;
+
+	switch (microcode_ops->request_microcode_fw(0, &microcode_pdev->dev)) {
+	case UCODE_NEW:
+		return microcode_reload_late();
+	case UCODE_NFOUND:
+		return -ENOENT;
+	default:
+		return -EBADFD;
+	}
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

