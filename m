Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350EB792FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbjIEUOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbjIEUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:14:09 -0400
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:13:47 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6549C113;
        Tue,  5 Sep 2023 13:13:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C022C433BC;
        Tue,  5 Sep 2023 19:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693940920;
        bh=odwCFoRqriyJMZJrebmLnyD9HgaYVBoEzbQlKC/Vgpg=;
        h=From:To:Cc:Subject:Date:From;
        b=YKMBKsPSFKtFPv5MEheuC31zhPo4TBoTqN/xXx4sMBGIsnBAaDGg1q4r5Dc6MujZb
         HfH+pwUFiH7j9iuWoVWnTXdZTrZ4lBwuNmVmcx1ARg4CrBIQY44REJNeYJXC2+QN0P
         4IGmU06qzeg9HYhiSrYbfAODaeypqb3JHZhMl9JWrlZEY9MGbllG0fNXRkhfZ6hFQw
         nQV1tPFMmr6Gce5ImEaWjhLpmpW0n7fWMUxtaKkLSwnProe9ELQIg9rEO0q84JLSE7
         HowNLOZWJbuuIAZMxF8tH6FoSB+3Ie1QgzQknqiCwJGfFcl6TuTa6H8CeJqUdKkpMi
         UrUa3ehP3iJKQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] linux/export: fix reference to exported functions for parisc64
Date:   Wed,  6 Sep 2023 04:08:28 +0900
Message-Id: <20230905190828.790400-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

John David Anglin reported parisc has been broken since commit
ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost").

I checked the assembler output, and noticed function references are
prefixed with P%, so the situation in parisc64 is similar to ia64.

Fixes: ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
Reported-by: John David Anglin <dave.anglin@bell.net>
Closes: https://lore.kernel.org/linux-parisc/1901598a-e11d-f7dd-a5d9-9a69d06e6b6e@bell.net/T/#u
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I just checked the assembler output, and I created this patch
based on my best guess. Only compile-tested.
I hope somebody will run-test this patch.


 include/linux/export-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 1c849db953a5..45fca09b2319 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -52,6 +52,8 @@
 
 #ifdef CONFIG_IA64
 #define KSYM_FUNC(name)		@fptr(name)
+#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
+#define KSYM_FUNC(name)		P%name
 #else
 #define KSYM_FUNC(name)		name
 #endif
-- 
2.39.2

