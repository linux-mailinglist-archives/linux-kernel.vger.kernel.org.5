Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17A57D5192
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjJXNWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjJXNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:21:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B631700;
        Tue, 24 Oct 2023 06:20:58 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:20:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3tYL+xCvoJzygrP0yYanGm8iOxXgmx3YuzRvfTV+v8=;
        b=3ot5VNocTehPk3TAWW84qp5vw7WOX3KH8w1h8EqrSnL2jw+Az2Ze0u+BP17g3akuvE/fjW
        22yYXHkJ2jFWwYnBHRXgRY4OPnJuBKoRd5nj1p4njzGTBgmd3lF44OaqrrEO9dm+dcG8yv
        k93g7M+64wx1osxIu400IjCCxR49mt1Rxm7p2FNHQlZ26XzXb/S6UtgaDdlxECliLgx2if
        RFCKhCPvqOouU6YHrNUjRCSYyrpgH0Bv3JyR5RoKsR4O7BWG/7AOEiy95aqbHkcxWSZkV8
        NpQZ97NqEeRXmZj0o0S07xgSC6DvRHFul7UznToOjHJaX8HEb9KPDvDxun8p6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3tYL+xCvoJzygrP0yYanGm8iOxXgmx3YuzRvfTV+v8=;
        b=36yJ743Plok0t0jfTGPPc+83kxF5TN+cYr13pb3s40NXcBK33ZGt4x4IBnfV0G9zvQumad
        MnBbq4VeT7HZvvCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Clarify the late load logic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.145048840@linutronix.de>
References: <20231002115903.145048840@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815365668.3135.6098105876703309302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     6f059e634dcd0d725854514c94c114bbdd83950d
Gitweb:        https://git.kernel.org/tip/6f059e634dcd0d725854514c94c114bbdd83950d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:57 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:54 +02:00

x86/microcode: Clarify the late load logic

reload_store() is way too complicated. Split the inner workings out and
make the following enhancements:

 - Taint the kernel only when the microcode was actually updated. If. e.g.
   the rendezvous fails, then nothing happened and there is no reason for
   tainting.

 - Return useful error codes

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20231002115903.145048840@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 41 ++++++++++++---------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7af1b60..63c4e12 100644
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
