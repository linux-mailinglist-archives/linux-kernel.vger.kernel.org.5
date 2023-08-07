Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8D77269F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjHGNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjHGNwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EE319B7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:51 -0700 (PDT)
Message-ID: <20230807135026.958541204@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lXvAKFXjZsZtpNvVsuWPTJGbTaymXF55DtvrpybYokk=;
        b=l1PZ8I8giV3b+mf4JVnWGkSVb1DnTyMcH4HCqJUibxXXnHCf2E0WsmrRnB+zpXKGx7i6Ms
        hwRBnofPezpEtZ1ebp0TjO/yKFWvIcTVCohVtwos9iSApAwLtEvoKsK5n4LOmXvaL+mrG7
        55mYpHHT11kq5RhnShL9Wt11jawmNg9RCCdR0m5oNkGM8jbqTLgFbAysqA8WaSLDFD3xy6
        4JX4DhivQHoCq1Eukpl8SPsGESkAkd0OjBj5QKivEW6QekR9SZh2fbwRJG7VivLiolSYqL
        0bt67O62ZW+bqUfPB3rZIBjNlMkeAAUDvHZfkhGCIKwgqhkiCVF7aVKsa4As2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lXvAKFXjZsZtpNvVsuWPTJGbTaymXF55DtvrpybYokk=;
        b=8AAFg35e1qoRQxuooevFqDgoPqOO+KTzGdPftEzlqfkvlGO8J/GvJ1y7ebTnEXzOdOs7Nq
        chnTu+Su1ZUXKqAA==
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
Subject: [patch 10/53] x86/mpparse: Provide separate early/late callbacks
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:49 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early argument of x86_init::mpparse::get_smp_config() is more than
confusing. Provide two callbacks, one for each purpose.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/x86_init.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -17,11 +17,15 @@ struct irq_domain;
  * @setup_ioapic_ids:		platform specific ioapic id override
  * @find_mptable:		Find MPTABLE early to reserve the memory region
  * @get_smp_config:		get the smp configuration
+ * @early_parse_smp_cfg:	Parse the SMP configuration data early before initmem_init()
+ * @parse_smp_cfg:		Parse the SMP configuration data
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
 	void (*find_mptable)(void);
 	void (*get_smp_config)(unsigned int early);
+	void (*early_parse_smp_cfg)(void);
+	void (*parse_smp_cfg)(void);
 };
 
 /**

