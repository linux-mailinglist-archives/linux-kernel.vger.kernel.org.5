Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1277771F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjHJLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjHJLeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:34:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC69C6;
        Thu, 10 Aug 2023 04:34:18 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:34:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691667256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0aLuO6U7iMSbeq9gve0XNt5cEBgevEzEpY6FCKp+VY=;
        b=ytijn5LJtGkjbm3Gf3HcyTIivpvHmRlW8sVMUNCuUVpp4wR30t7cs9B2oaIS9eUe1jJ3CV
        Cgzgw0qXZuPacqN32JcvFEdvx7hMxxPxVI3hFdXnXnJWRVp9F8vQxDnprtklV5Ep6EIAx7
        A3elpS6IjERI3tjUngp+jUmg4VWGW41/woneONyavoJlW709wP4JUWRA5xL7GNiBYtcfeX
        8C9IMOjAVMT4NhTs+vOK+v4sfkUZSiNCjxrCEcIi6Ly0w2zanO34ssVnimtdlOfWoqOGzP
        lHNXiQ7WKnCeJFuF7v0B5igRizJr9uBRCH34w/Pad4jyy2y9MI+W1tuPOnxAVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691667256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0aLuO6U7iMSbeq9gve0XNt5cEBgevEzEpY6FCKp+VY=;
        b=DqhiCAxKSHO/JLIONJARF2w4LhjO7ehDKHoRp81bNoD7uHaQXTQQ5wJKMFDCaAad0sJTYQ
        +/GlVJvzUMYCNXCg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] driver core: cpu: Make cpu_show_not_affected() static
Cc:     kernel test robot <lkp@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202308101956.oRj1ls7s-lkp@intel.com>
References: <202308101956.oRj1ls7s-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <169166725589.27769.14186794561809548097.tip-bot2@tip-bot2>
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

Commit-ID:     6524c798b727ffdb5c7eaed2f50e8e839997df8e
Gitweb:        https://git.kernel.org/tip/6524c798b727ffdb5c7eaed2f50e8e839997df8e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 10 Aug 2023 13:22:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 13:25:12 +02:00

driver core: cpu: Make cpu_show_not_affected() static

Fix a -Wmissing-prototypes warning and add the gather_data_sampling()
stub macro call for real.

Fixes: 0fddfe338210 ("driver core: cpu: Unify redundant silly stubs")
Closes: https://lore.kernel.org/oe-kbuild-all/202308101956.oRj1ls7s-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202308101956.oRj1ls7s-lkp@intel.com
---
 drivers/base/cpu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 054c81b..d7300d8 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -509,7 +509,7 @@ static void __init cpu_dev_register_generic(void)
 }
 
 #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
-ssize_t cpu_show_not_affected(struct device *dev,
+static ssize_t cpu_show_not_affected(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "Not affected\n");
@@ -534,12 +534,6 @@ CPU_SHOW_VULN_FALLBACK(retbleed);
 CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
 CPU_SHOW_VULN_FALLBACK(gather_data_sampling);
 
-ssize_t __weak cpu_show_gds(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -552,7 +546,7 @@ static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
-static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
+static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gather_data_sampling, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
