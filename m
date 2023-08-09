Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759FA7768D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjHITfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHITfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:35:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DEC6;
        Wed,  9 Aug 2023 12:34:59 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:34:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691609698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaN2WQvKSAOTqCbHsFrBwMGt9Wk6Yf6DrRMppzjalyE=;
        b=yhvYJIkymYOJ0XeoX+y4G6GBGyYFUMGNaKUuOR8/sKnGPktt14DQhSAZLjnlVifNwHF41e
        lzPf0o8HfbJX5yzsMIZmWrRZPjc76fRkVbre2QuYSDv9Z6cBcJW2Aq0jLUR1gm3s+kVQQk
        2YS6EGWjZYk1xAC07HU+e7sOKueBOP5htf/5HC/pmG/8eAtY9Rb/7v0252Hj+7kql6+Oho
        rzI2+iqdRpLreiEic/HhN80UYPElKk0cd1DIz1Y0gScGf0jxaJxnxbjFTHBTePzbssOitF
        eRdz59yivNb0rjEcWEv/B/Vw+VSA5EIfk/ZSjVl6YDXNgIH1IJeRsyoVgO9sRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691609698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaN2WQvKSAOTqCbHsFrBwMGt9Wk6Yf6DrRMppzjalyE=;
        b=vIk+Amrsp72K8tCePAJMP9OV4J2KWbcvcfazQLc34tJF+3k2vlL3oveHz6Z/+KyGsyAK8A
        i+OyenFsi0gw2/Bg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Select KERNFS as needed
Cc:     kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202307310732.r65EQFY0-lkp@intel.com>
References: <202307310732.r65EQFY0-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <169160969796.27769.8398357124658941325.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     98dfdd9ee93995a408192dbbf3dd219ba23e3738
Gitweb:        https://git.kernel.org/tip/98dfdd9ee93995a408192dbbf3dd219ba23e3738
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 30 Jul 2023 20:07:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Aug 2023 16:19:25 +02:00

sched/psi: Select KERNFS as needed

Users of KERNFS should select it to enforce its being built, so
do this to prevent a build error.

In file included from ../kernel/sched/build_utility.c:97:
../kernel/sched/psi.c: In function 'psi_trigger_poll':
../kernel/sched/psi.c:1479:17: error: implicit declaration of function 'kernfs_generic_poll' [-Werror=implicit-function-declaration]
 1479 |                 kernfs_generic_poll(t->of, wait);

Fixes: aff037078eca ("sched/psi: use kernfs polling functions for PSI trigger polling")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: lore.kernel.org/r/202307310732.r65EQFY0-lkp@intel.com
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index f7f65af..5e7d488 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -629,6 +629,7 @@ config TASK_IO_ACCOUNTING
 
 config PSI
 	bool "Pressure stall information tracking"
+	select KERNFS
 	help
 	  Collect metrics that indicate how overcommitted the CPU, memory,
 	  and IO capacity are in the system.
