Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B7776A22
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjHIUgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjHIUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190ADB4;
        Wed,  9 Aug 2023 13:36:05 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IkphxmPM5tysB4op+m1B+DDZ6LJglMpAWxW9xITodPE=;
        b=cn20GOZA+83HgU9xYQDT3T7EPnr99AqNbtGHgR1O24P58uPEn8FjVKmepWsDOkM66c4gCH
        8MFeI1m5k+mQaTQof8zTkSE9VzCj5J2h5CmhlC9UV4+ucdTEghxL898WzNCYDCnYNI2GhH
        jgD2UFvbtfpdlwhFtvN0PAiT1i3l91saiZWt/baBl9p61MDKmkKFw/o4kXqX+++VkEU2DU
        aMQ6dbwMQZELMAXKhPsZDGwe1Aa0t2JrQSMNgKMLpvWnKv7c2kxARvXSL5rIC8YBuSi5dJ
        p5hXcYI6EsMhthu3irsLEcwPntNVgXGTFyepbWSpWgSNvry+IFvoyILRSnPO5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IkphxmPM5tysB4op+m1B+DDZ6LJglMpAWxW9xITodPE=;
        b=iIuM8jOGYgfhiElq7CGBFrQIrVpJfNAb0svdW5+aMiD1gHYqpWpA5Dvjrgu/yq0W7mINTv
        LrdatQ9mK/QgBvBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Turn on static calls
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336293.27769.2235554939869573461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f8542a55499a69a859c84866b66f0df43933e563
Gitweb:        https://git.kernel.org/tip/f8542a55499a69a859c84866b66f0df43933e563
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:24 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:55 -07:00

x86/apic: Turn on static calls

Convert all the APIC callback inline wrappers from apic->foo() to
static_call(apic_call_foo)(), except for the safe_wait_icr_idle() one which
is only used during SMP bringup when sending INIT/SIPI. That really can do
the conditional callback. The regular wait_icr_idle() matters as it is used
in irq_work_raise(), so X2APIC machines spare the conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/apic.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index ddafd14..5af4ec1 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -394,68 +394,67 @@ DECLARE_APIC_CALL(write);
 
 static __always_inline u32 apic_read(u32 reg)
 {
-	return apic->read(reg);
+	return static_call(apic_call_read)(reg);
 }
 
 static __always_inline void apic_write(u32 reg, u32 val)
 {
-	apic->write(reg, val);
+	static_call(apic_call_write)(reg, val);
 }
 
 static __always_inline void apic_eoi(void)
 {
-	apic->eoi();
+	static_call(apic_call_eoi)();
 }
 
 static __always_inline void apic_native_eoi(void)
 {
-	apic->native_eoi();
+	static_call(apic_call_native_eoi)();
 }
 
 static __always_inline u64 apic_icr_read(void)
 {
-	return apic->icr_read();
+	return static_call(apic_call_icr_read)();
 }
 
 static __always_inline void apic_icr_write(u32 low, u32 high)
 {
-	apic->icr_write(low, high);
+	static_call(apic_call_icr_write)(low, high);
 }
 
 static __always_inline void __apic_send_IPI(int cpu, int vector)
 {
-	apic->send_IPI(cpu, vector);
+	static_call(apic_call_send_IPI)(cpu, vector);
 }
 
 static __always_inline void __apic_send_IPI_mask(const struct cpumask *mask, int vector)
 {
-	apic->send_IPI_mask(mask, vector);
+	static_call_mod(apic_call_send_IPI_mask)(mask, vector);
 }
 
 static __always_inline void __apic_send_IPI_mask_allbutself(const struct cpumask *mask, int vector)
 {
-	apic->send_IPI_mask_allbutself(mask, vector);
+	static_call(apic_call_send_IPI_mask_allbutself)(mask, vector);
 }
 
 static __always_inline void __apic_send_IPI_allbutself(int vector)
 {
-	apic->send_IPI_allbutself(vector);
+	static_call(apic_call_send_IPI_allbutself)(vector);
 }
 
 static __always_inline void __apic_send_IPI_all(int vector)
 {
-	apic->send_IPI_all(vector);
+	static_call(apic_call_send_IPI_all)(vector);
 }
 
 static __always_inline void __apic_send_IPI_self(int vector)
 {
-	apic->send_IPI_self(vector);
+	static_call_mod(apic_call_send_IPI_self)(vector);
 }
 
 static __always_inline void apic_wait_icr_idle(void)
 {
-	if (apic->wait_icr_idle)
-		apic->wait_icr_idle();
+	static_call_cond(apic_call_wait_icr_idle)();
 }
 
 static __always_inline u32 safe_apic_wait_icr_idle(void)
