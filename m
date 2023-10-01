Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FED7B4711
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjJALHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 07:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjJALHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 07:07:40 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A66EDD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 04:07:37 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id muIKqTqNAm6tamuIRq8U3c; Sun, 01 Oct 2023 13:07:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696158456;
        bh=v9P7JS8Eo6gg0JgpQ/a5dnlXc7ZeGy/7g3pcTmVCJ18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OcrHXPEwJq5ccOGM2WWXMREYaA5x0o3Tt5f28aR5RqTrPTdP8zPl6Hd6n0mtT99Tv
         1KHlmqCZPA7tCaA0QYbYkbQ+SmOJPAc2RDlcL6TtG0gyKE8KZP4+U9/GKRDBW+GCp6
         VzWecaU8rn3uaqyZ8qYdCITjFOtAqHPeX3w6zoM+d5R8cWW0FBa1TCFlMIuXAoNNSv
         yNqQoese2sMY/E4nuu0QocTSjow/jUUN7brb7p0UkkKckCpc7lPXVcsS6Fk3d0bA9m
         tpBLPy4DIdYTZKJVl6e1HeXg7sdsUnpTyrqCh2IyL22dIUZesYXZbSffSWzSu9wvfM
         IkgecWhFDL3cQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 13:07:36 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     keescook@chromium.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, dev@openvswitch.org, llvm@lists.linux.dev
Subject: [PATCH net-next 2/2] net: openvswitch: Annotate struct mask_array with __counted_byUse struct_size()
Date:   Sun,  1 Oct 2023 13:07:23 +0200
Message-Id: <f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8be59c9e06fca8eff2f264abb4c2f74db0b19a9e.1696156198.git.christophe.jaillet@wanadoo.fr>
References: <8be59c9e06fca8eff2f264abb4c2f74db0b19a9e.1696156198.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 9e659db78c05..8d9e83b4d62c 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -48,7 +48,7 @@ struct mask_array {
 	int count, max;
 	struct mask_array_stats __percpu *masks_usage_stats;
 	u64 *masks_usage_zero_cntr;
-	struct sw_flow_mask __rcu *masks[];
+	struct sw_flow_mask __rcu *masks[] __counted_by(size);
 };
 
 struct table_instance {
-- 
2.34.1

