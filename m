Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187D47F533E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjKVWSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjKVWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:18:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F0D42
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC02C433CC;
        Wed, 22 Nov 2023 22:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691502;
        bh=naPsrd6dgZmrcqFRnBTJLF85zK+mznbfmwCxwvHg1bc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DDxAjeN0PF56HLuHq+owxFyRf1SXkUc0Z3SIxrGBECInqJ9bI5WTebiKUjB+kdXgc
         4GAAJFWkwGKOeLi4wqgSc5qKmWrSDg2dC/VcMaTpnvQB/ctWee/LrWjppfZMvUUEZT
         +Xt4fRitwdPMjB5F1t2+G/fVNeDMtj/EVVXtakgp2AUggs4s5bljxWU2MTDNSB4ElI
         e5d9Yb4xkQhock5YbwJnwZ+TbIKMpPf7s/cT+0vH51VrCbGGPqjMw2BFSh1//YguKf
         ZXpMGYJ71+KG4ilzh78AGFUUbGJIONjGDFGHncsmOLm0RinIWC8kHlcjJce+uJ0aNU
         YM+gqd4jArNIg==
From:   deller@kernel.org
To:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-arch@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_* sections
Date:   Wed, 22 Nov 2023 23:18:12 +0100
Message-ID: <20231122221814.139916-3-deller@kernel.org>
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

On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
(e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
64-bit pointers into the __ksymtab* sections.
Make sure that those sections will be correctly aligned at module link time,
otherwise unaligned memory accesses may happen at runtime.

The __kcrctab* sections store 32-bit entities, so use ALIGN(4) for those.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
---
 scripts/module.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index bf5bcf2836d8..b00415a9ff27 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -15,10 +15,10 @@ SECTIONS {
 		*(.discard.*)
 	}
 
-	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : { *(SORT(___ksymtab_gpl+*)) }
-	__kcrctab		0 : { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : { *(SORT(___kcrctab_gpl+*)) }
+	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
+	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
+	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
+	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
-- 
2.41.0

