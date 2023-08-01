Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0886376B252
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjHAKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjHAKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:50:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011A26A1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:48:14 -0700 (PDT)
Message-ID: <20230801103817.241792953@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uHpiyIwnqkWBnjjWfT4MmD20MOeZo84Wu6JyGvenGyY=;
        b=SG+X5mlbJnOXiGx2gZKqTfQbTRbSUmwaAgesSjIWvPs5MNKdilDh/shBuO47Zw+7hO6hUl
        M7jfGjKJwEr/ehNvq7wYpg3FpmCBGoKeOtw3XH767mpHyadAp1LDq/m4YDHUqAjEMBkQTO
        1+hubfM4slz5vJSm1raxiYh4jCYnfk/y+Len0b8/qc1EHV98CTlxi/AYirRHk2EXIFIBGz
        0Whf+DKmQ4nS6xHe4VBX5ceWy/tKQRS6C1f4rPWRiFWyluEEmZcCn/nHgjynojKnG/Qx9u
        EgGViXxgWd75A+P35JZyyIHMZ9pn/yGD35ZkE5jrE8hTd+UKtcc2I4q30D0BeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uHpiyIwnqkWBnjjWfT4MmD20MOeZo84Wu6JyGvenGyY=;
        b=yl1bJg4zPYMaPphoMzr1CrxxtVLFqsXQufoew48WbsOUkCoF0t+dHhkSu0wHIuylmTOWoL
        GvmAZ2tL4PbS7RBw==
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
Subject: [patch V3 38/60] x86/apic/uv: Get rid of wrapper callbacks
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:28 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why on earth makes a wrapper around some common function sense? Just to be
able to slap some vendor name on it...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

