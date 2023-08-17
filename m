Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91577F934
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351992AbjHQOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352013AbjHQOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:35:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB312D73;
        Thu, 17 Aug 2023 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692282921; x=1723818921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=afTBq937w9TuZntVnjAl769RwLs9NQ0JIkRooQjTgOQ=;
  b=N+hz/+tEM/nCCUyhzOQIHtxNA9yzZrzgp66EfP5mgX46BMm167xKPtt2
   ZZEzkawYgZ0Bx5mpVY05Sjp8G591fITB4rKoqFkDpfz3WM9P7eD+jknr+
   NrQq1zRDX+WxPqQnbG9NXzo82GGFMSFTwH9XkJICN6MjD3PObo2+0MbDJ
   fQ1TC/gnAyKSCVZY8ttZ9665Yvt7jlOffSARrnsw2Q70Q1IkAUpFkEFZy
   mMfCQD94Wi9Du9YhtrU/avNW5Qu9y1UMK7mYoVp2wgfEm/TbX1ehR/2mE
   g8ls5Ao1Y2RjGs6pXDZm4oPmDFaicNZX+HY7Hw25mhQhaNRCGkZQJ04uT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="357799608"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="357799608"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="848898016"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848898016"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 07:35:20 -0700
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com, alx.manpages@gmail.com,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/4] linux/array_size.h: Add ARRAY_SIZE_OF_FIELD()
Date:   Thu, 17 Aug 2023 16:33:15 +0200
Message-ID: <20230817143352.132583-3-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce ARRAY_SIZE_OF_FIELD() in order to get the number of elements
of an array struct field.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 include/linux/array_size.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index 06d7d83196ca..37dac0473b5c 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,12 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/*
+ * ARRAY_SIZE_OF_FIELD - get the number of elements of an array struct field
+ *
+ * @TYPE: The structure containing the field of interest
+ * @MEMBER: The array field to be sized
+ */
+#define ARRAY_SIZE_OF_FIELD(TYPE, MEMBER) ARRAY_SIZE((((TYPE *)0)->MEMBER))
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.41.0

