Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51B7B51FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjJBMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjJBMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE71E3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:59 -0700 (PDT)
Message-ID: <20231002115903.145048840@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AKE/XS6SEIbqho91Hmin0oksrMtPi1Xkc5zYgAfFhzQ=;
        b=onKOuI3KLeunKNft9ejU67gHNGLSwK0diHMkh49crfc162JLJuX/jFLh/QdbHI/WqAZDoA
        fNYeninSONC1fv6Xg73oTNdA5fqv4scX9rAPgqjoEVcmKELWeLiLSGqM0qcID7mMI3Fe9T
        9GkEpXp0hTx9HCs6qijlCRy9qiQmAru+HVNwOgk4iaAa0g8lomv1G/8nutRLZvY/lBn9Px
        vqAz8/jwn2tyKZo/IDwjjOvQtcTz6IqwdE4yTHBfTlIT703c9IONKN0DmVWeax0x3pLtdq
        Ja1MOtc2GNJ+QR6/EYE7GbRHQaBnRWC3kwHYDuDZSgot0CqYX3DAP11EZo9KMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AKE/XS6SEIbqho91Hmin0oksrMtPi1Xkc5zYgAfFhzQ=;
        b=ag8vZTbFFEGB9v4EDRB9E+KijGSPy2iC083XmbmRZFXl4zOqMomeo56sRzwNBytrOUODoT
        RPdU92cAESVk0JCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 19/30] x86/microcode: Clarify the late load logic
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:57 +0200 (CEST)
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
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/microcode/core.c |   41 ++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 22 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -391,11 +391,11 @@ static int microcode_reload_late(void)
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
 
@@ -428,40 +428,37 @@ static bool ensure_cpus_are_online(void)
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

