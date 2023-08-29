Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9950078CEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjH2VsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjH2VsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:48:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1CD7;
        Tue, 29 Aug 2023 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693345680; x=1724881680;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=PiPj+zZYTp3WoxOjrotjdMcnCLnciTQjwmqbXEeRGb0=;
  b=Fb+Lemq0bJH8RmDTnH/9mm/otl9RgW+SZWUg2UDPTD9eVZNoCh9DYtWu
   3LHTVn9vXojM/U1G907OVS93lH7YJnqe99IvNHFaxT4NKOBiYpWjgUETv
   Ill/unjM1GW1b0AgcJoTkYkFZw8lZbqq7oFz2CNzsuoMh4lRq7eNem3QF
   KjPQzpG+mixhl5THcFGXlmpLPj0scnlq3cBLqHnDlWPP7Kni1WV+F3zja
   FmQ32raGjVU7ovaJh45lHWC2CAMmAhG3kXM5qi1qKar9NjHhtYW0US26Z
   QmXcnI9bDH8PWkI/dAfWcz7YeDWaXqR4uaXGyRsc/yoIvf8aACIo0L56n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="354996516"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="354996516"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 14:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688669193"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="688669193"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.150.239])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 14:47:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 29 Aug 2023 14:47:46 -0700
Subject: [PATCH] cxl/region: Clarify pointers in unregister_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-cxl-clarify-ptrs-v1-1-40e0705c6188@intel.com>
X-B4-Tracking: v=1; b=H4sIAIFn7mQC/x2NQQrCQAwAv1JyNlBTFqtfEQ/ZNWsDdS1JKZXSv
 7v1OAzDbOBiKg63ZgOTRV0/pcL51EAauLwE9VkZqKWu7emKaR0xjWyavzjN5pi7nkKIFwkUoWa
 RXTAalzQc4Zt9FjvEZJJ1/b/uj33/AQ82MN17AAAA
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693345677; l=1534;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=PiPj+zZYTp3WoxOjrotjdMcnCLnciTQjwmqbXEeRGb0=;
 b=PF3lyJ3yU784xODWaECpKEgdsgF5PC0YX3bJSjXd4VTluk2VIVXPBF3Fm7srfY8yiKjY6tgLp
 hSdAB/pG5CYCVT7FsXi56UHbbzgwSwMjd8rugcMJnCtZMKqMGVfwBq0
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_add_action_or_reset() passes a void * data parameter to the
callback.  In the case of CXL regions, unregister_region() is passed a
struct cxl_region *.

unregister_region() incorrectly interprets this as a struct device
pointer.  Fortunately the device structure was the first member of
cxl_region.  Therefore the code still works.  However, should struct
cxl_region change the bug could be subtle.

Use the proper types in unregister_region() and extract the device
pointer correctly.

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Cc: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..471d305ef675 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2018,10 +2018,11 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(void *dev)
+static void unregister_region(void *_cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region *cxlr = _cxlr;
 	struct cxl_region_params *p = &cxlr->params;
+	struct device *dev = &cxlr->dev;
 	int i;
 
 	device_del(dev);

---
base-commit: 1c59d383390f970b891b503b7f79b63a02db2ec5
change-id: 20230829-cxl-clarify-ptrs-f38255b7e52b

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

