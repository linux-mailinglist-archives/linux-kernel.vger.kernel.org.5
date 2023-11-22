Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F927F533D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbjKVWSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbjKVWSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:18:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60BD49
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08242C433CA;
        Wed, 22 Nov 2023 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691500;
        bh=xbM7UwIkiSdSjSS3CBuDr633BLrw+vGBgZ7TQFhbsLY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m2h70Ph0oAZb/KX4nmAIJIgAmgEZEAHewd+1aGGUOhZc0ygMNSOWeUiEp1Yg2WYgy
         vN3jz96ggTWzf1Bzay6hfnIGbpcm6KWoXWDKgTCPKRFBnwnJo53wEurBHbmta/5y+F
         MtE0afBV1dJSy4Js5ujpLxMDxY+lmy3oDFmunIGryqALbZSCSERfm4NW6NBKDd/cZY
         Vrb7l60r4giYrU3WZ2eflFchwcLkYBTML9vieiuIqzr3zvsWKZRmMvmalsDisaSBhM
         S79EOfk01xMSaLSuK1QPOMEwM4smNWNix8Jo/Kdp4fF7Ulk7r0ZUUllRLeCLj4URPW
         hAYOhMY02eQkA==
From:   deller@kernel.org
To:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-arch@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab entries
Date:   Wed, 22 Nov 2023 23:18:11 +0100
Message-ID: <20231122221814.139916-2-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

An alignment of 4 bytes is wrong for 64-bit platforms which don't define
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS (which then store 64-bit pointers).
Fix their alignment to 8 bytes.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 include/linux/export-internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 69501e0ec239..cd253eb51d6c 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -16,10 +16,13 @@
  * and eliminates the need for absolute relocations that require runtime
  * processing on relocatable kernels.
  */
+#define __KSYM_ALIGN		".balign 4"
 #define __KSYM_REF(sym)		".long " #sym "- ."
 #elif defined(CONFIG_64BIT)
+#define __KSYM_ALIGN		".balign 8"
 #define __KSYM_REF(sym)		".quad " #sym
 #else
+#define __KSYM_ALIGN		".balign 4"
 #define __KSYM_REF(sym)		".long " #sym
 #endif
 
@@ -42,7 +45,7 @@
 	    "	.asciz \"" ns "\""					"\n"	\
 	    "	.previous"						"\n"	\
 	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
-	    "	.balign	4"						"\n"	\
+		__KSYM_ALIGN						"\n"	\
 	    "__ksymtab_" #name ":"					"\n"	\
 		__KSYM_REF(sym)						"\n"	\
 		__KSYM_REF(__kstrtab_ ##name)				"\n"	\
-- 
2.41.0

