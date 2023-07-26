Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFCA7639B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjGZO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjGZO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE8A1FDD;
        Wed, 26 Jul 2023 07:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F90B61B0A;
        Wed, 26 Jul 2023 14:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92262C433C7;
        Wed, 26 Jul 2023 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690383465;
        bh=6Ey1DnvupEHtg/LC3ZlbR3DTrUjGUTqCzhifgM54UTo=;
        h=From:To:Cc:Subject:Date:From;
        b=BVXnn8VgoVYBOeXukMNjKr9GBjwcsObZ9zcJi/E0ehe2cS7U1JMl3f6CC144LRi7B
         Dc2KwAE3TZOgb9/HD8cnJfvmOgFNjUHYzwKBZyw4xtkUwl/xwYWST/TQbhqPceU+gL
         gOFlrzm/GjkexIA0YM7K+kL6SjX9Gf4OLgfM3s73hUal5QuS1I6ID8eqsS5u9/CeGH
         LA13VToRnbwtE1VMg5oC2MA36Z/lWwWVgT3GuF7ZiuyFs8rFz/2KuPhieIJzREri/r
         ICUwEJcI0Zufc2OYPAOFAoZB7weE6r2OhwK8vBePThHpUlNFAcIQrqP9U9nosO0qp/
         fnPxLAl0EhouA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] csky: fix old style declaration in module.c
Date:   Wed, 26 Jul 2023 16:57:36 +0200
Message-Id: <20230726145740.1765323-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With W=1, gcc warns about the inline keyword in the wrong place:

arch/csky/kernel/module.c:43:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index f11b3e5733448..0b56a8cd12a3d 100644
--- a/arch/csky/kernel/module.c
+++ b/arch/csky/kernel/module.c
@@ -40,7 +40,7 @@ static void jsri_2_lrw_jsr(uint32_t *location)
 	}
 }
 #else
-static void inline jsri_2_lrw_jsr(uint32_t *location)
+static inline void jsri_2_lrw_jsr(uint32_t *location)
 {
 	return;
 }
-- 
2.39.2

