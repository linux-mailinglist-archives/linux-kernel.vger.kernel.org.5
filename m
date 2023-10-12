Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D77C76F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442659AbjJLTdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442279AbjJLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D2BE9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4563EC433AD;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=U8fkZeKWQAxeRz/DmSHJexH3yzP6c2P5T0N66hgyrCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4RZMiZmrCkANuhqGb5vzkcuscOaDyTsLTZCo2BlSGScSyy5qFoZB1qtKnJUQE81f
         xCCHe59Vu67+k5+diQHgmaCzqV0SYxzlWfybZue8PJM+VVM7KnF9CyazJAW68Q3pJw
         0JIUSUZ3qH6pyuuab6PRl58FrCeRmh9pCDCzOz8D+SGzNpyAQNAmclC0Il2R3nVS82
         I+d6xzFIaxvjlKdxJivGqgof3SRfbb0IObuNptrOMieefBbz8BRrsxAV0yL15T6eTr
         +YcmG4bGcSz2UK/fvz8Yy0RJ4IUcYaOFpGpH7SPknGC4u1GqvEGAnIvIOiST1ZCY5e
         hvb3GCekooQMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E063CE0DE3; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 14/19] tools/nolibc: don't define new syscall number
Date:   Thu, 12 Oct 2023 12:32:28 -0700
Message-Id: <20231012193233.207857-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Weißschuh <linux@weissschuh.net>

All symbols created by nolibc are also visible to user code.
Syscall constants are expected to come from the kernel headers and
should not be made up by nolibc.

Refactor the logic to avoid defining syscall numbers.
Also the new code is easier to understand.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20230917-nolibc-syscall-nr-v2-3-03863d509b9a@weissschuh.net
---
 tools/include/nolibc/sys.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8389820e1928..f05144e46b67 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -938,11 +938,10 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#elif defined(__NR__newselect) || defined(__NR_select)
-#ifndef __NR__newselect
-#define __NR__newselect __NR_select
-#endif
+#elif defined(__NR__newselect)
 	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_select)
+	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
 #else
 	return __nolibc_enosys(__func__, nfds, rfds, wfds, efds, timeout);
 #endif
-- 
2.40.1

