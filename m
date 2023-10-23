Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25E7D29AD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 07:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjJWFgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 01:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJWFg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 01:36:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A36D66;
        Sun, 22 Oct 2023 22:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698039387; x=1729575387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4ahXNqa6c7vy2x9ujTqdFUKWTVtZ7enEGrd79rmm95E=;
  b=JXpVVhVn+sefPxYFftPtNWPtpCaeJrBxGwwdmXdS0vAwaG0KYxxcQiNs
   J3Vzg9k9QxnEL4KbnANhiiRwiS5XMoB8eFLUPWCszWlFua3IVBM672i+N
   u0tV58lwTgeF+u/5p7251+ZnisYi11w98es8IJ5ASWtNY17sEN8enAsmm
   PpkXKoIc9UKdfYhp0gox0XBncoA6ll7p+pxlPVeuCJcvzpLvstTk8Hhfj
   V6Fu+RJrnuy9yz/VnyCoBOjVdkuVqTJM/qGAwzTgaVhC65/p+w861DNhl
   OsESbfKVK+gprlnY52Xdn3y/LrqNlAOMzqp/AOGy4i2TAfwfCeJMUgDRX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417905428"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417905428"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 22:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734556690"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734556690"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2023 22:36:14 -0700
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
Subject: [PATCH v2 4/6] ACPI: x86: use acpi_dev_uid_match() for matching _UID
Date:   Mon, 23 Oct 2023 11:05:28 +0530
Message-Id: <20231023053530.5525-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231023053530.5525-1-raag.jadav@intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert manual _UID references to use the standard ACPI helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

