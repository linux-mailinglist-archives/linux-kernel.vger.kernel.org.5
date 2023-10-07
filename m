Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E57BC99C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjJGSzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:55:41 -0400
Received: from st43p00im-ztbu10073701.me.com (st43p00im-ztbu10073701.me.com [17.58.63.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2C193
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696704938;
        bh=F9EDgySKAqzaEyTQfAQOv+X3fKaJ8b5RqfEk4kbUM1Y=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=PCu1jWKEhCfwaBm0YKPOsV6jnpqj+yTAgmT2PtEaegT2iorj1/FJVLTBJ1KPlQ+8c
         j7joOpecpMuh1ab918HDXJ6F+e80B6gAgXJu6EZFftuk4fEp6TAJwDEZ/hGuDMJGsZ
         vjw9EN0RywCnogt7i0FKKLIcO/sBzaETDT7g8eorz3vhRcjQ973Hj+laAo0LFVlKUX
         DMLvdA0AWBBWIvp0DC9ZQZ4/L4SEzDxCcKKocEOPxuUJf3h0p8oQCFOLZ3LjR+ORIh
         2KvOyz6qi+jA7gz1ImDKT/qxHCmUxT4cZKhfyfo1qKY7oBbV6k32j1LnAaG3Mu4lv8
         XGotq01PwBwbA==
Received: from mainframe (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztbu10073701.me.com (Postfix) with ESMTPSA id A49F01C018E;
        Sat,  7 Oct 2023 18:55:21 +0000 (UTC)
Date:   Sat, 7 Oct 2023 20:55:19 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/p4: Fix "Wunused-but-set-variable" warning
Message-ID: <ZSGpl_hT23B6ix0M@mainframe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a compiler warning when compiling an allyesconfig with W=1:
warning: variable ´high´ set but not used [-Wunused-but-set-variable]

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
---
 arch/x86/events/intel/p4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 35936188db01..69aaf7c0f340 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1366,7 +1366,7 @@ static __initconst const struct x86_pmu p4_pmu = {
 
 __init int p4_pmu_init(void)
 {
-	unsigned int low, high;
+	unsigned int low, __maybe_unused high;
 	int i, reg;
 
 	/* If we get stripped -- indexing fails */
-- 
2.42.0

