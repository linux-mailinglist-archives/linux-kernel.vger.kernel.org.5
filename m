Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE67773DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjHJJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjHJJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D142D43;
        Thu, 10 Aug 2023 02:11:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:11:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691658709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxD26mpXhaVJ9Wv7T3hpLCp448s7AxP7phiyVMQatdk=;
        b=j8ubHTFOjRJQg6EsUi0Qkvx4Vm5w+APH9zTCgWLD1Jg+9mehMuBPr5WAYzJ0+A0jX7YAVx
        4q2E1n8FkkeJaqBlrS1iWKzP5B9TBa8+PpqbVRRcdfMwDmLZfPguPQnqW14YwiBacQjCOx
        zSrGXIBnEeYlTlmimj8x2Dy5gt7sI/Lfnb2FD9RNZ7tRNcJ0QSBxgwFmv5GlTQ3xPsDQar
        wTG8kLUoCnvUzLH039GQ84KUzdgQGD68ANtZg4t0blxzr12ZdVGX92sOT6mpOdhMcoJN0A
        bRFD41YE/pKtZO/kT5DZklaGvRwDbFkjgIvgvdup/5n1dgMyTT4ARVyaoTe+qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691658709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxD26mpXhaVJ9Wv7T3hpLCp448s7AxP7phiyVMQatdk=;
        b=FgK+fzQlxcLqODNjVQQmIWC4h8steYDVZiTYuquM/PeXhoLuGjQmFroqkQasmMiUlASSdD
        fdAFjVhX05eYiNDQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] driver core: cpu: Unify redundant silly stubs
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230809102700.29449-3-bp@alien8.de>
References: <20230809102700.29449-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <169165870902.27769.2974713899040967098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     0fddfe338210aa018137c03030c581f5ea4be282
Gitweb:        https://git.kernel.org/tip/0fddfe338210aa018137c03030c581f5ea4be282
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 29 Jul 2023 17:20:33 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 11:03:04 +02:00

driver core: cpu: Unify redundant silly stubs

Make them all a weak function, aliasing to a single function which
issues the "Not affected" string.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20230809102700.29449-3-bp@alien8.de
---
 drivers/base/cpu.c | 87 +++++++++------------------------------------
 1 file changed, 19 insertions(+), 68 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 52df435..054c81b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -509,79 +509,30 @@ static void __init cpu_dev_register_generic(void)
 }
 
 #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
-
-ssize_t __weak cpu_show_meltdown(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spectre_v1(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spectre_v2(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
-					  struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_l1tf(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_mds(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_srbds(struct device *dev,
+ssize_t cpu_show_not_affected(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "Not affected\n");
 }
 
-ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
-					struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_retbleed(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
-					     struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
+#define CPU_SHOW_VULN_FALLBACK(func)					\
+	ssize_t cpu_show_##func(struct device *,			\
+				  struct device_attribute *, char *)	\
+		 __attribute__((weak, alias("cpu_show_not_affected")))
+
+CPU_SHOW_VULN_FALLBACK(meltdown);
+CPU_SHOW_VULN_FALLBACK(spectre_v1);
+CPU_SHOW_VULN_FALLBACK(spectre_v2);
+CPU_SHOW_VULN_FALLBACK(spec_store_bypass);
+CPU_SHOW_VULN_FALLBACK(l1tf);
+CPU_SHOW_VULN_FALLBACK(mds);
+CPU_SHOW_VULN_FALLBACK(tsx_async_abort);
+CPU_SHOW_VULN_FALLBACK(itlb_multihit);
+CPU_SHOW_VULN_FALLBACK(srbds);
+CPU_SHOW_VULN_FALLBACK(mmio_stale_data);
+CPU_SHOW_VULN_FALLBACK(retbleed);
+CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
+CPU_SHOW_VULN_FALLBACK(gather_data_sampling);
 
 ssize_t __weak cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
