Return-Path: <linux-kernel+bounces-13049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321CB81FEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1B11F21966
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1A10A39;
	Fri, 29 Dec 2023 10:54:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35C10A1A;
	Fri, 29 Dec 2023 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 0D6F71402B9; Fri, 29 Dec 2023 11:54:42 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: devicetree@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Stephen Boyd <stephen.boyd@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: Fix double free in of_parse_phandle_with_args_map
Date: Fri, 29 Dec 2023 11:54:11 +0100
Message-Id: <20231229105411.1603434-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In of_parse_phandle_with_args_map() the inner loop that
iterates through the map entries calls of_node_put(new)
to free the reference acquired by the previous iteration
of the inner loop. This assumes that the value of "new" is
NULL on the first iteration of the inner loop.

Make sure that this is true in all iterations of the outer
loop by setting "new" to NULL after its value is assigned to "cur".

Extend the unittest to detect the double free and add an additional
test case that actually triggers this path.

Fixes: bd6f2fd5a1 ("of: Support parsing phandle argument lists through a nexus node")
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/of/base.c                           |  1 +
 drivers/of/unittest-data/tests-phandle.dtsi | 10 ++-
 drivers/of/unittest.c                       | 74 ++++++++++++---------
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8d93cb6ea9cd..b0ad8fc06e80 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1464,6 +1464,7 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 		out_args->np = new;
 		of_node_put(cur);
 		cur = new;
+		new = NULL;
 	}
 put:
 	of_node_put(cur);
diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index d01f92f0f0db..554a996b2ef1 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -40,6 +40,13 @@ provider4: provider4 {
 				phandle-map-pass-thru = <0x0 0xf0>;
 			};
 
+			provider5: provider5 {
+				#phandle-cells = <2>;
+				phandle-map = <2 7 &provider4 2 3>;
+				phandle-map-mask = <0xff 0xf>;
+				phandle-map-pass-thru = <0x0 0xf0>;
+			};
+
 			consumer-a {
 				phandle-list =	<&provider1 1>,
 						<&provider2 2 0>,
@@ -66,7 +73,8 @@ consumer-b {
 						<&provider4 4 0x100>,
 						<&provider4 0 0x61>,
 						<&provider0>,
-						<&provider4 19 0x20>;
+						<&provider4 19 0x20>,
+						<&provider5 2 7>;
 				phandle-list-bad-phandle = <12345678 0 0>;
 				phandle-list-bad-args = <&provider2 1 0>,
 							<&provider4 0>;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e9e90e96600e..45bd0d28c717 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -456,6 +456,9 @@ static void __init of_unittest_parse_phandle_with_args(void)
 
 		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
 			 i, args.np, rc);
+
+		if (rc == 0)
+			of_node_put(args.np);
 	}
 
 	/* Check for missing list property */
@@ -545,8 +548,9 @@ static void __init of_unittest_parse_phandle_with_args(void)
 
 static void __init of_unittest_parse_phandle_with_args_map(void)
 {
-	struct device_node *np, *p0, *p1, *p2, *p3;
+	struct device_node *np, *p[6] = {};
 	struct of_phandle_args args;
+	unsigned int prefs[6];
 	int i, rc;
 
 	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-b");
@@ -555,34 +559,24 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 		return;
 	}
 
-	p0 = of_find_node_by_path("/testcase-data/phandle-tests/provider0");
-	if (!p0) {
-		pr_err("missing testcase data\n");
-		return;
-	}
-
-	p1 = of_find_node_by_path("/testcase-data/phandle-tests/provider1");
-	if (!p1) {
-		pr_err("missing testcase data\n");
-		return;
-	}
-
-	p2 = of_find_node_by_path("/testcase-data/phandle-tests/provider2");
-	if (!p2) {
-		pr_err("missing testcase data\n");
-		return;
-	}
-
-	p3 = of_find_node_by_path("/testcase-data/phandle-tests/provider3");
-	if (!p3) {
-		pr_err("missing testcase data\n");
-		return;
+	p[0] = of_find_node_by_path("/testcase-data/phandle-tests/provider0");
+	p[1] = of_find_node_by_path("/testcase-data/phandle-tests/provider1");
+	p[2] = of_find_node_by_path("/testcase-data/phandle-tests/provider2");
+	p[3] = of_find_node_by_path("/testcase-data/phandle-tests/provider3");
+	p[4] = of_find_node_by_path("/testcase-data/phandle-tests/provider4");
+	p[5] = of_find_node_by_path("/testcase-data/phandle-tests/provider5");
+	for (i = 0; i < ARRAY_SIZE(p); ++i) {
+		if (!p[i]) {
+			pr_err("missing testcase data\n");
+			return;
+		}
+		prefs[i] = kref_read(&p[i]->kobj.kref);
 	}
 
 	rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
-	unittest(rc == 7, "of_count_phandle_with_args() returned %i, expected 7\n", rc);
+	unittest(rc == 8, "of_count_phandle_with_args() returned %i, expected 7\n", rc);
 
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 9; i++) {
 		bool passed = true;
 
 		memset(&args, 0, sizeof(args));
@@ -593,13 +587,13 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 		switch (i) {
 		case 0:
 			passed &= !rc;
-			passed &= (args.np == p1);
+			passed &= (args.np == p[1]);
 			passed &= (args.args_count == 1);
 			passed &= (args.args[0] == 1);
 			break;
 		case 1:
 			passed &= !rc;
-			passed &= (args.np == p3);
+			passed &= (args.np == p[3]);
 			passed &= (args.args_count == 3);
 			passed &= (args.args[0] == 2);
 			passed &= (args.args[1] == 5);
@@ -610,28 +604,36 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 			break;
 		case 3:
 			passed &= !rc;
-			passed &= (args.np == p0);
+			passed &= (args.np == p[0]);
 			passed &= (args.args_count == 0);
 			break;
 		case 4:
 			passed &= !rc;
-			passed &= (args.np == p1);
+			passed &= (args.np == p[1]);
 			passed &= (args.args_count == 1);
 			passed &= (args.args[0] == 3);
 			break;
 		case 5:
 			passed &= !rc;
-			passed &= (args.np == p0);
+			passed &= (args.np == p[0]);
 			passed &= (args.args_count == 0);
 			break;
 		case 6:
 			passed &= !rc;
-			passed &= (args.np == p2);
+			passed &= (args.np == p[2]);
 			passed &= (args.args_count == 2);
 			passed &= (args.args[0] == 15);
 			passed &= (args.args[1] == 0x20);
 			break;
 		case 7:
+			passed &= !rc;
+			passed &= (args.np == p[3]);
+			passed &= (args.args_count == 3);
+			passed &= (args.args[0] == 2);
+			passed &= (args.args[1] == 5);
+			passed &= (args.args[2] == 3);
+			break;
+		case 8:
 			passed &= (rc == -ENOENT);
 			break;
 		default:
@@ -640,6 +642,9 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 
 		unittest(passed, "index %i - data error on node %s rc=%i\n",
 			 i, args.np->full_name, rc);
+
+		if (rc == 0)
+			of_node_put(args.np);
 	}
 
 	/* Check for missing list property */
@@ -686,6 +691,13 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 		   "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	for (i = 0; i < ARRAY_SIZE(p); ++i) {
+		unittest(prefs[i] == kref_read(&p[i]->kobj.kref),
+			 "provider%d: expected:%d got:%d\n",
+			 i, prefs[i], kref_read(&p[i]->kobj.kref));
+		of_node_put(p[i]);
+	}
 }
 
 static void __init of_unittest_property_string(void)
-- 
2.40.1


