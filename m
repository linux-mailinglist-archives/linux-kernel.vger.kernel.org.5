Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EE75704D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGQXOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGQXOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:14:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B887E12D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:38 -0700 (PDT)
Message-ID: <20230717223223.194942624@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wpfpHOFENc3IPULGB99WSPXmdgySC90OqR7vmMwU8qU=;
        b=qAJH9ZInd6QS57kqU21jjx7PhuqHsepVuGll5ofOEwQWJL1/sFLOnjZ34EBGsJwJWbKvpY
        wv+zh4cBYwLIzYXEPvnhIHZg8F86wcIdAl2xh8iRVq8plyF22kHCi4ZU5rD9mh8u3+yc2b
        BcKn8m/oiYwct7zjwIhDevHX2StrtmZzarP6GQkFUqkwqnZTYA+OqDymMH05RTuF2sGRk6
        aiqek6XxC65mA9bJ3Klc1FP49ItANn3puhn0SNDgV4UcNPTKDCzKQNOF0vdJGr65iPfrHN
        bjDQkqSbexkWzcb/BN7wQYYsrxxFtUXSHylPl74uFG92tSDMrZ6GD6rfXRnK5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wpfpHOFENc3IPULGB99WSPXmdgySC90OqR7vmMwU8qU=;
        b=ZwLQueWk3iuye6RCxPL7GI5eQfeQLFp/Cmp+9F4jdovHOSbJt2O3OGatSO5ru7KKSf09oo
        qoIwD8KcUbsW+VBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 02/58] x86/cpu: Remove unused physid_*() nonsense
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:36 +0200 (CEST)
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

