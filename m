Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB357CDF07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjJROQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345165AbjJROPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:15:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9CE2114;
        Wed, 18 Oct 2023 07:13:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5F5C433CB;
        Wed, 18 Oct 2023 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638426;
        bh=i6OgIGJSxKPbH1liKPx3JpyYDrqSV3S+ooC+cPoDvAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdnPuKD7xEmUdHsC5jJw82rsJ3Y0yrE7VRLjdqux++apF5eaHHMUdVK5M/zGMDH8O
         E3Wp/75O8g8O0iU6rgQpata9woDwE1H2UCQcEyyFHnLxoIJUVnlR2m1Pd6UoeFYe7S
         6BAcNuy2FIFXtmEo3mgswhnCG2lu+sha2sENfpOkFdXcsnfQovI6lXoAxepQGUA913
         AYLPojiW2F10ILHgrK5vjlcrhCT9f2+ip6xSlM8YFh5ctIHPjGmk4NtO7zhwtNDBG9
         /9SDr9sPU641NMWTl+dYWux0P5bpQwKXLYCqbgfRe9R0NUoFGhVjpFtn6umBPtRWnq
         SgVPkH1mbkl1w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alejandro Colomar <alx@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/19] net: sched: cls_u32: Fix allocation size in u32_init()
Date:   Wed, 18 Oct 2023 10:13:12 -0400
Message-Id: <20231018141323.1334898-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit c4d49196ceec80e30e8d981410d73331b49b7850 ]

commit d61491a51f7e ("net/sched: cls_u32: Replace one-element array
with flexible-array member") incorrecly replaced an instance of
`sizeof(*tp_c)` with `struct_size(tp_c, hlist->ht, 1)`. This results
in a an over-allocation of 8 bytes.

This change is wrong because `hlist` in `struct tc_u_common` is a
pointer:

net/sched/cls_u32.c:
struct tc_u_common {
        struct tc_u_hnode __rcu *hlist;
        void                    *ptr;
        int                     refcnt;
        struct idr              handle_idr;
        struct hlist_node       hnode;
        long                    knodes;
};

So, the use of `struct_size()` makes no sense: we don't need to allocate
any extra space for a flexible-array member. `sizeof(*tp_c)` is just fine.

So, `struct_size(tp_c, hlist->ht, 1)` translates to:

sizeof(*tp_c) + sizeof(tp_c->hlist->ht) ==
sizeof(struct tc_u_common) + sizeof(struct tc_u_knode *) ==
						144 + 8  == 0x98 (byes)
						     ^^^
						      |
						unnecessary extra
						allocation size

$ pahole -C tc_u_common net/sched/cls_u32.o
struct tc_u_common {
	struct tc_u_hnode *        hlist;                /*     0     8 */
	void *                     ptr;                  /*     8     8 */
	int                        refcnt;               /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

	struct idr                 handle_idr;           /*    24    96 */
	/* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
	struct hlist_node          hnode;                /*   120    16 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	long int                   knodes;               /*   136     8 */

	/* size: 144, cachelines: 3, members: 6 */
	/* sum members: 140, holes: 1, sum holes: 4 */
	/* last cacheline: 16 bytes */
};

And with `sizeof(*tp_c)`, we have:

	sizeof(*tp_c) == sizeof(struct tc_u_common) == 144 == 0x90 (bytes)

which is the correct and original allocation size.

Fix this issue by replacing `struct_size(tp_c, hlist->ht, 1)` with
`sizeof(*tp_c)`, and avoid allocating 8 too many bytes.

The following difference in binary output is expected and reflects the
desired change:

| net/sched/cls_u32.o
| @@ -6148,7 +6148,7 @@
| include/linux/slab.h:599
|     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
|                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
|-    2cfc:      mov    $0x98,%edx
|+    2cfc:      mov    $0x90,%edx

Reported-by: Alejandro Colomar <alx@kernel.org>
Closes: https://lore.kernel.org/lkml/09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_u32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index ba93e2a6bdbb4..04448bfb4d3db 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -364,7 +364,7 @@ static int u32_init(struct tcf_proto *tp)
 	idr_init(&root_ht->handle_idr);
 
 	if (tp_c == NULL) {
-		tp_c = kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KERNEL);
+		tp_c = kzalloc(sizeof(*tp_c), GFP_KERNEL);
 		if (tp_c == NULL) {
 			kfree(root_ht);
 			return -ENOBUFS;
-- 
2.40.1

