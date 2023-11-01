Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D97DE3B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjKAPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKAPE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:04:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B0FD;
        Wed,  1 Nov 2023 08:04:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D235C433CD;
        Wed,  1 Nov 2023 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851097;
        bh=/1OKijib/XQjxvI5gIn4dRbp8P97f6PNc9AKR+6aMVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuO9OK1ID8Bd+002S6WsnJbMMhFLoi7cqZdQrsyVy8mXE5AgvWBkj6Dyj1PhuwMw7
         je1P48CBXUVfbW92u2kikCKXQDZI//lSUmKYLIrDUhi1Ddy9q0cuB3qzX0HAl+08GL
         GBo21IXYQdGPdAStQCdE16E5M363oGYU49HWpVuPiyEmrvu1hwDQoLJwGL6hZDP33Y
         q/pOcM1NgdQCmoU7r2dqBWa0+Wq1YD2PteY0XndPa7eCLFY9ttT7fQjt95mtwUFV1I
         Ui7Evg0rnzgoR3UsjtbtUrT+x0BDZy/vN/Ol+rjXVtYevS5XebUeI5rHwANV5LbS4+
         UqG3qqSvTKvgA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/7] modpost: add table_size local variable to symsearch_find_nearest()
Date:   Thu,  2 Nov 2023 00:04:00 +0900
Message-Id: <20231101150404.754108-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101150404.754108-1-masahiroy@kernel.org>
References: <20231101150404.754108-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep consistency with 'table', and make the conditional part slightly
shorter.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/symsearch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
index 00f0f9c354db..97566aee0979 100644
--- a/scripts/mod/symsearch.c
+++ b/scripts/mod/symsearch.c
@@ -154,9 +154,10 @@ Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
 				unsigned int secndx, bool allow_negative,
 				Elf_Addr min_distance)
 {
-	unsigned int hi = elf->symsearch->table_size;
-	unsigned int lo = 0;
 	const struct syminfo *table = elf->symsearch->table;
+	unsigned int table_size = elf->symsearch->table_size;
+	unsigned int hi = table_size;
+	unsigned int lo = 0;
 	struct syminfo target;
 
 	target.addr = addr;
@@ -183,8 +184,7 @@ Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
 	 */
 	Elf_Sym *result = NULL;
 
-	if (allow_negative &&
-	    hi < elf->symsearch->table_size &&
+	if (allow_negative && hi < table_size &&
 	    table[hi].section_index == secndx &&
 	    table[hi].addr - addr <= min_distance) {
 		min_distance = table[hi].addr - addr;
-- 
2.40.1

