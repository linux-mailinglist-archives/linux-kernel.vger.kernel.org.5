Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB967692F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjGaKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjGaKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:19:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24841A6;
        Mon, 31 Jul 2023 03:19:35 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaGBxewauEhPBUimcq/pODsBkFg4BhibqIT0MYHZ9Qk=;
        b=JdLzJzBH2JOXIV7xEgVG1cuyTBW8V9ZYDjAWH1QxLDiHj1CMqBaMjY581mlP6TNiLwfDgU
        2Z4xNGBZbGMaJddzcaBivwvvtbuseGt0jm29+JEf6/CAq6fN/6bv04q6mCbzK+dkVSxC/S
        ii6p4jt6mx4oKvvXAEcX62dYAvQdA7bVj5VqmQJfXGLocEOrIbQGKtfFjSAyed63bZDq+8
        kwphYKmCe4f6exnykzk2PudDKXTCeu1FWc/TGkhUiiaChLN4z1GyMbrI0ZLiLl+8DJwKGE
        J23jZ7LHh9vYcA+o4QroSm9M3uc4kVERsCfPLdLpgVL53gTYVRk2r2v0xYnMxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaGBxewauEhPBUimcq/pODsBkFg4BhibqIT0MYHZ9Qk=;
        b=izxcmJBpjBejKy0rGmmS9q19mN3NqbiE2vy8wm0Sk30yWXw5ZWdUxFTM9IcQahRAfJl8Hr
        1nwrqAvaOIOAVUAQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/mem: Introduce PERF_MEM_LVLNUM_UNC
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230725150206.184-2-ravi.bangoria@amd.com>
References: <20230725150206.184-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <169079877327.28540.11395438134296621838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     526fffabc5fb63e80eb890c74b6570df2570c87f
Gitweb:        https://git.kernel.org/tip/526fffabc5fb63e80eb890c74b6570df2570c87f
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Tue, 25 Jul 2023 20:32:04 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:28:44 +02:00

perf/mem: Introduce PERF_MEM_LVLNUM_UNC

Older API PERF_MEM_LVL_UNC can be replaced by PERF_MEM_LVLNUM_UNC.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230725150206.184-2-ravi.bangoria@amd.com
---
 include/uapi/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3767543..39c6a25 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1339,7 +1339,8 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0x8 available */
+/* 5-0x7 available */
+#define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
