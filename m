Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118AF7C6A30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbjJLJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjJLJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:57:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97148A9;
        Thu, 12 Oct 2023 02:57:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qqsRu-0007Vp-5J; Thu, 12 Oct 2023 11:57:46 +0200
Date:   Thu, 12 Oct 2023 11:57:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, willemb@google.com, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
Subject: Re: [Bisected] [1b4fa28a8b07] Build failure "net/core/gso_test.c"
Message-ID: <20231012095746.GA26871@breakpoint.cc>
References: <79fbe35c-4dd1-4f27-acb2-7a60794bc348@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79fbe35c-4dd1-4f27-acb2-7a60794bc348@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com> wrote:
> Greetings,
> 
> [net-next] [6.6-rc4] Build failure "net/core/gso_test.c"
> 
> --- Traces ---
> 
> make -j 33 -s && make modules_install && make install
> net/core/gso_test.c:58:48: error: initializer element is not constant
>    58 |                 .segs = (const unsigned int[]) { gso_size },
>       |                                                ^

Ouch, I can reproduce this with: gcc --version
gcc (Debian 12.2.0-14) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.

gcc 13.2.1 and clang-16.0.6 are ok.

Whats the preference here?  We could use simple preprocessor constant
or we could require much more recent compiler version for the net
kunit tests via kconfig.

gcc-12.2.0 can compile it after this simple s//g "fix":

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -4,7 +4,7 @@
 #include <linux/skbuff.h>
 
 static const char hdr[] = "abcdefgh";
-static const int gso_size = 1000;
+#define GSO_TEST_SIZE 1000
 
 static void __init_skb(struct sk_buff *skb)
 {
@@ -18,7 +18,7 @@ static void __init_skb(struct sk_buff *skb)
 
 	/* proto is arbitrary, as long as not ETH_P_TEB or vlan */
 	skb->protocol = htons(ETH_P_ATALK);
-	skb_shinfo(skb)->gso_size = gso_size;
+	skb_shinfo(skb)->gso_size = GSO_TEST_SIZE;
 }
 
 enum gso_test_nr {
@@ -53,70 +53,70 @@ static struct gso_test_case cases[] = {
 	{
 		.id = GSO_TEST_NO_GSO,
 		.name = "no_gso",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_segs = 1,
-		.segs = (const unsigned int[]) { gso_size },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE },
 	},
 	{
 		.id = GSO_TEST_LINEAR,
 		.name = "linear",
-		.linear_len = gso_size + gso_size + 1,
+		.linear_len = GSO_TEST_SIZE + GSO_TEST_SIZE + 1,
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 1 },
 	},
 	{
 		.id = GSO_TEST_FRAGS,
 		.name = "frags",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frags = 2,
-		.frags = (const unsigned int[]) { gso_size, 1 },
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, 1 },
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 1 },
 	},
 	{
 		.id = GSO_TEST_FRAGS_PURE,
 		.name = "frags_pure",
 		.nr_frags = 3,
-		.frags = (const unsigned int[]) { gso_size, gso_size, 2 },
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 2 },
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, 2 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 2 },
 	},
 	{
 		.id = GSO_TEST_GSO_PARTIAL,
 		.name = "gso_partial",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frags = 2,
-		.frags = (const unsigned int[]) { gso_size, 3 },
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, 3 },
 		.nr_segs = 2,
-		.segs = (const unsigned int[]) { 2 * gso_size, 3 },
+		.segs = (const unsigned int[]) { 2 * GSO_TEST_SIZE, 3 },
 	},
 	{
 		/* commit 89319d3801d1: frag_list on mss boundaries */
 		.id = GSO_TEST_FRAG_LIST,
 		.name = "frag_list",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frag_skbs = 2,
-		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE },
 	},
 	{
 		.id = GSO_TEST_FRAG_LIST_PURE,
 		.name = "frag_list_pure",
 		.nr_frag_skbs = 2,
-		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
 		.nr_segs = 2,
-		.segs = (const unsigned int[]) { gso_size, gso_size },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
 	},
 	{
 		/* commit 43170c4e0ba7: GRO of frag_list trains */
 		.id = GSO_TEST_FRAG_LIST_NON_UNIFORM,
 		.name = "frag_list_non_uniform",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frag_skbs = 4,
-		.frag_skbs = (const unsigned int[]) { gso_size, 1, gso_size, 2 },
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, 1, GSO_TEST_SIZE, 2 },
 		.nr_segs = 4,
-		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size, 3 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
 	},
 	{
 		/* commit 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes") and
