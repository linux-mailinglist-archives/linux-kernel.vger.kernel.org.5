Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047776B225
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjHAKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjHAKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:46:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A568E9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:46:45 -0700 (PDT)
Message-ID: <20230801103815.262993621@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=m8e6Afq1AsXnY+J/aZyhI7sMOyGQSw3ozTHH0I0x4W4=;
        b=A83zeqdCvkwiIHahWHf9dHZtnuLP5BjrQMaHFG7yp1bCFfarwNO78PQ6fjVw8eD+1VFwrw
        fTQ4ns96QNS3KXnB0Akou6k/QeYit2kTBy8cH+Ksqv837WQpDa0ddQ40mEa88QtL55XY9q
        MY4PY/okglnfO3KtDnLIRMxGHBfplcxV8VO1Zy3yBfyV8TnK29wWFDU5VQbbNk+/8ZOPyg
        hfNfcWsS7mm2XI6A5lqYh60PxbzIACEgYPHVUTqxSycHwcEqQ2GtnstL75a5+RiiPOtRBz
        TueZNc+8NkJysVCyrfxuHTfaaSwbKjhZVC0PSQFLD4WWqDEwRA7VH/fPAiSE5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=m8e6Afq1AsXnY+J/aZyhI7sMOyGQSw3ozTHH0I0x4W4=;
        b=aCmI3iiMN5es+AKUFUcjzXl3E/higAd7xogP3Aw/PM7bE7ipS6x2mO1LH7c9Vk7kOZB08V
        KbEK9g2up9HlPjDw==
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
Subject: [patch V3 02/60] x86/cpu: Remove unused physid_*() nonsense
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:43 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tons of silly unused bitmap wrappers...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/mpspec.h |   26 --------------------------
 1 file changed, 26 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -87,13 +87,7 @@ struct physid_mask {
 typedef struct physid_mask physid_mask_t;
 
 #define physid_set(physid, map)			set_bit(physid, (map).mask)
-#define physid_clear(physid, map)		clear_bit(physid, (map).mask)
 #define physid_isset(physid, map)		test_bit(physid, (map).mask)
-#define physid_test_and_set(physid, map)			\
-	test_and_set_bit(physid, (map).mask)
-
-#define physids_and(dst, src1, src2)					\
-	bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
 
 #define physids_or(dst, src1, src2)					\
 	bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
@@ -101,29 +95,9 @@ typedef struct physid_mask physid_mask_t
 #define physids_clear(map)					\
 	bitmap_zero((map).mask, MAX_LOCAL_APIC)
 
-#define physids_complement(dst, src)				\
-	bitmap_complement((dst).mask, (src).mask, MAX_LOCAL_APIC)
-
 #define physids_empty(map)					\
 	bitmap_empty((map).mask, MAX_LOCAL_APIC)
 
-#define physids_equal(map1, map2)				\
-	bitmap_equal((map1).mask, (map2).mask, MAX_LOCAL_APIC)
-
-#define physids_weight(map)					\
-	bitmap_weight((map).mask, MAX_LOCAL_APIC)
-
-#define physids_shift_right(d, s, n)				\
-	bitmap_shift_right((d).mask, (s).mask, n, MAX_LOCAL_APIC)
-
-#define physids_shift_left(d, s, n)				\
-	bitmap_shift_left((d).mask, (s).mask, n, MAX_LOCAL_APIC)
-
-static inline unsigned long physids_coerce(physid_mask_t *map)
-{
-	return map->mask[0];
-}
-
 static inline void physids_promote(unsigned long physids, physid_mask_t *map)
 {
 	physids_clear(*map);

