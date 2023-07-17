Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19A3757095
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGQXg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGQXgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:36:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86751719
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:36:03 -0700 (PDT)
Message-ID: <20230717223225.273415268@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0+V5+gDglWXFOXAl/NKeyplEXp2IefeCUE4Fh7G+n/4=;
        b=KmKQ0C6ZMTvfEMgWOWKvqJMIcQO3L7KYwm4M44SqqGkqOH2msmDctXcslNo37q98COYsjG
        07S6EO1elC3GA+p5bQiQHXM/8k4yka5pcdl2S5mvDJNsZhxVwmT059drPucIR4jysYlhId
        C7JPTtIBcluvu3sPuF7gFwik4+hY/O87pPgcZ8r7V5GUTNXJRZaUegt8JEwcEx9wtTxgky
        4NbMROhWywUFAQzWyWAvwbgTlGskzmamUcc0fqwyNVt7+ay+/TtP3IoSi5msrNH2ytXSfB
        hkD1nkn5ZQORYTnsqLKGNnP95WTAniZsQ8HWKf4GcItae+rAMAvIdO0a+i10ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0+V5+gDglWXFOXAl/NKeyplEXp2IefeCUE4Fh7G+n/4=;
        b=LJkgLnx1AiB7LE4UdEfC/YxcSdmOw+WdxAJOnnMQ5DtxuaNVKgM7lUrO/t2Pw8cojki5fP
        NAcoDqSF1Z9mQ2Dg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 37/58] x86/apic/uv: Get rid of wrapper callbacks
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:31 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why on earth makes a wrapper around some common function sense? Just to be
able to slap some vendor name on it...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -783,11 +783,6 @@ static int uv_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static u32 apic_uv_calc_apicid(unsigned int cpu)
-{
-	return apic_default_calc_apicid(cpu);
-}
-
 static unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
@@ -838,7 +833,7 @@ static struct apic apic_x2apic_uv_x __ro
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
-	.calc_dest_apicid		= apic_uv_calc_apicid,
+	.calc_dest_apicid		= apic_default_calc_apicid,
 
 	.send_IPI			= uv_send_IPI_one,
 	.send_IPI_mask			= uv_send_IPI_mask,

