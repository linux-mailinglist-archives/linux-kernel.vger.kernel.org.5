Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3CD7EB382
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjKNP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKNP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:27:13 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CF11D;
        Tue, 14 Nov 2023 07:27:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 27B7F40003;
        Tue, 14 Nov 2023 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699975626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PAfd5PzRAlov3r0lVkTLqmgUGDb3Mw2H4g0bqbIXqTI=;
        b=AeY77KkaNxILwfvBQ+kEBEvz0KK9Z5DDt3bQrhdRFzAnavgsj3ZiNXEmtDL2jNFyVn0Uji
        ZIlF5WNhfAy5kbNEYTp1CAZfDXy0llqUsS2EF34Z0+zsvHuEO5sY+PWXLXCfvHHgNAqUW3
        l8+U14CPDchb2jWrukR5pJZI8P9B/ygJOknh5ltEE/XLiiDstUzpoDImXbend1nlc/VnCg
        fET4sYdKUHjpo9peHV3jtthzI2SlJqryHZMsUNFzpFaV7PZKeUZt4BIJUS4X0bQ5/bpeLR
        9dwM07NnJH9I0KGROhUaivO4ZSEMBjv8Jzcx4j9IT4cHI5Zuqq4c6AmZK7ahHA==
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
Subject: [PATCH v3 1/1] lib/vsprintf: Fix %pfwf when current node refcount == 0
Date:   Tue, 14 Nov 2023 16:26:55 +0100
Message-ID: <20231114152655.409331-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
  ...
  of_node_get+0x1e/0x30
  of_fwnode_get+0x28/0x40
  fwnode_full_name_string+0x34/0x90
  fwnode_string+0xdb/0x140
  ...
  vsnprintf+0x17b/0x630
  ...
  __fwnode_link_del+0x25/0xa0
  fwnode_links_purge+0x39/0xb0
  of_node_release+0xd9/0x180
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
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes v2 -> v3
  - Fix typo in comment ("ie parents node" -> "i.e. parent nodes")
  - Add 'Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>'
  - Add 'Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>'

Changes v1 -> v2
  - Avoid handling current node out of the loop. Instead obtain/drop references
    in the loop based on the depth value.
  - Remove some of the backtrace lines in the commit log.

 lib/vsprintf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index afb88b24fa74..2aa408441cd3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2110,15 +2110,20 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
 
 	/* Loop starting from the root node to the current node. */
 	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
-		struct fwnode_handle *__fwnode =
-			fwnode_get_nth_parent(fwnode, depth);
+		/*
+		 * Only get a reference for other nodes (i.e. parent nodes).
+		 * fwnode refcount may be 0 here.
+		 */
+		struct fwnode_handle *__fwnode = depth ?
+			fwnode_get_nth_parent(fwnode, depth) : fwnode;
 
 		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
 			     default_str_spec);
 		buf = string(buf, end, fwnode_get_name(__fwnode),
 			     default_str_spec);
 
-		fwnode_handle_put(__fwnode);
+		if (depth)
+			fwnode_handle_put(__fwnode);
 	}
 
 	return buf;
-- 
2.41.0

