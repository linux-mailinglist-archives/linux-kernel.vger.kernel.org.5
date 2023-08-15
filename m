Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8777CF62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbjHOPlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbjHOPlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:41:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B7E61;
        Tue, 15 Aug 2023 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114078; x=1723650078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hW6WKgj1nITaNcnYYuF7AScms9zSUoubrx1m0DkRHyI=;
  b=nP95Q/If2LAqN/7hNervLLp+9H7KIvBr4HGkA7dhFtMwa1qszMfhfVg7
   7wz6gDIZyL1yjZBI+LLEvUJKN0XmmYQxjlZavWuaybqGVshEXquX/Nbmd
   MHgdFZ8ZzSL88I/BXsA2d+AIgz1kU4aYq6SJWb4EL0aZOKAwRipq6zesQ
   uSi9kuLXG5VYjBD1wPM2Q4dJ+ai+yUBDWpgDdSNkWO3epbb9N0rhCBMRo
   zkmsjdedD3Q63nXDBb+KZBJ0hd0Z0p47RgYIDHYR7y7fQ9usCeoyuolAZ
   fUhLdXT+vzdACSSPjAE+DZn3r5E/mJzEEDDM+jNaHimuA3ig0lC9+T7xs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="351896988"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="351896988"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727406714"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="727406714"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 08:41:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 69F67C51; Tue, 15 Aug 2023 18:41:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/3] iio: imu: st_lsm6dsx: Use aligned data type for timestamp
Date:   Tue, 15 Aug 2023 18:40:26 +0300
Message-Id: <20230815154027.12468-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __aligned_s64 for the timestamp field.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c19237717e81..d3d4b3281aa6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -442,10 +442,9 @@ struct st_lsm6dsx_hw {
 	const struct st_lsm6dsx_settings *settings;
 
 	struct iio_mount_matrix orientation;
-	/* Ensure natural alignment of buffer elements */
 	struct {
 		__le16 channels[3];
-		s64 ts __aligned(8);
+		__aligned_s64 ts;
 	} scan[ST_LSM6DSX_ID_MAX];
 };
 
-- 
2.40.0.1.gaa8946217a0b

