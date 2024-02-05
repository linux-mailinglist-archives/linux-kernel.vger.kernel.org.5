Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD5849729
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbkBEKAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Feb 2024 05:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbkBEKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2024 05:00:07 -0500
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1497;
        Mon,  5 Feb 2024 02:00:08 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, kadlec@netfilter.org, i.maximets@ovn.org,
 netfilter-devel@vger.kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 edumazet@google.com, pablo@netfilter.org, linux-kselftest@vger.kernel.org,
 horms@ovn.org, shuah@kernel.org
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from felix.runs.onstackit.cloud ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:00:00 +0000
Date:   Mon, 5 Feb 2024 09:59:59 +0000
From:   Felix Huettner <felix.huettner@mail.schwarz>
To:     pablo@netfilter.org, i.maximets@ovn.org
Cc:     coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, horms@ovn.org, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        luca.czesla@mail.schwarz, max.lamprecht@mail.schwarz,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Subject: [PATCH net] net: ctnetlink: fix filtering for zone 0
Message-ID: <ZcCxn9HDsB8DUPrI@felix.runs.onstackit.cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

previously filtering for the default zone would actually skip the zone
filter and flush all zones.

Fixes: eff3c558bb7e ("netfilter: ctnetlink: support filtering by zone")
Reported-by: Ilya Maximets <i.maximets@ovn.org>
Closes: https://lore.kernel.org/netdev/2032238f-31ac-4106-8f22-522e76df5a12@ovn.org/
Signed-off-by: Felix Huettner <felix.huettner@mail.schwarz>
---
 net/netfilter/nf_conntrack_netlink.c          | 12 ++++--
 .../netfilter/conntrack_dump_flush.c          | 43 ++++++++++++++++++-
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 0c22a02c2035..3b846cbdc050 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -876,6 +876,7 @@ struct ctnetlink_filter_u32 {
 
 struct ctnetlink_filter {
 	u8 family;
+	bool zone_filter;
 
 	u_int32_t orig_flags;
 	u_int32_t reply_flags;
@@ -992,9 +993,12 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 	if (err)
 		goto err_filter;
 
-	err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
-	if (err < 0)
-		goto err_filter;
+	if (cda[CTA_ZONE]) {
+		err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
+		if (err < 0)
+			goto err_filter;
+		filter->zone_filter = true;
+	}
 
 	if (!cda[CTA_FILTER])
 		return filter;
@@ -1148,7 +1152,7 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 	if (filter->family && nf_ct_l3num(ct) != filter->family)
 		goto ignore_entry;
 
-	if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
+	if (filter->zone_filter &&
 	    !nf_ct_zone_equal_any(ct, &filter->zone))
 		goto ignore_entry;
 
diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
index f18c6db13bbf..b11ea8ee6719 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -13,7 +13,7 @@
 #include "../kselftest_harness.h"
 
 #define TEST_ZONE_ID 123
-#define CTA_FILTER_F_CTA_TUPLE_ZONE (1 << 2)
+#define NF_CT_DEFAULT_ZONE_ID 0
 
 static int reply_counter;
 
@@ -336,6 +336,9 @@ FIXTURE_SETUP(conntrack_dump_flush)
 	ret = conntrack_data_generate_v4(self->sock, 0xf4f4f4f4, 0xf5f5f5f5,
 					 TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 0);
+	ret = conntrack_data_generate_v4(self->sock, 0xf6f6f6f6, 0xf7f7f7f7,
+					 NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
 
 	src = (struct in6_addr) {{
 		.__u6_addr32 = {
@@ -395,6 +398,26 @@ FIXTURE_SETUP(conntrack_dump_flush)
 					 TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 0);
 
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x07000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x08000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+
 	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
 	EXPECT_GE(ret, 2);
 	if (ret > 2)
@@ -425,6 +448,24 @@ TEST_F(conntrack_dump_flush, test_flush_by_zone)
 	EXPECT_EQ(ret, 2);
 	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+}
+
+TEST_F(conntrack_dump_flush, test_flush_by_zone_default)
+{
+	int ret;
+
+	ret = conntrack_flush_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
 }
 
 TEST_HARNESS_MAIN

base-commit: eef00a82c568944f113f2de738156ac591bbd5cd
-- 
2.43.0

