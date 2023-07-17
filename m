Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABA75709D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGQXkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGQXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:40:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A71BC8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:40:02 -0700 (PDT)
Message-ID: <20230717223225.574767249@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Q1JNQJEMBxAgDkdW0pLI2m/sGBRaEoryy+htOkBQTrI=;
        b=XVTtGjs7K8KwXqAXQvamTB5j0FI8ZG0Etn3P0nAYb44RxqjvhlSp/ZMS0bTDhd47zD421T
        KNyKLFg4ir8BlPTfLrXqqVk2afMM57cZg4BVBNQ2m7ARbx4+Li0B3zFwQHqmBDIpzLCZEk
        eWS64EuDFrq0TnFan+G9UnQ31oTgdewrokNT4L0FUVteWoPDDIuNG9Ttv/XBiO68fEPZmM
        w95GoK1ph9rrJH7FmgkY9Tn5BQ6qtkgmJhr4ykrP99iENkaYkw0LW9YZ0m+M/a6fyEft+C
        V7xpiILcDTYOsS/19vI1LjzzCDfsEj/JtuOV8m1pWdkWZjl7Hfkik4V0lMy93Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Q1JNQJEMBxAgDkdW0pLI2m/sGBRaEoryy+htOkBQTrI=;
        b=XU+BJFq/bYmMMjorgjZW5KwpaePkOpCDNCYgLXktF/uhc13HDW746lbXxGqxGnZ9sSSM/M
        UmZoOTTbC187LCCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 42/58] x86/apic: Simplify X2APIC ID validation
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:40 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in doing the zero equals unlimited check and if not zero compare
against the real number.

Unlimited is UINT_MAX. So initialize the variable with UINT_MAX and compare
less than or equal.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/x2apic_phys.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -8,7 +8,7 @@
 int x2apic_phys;
 
 static struct apic apic_x2apic_phys;
-static u32 x2apic_max_apicid __ro_after_init;
+static u32 x2apic_max_apicid __ro_after_init = UINT_MAX;
 
 void __init x2apic_set_max_apicid(u32 apicid)
 {
@@ -125,10 +125,7 @@ static int x2apic_phys_probe(void)
 /* Common x2apic functions, also used by x2apic_cluster */
 int x2apic_apic_id_valid(u32 apicid)
 {
-	if (x2apic_max_apicid && apicid > x2apic_max_apicid)
-		return 0;
-
-	return 1;
+	return apicid <= x2apic_max_apicid;
 }
 
 unsigned int x2apic_get_apic_id(unsigned long id)

