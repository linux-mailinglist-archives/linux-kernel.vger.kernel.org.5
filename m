Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E07CBD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjJQI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjJQI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:29:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A4393
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:29:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE46C433C8;
        Tue, 17 Oct 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697531396;
        bh=zenHPyeKceFZFgEV+uWEq8+8PBkYyEyPfOUeL8osqrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tf//FAUeFQheaHmWrLkoJ86tEiiDy0CYDoSqtRLPj4EO5RDVapbXV6sb6Yh24FnCj
         irWbXxZiWw0qnc4EFQalQhRF/kJfjHpZ2eXnuliUsyJf3bTMBHltGSfi6/jg18/u9N
         vjMX/DlsgafM0KjKzEq0sc2puRv7uFzoy8w2VXlA+gxVAzT1WG4A9ik8BpOGp/zmmp
         OkL8Ut6N3RXUYkONPHqLUQVkJFzPnX81VJCzkHDz30pMY/5yw2SRWHCuFPcJVLXr2g
         z835BgF7HA2MOEhvDoEEtoLUc9MiRRYsGkn3Zse2eFw8qag/kRFa9z3bSFqdh47MiF
         CzxzwfBGzzluA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] perf/benchmark: fix seccom_unotify benchmark for 32-bit
Date:   Tue, 17 Oct 2023 10:29:52 +0200
Message-ID: <20231017082952.31510-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@google.com>

Commit 7d5cb68af638 (perf/benchmark: add a new benchmark for
seccom_unotify) added a reference to __NR_seccomp into perf. This is
fine as it added also a definition of __NR_seccomp for 64-bit. But it
failed to do so for 32-bit as instead of ifndef, ifdef was used.

Fix this typo (so fix the build of perf on 32-bit).

Fixes: 7d5cb68af638 (perf/benchmark: add a new benchmark for seccom_unotify)
Cc: Andrei Vagin <avagin@google.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 4798f9d18fe8..9de35df1afc3 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -26,6 +26,6 @@
 #ifndef __NR_setns
 #define __NR_setns 346
 #endif
-#ifdef __NR_seccomp
+#ifndef __NR_seccomp
 #define __NR_seccomp 354
 #endif
-- 
2.42.0

