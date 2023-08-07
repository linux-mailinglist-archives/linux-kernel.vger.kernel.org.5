Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D7772698
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjHGNwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjHGNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04E9E79
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:36 -0700 (PDT)
Message-ID: <20230807135026.471131104@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZB2Tk1eymt/PbXMe0IaE8sjzy2MyrXEyff6m5gvO+II=;
        b=VIgCRyLDM+TeTTjYWM7f7ZMNKjZaw7AKGeuhsqFUBNEvcfXO95cO8ih3k0HSdj/cJ+ovMp
        7r3acC7grHSUIXryGZBQcmDLkNZVOi8om+PVcvjJZ8YGRCLWmVCfy5a39C5gY9K42ChBh9
        4MIgh5SaNtZ6D8g/mfUJucIURiNGBijKJMBgdYnYNGsuMnx1O5HGFLVKFD05ihgSiRHDHr
        qfqAkzFmK3hVssjabfiuI6Hojn2TqxJ0FOyEMtPqSgflkik9ZXDyb9NwPqHLF96nH2rcjW
        BozJALw8NUSMDVDxGzhdjNowcC17PrcqZE/FRNfwtsU4iwrVKyKnUatVTrqQdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZB2Tk1eymt/PbXMe0IaE8sjzy2MyrXEyff6m5gvO+II=;
        b=rEJdZnL380eOyNl4DeECbImyvDu62+fawzelWR3CXsCH7BhRa06BNE0t54zNI9Wy12SSTT
        srNI5MYAtz9G7ZCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 01/53] x86/cpu/topology: Cure off by one in fake_topology()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:34 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shift count for a single core CPU is obviously 0 and not 1.

Not that it matters much, but keep it correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -75,7 +75,7 @@ static bool fake_topology(struct topo_sc
 	 * which has useless CPUID information.
 	 */
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
-	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 1, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
 
 	return tscan->c->cpuid_level < 1 || xen_pv_domain();
 }

