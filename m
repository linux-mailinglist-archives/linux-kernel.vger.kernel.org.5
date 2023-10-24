Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FA7D475A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJXGVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjJXGVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:21:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100F110FE;
        Mon, 23 Oct 2023 23:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128458; x=1729664458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Fp+mcUvbUBGqwzFxRStIIQ/F0gyMOztw8zWtT91yBSs=;
  b=hurdb5l5qTkiEpBXwWbakMlPkEq0sD+F3JSNpq8lJWeqWOMpsc1fJVNN
   5dGADgUMFIDfQcTnDPypXelIpLJpBjeb3ojAcuoqdULZTEOA8wWU9twLe
   /QjjJE6V3wVssA9LWmJFmqpVrLe/iYDBUEwzRoaGHp6oZJLka5wH91aNs
   uaCE+1vihonBhpgTxUbNwnjxGWVFzlloGBu6FXLCWkWFnsXOqrfe1YKyp
   k/FJoTIsQTNAj5V2aEpG6UL5D1IYB8H7u84WMBiUQrZhyt/0SwV4RVQUY
   zpRFLXNrJJEG5t5NpfAdrulmWHb4+6vN/x3+2N7RzMePXBe9rGdftKrzB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806592"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806592"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751891416"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751891416"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2023 23:20:52 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net,
        Jonathan.Cameron@Huawei.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 4/6] ACPI: x86: use acpi_dev_uid_match() for matching _UID
Date:   Tue, 24 Oct 2023 11:50:16 +0530
Message-Id: <20231024062018.23839-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert manual _UID references to use the standard ACPI helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/x86/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 63d834dd3811..bc65ebfcdf76 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -184,8 +184,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 			if (acpi_match_device_ids(adev, override_status_ids[i].hid))
 				continue;
 
-			if (!adev->pnp.unique_id ||
-			    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
+			if (!acpi_dev_uid_match(adev, override_status_ids[i].uid))
 				continue;
 		}
 
-- 
2.17.1

