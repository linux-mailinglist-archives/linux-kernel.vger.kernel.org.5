Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2A7EC898
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjKOQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjKOQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:30:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97AAB;
        Wed, 15 Nov 2023 08:30:35 -0800 (PST)
Date:   Wed, 15 Nov 2023 16:30:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700065833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lv77ghejcmK3cKE1Vf2d/yMCjFLwc48hc+VxtEjCKYI=;
        b=d4kOJKZL+RuT9rvY+3XoqUPRRHs21qIVO+5JlejD+bj0OPqLqQSs4vjMAZDSYqpzUkWnmA
        zIwofycL6lG+vP0EZOhL7OSkAg9M/IJc1WHuL4GCyZvVuSY4otc+kp7h9QySLG/k+7t7Oe
        k1Dm1eFr5aWRfAwV+htbmNuY4OofQRoZOUiwJ9Il3Z/HC0WhuUZBfIT4xjPscGoX0rniGC
        ArhxzPyMzWvKN/UeT9BTj4DyfPm3nEw2yg7UciV40/zOAn6QDfa+LQ0kIeHd5dnFAoBlQy
        6RmuTJSe2EgQ5M+J8w33Le67IrAZ3BOTVUQpWUon264rUBa24xe+85IJrqpxQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700065833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lv77ghejcmK3cKE1Vf2d/yMCjFLwc48hc+VxtEjCKYI=;
        b=z/UgNWbyPqSD3nXPMQJLB7a85sgd/AbfI3VQgugkikiG9MQV4lFCwWIPWRMu6VPZ7e7meE
        qwM56+XuBqtYeYAw==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove redundant check from mce_device_create()
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231107165529.407349-1-nik.borisov@suse.com>
References: <20231107165529.407349-1-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <170006583302.391.15327031218782517108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     612905e13b8769caca7ec4194a8aceb24efa4d5c
Gitweb:        https://git.kernel.org/tip/612905e13b8769caca7ec4194a8aceb24efa4d5c
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Tue, 07 Nov 2023 18:55:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Nov 2023 17:19:14 +01:00

x86/mce: Remove redundant check from mce_device_create()

mce_device_create() is called only from mce_cpu_online() which in turn
will be called iff MCA support is available. That is, at the time of
mce_device_create() call it's guaranteed that MCA support is available.
No need to duplicate this check so remove it.

  [ bp: Massage commit message. ]

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231107165529.407349-1-nik.borisov@suse.com
---
 arch/x86/kernel/cpu/mce/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index df8d25e..1642018 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2584,9 +2584,6 @@ static int mce_device_create(unsigned int cpu)
 	int err;
 	int i, j;
 
-	if (!mce_available(&boot_cpu_data))
-		return -EIO;
-
 	dev = per_cpu(mce_device, cpu);
 	if (dev)
 		return 0;
