Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D07AA50D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjIUWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjIUWaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:30:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F4465A5;
        Thu, 21 Sep 2023 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nqDTsSYtIrtsgJfRZxQSmVfUy4UI0fM8vU1yAMBIetU=;
        t=1695316163; x=1696525763; b=EXKAgTuPVVfy8ylWiMVnePM2S25FQbqLGHAhT1vpoj7XbtN
        noPgP9Jg0aEsCyUWzDGafbS9LhYXtZGmWlZIHEcZ5/9Hl2KjA4Jez+eevbJN0LyTUwZyaJ2h/dFv5
        nUADlD6Z2jmONDwwQ8LGjyibG8/cSVRhcY925jJ0P8uCjkIcSt7GeuD/wen370bqujHA+uGuKFFkj
        lmki8Q/Vl8R7xDOJxOwFmgGXlbDxpvhyFLAJauCE6D1i/0sf9THBR/UJz4b/qdU1ZHYh6F6Czc2gE
        OmP0MD0ktlF4pyiL4bhjTWW8EiPtkJVX4+5BsSpAvxGYWkvxkjH0637rQA7vGoxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qjFPo-00D3lb-0V;
        Thu, 21 Sep 2023 10:52:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 4/4] tracing/timer: use __print_sym()
Date:   Thu, 21 Sep 2023 10:51:34 +0200
Message-ID: <20230921105129.e76b17c18447.I5e112e423a69704fa05db74a05a6ebaad45d4f6e@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921085129.261556-5-johannes@sipsolutions.net>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use the new __print_sym() in the timer tracing, just to show
how to convert something. This adds ~80 bytes of .text for a
saving of ~1.5K of data in my builds.

Note the format changes from

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { (1 << 0), "POSIX_TIMER" }, { (1 << 1), "PERF_EVENTS" }, { (1 << 2), "SCHED" }, { (1 << 3), "CLOCK_UNSTABLE" }, { (1 << 4), "RCU" }, { (1 << 5), "RCU_EXP" })

to

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { 1, "POSIX_TIMER" }, { 2, "PERF_EVENTS" }, { 4, "SCHED" }, { 8, "CLOCK_UNSTABLE" }, { 16, "RCU" }, { 32, "RCU_EXP" })

Since the values are now just printed in the show function as
pure decimal values.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/trace/events/timer.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index b4bc2828fa09..cb8294da29d0 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -382,26 +382,18 @@ TRACE_EVENT(itimer_expire,
 #undef tick_dep_mask_name
 #undef tick_dep_name_end
 
-/* The MASK will convert to their bits and they need to be processed too */
-#define tick_dep_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-#define tick_dep_name_end(sdep)  TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-/* NONE only has a mask defined for it */
-#define tick_dep_mask_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-
-TICK_DEP_NAMES
-
-#undef tick_dep_name
-#undef tick_dep_mask_name
-#undef tick_dep_name_end
-
 #define tick_dep_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
 #define tick_dep_mask_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
 #define tick_dep_name_end(sdep) { TICK_DEP_MASK_##sdep, #sdep }
 
+TRACE_DEFINE_SYM_LIST(tick_dep_names, TICK_DEP_NAMES);
+
+#undef tick_dep_name
+#undef tick_dep_mask_name
+#undef tick_dep_name_end
+
 #define show_tick_dep_name(val)				\
-	__print_symbolic(val, TICK_DEP_NAMES)
+	__print_sym(val, tick_dep_names)
 
 TRACE_EVENT(tick_stop,
 
-- 
2.41.0

