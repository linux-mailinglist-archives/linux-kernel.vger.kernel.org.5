Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366B07FD089
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjK2ITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK2ITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:19:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333D4172E;
        Wed, 29 Nov 2023 00:19:18 -0800 (PST)
Date:   Wed, 29 Nov 2023 08:19:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701245955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djJIouf8+bc7HXwkPpIknHpsufJGCMre9By1TQ0TV1g=;
        b=d/2cgVkErIPrs8IkbHo/Qjqebq+mDIIatPvNZEMu63PaLoJ9JzDVROnERW8tfZAC8kgGiw
        mcPIIM9VZ9yIMco2kroGISUptcNK8Pl3ZTM9dTTNzTeJcpjG3weQ5vm756/eJrVDPdPLx3
        I6cX5FanDzpZ8qN/wPF6PFuKme5k36Y/mb1A47E7D4e0Wqt3fIpujozxei9vN0LwecRFNJ
        +ndR8mMYLjmyp4v0KQkZGfXt/mRZEhXi3qVRd7vREyLlIqRFgBx+4v+s2DBRuN6aUrpQ5y
        P/KPRzGvltUOkOJfM5NAjwBFSMnKof3xZG10IJNYaVktugUZCoYW7vXvzs3vNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701245955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djJIouf8+bc7HXwkPpIknHpsufJGCMre9By1TQ0TV1g=;
        b=acsEVxjPvjymkYNTy4NejBBNFYI33bDmkDenK/emb5cshgk577bBFedrp7pgzTd1KAD8Ro
        rmVnpQO2JGdV5lCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ammy Yi <ammy.yi@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117163939.2468007-5-kan.liang@linux.intel.com>
References: <20231117163939.2468007-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170124595458.398.7592569170434852439.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cb4a6ccf35839895da63fcf6134d6fbd13224805
Gitweb:        https://git.kernel.org/tip/cb4a6ccf35839895da63fcf6134d6fbd13224805
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Nov 2023 08:39:39 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Nov 2023 20:25:03 +01:00

perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge

The same as Granite Rapids, the Sierra Forest and Grand Ridge also
supports the discovery table feature and the same type of the uncore
units. The difference of the available units and counters can be
retrieved from the discovery table automatically.
Just add the CPU model ID.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Link: https://lore.kernel.org/r/20231117163939.2468007-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7fb1c54..7927c0b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1877,6 +1877,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&gnr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&gnr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&gnr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
