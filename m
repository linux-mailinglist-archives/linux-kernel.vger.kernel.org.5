Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C497C92FC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjJNGfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjJNGfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:35:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9283
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 23:35:09 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rYEiqpnupvhM3rYEtqYMoq; Sat, 14 Oct 2023 08:35:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697265308;
        bh=il89cLsUPoSfIl2uIujuHP4uRIM1OQ8+x9zRodfnRok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Bo+61VSX/YyYHCKiYBpJL1M4zOyIazFJEkWMUYYuOZqqleYlxrRVIWb5m9/g/i2fk
         /mQgtot4aePqBFtElrsXiGMGf5KEJ4gObLlcrOg2AT7E8FiuLIIy8w9LlFI5aikPrA
         WEpS8BipFODvU5kvBv0CRASebxqMW9PzIhLsTjuYoW5kMujbLL2jeuQFVJD6XNLPz6
         QRELQx1T+AF5t8a4aMQxgdNyOYAkg2CkE5AtMEZWBLHPaFs7yYPB0Q9ebCjXDTqe5g
         Fwi4uo3NH/U9hS6shMji3XkK8YyMNjJjJ9XxaHF65GbJRWwoi3n57YNfnv8yG1/vNJ
         C5YpJmAFysrEg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Oct 2023 08:35:08 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, dev@openvswitch.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 2/2] net: openvswitch: Annotate struct mask_array with __counted_by
Date:   Sat, 14 Oct 2023 08:34:53 +0200
Message-Id: <ca5c8049f58bb933f231afd0816e30a5aaa0eddd.1697264974.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Fix the subject  [Ilya Maximets]
    fix the field name used with __counted_by  [Ilya Maximets]

v1: https://lore.kernel.org/all/f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr/


This patch is part of a work done in parallel of what is currently worked
on by Kees Cook.

My patches are only related to corner cases that do NOT match the
semantic of his Coccinelle script[1].

In this case, in tbl_mask_array_alloc(), several things are allocated with
a single allocation. Then, some pointer arithmetic computes the address of
the memory after the flex-array.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
---
 net/openvswitch/flow_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index 9e659db78c05..f524dc3e4862 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -48,7 +48,7 @@ struct mask_array {
 	int count, max;
 	struct mask_array_stats __percpu *masks_usage_stats;
 	u64 *masks_usage_zero_cntr;
-	struct sw_flow_mask __rcu *masks[];
+	struct sw_flow_mask __rcu *masks[] __counted_by(max);
 };
 
 struct table_instance {
-- 
2.34.1

