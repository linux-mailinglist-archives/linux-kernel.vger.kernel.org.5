Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462EB7FE606
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344019AbjK3BdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:33:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8810C9;
        Wed, 29 Nov 2023 17:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701307987; x=1732843987;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=biVFyY2ZTRVvjAGgkWkvryJWLterO+Gec8l2ksefpWo=;
  b=ljP6y29ZjVVjuSSKA9MqbfXcK5nxCI+PUk26ZDpIBb/Gt/vKPE3hz0N2
   Fx12GonHAhjyoKEgo/PaJM901quIRsGRXNsZAkD6+lM/6/5IMqMYyjQ0U
   +0cwjQj7egt9Tj2ZmnKf9pdzZlql73lhudowySkxGLX4VWbB5YErp3BwA
   9u2sVnvhimUaf+7ZDnbIZHazaIhoGlDzjPvRFbn71Z2X5GDUhc7WHT+/3
   Y9pNYF2hoxvrC7YxTpPcYTJDPDxoXr8/uK4rpaJRJ4wsFiQptjCsIU6WD
   v6huLyRUWW1XmhWDYDXjK+xw/c/0o93qrkKQThfRn4F99floihpran9sE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="131554"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="131554"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016467458"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016467458"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.173.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:33:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 29 Nov 2023 17:33:04 -0800
Subject: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
In-Reply-To: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701307983; l=1857;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=biVFyY2ZTRVvjAGgkWkvryJWLterO+Gec8l2ksefpWo=;
 b=/VUqKgmQlOysVLm7W9CszCTDQGTWnKoKE2hLzoFNsDwL6Ui9sFi8wmrQKCuaP/Zzmgw28CCvv
 X5foAbf+1CgD9LRkoGboAgxq43glhLTWP9LZBr0bI6cd6qxPS+2TPcd
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of the DCD support for CXL type-3 devices extended the CDAT
table large enough that the checksum being returned was incorrect.[1]

This was because the checksum value was using the header length field
rather than each of the 4 bytes of the length field.  This was
previously not seen because the length of the CDAT data was less than
256 thus resulting in an equivalent checksum value.

Properly calculate the checksum for the CDAT header.

[1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/

Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
[djiang: Remove do {} while (0);]
---
 hw/cxl/cxl-cdat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 24829cf2428d..67e44a4f992a 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -49,6 +49,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     g_autofree CDATTableHeader *cdat_header = NULL;
     g_autofree CDATEntry *cdat_st = NULL;
     uint8_t sum = 0;
+    uint8_t *buf;
     int ent, i;
 
     /* Use default table if fopen == NULL */
@@ -95,8 +96,12 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     /* For now, no runtime updates */
     cdat_header->sequence = 0;
     cdat_header->length += sizeof(CDATTableHeader);
-    sum += cdat_header->revision + cdat_header->sequence +
-        cdat_header->length;
+
+    buf = (uint8_t *)cdat_header;
+    for (i = 0; i < sizeof(*cdat_header); i++) {
+        sum += buf[i];
+    }
+
     /* Sum of all bytes including checksum must be 0 */
     cdat_header->checksum = ~sum + 1;
 

-- 
2.42.0

