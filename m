Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975C37D624C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjJYHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjJYHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:19:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1379137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:19:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3925C433C7;
        Wed, 25 Oct 2023 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698218387;
        bh=l5SLShQsxwI3OqVim20c6BSlmvdMyEKaxlcFl0STH/8=;
        h=From:To:Cc:Subject:Date:From;
        b=M5Yq2sr0PHpnp602mMGLHAbm14Rd5wFt2fZAOPLTd91Euf+ayhrmZ8wcB8mFgbBxO
         St5R+bw0ZBUp7bFaGpmwg4BuwMdYGw3rd0J6EgweCWSF0JOZ+Ct3Zok9WdanyHgf5v
         qk1SohHqgbcrLcpwNsv7s4GnRJ69krUxlLGGlrHu+a0lDfm4JXkQYG/4ClekVc5uOL
         s4CRnktXzT+WX6TkYYKSEUaPlNc1fhmeUD/Mj8qkhjD+ZZtwFbqebeeY1fuei44lEi
         hg5sqCrmkuaDdn5QPkGrESQj2fDIIahYR9NLjEvL7olSlL5/DztmD2YFoTLZWeMPGq
         txXW+ew8SZSMA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: pi: add early_map_kernel prototype
Date:   Wed, 25 Oct 2023 09:19:31 +0200
Message-Id: <20231025071942.2879030-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added function only has a caller from assembler code, so it
works without an extern prototype, but we get a warning if it's missing:

arch/arm64/kernel/pi/map_kernel.c:224:24: error: no previous prototype for 'early_map_kernel' [-Werror=missing-prototypes]

Fixes: 478ea5689054 ("arm64: head: Move early kernel mapping routines into C code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/pi/pi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index 93d7457dd10d..c07eea032b7e 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -28,3 +28,5 @@ void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
 	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
 
 asmlinkage u64 create_init_idmap(pgd_t *pgd, pteval_t clrmask);
+
+asmlinkage void early_map_kernel(u64 boot_status, void *fdt);
-- 
2.39.2

