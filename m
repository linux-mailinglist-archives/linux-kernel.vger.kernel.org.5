Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682A277972B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjHKSjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKSji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:39:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044030DC;
        Fri, 11 Aug 2023 11:39:37 -0700 (PDT)
Date:   Fri, 11 Aug 2023 18:39:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691779170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7U18nUB7ZZylyWZlfzeqQZ7OwuY9eqjEWthoA8dO794=;
        b=kuMz1LxWWrX8QglIll+lhrYcE5rLf8TyWXJsKrXb9wk0PWYRIa32yypGMYJMbp6UqsapIC
        9hkh6yM7tUpLp/mw+oj9dzv+qBf/qqMh7PmpYpctybGTIWRJISI2o+FWbHNt2O4X45WVyj
        jhZT0lwjzvitDJmnY0qwVdrrgrXhn/H6xlNLoWAq90Lxpb6e2a3BKQO7FMdQ7ItIfNwChI
        TAPHZv/d9RkXsTaVKRblzAMtFWtxXdgK/skP62mPbYUqswVJDmc+BZ/8MKD65HsMZX3o+g
        bCXJN6prJCr2thvKIXM02kp2CxtOCyJY9DAsgc1/l2TgVQKyb3utPLp5ZRByOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691779170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7U18nUB7ZZylyWZlfzeqQZ7OwuY9eqjEWthoA8dO794=;
        b=hGnA6QuaWDDoX3Q742fNoz2hEX8ouxV6iT9tS3xgjeK0gWm9DFvM4ZDYn6ZaZeySnI2F8f
        Be5M5K9rOA0hDZAQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] driver core: cpu: Fix the fallback cpu_show_gds() name
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230811095831.27513-1-bp@alien8.de>
References: <20230811095831.27513-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <169177916977.27769.3694730476189512700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     3477144c878a52fc3938a529186e81ea030e7779
Gitweb:        https://git.kernel.org/tip/3477144c878a52fc3938a529186e81ea030e7779
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 11 Aug 2023 11:32:09 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Aug 2023 20:36:02 +02:00

driver core: cpu: Fix the fallback cpu_show_gds() name

In

  6524c798b727 ("driver core: cpu: Make cpu_show_not_affected() static")

I fat-fingered the name of cpu_show_gds(). Usually, I'd rebase but since
those are extraordinary embargoed times, the commit above was already
pulled into another tree so no no.

Therefore, fix it ontop.

Fixes: 6524c798b727 ("driver core: cpu: Make cpu_show_not_affected() static")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230811095831.27513-1-bp@alien8.de
---
 drivers/base/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index d7300d8..fe6690e 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -532,7 +532,7 @@ CPU_SHOW_VULN_FALLBACK(srbds);
 CPU_SHOW_VULN_FALLBACK(mmio_stale_data);
 CPU_SHOW_VULN_FALLBACK(retbleed);
 CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
-CPU_SHOW_VULN_FALLBACK(gather_data_sampling);
+CPU_SHOW_VULN_FALLBACK(gds);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -546,7 +546,7 @@ static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
-static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gather_data_sampling, NULL);
+static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
