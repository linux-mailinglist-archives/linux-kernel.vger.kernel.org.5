Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF48777A79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjHJOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjHJOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41C2715
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FEC065DA6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BBDC433CA;
        Thu, 10 Aug 2023 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677328;
        bh=JYabf5wMJUk5e6DNY2CCvp9jZouGFzZsXU/Y/nl7JD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbzkssEyw3oDpgrWbl40D89GEU2FyM0Da7GcQQWjOczt0tCaNuu5lKOM3BYavzk8l
         YRtG58g0VE3FvnV7jujSsT4Rv4Ca97uWBtvFSmt2aOVZPdIXz889tJuRxkDITmGnzC
         LiE+Z3QUi1SDfLiA8InaZsrzUJNFyI11K155utwPluxPu02iQ6gUigfe+bgFSNAn+X
         u7LbuxUwenMNBAc7V9xxT8AaasD8Cmc6/6QVf3gvzku1Wn1xom9SUL/+GA3UbAYDIP
         +FI/j3dwL/UGXUMl6QjKXH9o5H+olG6iZuBJKr1fgkSON13xxi3Nq2XfDKoudsXQBn
         pKFmkP7dwn02g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/17] microblaze: mark flush_dcache_folio() inline
Date:   Thu, 10 Aug 2023 16:19:26 +0200
Message-Id: <20230810141947.1236730-9-arnd@kernel.org>
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

The newly added flush_dcache_folio() causes a harmless warning that
turns into a build failure with CONFIG_WERROR:

arch/microblaze/include/asm/cacheflush.h:77:13: error: 'flush_dcache_folio' defined but not used [-Werror=unused-function]

Mark it as inline to avoid this.

Fixes: 1330c94f53996 ("microblaze: implement the new page table range API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/include/asm/cacheflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
index e6641ff98cb30..ffa2cf3893e4b 100644
--- a/arch/microblaze/include/asm/cacheflush.h
+++ b/arch/microblaze/include/asm/cacheflush.h
@@ -74,7 +74,7 @@ do { \
 	flush_dcache_range((unsigned) (addr), (unsigned) (addr) + PAGE_SIZE); \
 } while (0);
 
-static void flush_dcache_folio(struct folio *folio)
+static inline void flush_dcache_folio(struct folio *folio)
 {
 	unsigned long addr = folio_pfn(folio) << PAGE_SHIFT;
 
-- 
2.39.2

