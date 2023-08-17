Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6E77F935
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351998AbjHQOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351958AbjHQOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:35:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A12D73;
        Thu, 17 Aug 2023 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692282910; x=1723818910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ULX7WCNz8+e7JhTCrh7iqp4Awl93HQg0jq2Qt7qguCc=;
  b=JF2Fwl2qcTql+roSsvagOnHNm9jeWay8Q/r3RRiHbFXU8Q+DgglUXYu2
   s0IIrTXIjctjKjkX3UvEfrJrdwkG9dxerQH3CZ78CTBBTnrAZVCEdnRMu
   1c+vP3MMTxUZPoYstB6ALpLZvUImwmTb2RNprlR0kaVGWklvp6FgkdSob
   L2D80Mw15yqrRSblQM8zxrE2bh2Qfr5Wjir19okQLc343Dd+fTK/TsRhi
   GOeZYBYtZWrseR5l82EB1m5o9K+6QyQwWdvq7FXpzudKQ/6w1R9j9DYfC
   gPX5Yq92ZuDv6nJuTH05E3pzC1TgTFlVecuJA8BaOQFmcU9oEIwM9tJKw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="357799587"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="357799587"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="848897987"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848897987"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 07:35:08 -0700
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com, alx.manpages@gmail.com,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Subject: [PATCH 0/4] Add debugfs pm_status for qat driver
Date:   Thu, 17 Aug 2023 16:33:13 +0200
Message-ID: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs pm_status.

Expose power management info by providing the "pm_status" file under
debugfs.

Patch #1 has been added to this pathcset in order to add
ARRAY_SIZE_OF_FIELD() (Patch #2) without expanding kernel.h

---

Alejandro Colomar (1):
  linux/array_size.h: Move ARRAY_SIZE(arr) to a separate header

Lucas Segarra Fernandez (3):
  linux/array_size.h: Add ARRAY_SIZE_OF_FIELD()
  crypto: qat - refactor included headers
  crypto: qat - add pm_status debugfs file

 Documentation/ABI/testing/debugfs-driver-qat  |   9 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |  13 +
 .../crypto/intel/qat/qat_common/adf_admin.c   |  25 ++
 .../intel/qat/qat_common/adf_common_drv.h     |   1 +
 .../crypto/intel/qat/qat_common/adf_dbgfs.c   |   3 +
 .../crypto/intel/qat/qat_common/adf_gen4_pm.c | 265 ++++++++++++++++++
 .../crypto/intel/qat/qat_common/adf_gen4_pm.h |  38 ++-
 .../intel/qat/qat_common/adf_pm_dbgfs.c       |  47 ++++
 .../intel/qat/qat_common/adf_pm_dbgfs.h       |  12 +
 .../qat/qat_common/icp_qat_fw_init_admin.h    |  33 +++
 include/linux/array_size.h                    |  21 ++
 include/linux/clk-provider.h                  |   1 +
 include/linux/counter.h                       |   1 +
 include/linux/genl_magic_func.h               |   1 +
 include/linux/hashtable.h                     |   1 +
 include/linux/kernel.h                        |   7 +-
 include/linux/kfifo.h                         |   1 +
 include/linux/kvm_host.h                      |   1 +
 include/linux/moduleparam.h                   |   2 +
 include/linux/mtd/rawnand.h                   |   1 +
 include/linux/netfilter.h                     |   1 +
 include/linux/pagemap.h                       |   1 +
 include/linux/phy.h                           |   1 +
 include/linux/pinctrl/machine.h               |   2 +-
 include/linux/property.h                      |   1 +
 include/linux/rcupdate_wait.h                 |   1 +
 include/linux/regmap.h                        |   1 +
 include/linux/skmsg.h                         |   1 +
 include/linux/string.h                        |   1 +
 include/linux/surface_aggregator/controller.h |   1 +
 31 files changed, 487 insertions(+), 8 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h
 create mode 100644 include/linux/array_size.h

-- 
2.41.0

