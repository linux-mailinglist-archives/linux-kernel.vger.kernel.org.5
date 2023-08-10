Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD2777A81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjHJOXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjHJOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501A2D69
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9355B65D97
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A24BC433C8;
        Thu, 10 Aug 2023 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677357;
        bh=yCLl77lX4o4d0X3UveMkTccIfSP8PULnksDo4HNqlss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bE/5ycRcHjEHnJfYHG10Q7p/nvO0wujx9qYPBNw2jOxRQwrr3TUL8xLdRUm33QavS
         FM+7U5N2E1xlEHo3tlyPbm+UORZdsaHLQERAP1qDZ7NuG5I1CkkQXCZYO6gsXKm+mh
         rAadFrYiyu+E0fCffkjGfyeMt8tyrEz48ytFY01LGhZeZGztCWOReG5DZrO/PFJpRi
         NKIq2wvBvOpwS55ZJpdMyDBcSf4KqXmDukUsWPDuPL6JazmE+R3npWhiREVwh48OEx
         ugn48IcVYpnk7ajTDLlB6MoCFkCbxvSu3DxdJC6+1NZGihYS5PTnW4KjMkRPZtrf9c
         ID0JsCKigZCpA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/17] time: make sysfs_get_uname() function visible in header
Date:   Thu, 10 Aug 2023 16:19:30 +0200
Message-Id: <20230810141947.1236730-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

This function is defined globally in clocksource.c and used conditionally
in clockevent.c, which the declaration hidden when clockevent support
is disabled. This causes a harmless warning in the definition:

kernel/time/clocksource.c:1324:9: warning: no previous prototype for 'sysfs_get_uname' [-Wmissing-prototypes]
 1324 | ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt)

Move the declaration out of the #ifdef so it is always visible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/tick-internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f06..481b7ab65e2cf 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -56,7 +56,6 @@ extern int clockevents_program_event(struct clock_event_device *dev,
 				     ktime_t expires, bool force);
 extern void clockevents_handle_noop(struct clock_event_device *dev);
 extern int __clockevents_update_freq(struct clock_event_device *dev, u32 freq);
-extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
 
 /* Broadcasting support */
 # ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
@@ -197,3 +196,5 @@ void hrtimers_resume_local(void);
 #else
 #define JIFFIES_SHIFT	8
 #endif
+
+extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
-- 
2.39.2

