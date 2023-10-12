Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9177C76EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442334AbjJLTdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442263AbjJLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD8EA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4E3C433A9;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=cffo0Opb832Q634IA4d6N2Zi+yxWXyiKi+nWzBmlGXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxwqeOs4r8vpCqBJORSSRoXOGV4RiW98JDhjqe5p4WP4aDt+w3tkD68fc64MkNVR0
         KGLkMybw4iAfo1HRv0gj6Hf9sn8DL/yQRdO0DmSkpgyAQiyRVPDicp8fVO6u1OnOJx
         pG/zOYEHMY7WzrHab2BIaMErRQ22mxmsNHORhY3XDw0qPim9dZjJZNRugvqQAO6BV7
         UKf5MD+dg9fSiHNNn+lp9rTOovZ2bOzp1sSE3/In6IQrERIrYPOfZIQ/fGGQXw93wd
         tbXydJvtu7GAqNxa7TJnANkhVV1D2YjvSNkFI9YBaq04e81j+5e+fOyu2yy44gWPIM
         tBeFBmReQZakg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A19ACE0CF9; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 12/19] selftests/nolibc: allow building i386 with multiarch compiler
Date:   Thu, 12 Oct 2023 12:32:26 -0700
Message-Id: <20231012193233.207857-12-paulmck@kernel.org>
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

When building with a multiarch-capable compiler, like those provided by
common distributions the -m32 argument is required to build 32bit code.

Wrap it in cc-option in case the compiler is not multiarch-capable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20230917-nolibc-syscall-nr-v2-1-03863d509b9a@weissschuh.net
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ee6a9ad28cfd..891aa396163d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -113,6 +113,7 @@ else
 Q=@
 endif
 
+CFLAGS_i386 = $(call cc-option,-m32)
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
-- 
2.40.1

