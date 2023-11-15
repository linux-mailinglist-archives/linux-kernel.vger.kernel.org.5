Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD1F7EC6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbjKOPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbjKOPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:14:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CAA1A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:14:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DAFC433C7;
        Wed, 15 Nov 2023 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700061248;
        bh=9FyYN/LMD2/fmw8fX0LrTB664VhgSDnzIJOwUJw0Y/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5m+7PM5vOqzBpNbL1+fn6Ycsl2BUOIivbf/wNwef9DrWYraapI6EjD0i1SiJvFMy
         6TbCpVDi4b1Ihc+IpXrvrfcwYC5GveDUg7zyIv9CYD/e7bENZGW2mW6W2h7ibG4AT6
         5JrpGoK8wnI64jYVgpKnlQcXkth5RCKe3bnztzcitkEoihyqPiN5MaSlRB4X5LQkjV
         vlIGQT6RpjUI1ouzn6pt89RalvhyDri6tqBPdFa25uSkP4gOZwr4vZxUGNogdnRnm0
         suOyFAz8RHMJQA9Ct/cpWVLqqueumDGCWhU9BtTcV6cj/fSOHRsNR0gTBVKs4Y9RQx
         b5GfqpUBu5tUw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/4] x86: Remove the current_clr_polling() call upon mwait exit
Date:   Wed, 15 Nov 2023 10:13:25 -0500
Message-ID: <20231115151325.6262-5-frederic@kernel.org>
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

mwait_idle_with_hints() is mostly called from cpuidle which already sets
back TIF_NR_POLLING and fold TIF_NEED_RESCHED if necessary.

The only non-cpuidle caller is power_saving_thread() which acts as an idle
loop and is the only reason why mwait_idle_with_hints() carries a costly
fully ordered atomic operation upon idle exit.

Make this overhead proper to power_saving_thread() instead which already
duplicates quite some cpuidle code.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 1 -
 drivers/acpi/acpi_pad.c      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 920426d691ce..c1be3775b94a 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -134,7 +134,6 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 			}
 		}
 	}
-	current_clr_polling();
 }
 
 /*
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index bd1ad07f0290..86b57123713f 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -175,6 +175,7 @@ static int power_saving_thread(void *data)
 			stop_critical_timings();
 
 			mwait_idle_with_hints(power_saving_mwait_eax, 1);
+			current_clr_polling();
 
 			start_critical_timings();
 			tick_broadcast_exit();
-- 
2.42.1

