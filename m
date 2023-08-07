Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE97726B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHGNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjHGNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92997199B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:17 -0700 (PDT)
Message-ID: <20230807135027.848546733@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JDi87pLR5a8qAf6RSOGJA9lNdy/Pfs6qvOHQvJ93Uhk=;
        b=YHMlPjfwlSWB+MqCo5PLl5iYmiuKmuIwNBeJ25V3URVpA/YrgQ9jmn0bHqcND5N8eUp/Qu
        7JiFexoliy01Ti+FUZhtsT+dIXw9KhjS+/UOtm3JKx278JzpNtCWDPbjQjIz491iB4Wn63
        kYcKQX7Gjr8/xgVxqQ3oWJVWUGHJKP40dpoRBzsKtn8vejklPRLbLwH38iABGUqt0ex0Lx
        8TGIWDHMoS3g7iuEQyoNW0wK5NYum9Too9rc9I4c/XBNIfmFgRTXsvBlSEF4BEKhbRfNkj
        eNEV5kGqm0yTTSzv9amGBda1znVVZp5RJUoGM21X6P1enICNujy5DazraZEYiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JDi87pLR5a8qAf6RSOGJA9lNdy/Pfs6qvOHQvJ93Uhk=;
        b=LrQJoHRjAJkn+L3kxPGDC2//khzseVUhnrqk+FQYBcL2T+jocUme7FbolPq83dMgmSyP0S
        EYw2LuJ0IIa0gpDA==
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
Subject: [patch 27/53] x86/of: Use new APIC registration functions
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:15 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/devicetree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -136,7 +136,7 @@ static void __init dtb_cpu_setup(void)
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-		generic_processor_info(apic_id);
+		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 	}
 }
 

