Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5B7FD085
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjK2ITO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjK2ITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:19:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C81735;
        Wed, 29 Nov 2023 00:19:18 -0800 (PST)
Date:   Wed, 29 Nov 2023 08:19:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701245955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/uz1/fNwyG7HYXpXFVuptWMb0PsFl3St6R4c9tq+FI=;
        b=22furB+v3evXBmdnbvCjmg/jpkqFE955rZpphtEeRuCW08imirHTB/A7BY2tkqXVquvief
        PjT8FbcdlsV9GMpPG1oeb+APxNRw8mtZo2bY2PmO2z+roFgN9J/fuUnlwAKNcGp9Vw+NJi
        0bvk0quqEzNcfB64FgTjXzqpd5BJhCS3gwrn57H4yn4CFU1wZzJGrVbQVaOL6+mS6+JD9D
        jTCRCacMQkKdC22shu2rYk7E2E1YdVD4+mKgnFNH5pnY7GE+aLZPj+DeqMcpogprTxQ9Qq
        aQ++Y4eH1FP6HGmg8wniWxNfVs+vKg9PEhNsE5LIcc9BKQKaflASArwz698STw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701245955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/uz1/fNwyG7HYXpXFVuptWMb0PsFl3St6R4c9tq+FI=;
        b=+2YVIwPl0heGj/5r1OIe6AYglYXpcFXS6LhcUAal9XMkg1obvSCbyukKCQW2eHkraJw4do
        uiCRi00aC/K3SfAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support IIO free-running
 counters on GNR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ammy Yi <ammy.yi@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117163939.2468007-4-kan.liang@linux.intel.com>
References: <20231117163939.2468007-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170124595523.398.17885878849892103147.tip-bot2@tip-bot2>
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

Commit-ID:     388d76175bd9bbad52bbff25c88361d9e5c6615e
Gitweb:        https://git.kernel.org/tip/388d76175bd9bbad52bbff25c88361d9e5c6615e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Nov 2023 08:39:38 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Nov 2023 20:25:02 +01:00

perf/x86/intel/uncore: Support IIO free-running counters on GNR

The free-running counters for IIO uncore blocks on Granite Rapids are
similar to Sapphire Rapids. The key difference is the offset of the
registers. The number of the IIO uncore blocks can also be retrieved
from the discovery table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Link: https://lore.kernel.org/r/20231117163939.2468007-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ab31cda..aeaa8ef 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6648,11 +6648,21 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	NULL,
 };
 
+static struct freerunning_counters gnr_iio_freerunning[] = {
+	[SPR_IIO_MSR_IOCLK]	= { 0x290e, 0x01, 0x10, 1, 48 },
+	[SPR_IIO_MSR_BW_IN]	= { 0x360e, 0x10, 0x80, 8, 48 },
+	[SPR_IIO_MSR_BW_OUT]	= { 0x2e0e, 0x10, 0x80, 8, 48 },
+};
+
 void gnr_uncore_cpu_init(void)
 {
-	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR, 0, NULL,
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
+						UNCORE_SPR_MSR_EXTRA_UNCORES,
+						spr_msr_uncores,
 						UNCORE_GNR_NUM_UNCORE_TYPES,
 						gnr_uncores);
+	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
+	spr_uncore_iio_free_running.freerunning = gnr_iio_freerunning;
 }
 
 int gnr_uncore_pci_init(void)
