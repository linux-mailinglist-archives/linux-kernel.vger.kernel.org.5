Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37C476B254
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjHAKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjHAKuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:50:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D784493
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:48:20 -0700 (PDT)
Message-ID: <20230801103817.514745407@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1t5AYKxWBGS5UIcYUily8whdBGpo1cGe3a+nedmnJoI=;
        b=ugunpQLez4IeCETdM/Imk81NmZS2V0dcD8qWAefO7TK4zD85zEVcQLKuL+Vn4dK+1SO50Q
        TewwhywfWxpN9I3kA5XEWwyQc9G69vat6KZJTyAN3ZKJ3aVwypmiwqDv6I+aKRAwNzuFoT
        vgwPb/Su18S8uQi+yKYAPcOf0jk5JZ7KzXHtf3ukEhJ12SaBk5HKyy2OsFtI9o/j/Sc187
        VNhjKyGGsFZjiHjSuF9jkIT06FfPqJ33krfUS/YXpX0Z12WLcIIm7o6ne1ox3546Eqw1Fi
        hvh89Y6L67BurfP9xX/I/eYeLisl7NlMYH4JjYUGcFhWaWLzZahHcoOzZxeJ9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1t5AYKxWBGS5UIcYUily8whdBGpo1cGe3a+nedmnJoI=;
        b=xb6MTZPu1mNmqYhL1B9Gy9GjhJAaFQqS5QO9ZB8eOXXipUlU9C8QK6bK+4pTrWur2RVc3S
        jamES18/YJ9mWjAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 43/60] x86/apic: Simplify X2APIC ID validation
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:34 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

