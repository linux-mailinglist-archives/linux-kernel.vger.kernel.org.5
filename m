Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B687C76E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442299AbjJLTcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442158AbjJLTci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D2EE6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8CBC433CA;
        Thu, 12 Oct 2023 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139155;
        bh=pg4Aqoba2EU/o3cS7KiwqgLXSRgn8eg2p5Eiz67tpcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZm8UEOl+44DEWZ0QLu7dr6fraJOnu4psSm2sgUqRVrF5C+k9wKoP4R6cCTPWnOev
         NJAgGMoxg4qD0CrBd1LRiNtUvJAHKdHJ44C93nz0Rz6/59N+U5D8YCbTqPfSAT8c5s
         g1sqZDPfrBTU1Cuos5QjUTJlrA+wy/wKjLacLafZ0NAkP9fi0SxO4Nk4XHacy8/xms
         3SBYVUOT/7TqfgGOlTD1Fe/jHBeeYW53NHkJ7KrxWNxz8buzd5NwC5PS8WvcB/djhT
         Zm6oS/udqDCXjzsawYqKSOnaSYzZTEeuO2On49ROTEh3IoExqdfNZOX4aczNLC4yQl
         80zh0AazHi4UQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42B17CE09E3; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 03/19] tools/nolibc: mark start_c as weak
Date:   Thu, 12 Oct 2023 12:32:17 -0700
Message-Id: <20231012193233.207857-3-paulmck@kernel.org>
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

Otherwise the different instances of _start_c from each compilation unit
will lead to linker errors:

/usr/bin/ld: /tmp/ccSNvRqs.o: in function `_start_c':
nolibc-test-foo.c:(.text.nolibc_memset+0x9): multiple definition of `_start_c'; /tmp/ccG25101.o:nolibc-test.c:(.text+0x1ea3): first defined here

Fixes: 17336755150b ("tools/nolibc: add new crt.h with _start_c")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/
Link: https://lore.kernel.org/lkml/20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net/
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/crt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index a5f33fef1672..a05655b4ce1d 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -13,6 +13,7 @@ const unsigned long *_auxv __attribute__((weak));
 static void __stack_chk_init(void);
 static void exit(int);
 
+__attribute__((weak))
 void _start_c(long *sp)
 {
 	long argc;
-- 
2.40.1

