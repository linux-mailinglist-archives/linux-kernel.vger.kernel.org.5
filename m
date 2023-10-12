Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99B77C76F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442359AbjJLTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442338AbjJLTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AC7B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC96C4339A;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=ZO74adjr52q07m5XK1/r7PBJO8jHbbI0TTXAAStMf9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2pK3ImIwA4SVwN4HcIqBTkoMOqyB+RFU28nc+07PciFLqzo+eS/G7hMdgOoUeGu9
         V/ATNneIKmwBIBAme5b2MZwYv9HBvJicxHyCaL1I88cVNrV0YXQphyJHxxmQcC10Vq
         PBAF0qA+kCEcaFISQcSJrdjqIQ6C8683BqBaQ7dXJlXhqfz8XIzn8qT9G6dLwQRLvm
         zWZg1nZ/Up0MM+/CQnn8R/nAFTlmRWI7NchEqUQXIRxIgh+dRJpfc/W7lyF8uY091A
         tQYKiAwVSGInGNEJpD58c/fmAsxb6bqq+Mmf6zzWFTs7Uh2P+5gW6+YhGasVWHAHg2
         sV6nigvjM2msg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6339ECE0F11; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH nolibc 16/19] tools/nolibc: drop test for getauxval(AT_PAGESZ)
Date:   Thu, 12 Oct 2023 12:32:30 -0700
Message-Id: <20231012193233.207857-16-paulmck@kernel.org>
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

Other testcases are already testing the same functionality:
* auxv_AT_UID tests getauxval() in general.
* test_getpagesize() tests pagesize() which directly calls
  getauxval(AT_PAGESZ).

Link: https://lore.kernel.org/r/20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a3ee4496bf0a..7e3936c182dc 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -630,7 +630,6 @@ int run_startup(int min, int max)
 		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(auxv_AT_PAGESZ);   EXPECT_GE(1, getauxval(AT_PAGESZ), 4096); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.40.1

