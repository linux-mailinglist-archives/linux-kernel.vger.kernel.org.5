Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000317EAE92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjKNLFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjKNLFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:05:06 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA1D9;
        Tue, 14 Nov 2023 03:05:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 77B05FF806;
        Tue, 14 Nov 2023 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699959900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kd3NZ8a4zLSdrVW2pyTXkblkfiqMqtu4eWyUiU4OKDc=;
        b=WNF3rj0KHC0t0bMTi+avu+bqHhgub6Djlh3UWFLgEmH1Vzcw3MPp1WraG3RvCxBJqHq995
        +mV7YRfvrh8R+GDj2+VW/MIa4OOPC5lfdNPWr9RHpkSwvMtbdYGby25fHikv667bMzvroU
        6RgFCVJAxmmk5i61mJ48++aeEobralqjLN6s3/33Bxi0Iyr510/UJnbJKQomk7+AbGwt1E
        jc9QTCGkJVygVTgFD/zGHm2qe1eFlG9FzFmXsPXjLLPQ4FqF4cSnAU6NFHi+PNHH9W+ZKu
        vdfEQn1vGTbC1IeHtqay8i12kigbz5zlGQGwoj8Avho46ltDS4+KKld9wGlZXw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH 1/1] lib/vsprintf: Fix %pfwf when current node refcount == 0
Date:   Tue, 14 Nov 2023 12:04:56 +0100
Message-ID: <20231114110456.273844-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A refcount issue can appeared in __fwnode_link_del() due to the
pr_debug() call:
  WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
  Call Trace:
  <TASK>
  ? refcount_warn_saturate+0xe5/0x110
  ? __warn+0x81/0x130
  ? refcount_warn_saturate+0xe5/0x110
  ? report_bug+0x191/0x1c0
  ? srso_alias_return_thunk+0x5/0x7f
  ? prb_read_valid+0x1b/0x30
  ? handle_bug+0x3c/0x80
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? refcount_warn_saturate+0xe5/0x110
  kobject_get+0x68/0x70
  of_node_get+0x1e/0x30
  of_fwnode_get+0x28/0x40
  fwnode_full_name_string+0x34/0x90
  fwnode_string+0xdb/0x140
  vsnprintf+0x17b/0x630
  va_format.isra.0+0x71/0x130
  vsnprintf+0x17b/0x630
  vprintk_store+0x162/0x4d0
  ? srso_alias_return_thunk+0x5/0x7f
  ? srso_alias_return_thunk+0x5/0x7f
  ? srso_alias_return_thunk+0x5/0x7f
  ? try_to_wake_up+0x9c/0x620
  ? rwsem_mark_wake+0x1b2/0x310
  vprintk_emit+0xe4/0x2b0
  _printk+0x5c/0x80
  __dynamic_pr_debug+0x131/0x160
  ? srso_alias_return_thunk+0x5/0x7f
  __fwnode_link_del+0x25/0xa0
  fwnode_links_purge+0x39/0xb0
  of_node_release+0xd9/0x180
  kobject_put+0x7b/0x190
  ...

Indeed, an fwnode (of_node) is being destroyed and so, of_node_release()
is called because the of_node refcount reached 0.
From of_node_release() several function calls are done and lead to
a pr_debug() calls with %pfwf to print the fwnode full name.
The issue is not present if we change %pfwf to %pfwP.

To print the full name, %pfwf iterates over the current node and its
parents and obtain/drop a reference to all nodes involved.

In order to allow to print the full name (%pfwf) of a node while it is
being destroyed, do not obtain/drop a reference to this current node.

Fixes: a92eb7621b9f ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 lib/vsprintf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index afb88b24fa74..74ef229c2783 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2108,8 +2108,8 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
 {
 	int depth;
 
-	/* Loop starting from the root node to the current node. */
-	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
+	/* Loop starting from the root node to the parent of current node. */
+	for (depth = fwnode_count_parents(fwnode); depth > 0; depth--) {
 		struct fwnode_handle *__fwnode =
 			fwnode_get_nth_parent(fwnode, depth);
 
@@ -2121,6 +2121,16 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
 		fwnode_handle_put(__fwnode);
 	}
 
+	/* Handle current node without calling fwnode_handle_{get,put}().
+	 * This allows to print the full node name while the current node is
+	 * being destroyed (ie print from a function called because of
+	 * refcount == 0) without any refcount issues.
+	 */
+	buf = string(buf, end, fwnode_get_name_prefix(fwnode),
+		     default_str_spec);
+	buf = string(buf, end, fwnode_get_name(fwnode),
+		     default_str_spec);
+
 	return buf;
 }
 
-- 
2.41.0

