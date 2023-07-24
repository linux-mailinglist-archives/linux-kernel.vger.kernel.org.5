Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5636075F853
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGXNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGXNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:33:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20481BC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:33:49 -0700 (PDT)
Message-ID: <20230724132044.704993533@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=m8e6Afq1AsXnY+J/aZyhI7sMOyGQSw3ozTHH0I0x4W4=;
        b=NRpQPH0J2FEr174g1MdlHl9aYhmrEJx14C2AeYhq51rllbtPOA9e6o+p8x/K0PfNo3+soJ
        WN0alNPp8SK8iaLAusmPTqCsDzTs/1liZyrMBZEhOxv7wbjCy5MgyEOcDCURoX3+A2cOpO
        u+aUNQosNEHF5VEn5hkzHhMgIkL60WuEZLT6WfMYxJHp2ZEXM3MDJjaQANkBFykBZ9CTVm
        vcCWNAnRxB5RCZEw5/TUGasurXzsTJSGMwjUb3Y1OUWIOeVaD79eK9grtpGRjo22mRmDX6
        ZV6MfKQhpbH4w8qNtz0Cemzh+q/q0fneyk/G/NjCxsyIhzUqOTo6kav7RleUfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=m8e6Afq1AsXnY+J/aZyhI7sMOyGQSw3ozTHH0I0x4W4=;
        b=LBEMXwzIHZHwVn6OB5S+ok28vdlLS/1BWV45xPqV3EltHKyfasosadq9Hi2I9WfLCgoNTY
        ielJaPYQ7Yi1OrDw==
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
Subject: [patch V2 02/58] x86/cpu: Remove unused physid_*() nonsense
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:33:47 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

