Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD27D0ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376527AbjJTIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376474AbjJTIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:48:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD331A8;
        Fri, 20 Oct 2023 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791690; x=1729327690;
  h=from:to:cc:subject:date:message-id;
  bh=55kFwQ1dJ+2JNO1s52sQQCyE+DnzabG8i8c9Ir2rEwI=;
  b=LiGzTaePRnnr4rShhjxisC82fwc5QWFK7iH60WI7wDsDQxYZIi4C5Iss
   jbH/dQj37MTs3XoswEZ9ZxafNXhCb50UvA3ZElVtKjmfCOskiv0imFWZM
   ChMIz1KO5Zt7Y4rr67VUuNj2ix03/uA92fHBPh/wzmQ3sajZtzwM5Ifhq
   OXYFxzB6UI+J3km9MWKyAVgQJEAzCv3zqEhSUqMqFQDYaLm+ByE1547JT
   WQ1bfkz6NBxM57+rHKRMSkXFLG6In+2BvCPTG5k+63bUBqvxTVrDfTI6z
   8oWlgemlrLmZ1Oh4YPiN0GDAlTxvma9MM5fX15VSKgITEoSFXy+rZB3bR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683485"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832155"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832155"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:47:42 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/8] Refine _UID references across kernel
Date:   Fri, 20 Oct 2023 14:17:24 +0530
Message-Id: <20231020084732.17130-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refines _UID references across kernel by:

- Extracting _UID matching functionality from acpi_dev_hid_uid_match()
  helper and introducing it as a separate acpi_dev_uid_match() helper.

- Converting manual _UID references to use standard ACPI helpers.

Raag Jadav (8):
  ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
  pinctrl: intel: use acpi_dev_uid_match() for matching _UID
  ACPI: sysfs: use acpi_device_uid() for fetching _UID
  ACPI: utils: use acpi_dev_uid_match() for matching _UID
  ACPI: x86: use acpi_dev_uid_match() for matching _UID
  perf: qcom: use acpi_device_uid() for fetching _UID
  hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
    _UID
  perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
    _UID

 drivers/acpi/device_sysfs.c           |  6 ++--
 drivers/acpi/utils.c                  | 43 +++++++++++++++++++++------
 drivers/acpi/x86/utils.c              |  3 +-
 drivers/hwmon/nct6775-platform.c      |  4 +--
 drivers/perf/arm_cspmu/arm_cspmu.c    |  8 ++---
 drivers/perf/qcom_l3_pmu.c            |  4 +--
 drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
 include/acpi/acpi_bus.h               |  1 +
 include/linux/acpi.h                  |  5 ++++
 9 files changed, 51 insertions(+), 25 deletions(-)


base-commit: 9bc2fb9a7e41542a193658deff3df572fa24cb68
-- 
2.17.1

