Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8303779071
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjHKNKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjHKNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009CF3581
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F4B67060
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E982C433C7;
        Fri, 11 Aug 2023 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691759428;
        bh=pcelJUzS2twcARW8O86PiBrVO0sL2055vkOVNT1w1Zw=;
        h=From:To:Cc:Subject:Date:From;
        b=RnT17tLslKfdp5lRCrKNH0H4zXXGnRfEJA/OJumqoa4BDWfwW7/EANNMhLm2fmwvb
         b7KlU2acWiBhdOz11UGndZ8Mq2ChIveuyJXXztrXQpQGdaxcqxV2gWFHyN2dX91EnD
         NVh0yTtNaIhF7xGPHhaGib6S5KSLr0sqlJLW+Jg+Qm+/ebYkDx9ltjEg/KbGJpAUjo
         UpdLWzlYiugW8iIc++pJ5LGXk3snXckvC86U8eTNV9SiHPZagjQPmjF6VFIy6HofX7
         Edh89b9zE0VM4iPTCuUxgoughC1Ocv65K85n5ksvGG6UsAAY0N1b3Z9T5Euq7gyls6
         k3pztFNntl00g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] radix tree: remove unused variable
Date:   Fri, 11 Aug 2023 15:10:13 +0200
Message-Id: <20230811131023.2226509-1-arnd@kernel.org>
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

Recent versions of clang warn about an unused variable, though older
versions saw the 'slot++' as a use and did not warn:

radix-tree.c:1136:50: error: parameter 'slot' set but not used [-Werror,-Wunused-but-set-parameter]

It's clearly not needed any more, so just remove it.

Fixes: 3a08cd52c37c7 ("radix tree: Remove multiorder support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/radix-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 1a31065b2036a..976b9bd02a1b5 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1136,7 +1136,6 @@ static void set_iter_tags(struct radix_tree_iter *iter,
 void __rcu **radix_tree_iter_resume(void __rcu **slot,
 					struct radix_tree_iter *iter)
 {
-	slot++;
 	iter->index = __radix_tree_iter_add(iter, 1);
 	iter->next_index = iter->index;
 	iter->tags = 0;
-- 
2.39.2

