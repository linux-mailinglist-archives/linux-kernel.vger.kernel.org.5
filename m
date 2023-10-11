Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811727C5936
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346938AbjJKQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346866AbjJKQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:33:47 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31FB6;
        Wed, 11 Oct 2023 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1697042027; x=1728578027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ayP63XpEjjnUm/94ajAACfUiM49T7g7LwK1ZuxXw33E=;
  b=abl7Hz2ji4w6H4xEiBmzMeHxMDZs16a8hD02Ij3J7zJqo9dNYuqfR94D
   cWs2jSOI2Pb/f6vUI6RjXYAfULRSPWoLdoE1UJZMMDQG+V5TuBFrBa/dI
   3sOjFFCulAyrkp3utgO4O8kRpv0mWLrRj6L0DTDSx+XN7ySJ3wCLmtD6W
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,216,1694736000"; 
   d="scan'208";a="244910999"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:38 +0000
Received: from EX19D002EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id EC2F840D61;
        Wed, 11 Oct 2023 16:33:37 +0000 (UTC)
Received: from dev-dsk-sironi-1a-c39c3a30.eu-west-1.amazon.com (172.19.97.49)
 by EX19D002EUA002.ant.amazon.com (10.252.50.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 16:33:33 +0000
From:   Filippo Sironi <sironi@amazon.de>
To:     <linux-kernel@vger.kernel.org>
CC:     <sironi@amazon.de>, <tony.luck@intel.com>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8 pages
Date:   Wed, 11 Oct 2023 16:33:20 +0000
Message-ID: <20231011163320.79732-1-sironi@amazon.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [172.19.97.49]
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D002EUA002.ant.amazon.com (10.252.50.7)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some of our large servers and some of our most sorry servers ( :) ),
we're seeing the kernel reporting the warning in mce_gen_pool_add: "MCE
records pool full!". Let's increase the amount of memory that we use to
store the MCE records from 2 to 8 pages to prevent this from happening
and be able to collect useful information.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 arch/x86/kernel/cpu/mce/genpool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index fbe8b61c3413..870dcb7011cd 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -17,9 +17,9 @@
  *
  * This memory pool is only to be used to save MCE records in MCE context.
  * MCE events are rare, so a fixed size memory pool should be enough. Use
- * 2 pages to save MCE events for now (~80 MCE records at most).
+ * 8 pages to save MCE events for now (~320 MCE records at most).
  */
-#define MCE_POOLSZ	(2 * PAGE_SIZE)
+#define MCE_POOLSZ	(8 * PAGE_SIZE)
 
 static struct gen_pool *mce_evt_pool;
 static LLIST_HEAD(mce_event_llist);
-- 
2.33.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



