Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761147E7F77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjKJRyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKJRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:19 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E77742C22;
        Fri, 10 Nov 2023 09:01:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id C14F360005;
        Fri, 10 Nov 2023 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699635686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xEm3o8VU+39ALGHyQKeorPBmsousXOC90k2SfHr6l+8=;
        b=akEddODtZEANlh32ZjSuOqfH9OK2OytJ70Ew/Ly8Ab5NURRRE4ozxB0zfFCHCcZ7wuloAO
        5XVpuDCbWUHw41I5C0TYDWV1e/cTXvG8jxDVqUMuEBnePr96w8Vrm5bMLAwhVooARZ/vEd
        rDfqqXPNDLxEXcaLHDkmJf+4mCesbVL1xmEx+jc2ZRBU1E7a8k6yMtJi9qnJuSGXi7jOL4
        ka3EMTDWJGjasU4jtE03UiaQWb0hAma7qFqL6OLBWSP5DWPcScArcPnSuNCdobgYVrklqG
        43PH6RASlV6flnurH5hzK7/5gk9GL1hseswLHho4YDPcDpD6wU573tpPfxpC4g==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH 1/1] driver core: Avoid using fwnode in __fwnode_link_del()
Date:   Fri, 10 Nov 2023 18:01:20 +0100
Message-ID: <20231110170121.769221-1-herve.codina@bootlin.com>
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

Indeed, an of_node is destroyed and so, of_node_release() is called
because the of_node refcount reached 0.
of_node_release() calls fwnode_links_purge() to purge the links and
ended with __fwnode_link_del() calls.
__fwnode_link_del calls pr_debug() to print the fwnodes (of_nodes)
involved in the link and so this call is done while one of them is no
more available (ie the one related to the of_node_release() call)

Remove the pr_debug() call to avoid the use of the links fwnode while
destroying the fwnode itself.

Fixes: ebd6823af378 ("driver core: Add debug logs when fwnode links are added/deleted")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f4b09691998e..62088c663014 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -109,8 +109,6 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
  */
 static void __fwnode_link_del(struct fwnode_link *link)
 {
-	pr_debug("%pfwf Dropping the fwnode link to %pfwf\n",
-		 link->consumer, link->supplier);
 	list_del(&link->s_hook);
 	list_del(&link->c_hook);
 	kfree(link);
-- 
2.41.0

