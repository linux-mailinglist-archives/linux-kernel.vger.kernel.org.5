Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAFE7DB947
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjJ3LvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjJ3LvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:51:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB0C9D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698666659; x=1730202659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4GRBubH/Otb5eL3Hy70mHZ0QZ2wvkq5ML1h3y6fE1CA=;
  b=ZPoFfIjLOSTCcI6h4z3O/dTzf9S7FxgoQSDo+zooNkSuC9WY41lpwoSa
   Ym2juzCnvQk1UAvFHd3dGtS1ckgLBxNuLVNko7ODqgLW9NCT2MHIZBMC7
   iyvkGgG3qjwKbNzPkGWXK3bflExJ0OAxsYiM47VqeVWiwh5yHN0ouH/NY
   b2UEr7B4zoIcOCCFlpi8Qj6tF+Mqv4CmlJa+MrlqkA3uEgw+cbfI8nmM7
   ro2oQThKseP8tY8tHJwDMyA15nJuXn11iVDAwirIgsRhEEzknbtTMq3gS
   LOHdMTo3XN3F14AK8ahMkPjrHJ8oDYpLztZNZTBuF223EGDe0lPGCDlzr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6688918"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6688918"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 04:50:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="826031142"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826031142"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 04:50:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B431A2BF; Mon, 30 Oct 2023 13:50:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v1 1/1] pcmcia: Convert to use less arguments in pci_bus_for_each_resource()
Date:   Mon, 30 Oct 2023 13:50:53 +0200
Message-Id: <20231030115053.2752588-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci_bus_for_each_resource() can hide the iterator loop since
it may be not used otherwise. With this, we may drop that iterator
variable definition.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

 Split out of a series: 20230330162434.35055-1-andriy.shevchenko@linux.intel.com.

 Fixed the second hunk in nonstatic_autoadd_resources() to avoid
 potential breakage.

 drivers/pcmcia/rsrc_nonstatic.c | 6 +++---
 drivers/pcmcia/yenta_socket.c   | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index bf9d070a4496..39da2ad9d0b2 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -934,7 +934,7 @@ static int adjust_io(struct pcmcia_socket *s, unsigned int action, unsigned long
 static int nonstatic_autoadd_resources(struct pcmcia_socket *s)
 {
 	struct resource *res;
-	int i, done = 0;
+	int done = 0;
 
 	if (!s->cb_dev || !s->cb_dev->bus)
 		return -ENODEV;
@@ -961,10 +961,10 @@ static int nonstatic_autoadd_resources(struct pcmcia_socket *s)
 	if (s->cb_dev->bus->number == 0)
 		return -EINVAL;
 
-	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+	for (unsigned int i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
 		res = s->cb_dev->bus->resource[i];
 #else
-	pci_bus_for_each_resource(s->cb_dev->bus, res, i) {
+	pci_bus_for_each_resource(s->cb_dev->bus, res) {
 #endif
 		if (!res)
 			continue;
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 1365eaa20ff4..fd18ab571ce8 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -673,9 +673,8 @@ static int yenta_search_res(struct yenta_socket *socket, struct resource *res,
 			    u32 min)
 {
 	struct resource *root;
-	int i;
 
-	pci_bus_for_each_resource(socket->dev->bus, root, i) {
+	pci_bus_for_each_resource(socket->dev->bus, root) {
 		if (!root)
 			continue;
 
-- 
2.40.0.1.gaa8946217a0b

