Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833D37FA075
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjK0NRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjK0NRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:17:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A1CD4D;
        Mon, 27 Nov 2023 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701091027; x=1732627027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2pAaMh0cJn8v4EHY52uAptTzkL/1qOHMD953Lt40J/E=;
  b=GDop1Sx/Lfg1WOHUj+V+FGP0+fKMXv/LBB/j17BzvIIoYPUGQ8fkqjAw
   IHoFqTB5Fph8dPe75HLH+6Lfq+uUKK3KyOAbUekOPTZJJa4h+PmbQCuyx
   TAPJmutJBwQx8TBvzqommLDs/3yEa+BCkd8nVd8wAfEevc/E24CWiKNCi
   /Rhzewgo2/GxMTOy/EPsAnLPBfl+n25a6l8VgpR1LpOn8wQhtDTOtsa/G
   gORQ3uSQA6KBttexbaCNS7AcHucWGiSnc28z6zPlLHJU00To9k3TOvbZm
   1yn8r5C+MFh5gjVUxZMPK+quNUriUQwkwJAXCgOmMLAzttDMyXAKzNVc2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="423833664"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="423833664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="718031604"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="718031604"
Received: from zhipengw-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.237])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:17:04 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] hwmon: (coretemp) Fix core count limitation
Date:   Mon, 27 Nov 2023 21:16:48 +0800
Message-Id: <20231127131651.476795-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, coretemp driver only supports 128 cores per package.
This loses some core temperature information on systems that have more
than 128 cores per package.
 [   58.685033] coretemp coretemp.0: Adding Core 128 failed
 [   58.692009] coretemp coretemp.0: Adding Core 129 failed

To get rid of the fixed length pdata->core_data[] array,
  Patch 1/3 and 2/3 removes the dependency of array index in sysfs
  attribute callbacks.
  Patch 3/3 removes the pdata->core_data[] array and use a per package
  list to maintain the per core temperature infomation instead.

-rui

----------------------------------------------------------------
Zhang Rui (3):
      hwmon: (coretemp) Introduce enum for attr index
      hwmon: (coretemp) Remove unnecessary dependency of array index
      hwmon: (coretemp) Fix core count limitation

 drivers/hwmon/coretemp.c | 137 +++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 70 deletions(-)
