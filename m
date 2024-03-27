Return-Path: <linux-kernel+bounces-121526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04AE88EA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6FEB3CB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA5149C71;
	Wed, 27 Mar 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBWxC/xD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B4149C48;
	Wed, 27 Mar 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553130; cv=none; b=uYfPI9TM2zZnxEx/H4rMrxnOSWB/vmlWzfieTRJZvLA/ZpIbCAoNHhMyXQ0uyDzK/zcgtv5ZqMoELwlE+gD3iqf/yqmserJ+wsTRfBk6lHr5jwoWjSjoGV7YSYMJd2loHgE0XF7MpcaGjinqBy7+akUnd/b+zPvh3uVjm5awDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553130; c=relaxed/simple;
	bh=XijAiJr8ED45Yq86XEpAzxGAIQnSHo95M8Ili6sTQNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jardtW56yejaIQxrtJ5pEkD+aEoOSmK6mOBNKtSPxtQ8sgqN3ZmmA3gG4MfEW+rT7ZpRhssG8MCl97ev9s5diAjaq5/7hguTpxwosH3HHp4gUv3DZ8zT8Cf5KrDzAVJWcGrGPLbDsVY55Iu/JOq0xrfR5nOk5WU7OmHGbuaXMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBWxC/xD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553129; x=1743089129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XijAiJr8ED45Yq86XEpAzxGAIQnSHo95M8Ili6sTQNI=;
  b=CBWxC/xDrlTTMmosu2xRLBt1P7zEjG5hqGTSPLYkspm90AiUy6gvv8Ht
   I/IximDzP234q9/aHul03INRSLONdWI5BoHKX23QJIG0EdMZqzjO0NJYA
   7hk5khbmhSvl7zgS4mblxsf0aUszroej8Ktzn8JNfM911vv+GIIaMq1jD
   WmAsyKUADiKYAfuJajhD3zxrOcFVQEXsQgXeqpsmI6WvFaUARQbdO80L7
   shYovtuncrEFaDsoKsMJ/VRVGyZVcSYZQF5wU3xnzMJFNsDgnNdrg3+CK
   278F2TA1ITixlCAR18volwKnDegQQnJ0NllMiFOaG0MySLoG2sYhW0BlE
   A==;
X-CSE-ConnectionGUID: tllghLzJSkqi2IorGlpmbw==
X-CSE-MsgGUID: 3lTRd0mlQsy80MLcRsnC0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518262"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414381"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:25:25 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 17/21] net: net_test: add tests for IP tunnel flags conversion helpers
Date: Wed, 27 Mar 2024 16:23:54 +0100
Message-ID: <20240327152358.2368467-18-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that there are helpers for converting IP tunnel flags between the
old __be16 format and the bitmap format, make sure they work as expected
by adding a couple of tests to the networking testing suite. The helpers
are all inline, so no dependencies on the related CONFIG_* (or a
standalone module) are needed.

Cover three possible cases:

1. No bits past BIT(15) are set, VTI/SIT bits are not set. This
   conversion is almost a direct assignment.
2. No bits past BIT(15) are set, but VTI/SIT bit is set. During the
   conversion, it must be transformed into BIT(16) in the bitmap,
   but still compatible with the __be16 format.
3. The bitmap has bits past BIT(15) set (not the VTI/SIT one). The
   result will be truncated.
   Note that currently __IP_TUNNEL_FLAG_NUM is 17 (incl. special),
   which means that the result of this case is currently
   semi-false-positive. When BIT(17) is finally here, it will be
   adjusted accordingly.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/Makefile                   |   2 +-
 net/core/{gso_test.c => net_test.c} | 132 ++++++++++++++++++++++++++--
 2 files changed, 125 insertions(+), 9 deletions(-)
 rename net/core/{gso_test.c => net_test.c} (67%)

diff --git a/net/core/Makefile b/net/core/Makefile
index 6e6548011fae..21d6fbc7e884 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -41,4 +41,4 @@ obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
 obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
-obj-$(CONFIG_NET_TEST) += gso_test.o
+obj-$(CONFIG_NET_TEST) += net_test.o
diff --git a/net/core/gso_test.c b/net/core/net_test.c
similarity index 67%
rename from net/core/gso_test.c
rename to net/core/net_test.c
index 358c44680d91..30062b9621e4 100644
--- a/net/core/gso_test.c
+++ b/net/core/net_test.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <kunit/test.h>
+
+/* GSO */
+
 #include <linux/skbuff.h>
 
 static const char hdr[] = "abcdefgh";
@@ -258,17 +261,130 @@ static void gso_test_func(struct kunit *test)
 	consume_skb(skb);
 }
 
