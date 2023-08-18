Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6217809F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358994AbjHRKYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358918AbjHRKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:24:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4B3589;
        Fri, 18 Aug 2023 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692354269; x=1723890269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nAvfgu5XecqrL8CvSz7MeC0n2JryryvBly8wnBIzuFY=;
  b=LsZOKM5U77s+WdwEwXhr071WpOJT0ZnxguO2L/KEy9wL28RQRZrrnvZe
   8a++XZL0CJOz+BbJ9hOOBGbTmH49tpeA0dE4IR/UJLrfbK9fTNNC2xydR
   R5X9Y9EYwqW4rHUel8U3DfFTVWXj8WnXm5LlNO8KRLJfcbMJ9Iy7zDGkQ
   30bav2YDZ/rRbAG3nnFmdKDHMvqoneh5f1WgZEtqt69JEzA3aKzaDM/jf
   eN4e2kfAW/4AUV1oiWYnP15zycq82TC9n+j9/FDj44g3JQ0BKH5H7erf1
   ylUKAONcLMel3bwXJxT56Q1Deoz0zFp8BFPZEOb6gbkLKvz5uUOumA+/S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376829228"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="376829228"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878636039"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2023 03:24:32 -0700
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com, alx@kernel.org,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Subject: [PATCH v2 0/2] Add debugfs pm_status for qat driver
Date:   Fri, 18 Aug 2023 12:23:07 +0200
Message-ID: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs pm_status

Expose power management info by providing the "pm_status" file under
debugfs.

---
v1 -> v2:
- Add constant ICP_QAT_NUMBER_OF_PM_EVENTS, rather than
  ARRAY_SIZE_OF_FIELD()
---

Lucas Segarra Fernandez (2):
  crypto: qat - refactor included headers
  crypto: qat - add pm_status debugfs file

 Documentation/ABI/testing/debugfs-driver-qat  |   9 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |  13 +
 .../crypto/intel/qat/qat_common/adf_admin.c   |  25 ++
 .../intel/qat/qat_common/adf_common_drv.h     |   1 +
 .../crypto/intel/qat/qat_common/adf_dbgfs.c   |   3 +
 .../crypto/intel/qat/qat_common/adf_gen4_pm.c | 261 ++++++++++++++++++
 .../crypto/intel/qat/qat_common/adf_gen4_pm.h |  38 ++-
 .../intel/qat/qat_common/adf_pm_dbgfs.c       |  47 ++++
 .../intel/qat/qat_common/adf_pm_dbgfs.h       |  12 +
 .../qat/qat_common/icp_qat_fw_init_admin.h    |  35 +++
 11 files changed, 444 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h

-- 
2.41.0

