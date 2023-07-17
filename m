Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A04756063
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGQK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGQK2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:28:17 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901AB1A8;
        Mon, 17 Jul 2023 03:28:16 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so26187025e9.1;
        Mon, 17 Jul 2023 03:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589695; x=1692181695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkZqDw+1/Brauf2lZXhoxi+see4xLt/P00aPxZ1mK3o=;
        b=VCMMHu6Wfo831KNSBeblau/aq6gmo6Gc7MLaXewDGkMur0bbA0vl3t4HCqCb+JowNV
         cmuycIYARujd2J3lMpIbZro+U+7EI1BYSE6nWTKtMcLlNR59qYTQIqP0xkW8VybqdbQ/
         N+mNi3lu3X7ude3CHuW+j61D/YLJB2zqTGsLgXeckYp6xZoaEQ6zXt0+BVn5hw1XfFvL
         3ji16hpPl06pKRghkI8Wc82pGAicWRGJHLmDEYghGt5L0UFegt1JqOowk0/s0ROKnfNY
         Z9l6t6jfiR7IyBkRIfQryXpx8s+UOe/GoTkBKnYFVCzR6u1cygVmlksrTn+4oUyYCi2z
         RADQ==
X-Gm-Message-State: ABy/qLafE3LoCD5sY9O63ecUoe8NtMj4a/yRpvAbwCkYvO4LfA68LMIY
        GhVxszta5Dsu+Cn4YG398OY=
X-Google-Smtp-Source: APBJJlFDOQsZ9zZZ/bg213cfh+z43UqeoawNZRd5hrD4XvGCfgSKnL6YNQlW/vAzPzh9NQh3fV/LJg==
X-Received: by 2002:a05:600c:4689:b0:3fa:955a:9291 with SMTP id p9-20020a05600c468900b003fa955a9291mr7656892wmo.9.1689589694806;
        Mon, 17 Jul 2023 03:28:14 -0700 (PDT)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe949000000b0031128382ed0sm18845454wrn.83.2023.07.17.03.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:28:14 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     leit@meta.com, kernel test robot <lkp@intel.com>,
        linux-cxl@vger.kernel.org (open list:COMPUTE EXPRESS LINK (CXL)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cxl/acpi: Use printk specifier for resource
Date:   Mon, 17 Jul 2023 03:26:20 -0700
Message-Id: <20230717102625.4083462-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3840e10e8dca ("cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()")
is using %llx to print resources pointers, but it is incorrect on 32-bits
system, causing the following compilation warning on i386:

	 drivers/cxl/acpi.c:300:4: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]

Instead of using pointers to the resource, uses the proper printk
specifier that knows how to handle the struct "resources".

This is the new format, being printed now:

	Failed to add decode range: [mem 0x4080000000-0x2baffffffff flags 0x200]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307151059.2vvBt55H-lkp@intel.com/
Fixes: 3840e10e8dca ("cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/cxl/acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 815b43859c16..d1c559879dcc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -296,8 +296,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
-		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
-			res->start, res->end);
+		dev_err(dev, "Failed to add decode range: %pr", res);
 		return rc;
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
-- 
2.34.1

