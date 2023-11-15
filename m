Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEAD7EC6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbjKOPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344461AbjKOPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:14:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967919F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:14:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D18EC433C9;
        Wed, 15 Nov 2023 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700061245;
        bh=FusWax7dBGiMSsQErHycJtFZnQRX1tPbGgeRj6wuVTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLxROmPDxBB6f9W3KC+aeY3ToBV7kGUt66qKwhArVFuIVl87ae+RbGrQ74Ga8mVV3
         M/lVlVMjqtzBH4RnCGlTlUqbhkdg8LAH9b1rr2R4MrF8J7gRa9gaPT1YcUm1AE1WDZ
         IhOLJpdDo1RaSybJc+2cJVSJ937/aUnnkCBeizYwLgrHawuWVWsp7f6e/9PXdrrcNG
         XNJmPZSZTDb8ClGnMixOvjNO6bSNkvG70y/Nkn96YV5XhKWq3eldjYJjwTbN+fvwPK
         pDudPFcrP2qXQidfvj2nXoOzY1YrXC7jB9kNpGuq3N/GvjSZgFaqiGAnbImq42a3cJ
         vNxgJheaI2lAw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/4] x86: Remove __current_clr_polling() from mwait_idle()
Date:   Wed, 15 Nov 2023 10:13:24 -0500
Message-ID: <20231115151325.6262-4-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115151325.6262-1-frederic@kernel.org>
References: <20231115151325.6262-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mwait_idle() is only ever called through by cpuidle, either from
default_idle_call() or from cpuidle_enter(). In any case
cpuidle_idle_call() sets again TIF_NR_POLLING after calling it so there
is no point for this atomic operation upon idle exit.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6f4e8399fca..fc7a38084606 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -930,7 +930,6 @@ static __cpuidle void mwait_idle(void)
 			raw_local_irq_disable();
 		}
 	}
-	__current_clr_polling();
 }
 
 void select_idle_routine(const struct cpuinfo_x86 *c)
-- 
2.42.1