-static struct kunit_case gso_test_cases[] = {
-	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
-	{}
+/* IP tunnel flags */
+
+#include <net/ip_tunnels.h>
+
+struct ip_tunnel_flags_test {
+	const char	*name;
+
+	const u16	*src_bits;
+	const u16	*exp_bits;
+	u8		src_num;
+	u8		exp_num;
+
+	__be16		exp_val;
+	bool		exp_comp;
+};
+
+#define IP_TUNNEL_FLAGS_TEST(n, src, comp, eval, exp) {	\
+	.name		= (n),				\
+	.src_bits	= (src),			\
+	.src_num	= ARRAY_SIZE(src),		\
+	.exp_comp	= (comp),			\
+	.exp_val	= (eval),			\
+	.exp_bits	= (exp),			\
+	.exp_num	= ARRAY_SIZE(exp),		\
+}
+
+/* These are __be16-compatible and can be compared as is */
+static const u16 ip_tunnel_flags_1[] = {
+	IP_TUNNEL_KEY_BIT,
+	IP_TUNNEL_STRICT_BIT,
+	IP_TUNNEL_ERSPAN_OPT_BIT,
+};
+
+/* Due to the previous flags design limitation, setting either
+ * ``IP_TUNNEL_CSUM_BIT`` (on Big Endian) or ``IP_TUNNEL_DONT_FRAGMENT_BIT``
+ * (on Little) also sets VTI/ISATAP bit. In the bitmap implementation, they
+ * correspond to ``BIT(16)``, which is bigger than ``U16_MAX``, but still is
+ * backward-compatible.
+ */
+#ifdef __LITTLE_ENDIAN
+#define IP_TUNNEL_CONFLICT_BIT	IP_TUNNEL_DONT_FRAGMENT_BIT
+#else
+#define IP_TUNNEL_CONFLICT_BIT	IP_TUNNEL_CSUM_BIT
+#endif
+
+static const u16 ip_tunnel_flags_2_src[] = {
+	IP_TUNNEL_CONFLICT_BIT,
+};
+
+static const u16 ip_tunnel_flags_2_exp[] = {
+	IP_TUNNEL_CONFLICT_BIT,
+	IP_TUNNEL_SIT_ISATAP_BIT,
 };
 
-static struct kunit_suite gso_test_suite = {
-	.name = "net_core_gso",
-	.test_cases = gso_test_cases,
+/* Bits 17 and higher are not compatible with __be16 flags */
+static const u16 ip_tunnel_flags_3_src[] = {
+	IP_TUNNEL_VXLAN_OPT_BIT,
+	17,
+	18,
+	20,
 };
 
-kunit_test_suite(gso_test_suite);
+static const u16 ip_tunnel_flags_3_exp[] = {
+	IP_TUNNEL_VXLAN_OPT_BIT,
+};
+
+static const struct ip_tunnel_flags_test ip_tunnel_flags_test[] = {
+	IP_TUNNEL_FLAGS_TEST("compat", ip_tunnel_flags_1, true,
+			     cpu_to_be16(BIT(IP_TUNNEL_KEY_BIT) |
+					 BIT(IP_TUNNEL_STRICT_BIT) |
+					 BIT(IP_TUNNEL_ERSPAN_OPT_BIT)),
+			     ip_tunnel_flags_1),
+	IP_TUNNEL_FLAGS_TEST("conflict", ip_tunnel_flags_2_src, true,
+			     VTI_ISVTI, ip_tunnel_flags_2_exp),
+	IP_TUNNEL_FLAGS_TEST("new", ip_tunnel_flags_3_src,
+			     /* This must be set to ``false`` once
+			      * ``__IP_TUNNEL_FLAG_NUM`` goes above 17.
+			      */
+			     true, cpu_to_be16(BIT(IP_TUNNEL_VXLAN_OPT_BIT)),
+			     ip_tunnel_flags_3_exp),
+};
+
+static void
+ip_tunnel_flags_test_case_to_desc(const struct ip_tunnel_flags_test *t,
+				  char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+KUNIT_ARRAY_PARAM(ip_tunnel_flags_test, ip_tunnel_flags_test,
+		  ip_tunnel_flags_test_case_to_desc);
+
+static void ip_tunnel_flags_test_run(struct kunit *test)
+{
+	const struct ip_tunnel_flags_test *t = test->param_value;
+	IP_TUNNEL_DECLARE_FLAGS(src) = { };
+	IP_TUNNEL_DECLARE_FLAGS(exp) = { };
+	IP_TUNNEL_DECLARE_FLAGS(out);
+
+	for (u32 j = 0; j < t->src_num; j++)
+		__set_bit(t->src_bits[j], src);
+	for (u32 j = 0; j < t->exp_num; j++)
+		__set_bit(t->exp_bits[j], exp);
+
+	KUNIT_ASSERT_EQ(test, t->exp_comp,
+			ip_tunnel_flags_is_be16_compat(src));
+	KUNIT_ASSERT_EQ(test, (__force u16)t->exp_val,
+			(__force u16)ip_tunnel_flags_to_be16(src));
+
+	ip_tunnel_flags_from_be16(out, t->exp_val);
+	KUNIT_ASSERT_TRUE(test, __ipt_flag_op(bitmap_equal, exp, out));
+}
+
+static struct kunit_case net_test_cases[] = {
+	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
+	KUNIT_CASE_PARAM(ip_tunnel_flags_test_run,
+			 ip_tunnel_flags_test_gen_params),
+	{ },
+};
+
+static struct kunit_suite net_test_suite = {
+	.name		= "net_core",
+	.test_cases	= net_test_cases,
+};
+kunit_test_suite(net_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for networking core");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("KUnit tests for segmentation offload");
-- 
2.44.0


