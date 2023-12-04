Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED8803B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjLDRSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjLDRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:18:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6474C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:18:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5EC13D5;
        Mon,  4 Dec 2023 09:19:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3377F3F6C4;
        Mon,  4 Dec 2023 09:18:16 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        andreyknvl@gmail.com, bp@alien8.de, dvyukov@google.com,
        mark.rutland@arm.com
Subject: [PATCH] kcov: remove stale RANDOMIZE_BASE text
Date:   Mon,  4 Dec 2023 17:18:07 +0000
Message-Id: <20231204171807.3313022-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig help text for CONFIG_KCOV describes that recorded PC values
will not be stable across machines or reboots when RANDOMIZE_BASE is
selected. This was the case when KCOV was introduced in commit:

  5c9a8750a6409c63 ("kernel: add kcov code coverage")

However, this changed in commit:

  4983f0ab7ffaad1e ("kcov: make kcov work properly with KASLR enabled")

Since that commit KCOV always subtracts the KASLR offset from PC values,
which ensures that these are stable across machines and across reboots
even when RANDOMIZE_BASE is selected.

Unfortunately, that commit failed to update the Kconfig help text, which
still suggests disabling RANDOMIZE_BASE even though this is no longer
necessary.

Remove the stale Kconfig text.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 lib/Kconfig.debug | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc019..e77873cf85c78 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2103,10 +2103,6 @@ config KCOV
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
 
-	  If RANDOMIZE_BASE is enabled, PC values will not be stable across
-	  different machines and across reboots. If you need stable PC values,
-	  disable RANDOMIZE_BASE.
-
 	  For more details, see Documentation/dev-tools/kcov.rst.
 
 config KCOV_ENABLE_COMPARISONS
-- 
2.30.2

